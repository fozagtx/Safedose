import 'dart:async';

import 'package:onedose_server/src/generated/protocol.dart';
import 'package:onedose_server/src/onedose/logic/escalation.dart';
import 'package:serverpod/serverpod.dart' show UuidValue;
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const mumId = '11111111-1111-4111-8111-111111111111';
const grandpaId = '22222222-2222-4222-8222-222222222222';
const strangerId = '33333333-3333-4333-8333-333333333333';

TestSessionBuilder as(TestSessionBuilder b, String id) => b.copyWith(
  authentication: AuthenticationOverride.authenticationInfo(id, {}),
);

/// A child with a parent, Calpol (paracetamol, 4h, max 4) and a cold
/// remedy that also contains paracetamol.
class Circle {
  final int childId;
  final Medicine calpol;
  final Medicine coldRemedy;
  Circle(this.childId, this.calpol, this.coldRemedy);
}

Future<Circle> setUpCircle(
  TestSessionBuilder b,
  TestEndpoints endpoints,
) async {
  final mum = as(b, mumId);
  final summary = await endpoints.child.create(
    mum,
    name: 'Maya',
    ownerName: 'Mum',
    utcOffsetMinutes: 0,
  );
  final childId = summary.child.id!;
  final calpol = await endpoints.medicine.add(
    mum,
    Medicine(
      childId: childId,
      name: 'Calpol',
      ingredient: ' Paracetamol ',
      doseText: '5 ml',
      minHoursBetween: 4,
      maxPer24h: 4,
      fixedTimes: [],
    ),
  );
  final cold = await endpoints.medicine.add(
    mum,
    Medicine(
      childId: childId,
      name: 'Cold remedy',
      ingredient: 'paracetamol',
      doseText: '10 ml',
      minHoursBetween: 4,
      maxPer24h: 4,
      fixedTimes: [],
    ),
  );
  return Circle(childId, calpol, cold);
}

Future<void> addSitter(
  TestSessionBuilder b,
  TestEndpoints endpoints,
  int childId, {
  required DateTime start,
  required DateTime end,
}) async {
  final invite = await endpoints.invite.create(
    as(b, mumId),
    childId: childId,
    displayName: 'Grandpa',
    role: CareRole.sitter,
    shiftStart: start,
    shiftEnd: end,
  );
  await endpoints.invite.accept(as(b, grandpaId), invite.token);
}

Matcher throwsCode(OneDoseErrorCode code) =>
    throwsA(isA<OneDoseException>().having((e) => e.code, 'code', code));

void main() {
  withServerpod(
    'Given two caregivers tapping at the same moment',
    (b, endpoints) {
      test('R1: then exactly one dose is accepted', () async {
        final c = await setUpCircle(b, endpoints);
        final now = DateTime.now().toUtc();
        await addSitter(
          b,
          endpoints,
          c.childId,
          start: now.subtract(const Duration(minutes: 1)),
          end: now.add(const Duration(hours: 1)),
        );

        final results = await Future.wait([
          endpoints.dose.logDose(as(b, mumId), c.calpol.id!),
          endpoints.dose.logDose(as(b, grandpaId), c.calpol.id!),
        ]);

        final accepted = results.where((r) => r.accepted).toList();
        final refused = results.where((r) => !r.accepted).toList();
        expect(accepted, hasLength(1));
        expect(refused, hasLength(1));
        expect(refused.single.outcome, DoseOutcome.refusedInterval);
        expect(refused.single.givenBy, accepted.single.event.caregiverName);
        expect(refused.single.message, startsWith('Already given by'));

        final history = await endpoints.history.list(
          as(b, mumId),
          c.childId,
        );
        expect(history, hasLength(2), reason: 'both attempts are audited');
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );

  withServerpod('Given Calpol was just given', (b, endpoints) {
    test('R2: when a cold remedy with paracetamol is given then refused '
        'by ingredient', () async {
      final c = await setUpCircle(b, endpoints);
      final first = await endpoints.dose.logDose(as(b, mumId), c.calpol.id!);
      expect(first.accepted, isTrue);

      final second = await endpoints.dose.logDose(
        as(b, mumId),
        c.coldRemedy.id!,
      );
      expect(second.accepted, isFalse);
      expect(second.message, contains('Contains paracetamol'));
      expect(
        second.nextAllowedAt,
        first.event.at.add(const Duration(hours: 4)),
      );

      final status = await endpoints.dose.status(as(b, mumId), c.childId);
      expect(status.map((s) => s.light), everyElement(StatusLight.red));
    });

    test('when the owner overrides with a reason then it is logged as an '
        'override', () async {
      final c = await setUpCircle(b, endpoints);
      await endpoints.dose.logDose(as(b, mumId), c.calpol.id!);
      final r = await endpoints.dose.overrideDose(
        as(b, mumId),
        c.calpol.id!,
        'Doctor said 3 hours',
      );
      expect(r.accepted, isTrue);
      expect(r.outcome, DoseOutcome.override);
    });

    test('when it is undone then Calpol can be given again', () async {
      final c = await setUpCircle(b, endpoints);
      final first = await endpoints.dose.logDose(as(b, mumId), c.calpol.id!);
      await endpoints.dose.undo(as(b, mumId), first.event.id!);
      final again = await endpoints.dose.logDose(as(b, mumId), c.calpol.id!);
      expect(again.accepted, isTrue);
    });
  });

  withServerpod('Given four doses in the last 24 hours', (b, endpoints) {
    test('R3: then the 5th is refused naming the oldest dose', () async {
      final c = await setUpCircle(b, endpoints);
      final session = b.build();
      final now = DateTime.now().toUtc();
      for (var i = 0; i < 4; i++) {
        await DoseEvent.db.insertRow(
          session,
          DoseEvent(
            childId: c.childId,
            medicineId: c.calpol.id!,
            medicineName: 'Calpol',
            ingredient: 'paracetamol',
            doseText: '5 ml',
            caregiverId: UuidValue.fromString(mumId),
            caregiverName: 'Mum',
            at: now.subtract(Duration(hours: 20 - 5 * i)),
            outcome: DoseOutcome.accepted,
          ),
        );
      }
      final r = await endpoints.dose.logDose(as(b, mumId), c.calpol.id!);
      expect(r.outcome, DoseOutcome.refusedDailyMax);
      expect(r.message, startsWith('Daily maximum for paracetamol reached'));
      expect(r.givenAt, now.subtract(const Duration(hours: 20)));
    });
  });

  withServerpod('Given a live circle stream', (b, endpoints) {
    test('R4: when a dose is accepted then the other phone gets it', () async {
      final c = await setUpCircle(b, endpoints);
      final now = DateTime.now().toUtc();
      await addSitter(
        b,
        endpoints,
        c.childId,
        start: now.subtract(const Duration(minutes: 1)),
        end: now.add(const Duration(hours: 1)),
      );
      final stream = endpoints.circle.watch(as(b, grandpaId), c.childId);
      final received = <CircleEvent>[];
      final sub = stream.listen(received.add);
      await flushEventQueue();

      await endpoints.dose.logDose(as(b, mumId), c.calpol.id!);
      await flushEventQueue();
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await sub.cancel();

      expect(received.first.type, CircleEventType.snapshot);
      final accepted = received.firstWhere(
        (e) => e.type == CircleEventType.doseAccepted,
      );
      expect(accepted.event!.caregiverName, 'Mum');
      expect(
        accepted.statuses!.firstWhere((s) => s.medicine.name == 'Calpol').light,
        StatusLight.red,
      );
    });
  }, rollbackDatabase: RollbackDatabase.disabled);

  withServerpod('Given a sitter invited for a later shift', (b, endpoints) {
    test('R7: then they cannot log before it starts', () async {
      final c = await setUpCircle(b, endpoints);
      final now = DateTime.now().toUtc();
      await addSitter(
        b,
        endpoints,
        c.childId,
        start: now.add(const Duration(hours: 1)),
        end: now.add(const Duration(hours: 5)),
      );
      await expectLater(
        endpoints.dose.logDose(as(b, grandpaId), c.calpol.id!),
        throwsCode(OneDoseErrorCode.notAuthorized),
      );
    });
  });

  withServerpod('Given a sitter on shift with an open stream', (b, endpoints) {
    test('R7: when the shift expires then the stream closes and calls '
        'fail', () async {
      final c = await setUpCircle(b, endpoints);
      final now = DateTime.now().toUtc();
      await addSitter(
        b,
        endpoints,
        c.childId,
        start: now.subtract(const Duration(minutes: 1)),
        end: now.add(const Duration(hours: 1)),
      );
      final received = <CircleEvent>[];
      Object? error;
      final done = Completer<void>();
      endpoints.circle
          .watch(as(b, grandpaId), c.childId)
          .listen(
            received.add,
            onError: (Object e) => error = e,
            onDone: done.complete,
          );
      await flushEventQueue();

      final session = b.build();
      final member = await CareMember.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(UuidValue.fromString(grandpaId)),
      );
      // What the ShiftExpiry future call runs at shift end.
      await Escalation.onShiftExpiry(session, member!.id!);
      await done.future.timeout(const Duration(seconds: 5));

      expect(received.last.type, CircleEventType.shiftEnded);
      expect(error, isNotNull, reason: 'the server closes the stream');
      await expectLater(
        endpoints.dose.logDose(as(b, grandpaId), c.calpol.id!),
        throwsCode(OneDoseErrorCode.notAuthorized),
      );
    });
  }, rollbackDatabase: RollbackDatabase.disabled);

  withServerpod('Given earlier doses and a sitter', (b, endpoints) {
    test('R8: then the sitter only sees their shift', () async {
      final c = await setUpCircle(b, endpoints);
      final session = b.build();
      final now = DateTime.now().toUtc();
      await DoseEvent.db.insertRow(
        session,
        DoseEvent(
          childId: c.childId,
          medicineId: c.calpol.id!,
          medicineName: 'Calpol',
          ingredient: 'paracetamol',
          doseText: '5 ml',
          caregiverId: UuidValue.fromString(mumId),
          caregiverName: 'Mum',
          at: now.subtract(const Duration(hours: 6)),
          outcome: DoseOutcome.accepted,
        ),
      );
      await addSitter(
        b,
        endpoints,
        c.childId,
        start: now.subtract(const Duration(minutes: 1)),
        end: now.add(const Duration(hours: 1)),
      );
      await endpoints.dose.logDose(as(b, grandpaId), c.calpol.id!);

      final sitterView = await endpoints.history.list(
        as(b, grandpaId),
        c.childId,
      );
      final parentView = await endpoints.history.list(
        as(b, mumId),
        c.childId,
      );
      expect(sitterView, hasLength(1));
      expect(parentView, hasLength(2));
    });

    test('R10: then a sitter cannot change medicine limits', () async {
      final c = await setUpCircle(b, endpoints);
      final now = DateTime.now().toUtc();
      await addSitter(
        b,
        endpoints,
        c.childId,
        start: now.subtract(const Duration(minutes: 1)),
        end: now.add(const Duration(hours: 1)),
      );
      await expectLater(
        endpoints.medicine.update(
          as(b, grandpaId),
          c.calpol.copyWith(minHoursBetween: 1),
        ),
        throwsCode(OneDoseErrorCode.notAuthorized),
      );
    });

    test('then a stranger cannot read anything', () async {
      final c = await setUpCircle(b, endpoints);
      await expectLater(
        endpoints.dose.status(as(b, strangerId), c.childId),
        throwsCode(OneDoseErrorCode.notAuthorized),
      );
    });
  });

  withServerpod('Given a fixed-time antibiotic that was not logged', (
    b,
    endpoints,
  ) {
    test('R5: then stage 1 alerts the sitter and stage 2 the parent', () async {
      final c = await setUpCircle(b, endpoints);
      final now = DateTime.now().toUtc();
      await addSitter(
        b,
        endpoints,
        c.childId,
        start: now.subtract(const Duration(hours: 1)),
        end: now.add(const Duration(hours: 1)),
      );
      final antibiotic = await endpoints.medicine.add(
        as(b, mumId),
        Medicine(
          childId: c.childId,
          name: 'Amoxicillin',
          ingredient: 'amoxicillin',
          doseText: '5 ml',
          minHoursBetween: 8,
          maxPer24h: 3,
          fixedTimes: ['20:00'],
        ),
      );
      final sitterEvents = <CircleEvent>[];
      final mumEvents = <CircleEvent>[];
      final s1 = endpoints.circle
          .watch(as(b, grandpaId), c.childId)
          .listen(sitterEvents.add);
      final s2 = endpoints.circle
          .watch(as(b, mumId), c.childId)
          .listen(mumEvents.add);
      await flushEventQueue();

      final session = b.build();
      final due = now.subtract(const Duration(minutes: 31));
      await Escalation.onMissedDoseCheck(session, antibiotic.id!, due, 1);
      await settle();
      expect(sitterEvents.where((e) => e.type == CircleEventType.alert), [
        isA<CircleEvent>(),
      ]);
      expect(mumEvents.where((e) => e.type == CircleEventType.alert), isEmpty);

      await Escalation.onMissedDoseCheck(session, antibiotic.id!, due, 2);
      await settle();
      expect(
        mumEvents.where((e) => e.type == CircleEventType.alert),
        hasLength(1),
      );

      // Once logged, a later check is silent.
      await endpoints.dose.logDose(as(b, grandpaId), antibiotic.id!);
      await Escalation.onMissedDoseCheck(session, antibiotic.id!, due, 2);
      await settle();
      expect(
        mumEvents.where((e) => e.type == CircleEventType.alert),
        hasLength(1),
      );
      await s1.cancel();
      await s2.cancel();
    });
  }, rollbackDatabase: RollbackDatabase.disabled);
}

/// Lets server events reach open streams.
Future<void> settle() async {
  await flushEventQueue();
  await Future<void>.delayed(const Duration(milliseconds: 300));
}
