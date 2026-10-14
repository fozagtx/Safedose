import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../logic/access.dart';
import '../logic/circle_events.dart';
import '../logic/config.dart';
import '../logic/escalation.dart';

/// One-time links that add a sitter for one shift, or a co-parent.
class InviteEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static final _random = Random.secure();
  static const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  static String _token() => List.generate(
    10,
    (_) => _alphabet[_random.nextInt(_alphabet.length)],
  ).join();

  Future<InviteCreated> create(
    Session session, {
    required int childId,
    required String displayName,
    required CareRole role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
  }) async {
    await requireMember(session, childId, roles: {CareRole.owner});
    if (displayName.trim().isEmpty) {
      throw OneDoseException(
        code: OneDoseErrorCode.invalid,
        message: 'Enter a name, e.g. Grandpa.',
      );
    }
    if (role == CareRole.owner) {
      throw OneDoseException(
        code: OneDoseErrorCode.invalid,
        message: 'Invite a co-parent or a sitter.',
      );
    }
    if (role == CareRole.sitter &&
        (shiftStart == null ||
            shiftEnd == null ||
            !shiftEnd.isAfter(shiftStart) ||
            !shiftEnd.isAfter(DateTime.now()))) {
      throw OneDoseException(
        code: OneDoseErrorCode.invalid,
        message: 'A sitter needs a shift that ends in the future.',
      );
    }
    final token = _token();
    final invite = await Invite.db.insertRow(
      session,
      Invite(
        token: token,
        childId: childId,
        displayName: displayName.trim(),
        role: role,
        shiftStart: role == CareRole.sitter ? shiftStart!.toUtc() : null,
        shiftEnd: role == CareRole.sitter ? shiftEnd!.toUtc() : null,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return InviteCreated(token: token, invite: invite);
  }

  /// Joins the circle. The membership is scoped to the invite's shift, and
  /// a future call revokes it when the shift ends.
  Future<CircleSummary> accept(Session session, String token) async {
    final userId = currentUserId(session);
    final now = DateTime.now().toUtc();
    final member = await session.db.transaction((tx) async {
      final invite = await Invite.db.findFirstRow(
        session,
        where: (t) => t.token.equals(token.trim().toUpperCase()),
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (invite == null ||
          invite.usedAt != null ||
          now.difference(invite.createdAt) > OneDoseConfig.inviteLifetime ||
          (invite.shiftEnd != null && !now.isBefore(invite.shiftEnd!))) {
        throw OneDoseException(
          code: OneDoseErrorCode.notFound,
          message:
              'This invite is not valid any more. Ask the parent for '
              'a new one.',
        );
      }
      await Invite.db.updateRow(
        session,
        invite.copyWith(usedAt: now),
        transaction: tx,
      );
      // Replace any earlier membership of this user in this circle.
      final previous = await CareMember.db.find(
        session,
        where: (t) =>
            t.childId.equals(invite.childId) &
            t.userId.equals(userId) &
            t.revokedAt.equals(null),
        transaction: tx,
      );
      if (previous.any((m) => m.role == CareRole.owner)) {
        throw OneDoseException(
          code: OneDoseErrorCode.invalid,
          message: 'You are already the parent in this circle.',
        );
      }
      for (final p in previous) {
        await CareMember.db.updateRow(
          session,
          p.copyWith(revokedAt: now),
          transaction: tx,
        );
      }
      return CareMember.db.insertRow(
        session,
        CareMember(
          childId: invite.childId,
          userId: userId,
          displayName: invite.displayName,
          role: invite.role,
          shiftStart: invite.shiftStart,
          shiftEnd: invite.shiftEnd,
        ),
        transaction: tx,
      );
    });
    await Escalation.scheduleShiftExpiry(session, member);
    await CircleEvents.post(
      session,
      CircleEvent(
        type: CircleEventType.membersChanged,
        childId: member.childId,
        message: '${member.displayName} joined the circle.',
        at: now,
      ),
    );
    final child = await requireChild(session, member.childId);
    return CircleSummary(child: child, me: member);
  }
}
