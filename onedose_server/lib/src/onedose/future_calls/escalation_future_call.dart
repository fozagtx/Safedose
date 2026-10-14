import 'package:serverpod/serverpod.dart';

import '../logic/escalation.dart';

/// Scheduled jobs for missed doses and shift expiry. They are stored in
/// Postgres by Serverpod, so they still run after a server restart.
class EscalationFutureCall extends FutureCall {
  /// Runs at a fixed dose time: schedules that slot's escalation checks and
  /// the same slot tomorrow.
  Future<void> slotDue(Session session, int medicineId, DateTime dueAt) =>
      Escalation.onSlotDue(session, medicineId, dueAt);

  /// Stage 1 alerts the on-shift caregivers, stage 2 the owner.
  Future<void> missedDoseCheck(
    Session session,
    int medicineId,
    DateTime dueAt,
    int stage,
  ) => Escalation.onMissedDoseCheck(session, medicineId, dueAt, stage);

  /// Runs at a sitter's shift end: revokes access and closes their stream.
  Future<void> shiftExpiry(Session session, int memberId) =>
      Escalation.onShiftExpiry(session, memberId);
}
