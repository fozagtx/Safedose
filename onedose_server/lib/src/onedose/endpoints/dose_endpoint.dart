import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../logic/access.dart';
import '../logic/dose_service.dart';

/// "Can I give this now?" and "I gave it."
class DoseEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Logs a dose. The server accepts it or refuses it with who gave the
  /// blocking dose, when, and when the next one is allowed.
  Future<DoseResult> logDose(Session session, int medicineId) =>
      DoseService.logDose(session, medicineId);

  /// Owner only: log a dose despite a refusal, with a typed reason (for a
  /// doctor-advised change). Shown in red in the history.
  Future<DoseResult> overrideDose(
    Session session,
    int medicineId,
    String reason,
  ) => DoseService.logDose(session, medicineId, overrideReason: reason);

  /// Undo a dose logged by mistake, within 2 minutes.
  Future<DoseEvent> undo(Session session, int doseEventId) =>
      DoseService.undo(session, doseEventId);

  /// Green / amber / red for each medicine right now.
  Future<List<MedicineStatus>> status(Session session, int childId) async {
    await requireMember(session, childId);
    return DoseService.statuses(session, childId);
  }
}
