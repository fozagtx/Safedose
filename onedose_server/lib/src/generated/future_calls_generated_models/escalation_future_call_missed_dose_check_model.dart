/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class EscalationFutureCallMissedDoseCheckModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EscalationFutureCallMissedDoseCheckModel._({
    required this.medicineId,
    required this.dueAt,
    required this.stage,
  });

  factory EscalationFutureCallMissedDoseCheckModel({
    required int medicineId,
    required DateTime dueAt,
    required int stage,
  }) = _EscalationFutureCallMissedDoseCheckModelImpl;

  factory EscalationFutureCallMissedDoseCheckModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EscalationFutureCallMissedDoseCheckModel(
      medicineId: jsonSerialization['medicineId'] as int,
      dueAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      stage: jsonSerialization['stage'] as int,
    );
  }

  int medicineId;

  DateTime dueAt;

  int stage;

  /// Returns a shallow copy of this [EscalationFutureCallMissedDoseCheckModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EscalationFutureCallMissedDoseCheckModel copyWith({
    int? medicineId,
    DateTime? dueAt,
    int? stage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EscalationFutureCallMissedDoseCheckModel',
      'medicineId': medicineId,
      'dueAt': dueAt.toJson(),
      'stage': stage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _EscalationFutureCallMissedDoseCheckModelImpl
    extends EscalationFutureCallMissedDoseCheckModel {
  _EscalationFutureCallMissedDoseCheckModelImpl({
    required int medicineId,
    required DateTime dueAt,
    required int stage,
  }) : super._(
         medicineId: medicineId,
         dueAt: dueAt,
         stage: stage,
       );

  /// Returns a shallow copy of this [EscalationFutureCallMissedDoseCheckModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EscalationFutureCallMissedDoseCheckModel copyWith({
    int? medicineId,
    DateTime? dueAt,
    int? stage,
  }) {
    return EscalationFutureCallMissedDoseCheckModel(
      medicineId: medicineId ?? this.medicineId,
      dueAt: dueAt ?? this.dueAt,
      stage: stage ?? this.stage,
    );
  }
}
