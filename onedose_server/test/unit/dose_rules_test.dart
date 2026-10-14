import 'package:onedose_server/src/generated/protocol.dart';
import 'package:onedose_server/src/onedose/logic/dose_rules.dart';
import 'package:test/test.dart';

void main() {
  final t0 = DateTime.utc(2026, 10, 14, 18, 0);
  const fourHours = IngredientLimits(4, 4);

  group('Given paracetamol given at 18:00 with a 4 hour minimum', () {
    final given = [GivenDose(t0, 'Mum')];

    test('when checked at 19:30 then refused until 22:00', () {
      final d = decideDose(
        now: t0.add(const Duration(minutes: 90)),
        limits: fourHours,
        given: given,
      );
      expect(d.outcome, DoseOutcome.refusedInterval);
      expect(d.nextAllowedAt, DateTime.utc(2026, 10, 14, 22, 0));
      expect(d.blockingBy, 'Mum');
    });

    test('when checked at 22:00 then accepted', () {
      final d = decideDose(
        now: t0.add(const Duration(hours: 4)),
        limits: fourHours,
        given: given,
      );
      expect(d.accepted, isTrue);
    });

    test('when described for another product then names the ingredient', () {
      final d = decideDose(
        now: t0.add(const Duration(minutes: 90)),
        limits: fourHours,
        given: given,
      );
      expect(
        describeDecision(
          d,
          medicineName: 'Cold remedy',
          ingredient: 'paracetamol',
          sameMedicine: false,
          utcOffsetMinutes: 0,
        ),
        'Contains paracetamol, already given by Mum at 6:00pm. '
        'Next allowed 10:00pm.',
      );
    });
  });

  group('Given 4 doses in the last 24 hours and a maximum of 4', () {
    final given = [
      for (var i = 0; i < 4; i++)
        GivenDose(t0.add(Duration(hours: 4 * i)), 'Mum'),
    ];

    test('when a 5th is checked then refused until the oldest drops out', () {
      final d = decideDose(
        now: t0.add(const Duration(hours: 17)),
        limits: fourHours,
        given: given,
      );
      expect(d.outcome, DoseOutcome.refusedDailyMax);
      expect(d.blockingAt, t0);
      expect(d.nextAllowedAt, t0.add(const Duration(hours: 24)));
    });
  });

  test('Given two products when limits combine then the strictest wins', () {
    final limits = IngredientLimits.strictest([
      _med(minHours: 4, max: 4),
      _med(minHours: 6, max: 5),
    ]);
    expect(limits.minHoursBetween, 6);
    expect(limits.maxPer24h, 4);
  });

  group('nextDueAt', () {
    test('when the time is later today then returns today', () {
      expect(
        nextDueAt('20:00', DateTime.utc(2026, 10, 14, 10), 0),
        DateTime.utc(2026, 10, 14, 20),
      );
    });
    test('when the time has passed then returns tomorrow', () {
      expect(
        nextDueAt('08:00', DateTime.utc(2026, 10, 14, 10), 0),
        DateTime.utc(2026, 10, 15, 8),
      );
    });
    test('when local time is UTC+1 then converts to UTC', () {
      expect(
        nextDueAt('20:00', DateTime.utc(2026, 10, 14, 10), 60),
        DateTime.utc(2026, 10, 14, 19),
      );
    });
  });

  test('formatLocalTime uses 12 hour clock', () {
    expect(formatLocalTime(DateTime.utc(2026, 1, 1, 18, 2), 0), '6:02pm');
    expect(formatLocalTime(DateTime.utc(2026, 1, 1, 0, 5), 0), '12:05am');
  });
}

Medicine _med({required double minHours, required int max}) => Medicine(
  childId: 1,
  name: 'x',
  ingredient: 'paracetamol',
  doseText: '5 ml',
  minHoursBetween: minHours,
  maxPer24h: max,
  fixedTimes: [],
);
