import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../logic/access.dart';

/// The audit trail: every attempt, accepted or refused.
class HistoryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Newest first. Sitters only see what happened during their shift.
  Future<List<DoseEvent>> list(Session session, int childId) async {
    final member = await requireMember(session, childId);
    final since = member.role == CareRole.sitter ? member.shiftStart : null;
    return DoseEvent.db.find(
      session,
      where: (t) => since == null
          ? t.childId.equals(childId)
          : t.childId.equals(childId) & (t.at >= since),
      orderByList: (t) => [t.at.desc()],
      limit: 500,
    );
  }
}
