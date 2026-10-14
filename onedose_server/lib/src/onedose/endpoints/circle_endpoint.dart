import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../logic/access.dart';
import '../logic/circle_events.dart';
import '../logic/dose_service.dart';
import '../logic/escalation.dart';

/// The care circle: who is in it, and the live stream every phone watches.
class CircleEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Streams everything that happens in the circle. The first event is a
  /// snapshot of every medicine's status; every later event carries fresh
  /// statuses too, so a phone never has to refresh. Access is re-checked on
  /// every event: when a sitter's shift ends the stream sends `shiftEnded`
  /// and closes with an error.
  Stream<CircleEvent> watch(Session session, int childId) async* {
    final me = await requireMember(session, childId);
    final events = session.messages.createStream<CircleEvent>(
      CircleEvents.channel(childId),
    );

    yield CircleEvent(
      type: CircleEventType.snapshot,
      childId: childId,
      statuses: await DoseService.statuses(session, childId),
      at: DateTime.now().toUtc(),
    );

    await for (final event in events) {
      if (event.targetUserId != null && event.targetUserId != me.userId) {
        continue;
      }
      if (event.type == CircleEventType.shiftEnded) {
        yield event;
        throw OneDoseException(
          code: OneDoseErrorCode.shiftEnded,
          message: 'Your shift has ended.',
        );
      }
      // Throws if access was revoked or the shift is over.
      await requireMember(session, childId);
      yield event.copyWith(
        statuses: await DoseService.statuses(session, childId),
      );
    }
  }

  /// Everyone in the circle. Owners see all members; others see who is
  /// active now.
  Future<List<CareMember>> members(Session session, int childId) async {
    final me = await requireMember(session, childId);
    final all = await CareMember.db.find(
      session,
      where: (t) => t.childId.equals(childId) & t.revokedAt.equals(null),
      orderBy: (t) => t.id,
    );
    if (me.role == CareRole.owner) return all;
    final now = DateTime.now().toUtc();
    return all.where((m) => isActive(m, now)).toList();
  }

  /// Owner only: remove someone. Their open stream closes on the next event.
  Future<void> revoke(Session session, int memberId) async {
    final member = await CareMember.db.findById(session, memberId);
    if (member == null) return;
    await requireMember(session, member.childId, roles: {CareRole.owner});
    if (member.role == CareRole.owner) {
      throw OneDoseException(
        code: OneDoseErrorCode.invalid,
        message: 'The owner cannot be removed.',
      );
    }
    final now = DateTime.now().toUtc();
    await CareMember.db.updateRow(session, member.copyWith(revokedAt: now));
    await Escalation.cancelShiftExpiry(session, memberId);
    await CircleEvents.post(
      session,
      CircleEvent(
        type: CircleEventType.shiftEnded,
        childId: member.childId,
        message: 'The parent has removed your access.',
        targetUserId: member.userId,
        at: now,
      ),
    );
    await CircleEvents.post(
      session,
      CircleEvent(
        type: CircleEventType.membersChanged,
        childId: member.childId,
        message: '${member.displayName} was removed.',
        at: now,
      ),
    );
  }
}
