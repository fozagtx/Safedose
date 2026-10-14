import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../logic/access.dart';
import '../logic/config.dart';

/// The signed-in caregiver's circles, and setting up a child.
class ChildEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Circles the caller belongs to and can act in right now.
  Future<List<CircleSummary>> mine(Session session) async {
    final userId = currentUserId(session);
    final members = await CareMember.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.revokedAt.equals(null),
    );
    final now = DateTime.now().toUtc();
    final result = <CircleSummary>[];
    for (final m in members) {
      // Sitters whose shift is over are not shown; upcoming shifts are.
      if (m.role == CareRole.sitter &&
          m.shiftEnd != null &&
          !now.isBefore(m.shiftEnd!)) {
        continue;
      }
      final child = await Child.db.findById(session, m.childId);
      if (child != null) result.add(CircleSummary(child: child, me: m));
    }
    return result;
  }

  /// Creates a child with the caller as owner. One child per account.
  Future<CircleSummary> create(
    Session session, {
    required String name,
    required String ownerName,
    required int utcOffsetMinutes,
    String? photoUrl,
  }) async {
    final userId = currentUserId(session);
    if (name.trim().isEmpty || ownerName.trim().isEmpty) {
      throw OneDoseException(
        code: OneDoseErrorCode.invalid,
        message: 'Enter the child\'s name and what they call you.',
      );
    }
    final owned = await Child.db.count(
      session,
      where: (t) => t.ownerId.equals(userId),
    );
    if (owned > 0) {
      throw OneDoseException(
        code: OneDoseErrorCode.invalid,
        message: 'OneDose supports one child per account for now.',
      );
    }
    return session.db.transaction((tx) async {
      final child = await Child.db.insertRow(
        session,
        Child(
          name: name.trim(),
          photoUrl: photoUrl,
          ownerId: userId,
          utcOffsetMinutes: utcOffsetMinutes,
        ),
        transaction: tx,
      );
      final me = await CareMember.db.insertRow(
        session,
        CareMember(
          childId: child.id!,
          userId: userId,
          displayName: ownerName.trim(),
          role: CareRole.owner,
        ),
        transaction: tx,
      );
      return CircleSummary(child: child, me: me);
    });
  }

  /// Owner only: rename, change photo or time zone.
  Future<Child> update(Session session, Child child) async {
    await requireMember(session, child.id!, roles: {CareRole.owner});
    final existing = await requireChild(session, child.id!);
    return Child.db.updateRow(
      session,
      existing.copyWith(
        name: child.name.trim(),
        photoUrl: child.photoUrl,
        utcOffsetMinutes: child.utcOffsetMinutes,
      ),
    );
  }

  /// Whether the server runs shortened demo timings.
  Future<bool> demoMode(Session session) async => OneDoseConfig.demo;
}
