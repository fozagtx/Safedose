import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../generated/protocol.dart';

Never _deny(String message) => throw OneDoseException(
  code: OneDoseErrorCode.notAuthorized,
  message: message,
);

UuidValue currentUserId(Session session) {
  final id = session.authenticated?.authUserId;
  if (id == null) _deny('Sign in first.');
  return id;
}

/// Whether [member] may act right now. Sitters only inside their shift.
bool isActive(CareMember member, DateTime now) {
  if (member.revokedAt != null) return false;
  if (member.role != CareRole.sitter) return true;
  final start = member.shiftStart;
  final end = member.shiftEnd;
  if (start != null && now.isBefore(start)) return false;
  if (end != null && !now.isBefore(end)) return false;
  return true;
}

/// Loads the caller's membership of [childId] and checks it is active, and
/// that its role is one of [roles] when given. Every endpoint goes through
/// this, so access is enforced by the server, never the app.
Future<CareMember> requireMember(
  Session session,
  int childId, {
  Set<CareRole>? roles,
  Transaction? transaction,
}) async {
  final userId = currentUserId(session);
  final member = await CareMember.db.findFirstRow(
    session,
    where: (t) =>
        t.childId.equals(childId) &
        t.userId.equals(userId) &
        t.revokedAt.equals(null),
    transaction: transaction,
  );
  if (member == null) _deny('You are not in this child\'s care circle.');
  final now = DateTime.now().toUtc();
  if (!isActive(member, now)) {
    if (member.shiftStart != null && now.isBefore(member.shiftStart!)) {
      _deny('Your shift has not started yet.');
    }
    throw OneDoseException(
      code: OneDoseErrorCode.shiftEnded,
      message: 'Your shift has ended.',
    );
  }
  if (roles != null && !roles.contains(member.role)) {
    _deny('Only the parent can do that.');
  }
  return member;
}

Future<Child> requireChild(Session session, int childId) async {
  final child = await Child.db.findById(session, childId);
  if (child == null) {
    throw OneDoseException(
      code: OneDoseErrorCode.notFound,
      message: 'Child not found.',
    );
  }
  return child;
}
