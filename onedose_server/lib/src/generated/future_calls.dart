/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: depend_on_referenced_packages

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:clock/clock.dart' as _io0w16m8;
import 'package:serverpod/serverpod.dart' as _is;
import '../onedose/future_calls/escalation_future_call.dart' as _i93k4keb;
import 'future_calls_generated_models/escalation_future_call_missed_dose_check_model.dart'
    as _i6rfisfz;
import 'future_calls_generated_models/escalation_future_call_shift_expiry_model.dart'
    as _iu2jkarh;
import 'future_calls_generated_models/escalation_future_call_slot_due_model.dart'
    as _ihh2y04m;

/// Invokes a future call.
typedef _InvokeFutureCall =
    Future<void> Function(String name, _is.SerializableModel? object);

extension ServerpodFutureCallsGetter on _is.Serverpod {
  /// Generated future calls.
  FutureCalls get futureCalls => FutureCalls();
}

class FutureCalls extends _is.FutureCallDispatch<_FutureCallRef> {
  FutureCalls._();

  factory FutureCalls() {
    return _instance;
  }

  static final FutureCalls _instance = FutureCalls._();

  _is.FutureCallManager? _futureCallManager;

  String? _serverId;

  String get _effectiveServerId {
    if (_serverId == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _serverId!;
  }

  _is.FutureCallManager get _effectiveFutureCallManager {
    if (_futureCallManager == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _futureCallManager!;
  }

  @override
  void initialize(
    _is.FutureCallManager futureCallManager,
    String serverId,
  ) {
    var registeredFutureCalls = <String, _is.InvokableFutureCall>{
      'EscalationSlotDueFutureCall': EscalationSlotDueFutureCall(),
      'EscalationMissedDoseCheckFutureCall':
          EscalationMissedDoseCheckFutureCall(),
      'EscalationShiftExpiryFutureCall': EscalationShiftExpiryFutureCall(),
    };
    _futureCallManager = futureCallManager;
    _serverId = serverId;
    for (final entry in registeredFutureCalls.entries) {
      _futureCallManager?.registerFutureCall(entry.value, entry.key);
    }
  }

  @override
  _FutureCallRef callAtTime(
    DateTime time, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          time,
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _FutureCallRef callWithDelay(
    Duration delay, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          DateTime.now().toUtc().add(delay),
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _is.RecurringFutureCallDispatch<_FutureCallRef> callRecurring({
    String? identifier,
  }) {
    return _RecurringFutureCallDispatchImpl(
      _effectiveFutureCallManager,
      _effectiveServerId,
      identifier,
    );
  }

  @override
  Future<void> cancel(String identifier) async {
    await _effectiveFutureCallManager.cancelFutureCall(identifier);
  }
}

class _RecurringFutureCallDispatchImpl
    extends _is.RecurringFutureCallDispatch<_FutureCallRef> {
  _RecurringFutureCallDispatchImpl(
    this._futureCallManager,
    this._serverId,
    this._identifier,
  );

  final _is.FutureCallManager _futureCallManager;

  final String _serverId;

  final String? _identifier;

  @override
  _FutureCallRef cron(String cronExpression) {
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          _is.Cron.parse(cronExpression).nextTime(),
          _serverId,
          _identifier,
          scheduling: _is.CronFutureCallScheduling(cron: cronExpression),
        );
      },
    );
  }

  @override
  _FutureCallRef every(
    Duration interval, {
    DateTime? start,
  }) {
    final now = _io0w16m8.clock.now().toUtc();
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          start ?? now.add(interval),
          _serverId,
          _identifier,
          scheduling: _is.IntervalFutureCallScheduling(
            interval: interval,
            start: start,
          ),
        );
      },
    );
  }
}

class _FutureCallRef {
  _FutureCallRef(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  late final escalation = _EscalationFutureCallDispatcher(_invokeFutureCall);
}

class _EscalationFutureCallDispatcher {
  _EscalationFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> slotDue(
    int medicineId,
    DateTime dueAt,
  ) {
    var object = _ihh2y04m.EscalationFutureCallSlotDueModel(
      medicineId: medicineId,
      dueAt: dueAt,
    );
    return _invokeFutureCall(
      'EscalationSlotDueFutureCall',
      object,
    );
  }

  Future<void> missedDoseCheck(
    int medicineId,
    DateTime dueAt,
    int stage,
  ) {
    var object = _i6rfisfz.EscalationFutureCallMissedDoseCheckModel(
      medicineId: medicineId,
      dueAt: dueAt,
      stage: stage,
    );
    return _invokeFutureCall(
      'EscalationMissedDoseCheckFutureCall',
      object,
    );
  }

  Future<void> shiftExpiry(int memberId) {
    var object = _iu2jkarh.EscalationFutureCallShiftExpiryModel(
      memberId: memberId,
    );
    return _invokeFutureCall(
      'EscalationShiftExpiryFutureCall',
      object,
    );
  }
}

/// Runs at a fixed dose time: schedules that slot's escalation checks and
/// the same slot tomorrow.
class EscalationSlotDueFutureCall
    extends _is.FutureCall<_ihh2y04m.EscalationFutureCallSlotDueModel>
    implements
        _is.InvokableFutureCall<_ihh2y04m.EscalationFutureCallSlotDueModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _ihh2y04m.EscalationFutureCallSlotDueModel? object,
  ) async {
    if (object != null) {
      await _i93k4keb.EscalationFutureCall().slotDue(
        session,
        object.medicineId,
        object.dueAt,
      );
    }
  }
}

/// Stage 1 alerts the on-shift caregivers, stage 2 the owner.
class EscalationMissedDoseCheckFutureCall
    extends _is.FutureCall<_i6rfisfz.EscalationFutureCallMissedDoseCheckModel>
    implements
        _is.InvokableFutureCall<
          _i6rfisfz.EscalationFutureCallMissedDoseCheckModel
        > {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _i6rfisfz.EscalationFutureCallMissedDoseCheckModel? object,
  ) async {
    if (object != null) {
      await _i93k4keb.EscalationFutureCall().missedDoseCheck(
        session,
        object.medicineId,
        object.dueAt,
        object.stage,
      );
    }
  }
}

/// Runs at a sitter's shift end: revokes access and closes their stream.
class EscalationShiftExpiryFutureCall
    extends _is.FutureCall<_iu2jkarh.EscalationFutureCallShiftExpiryModel>
    implements
        _is.InvokableFutureCall<
          _iu2jkarh.EscalationFutureCallShiftExpiryModel
        > {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _iu2jkarh.EscalationFutureCallShiftExpiryModel? object,
  ) async {
    if (object != null) {
      await _i93k4keb.EscalationFutureCall().shiftExpiry(
        session,
        object.memberId,
      );
    }
  }
}
