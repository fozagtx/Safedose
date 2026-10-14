import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import 'access.dart';
import 'circle_events.dart';
import 'config.dart';
import 'dose_rules.dart';
import 'escalation.dart';

const _counted = {DoseOutcome.accepted, DoseOutcome.override};

/// All dose safety logic. The app only displays what this decides.
class DoseService {
  static Future<Medicine> _medicine(Session session, int medicineId) async {
    final medicine = await Medicine.db.findById(session, medicineId);
    if (medicine == null || medicine.archivedAt != null) {
      throw OneDoseException(
        code: OneDoseErrorCode.notFound,
        message: 'Medicine not found.',
      );
    }
    return medicine;
  }

  /// Every medicine of the child that shares [ingredient].
  static Future<List<Medicine>> _sameIngredient(
    Session session,
    int childId,
    String ingredient, {
    Transaction? transaction,
  }) => Medicine.db.find(
    session,
    where: (t) =>
        t.childId.equals(childId) &
        t.ingredient.equals(ingredient) &
        t.archivedAt.equals(null),
    transaction: transaction,
  );

  /// Accepted doses of [ingredient] in the last 24 hours.
  static Future<List<DoseEvent>> _recentDoses(
    Session session,
    int childId,
    String ingredient,
    DateTime now, {
    Transaction? transaction,
  }) => DoseEvent.db.find(
    session,
    where: (t) =>
        t.childId.equals(childId) &
        t.ingredient.equals(ingredient) &
        t.outcome.inSet(_counted) &
        t.undoneAt.equals(null) &
        (t.at > now.subtract(const Duration(hours: 24))),
    orderBy: (t) => t.at,
    transaction: transaction,
  );

  static List<GivenDose> _given(List<DoseEvent> events) =>
      events.map((e) => GivenDose(e.at, e.caregiverName)).toList();

  /// Ensures the lock row exists. Called when a medicine is added.
  static Future<void> ensureLock(
    Session session,
    int childId,
    String ingredient,
  ) async {
    final existing = await IngredientLock.db.findFirstRow(
      session,
      where: (t) => t.childId.equals(childId) & t.ingredient.equals(ingredient),
    );
    if (existing != null) return;
    try {
      await IngredientLock.db.insertRow(
        session,
        IngredientLock(childId: childId, ingredient: ingredient),
      );
    } on DatabaseException {
      // Another request created it first (unique index). Fine.
    }
  }

  /// The core check. Runs in one transaction that holds a row lock on the
  /// (child, ingredient) row, so of two simultaneous taps exactly one wins
  /// and the other sees its dose.
  static Future<DoseResult> logDose(
    Session session,
    int medicineId, {
    String? overrideReason,
  }) async {
    final medicine = await _medicine(session, medicineId);
    final child = await requireChild(session, medicine.childId);
    final member = await requireMember(
      session,
      medicine.childId,
      roles: overrideReason != null ? {CareRole.owner} : null,
    );
    if (overrideReason != null && overrideReason.trim().length < 3) {
      throw OneDoseException(
        code: OneDoseErrorCode.invalid,
        message: 'Type a reason for the override.',
      );
    }
    await ensureLock(session, medicine.childId, medicine.ingredient);

    final result = await session.db.transaction((tx) async {
      // Lock the ingredient row. A second logDose for the same ingredient
      // waits here until this transaction commits.
      final lock = await IngredientLock.db.findFirstRow(
        session,
        where: (t) =>
            t.childId.equals(medicine.childId) &
            t.ingredient.equals(medicine.ingredient),
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      final now = DateTime.now().toUtc();
      final limits = IngredientLimits.strictest(
        await _sameIngredient(
          session,
          medicine.childId,
          medicine.ingredient,
          transaction: tx,
        ),
      );
      final recent = await _recentDoses(
        session,
        medicine.childId,
        medicine.ingredient,
        now,
        transaction: tx,
      );
      final decision = decideDose(
        now: now,
        limits: limits,
        given: _given(recent),
      );
      var message = describeDecision(
        decision,
        medicineName: medicine.name,
        ingredient: medicine.ingredient,
        sameMedicine:
            recent.isNotEmpty && recent.last.medicineId == medicine.id,
        utcOffsetMinutes: child.utcOffsetMinutes,
      );
      var outcome = decision.outcome;
      if (overrideReason != null) {
        outcome = DoseOutcome.override;
        message = decision.accepted
            ? '${medicine.name} logged (override: ${overrideReason.trim()}).'
            : 'Override: ${overrideReason.trim()}. Refusal was: $message';
      }
      final counted = _counted.contains(outcome);

      final event = await DoseEvent.db.insertRow(
        session,
        DoseEvent(
          childId: medicine.childId,
          medicineId: medicine.id!,
          medicineName: medicine.name,
          ingredient: medicine.ingredient,
          doseText: medicine.doseText,
          caregiverId: member.userId,
          caregiverName: member.displayName,
          at: now,
          outcome: outcome,
          reason: counted && overrideReason == null ? null : message,
          nextAllowedAt: counted
              ? now.add(limits.minInterval)
              : decision.nextAllowedAt,
        ),
        transaction: tx,
      );
      if (counted && lock != null) {
        await IngredientLock.db.updateRow(
          session,
          lock.copyWith(lastGivenAt: now, lastGivenBy: member.displayName),
          transaction: tx,
        );
      }
      return DoseResult(
        accepted: counted,
        outcome: outcome,
        message: message,
        givenBy: counted ? member.displayName : decision.blockingBy,
        givenAt: counted ? now : decision.blockingAt,
        nextAllowedAt: event.nextAllowedAt,
        event: event,
      );
    });

    if (result.accepted) {
      await Escalation.cancelForDose(
        session,
        medicine,
        child.utcOffsetMinutes,
        result.event.at,
      );
    }
    await CircleEvents.post(
      session,
      CircleEvent(
        type: result.accepted
            ? CircleEventType.doseAccepted
            : CircleEventType.doseRefused,
        childId: medicine.childId,
        message: result.accepted
            ? '${member.displayName} gave ${medicine.name}'
                  ' (${medicine.doseText}).'
            : '${member.displayName} was stopped from giving '
                  '${medicine.name}: ${result.message}',
        event: result.event,
        at: result.event.at,
      ),
    );
    return result;
  }

  /// Marks an accepted dose as logged by mistake. Only the person who logged
  /// it (or the owner), within [OneDoseConfig.undoWindow]. The event stays in
  /// the audit trail.
  static Future<DoseEvent> undo(Session session, int eventId) async {
    final event = await DoseEvent.db.findById(session, eventId);
    if (event == null || !_counted.contains(event.outcome)) {
      throw OneDoseException(
        code: OneDoseErrorCode.notFound,
        message: 'Nothing to undo.',
      );
    }
    final member = await requireMember(session, event.childId);
    if (event.caregiverId != member.userId && member.role != CareRole.owner) {
      throw OneDoseException(
        code: OneDoseErrorCode.notAuthorized,
        message: 'Only the person who logged it can undo it.',
      );
    }
    final now = DateTime.now().toUtc();
    if (event.undoneAt != null ||
        now.difference(event.at) > OneDoseConfig.undoWindow) {
      throw OneDoseException(
        code: OneDoseErrorCode.invalid,
        message: 'Undo is only possible for 2 minutes.',
      );
    }
    final updated = await session.db.transaction((tx) async {
      final lock = await IngredientLock.db.findFirstRow(
        session,
        where: (t) =>
            t.childId.equals(event.childId) &
            t.ingredient.equals(event.ingredient),
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      final updated = await DoseEvent.db.updateRow(
        session,
        event.copyWith(undoneAt: now),
        transaction: tx,
      );
      await DoseEvent.db.insertRow(
        session,
        event.copyWith(
          id: null,
          caregiverId: member.userId,
          caregiverName: member.displayName,
          at: now,
          outcome: DoseOutcome.undone,
          reason: 'Logged by mistake (undid ${event.caregiverName}\'s dose).',
          nextAllowedAt: null,
        ),
        transaction: tx,
      );
      if (lock != null) {
        final latest = await DoseEvent.db.findFirstRow(
          session,
          where: (t) =>
              t.childId.equals(event.childId) &
              t.ingredient.equals(event.ingredient) &
              t.outcome.inSet(_counted) &
              t.undoneAt.equals(null),
          orderByList: (t) => [t.at.desc()],
          transaction: tx,
        );
        await IngredientLock.db.updateRow(
          session,
          lock.copyWith(
            lastGivenAt: latest?.at,
            lastGivenBy: latest?.caregiverName,
          ),
          transaction: tx,
        );
      }
      return updated;
    });
    await CircleEvents.post(
      session,
      CircleEvent(
        type: CircleEventType.doseUndone,
        childId: event.childId,
        message: '${member.displayName} undid ${event.medicineName}.',
        event: updated,
        at: now,
      ),
    );
    return updated;
  }

  /// Green / amber / red for each medicine right now.
  static Future<List<MedicineStatus>> statuses(
    Session session,
    int childId,
  ) async {
    final child = await requireChild(session, childId);
    final now = DateTime.now().toUtc();
    final medicines = await Medicine.db.find(
      session,
      where: (t) => t.childId.equals(childId) & t.archivedAt.equals(null),
      orderBy: (t) => t.name,
    );
    final byIngredient = <String, List<Medicine>>{};
    for (final m in medicines) {
      byIngredient.putIfAbsent(m.ingredient, () => []).add(m);
    }
    final recentByIngredient = <String, List<DoseEvent>>{};
    for (final ingredient in byIngredient.keys) {
      recentByIngredient[ingredient] = await _recentDoses(
        session,
        childId,
        ingredient,
        now,
      );
    }
    return [
      for (final m in medicines)
        _status(
          m,
          IngredientLimits.strictest(byIngredient[m.ingredient]!),
          recentByIngredient[m.ingredient]!,
          now,
          child.utcOffsetMinutes,
        ),
    ];
  }

  static MedicineStatus _status(
    Medicine m,
    IngredientLimits limits,
    List<DoseEvent> recent,
    DateTime now,
    int offset,
  ) {
    final decision = decideDose(
      now: now,
      limits: limits,
      given: _given(recent),
    );
    final last = recent.isEmpty ? null : recent.last;
    final String message;
    if (decision.accepted) {
      message = last == null
          ? 'OK to give now.'
          : 'OK to give now. Last given by ${last.caregiverName} at '
                '${formatLocalTime(last.at, offset)}.';
    } else {
      message = describeDecision(
        decision,
        medicineName: m.name,
        ingredient: m.ingredient,
        sameMedicine: last?.medicineId == m.id,
        utcOffsetMinutes: offset,
      );
    }
    return MedicineStatus(
      medicine: m,
      light: lightFor(decision, now),
      message: message,
      lastGivenAt: last?.at,
      lastGivenBy: last?.caregiverName,
      nextAllowedAt: decision.nextAllowedAt,
      dosesLast24h: recent.length,
      maxPer24h: limits.maxPer24h,
    );
  }
}
