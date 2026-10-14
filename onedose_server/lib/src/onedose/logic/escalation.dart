import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../../generated/future_calls.dart';
import 'circle_events.dart';
import 'config.dart';
import 'dose_rules.dart';

/// Scheduling of missed-dose escalation and shift expiry.
class Escalation {
  static String _slotId(int medicineId, DateTime dueAt) =>
      'slot:$medicineId:${dueAt.toUtc().millisecondsSinceEpoch}';
  static String _checksId(int medicineId, DateTime dueAt) =>
      'missed:$medicineId:${dueAt.toUtc().millisecondsSinceEpoch}';
  static String _shiftId(int memberId) => 'shift:$memberId';

  static FutureCalls get _calls => FutureCalls();

  /// Schedules the next occurrence of every fixed time of [medicine].
  static Future<void> scheduleMedicine(
    Session session,
    Medicine medicine,
  ) async {
    final child = await Child.db.findById(session, medicine.childId);
    if (child == null) return;
    final now = DateTime.now().toUtc();
    for (final time in medicine.fixedTimes) {
      if (parseFixedTime(time) == null) continue;
      final due = nextDueAt(time, now, child.utcOffsetMinutes);
      await _calls
          .callAtTime(due, identifier: _slotId(medicine.id!, due))
          .escalation
          .slotDue(medicine.id!, due);
    }
  }

  /// Cancels every pending slot and check for [medicine], e.g. before its
  /// fixed times are edited. Identifiers are keyed by due time, so this
  /// cancels the next 24 hours of slots from now.
  static Future<void> cancelMedicine(Session session, Medicine medicine) async {
    final child = await Child.db.findById(session, medicine.childId);
    if (child == null) return;
    final now = DateTime.now().toUtc();
    for (final time in medicine.fixedTimes) {
      if (parseFixedTime(time) == null) continue;
      final next = nextDueAt(time, now, child.utcOffsetMinutes);
      for (final due in [next, next.subtract(const Duration(days: 1))]) {
        await _calls.cancel(_slotId(medicine.id!, due));
        await _calls.cancel(_checksId(medicine.id!, due));
      }
    }
  }

  static Future<void> onSlotDue(
    Session session,
    int medicineId,
    DateTime dueAt,
  ) async {
    final medicine = await Medicine.db.findById(session, medicineId);
    if (medicine == null || medicine.archivedAt != null) return;
    final id = _checksId(medicineId, dueAt);
    await _calls
        .callAtTime(dueAt.add(OneDoseConfig.escalationStage1), identifier: id)
        .escalation
        .missedDoseCheck(medicineId, dueAt, 1);
    await _calls
        .callAtTime(dueAt.add(OneDoseConfig.escalationStage2), identifier: id)
        .escalation
        .missedDoseCheck(medicineId, dueAt, 2);
    final tomorrow = dueAt.add(const Duration(days: 1));
    await _calls
        .callAtTime(tomorrow, identifier: _slotId(medicineId, tomorrow))
        .escalation
        .slotDue(medicineId, tomorrow);
  }

  /// Whether a dose of [medicine] was accepted close enough to [dueAt].
  static Future<bool> _slotLogged(
    Session session,
    Medicine medicine,
    DateTime dueAt,
  ) async {
    final from = dueAt.subtract(OneDoseConfig.slotWindow);
    final count = await DoseEvent.db.count(
      session,
      where: (t) =>
          t.childId.equals(medicine.childId) &
          t.ingredient.equals(medicine.ingredient) &
          t.outcome.inSet({DoseOutcome.accepted, DoseOutcome.override}) &
          t.undoneAt.equals(null) &
          (t.at > from),
    );
    return count > 0;
  }

  static Future<void> onMissedDoseCheck(
    Session session,
    int medicineId,
    DateTime dueAt,
    int stage,
  ) async {
    final medicine = await Medicine.db.findById(session, medicineId);
    if (medicine == null || medicine.archivedAt != null) return;
    // Idempotent: a dose logged in time means there is nothing to say.
    if (await _slotLogged(session, medicine, dueAt)) return;
    final child = await Child.db.findById(session, medicine.childId);
    if (child == null) return;

    final now = DateTime.now().toUtc();
    final members = await CareMember.db.find(
      session,
      where: (t) => t.childId.equals(child.id!) & t.revokedAt.equals(null),
    );
    final due = formatLocalTime(dueAt, child.utcOffsetMinutes);
    final List<CareMember> targets;
    if (stage == 1) {
      // The on-shift caregiver: an active sitter, else the parents.
      final sitters = members
          .where((m) => m.role == CareRole.sitter && _onShift(m, now))
          .toList();
      targets = sitters.isNotEmpty
          ? sitters
          : members.where((m) => m.role != CareRole.sitter).toList();
    } else {
      targets = members.where((m) => m.role == CareRole.owner).toList();
    }
    for (final m in targets) {
      await CircleEvents.post(
        session,
        CircleEvent(
          type: CircleEventType.alert,
          childId: child.id!,
          message: stage == 1
              ? '${medicine.name} (${medicine.doseText}) was due at $due '
                    'and has not been logged.'
              : 'Missed: ${medicine.name} was due at $due and nobody has '
                    'logged it.',
          targetUserId: m.userId,
          at: now,
        ),
      );
    }
  }

  /// Cancels pending escalation for the fixed-time slot a dose covers.
  static Future<void> cancelForDose(
    Session session,
    Medicine medicine,
    int utcOffsetMinutes,
    DateTime at,
  ) async {
    for (final time in medicine.fixedTimes) {
      if (parseFixedTime(time) == null) continue;
      // The slot this dose covers is the nearest fixed time within the window.
      final next = nextDueAt(time, at, utcOffsetMinutes);
      for (final due in [next, next.subtract(const Duration(days: 1))]) {
        if (due.difference(at).abs() <= OneDoseConfig.slotWindow) {
          await _calls.cancel(_checksId(medicine.id!, due));
        }
      }
    }
  }

  static bool _onShift(CareMember m, DateTime now) =>
      (m.shiftStart == null || !now.isBefore(m.shiftStart!)) &&
      (m.shiftEnd == null || now.isBefore(m.shiftEnd!));

  static Future<void> scheduleShiftExpiry(
    Session session,
    CareMember member,
  ) async {
    if (member.shiftEnd == null) return;
    await _calls
        .callAtTime(member.shiftEnd!, identifier: _shiftId(member.id!))
        .escalation
        .shiftExpiry(member.id!);
  }

  static Future<void> cancelShiftExpiry(Session session, int memberId) =>
      _calls.cancel(_shiftId(memberId));

  static Future<void> onShiftExpiry(Session session, int memberId) async {
    final member = await CareMember.db.findById(session, memberId);
    if (member == null || member.revokedAt != null) return;
    final now = DateTime.now().toUtc();
    await CareMember.db.updateRow(session, member.copyWith(revokedAt: now));
    await CircleEvents.post(
      session,
      CircleEvent(
        type: CircleEventType.shiftEnded,
        childId: member.childId,
        message: '${member.displayName}\'s shift has ended.',
        targetUserId: member.userId,
        at: now,
      ),
    );
    await CircleEvents.post(
      session,
      CircleEvent(
        type: CircleEventType.membersChanged,
        childId: member.childId,
        message: '${member.displayName}\'s shift has ended.',
        at: now,
      ),
    );
  }
}
