import '../../generated/protocol.dart';

/// The limits that apply to one active ingredient: the strictest of every
/// medicine that contains it, so a second product can never loosen them.
class IngredientLimits {
  final double minHoursBetween;
  final int maxPer24h;

  const IngredientLimits(this.minHoursBetween, this.maxPer24h);

  factory IngredientLimits.strictest(Iterable<Medicine> medicines) {
    var minHours = 0.0;
    int? maxDaily;
    for (final m in medicines) {
      if (m.minHoursBetween > minHours) minHours = m.minHoursBetween;
      if (maxDaily == null || m.maxPer24h < maxDaily) maxDaily = m.maxPer24h;
    }
    return IngredientLimits(minHours, maxDaily ?? 0);
  }

  Duration get minInterval =>
      Duration(milliseconds: (minHoursBetween * 3600 * 1000).round());
}

/// Outcome of checking one dose against the history of its ingredient.
class DoseDecision {
  final DoseOutcome outcome;
  final DateTime? nextAllowedAt;

  /// The dose that blocks this one (the last one for an interval refusal,
  /// the oldest in the window for a daily maximum refusal).
  final DateTime? blockingAt;
  final String? blockingBy;

  const DoseDecision(
    this.outcome, {
    this.nextAllowedAt,
    this.blockingAt,
    this.blockingBy,
  });

  bool get accepted => outcome == DoseOutcome.accepted;
}

/// A dose that counts against the limits.
class GivenDose {
  final DateTime at;
  final String by;
  const GivenDose(this.at, this.by);
}

/// Pure decision logic, kept apart from the database so it can be unit
/// tested. [given] are the doses of the same ingredient, any order.
DoseDecision decideDose({
  required DateTime now,
  required IngredientLimits limits,
  required List<GivenDose> given,
}) {
  final sorted = [...given]..sort((a, b) => a.at.compareTo(b.at));
  final last = sorted.isEmpty ? null : sorted.last;

  if (last != null) {
    final next = last.at.add(limits.minInterval);
    if (now.isBefore(next)) {
      return DoseDecision(
        DoseOutcome.refusedInterval,
        nextAllowedAt: next,
        blockingAt: last.at,
        blockingBy: last.by,
      );
    }
  }

  final windowStart = now.subtract(const Duration(hours: 24));
  final inWindow = sorted.where((d) => d.at.isAfter(windowStart)).toList();
  if (limits.maxPer24h > 0 && inWindow.length >= limits.maxPer24h) {
    // The window frees up when the oldest dose that keeps it full drops out.
    final oldest = inWindow[inWindow.length - limits.maxPer24h];
    return DoseDecision(
      DoseOutcome.refusedDailyMax,
      nextAllowedAt: oldest.at.add(const Duration(hours: 24)),
      blockingAt: oldest.at,
      blockingBy: oldest.by,
    );
  }

  return const DoseDecision(DoseOutcome.accepted);
}

/// Formats a UTC time in the family's local time, e.g. "6:02pm".
String formatLocalTime(DateTime utc, int utcOffsetMinutes) {
  final local = utc.toUtc().add(Duration(minutes: utcOffsetMinutes));
  final h = local.hour % 12 == 0 ? 12 : local.hour % 12;
  final m = local.minute.toString().padLeft(2, '0');
  return '$h:$m${local.hour < 12 ? 'am' : 'pm'}';
}

/// The refusal or acceptance sentence shown to the caregiver.
String describeDecision(
  DoseDecision d, {
  required String medicineName,
  required String ingredient,
  required bool sameMedicine,
  required int utcOffsetMinutes,
}) {
  String t(DateTime x) => formatLocalTime(x, utcOffsetMinutes);
  switch (d.outcome) {
    case DoseOutcome.refusedInterval:
      final what = sameMedicine
          ? 'Already given'
          : 'Contains $ingredient, already given';
      return '$what by ${d.blockingBy} at ${t(d.blockingAt!)}. '
          'Next allowed ${t(d.nextAllowedAt!)}.';
    case DoseOutcome.refusedDailyMax:
      return 'Daily maximum for $ingredient reached. Oldest dose was given '
          'by ${d.blockingBy} at ${t(d.blockingAt!)}. '
          'Next allowed ${t(d.nextAllowedAt!)}.';
    default:
      return '$medicineName logged.';
  }
}

/// Parses "HH:mm". Returns null when malformed.
({int hour, int minute})? parseFixedTime(String s) {
  final m = RegExp(r'^(\d{1,2}):(\d{2})$').firstMatch(s.trim());
  if (m == null) return null;
  final h = int.parse(m.group(1)!);
  final min = int.parse(m.group(2)!);
  if (h > 23 || min > 59) return null;
  return (hour: h, minute: min);
}

/// The next UTC instant strictly after [after] at which [fixedTime] (local)
/// falls.
DateTime nextDueAt(String fixedTime, DateTime after, int utcOffsetMinutes) {
  final t = parseFixedTime(fixedTime)!;
  final offset = Duration(minutes: utcOffsetMinutes);
  final local = after.toUtc().add(offset);
  var candidate = DateTime.utc(
    local.year,
    local.month,
    local.day,
    t.hour,
    t.minute,
  ).subtract(offset);
  while (!candidate.isAfter(after)) {
    candidate = candidate.add(const Duration(days: 1));
  }
  return candidate;
}

/// Traffic light for the status card.
/// red: daily maximum reached, or locked for more than another hour.
/// amber: locked, but allowed within the hour.
/// green: can be given now.
StatusLight lightFor(DoseDecision d, DateTime now) {
  if (d.accepted) return StatusLight.green;
  if (d.outcome == DoseOutcome.refusedDailyMax) return StatusLight.red;
  final wait = d.nextAllowedAt!.difference(now);
  return wait > const Duration(hours: 1) ? StatusLight.red : StatusLight.amber;
}

String normaliseIngredient(String s) =>
    s.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
