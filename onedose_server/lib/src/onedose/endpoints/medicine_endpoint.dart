import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../logic/access.dart';
import '../logic/circle_events.dart';
import '../logic/dose_rules.dart';
import '../logic/dose_service.dart';
import '../logic/escalation.dart';

/// Medicines and their limits. Limits come from the label or the doctor;
/// OneDose never suggests them. Only the owner can change them.
class MedicineEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Medicine>> list(Session session, int childId) async {
    await requireMember(session, childId);
    return Medicine.db.find(
      session,
      where: (t) => t.childId.equals(childId) & t.archivedAt.equals(null),
      orderBy: (t) => t.name,
    );
  }

  Medicine _validated(Medicine m) {
    String? error;
    if (m.name.trim().isEmpty) error = 'Enter the medicine name.';
    if (m.ingredient.trim().isEmpty) {
      error = 'Enter the active ingredient from the label.';
    }
    if (m.doseText.trim().isEmpty) error = 'Enter the dose from the label.';
    if (m.minHoursBetween <= 0 || m.minHoursBetween > 168) {
      error = 'Hours between doses must be between 0 and 168.';
    }
    if (m.maxPer24h < 1 || m.maxPer24h > 24) {
      error = 'Maximum doses per 24 hours must be between 1 and 24.';
    }
    if (m.fixedTimes.any((t) => parseFixedTime(t) == null)) {
      error = 'Fixed times must look like 08:00.';
    }
    if (error != null) {
      throw OneDoseException(code: OneDoseErrorCode.invalid, message: error);
    }
    final times =
        m.fixedTimes
            .map((t) {
              final p = parseFixedTime(t)!;
              return '${p.hour.toString().padLeft(2, '0')}:'
                  '${p.minute.toString().padLeft(2, '0')}';
            })
            .toSet()
            .toList()
          ..sort();
    return m.copyWith(
      name: m.name.trim(),
      ingredient: normaliseIngredient(m.ingredient),
      doseText: m.doseText.trim(),
      fixedTimes: times,
    );
  }

  Future<Medicine> add(Session session, Medicine medicine) async {
    await requireMember(session, medicine.childId, roles: {CareRole.owner});
    final valid = _validated(medicine.copyWith(id: null, archivedAt: null));
    final saved = await Medicine.db.insertRow(session, valid);
    await DoseService.ensureLock(session, saved.childId, saved.ingredient);
    await Escalation.scheduleMedicine(session, saved);
    await _changed(session, saved.childId);
    return saved;
  }

  Future<Medicine> update(Session session, Medicine medicine) async {
    final existing = await Medicine.db.findById(session, medicine.id!);
    if (existing == null || existing.archivedAt != null) {
      throw OneDoseException(
        code: OneDoseErrorCode.notFound,
        message: 'Medicine not found.',
      );
    }
    await requireMember(session, existing.childId, roles: {CareRole.owner});
    final valid = _validated(medicine.copyWith(childId: existing.childId));
    await Escalation.cancelMedicine(session, existing);
    final saved = await Medicine.db.updateRow(session, valid);
    await DoseService.ensureLock(session, saved.childId, saved.ingredient);
    await Escalation.scheduleMedicine(session, saved);
    await _changed(session, saved.childId);
    return saved;
  }

  /// Removes a medicine from the card. Its dose history is kept.
  Future<void> archive(Session session, int medicineId) async {
    final existing = await Medicine.db.findById(session, medicineId);
    if (existing == null) return;
    await requireMember(session, existing.childId, roles: {CareRole.owner});
    await Escalation.cancelMedicine(session, existing);
    await Medicine.db.updateRow(
      session,
      existing.copyWith(archivedAt: DateTime.now().toUtc()),
    );
    await _changed(session, existing.childId);
  }

  Future<void> _changed(Session session, int childId) => CircleEvents.post(
    session,
    CircleEvent(
      type: CircleEventType.medicinesChanged,
      childId: childId,
      at: DateTime.now().toUtc(),
    ),
  );
}
