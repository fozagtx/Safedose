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

abstract class EscalationFutureCallSlotDueModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EscalationFutureCallSlotDueModel._({
    required this.medicineId,
    required this.dueAt,
  });

  factory EscalationFutureCallSlotDueModel({
    required int medicineId,
    required DateTime dueAt,
  }) = _EscalationFutureCallSlotDueModelImpl;

  factory EscalationFutureCallSlotDueModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EscalationFutureCallSlotDueModel(
      medicineId: jsonSerialization['medicineId'] as int,
      dueAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
    );
  }

  int medicineId;

  DateTime dueAt;

  /// Returns a shallow copy of this [EscalationFutureCallSlotDueModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EscalationFutureCallSlotDueModel copyWith({
    int? medicineId,
    DateTime? dueAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EscalationFutureCallSlotDueModel',
      'medicineId': medicineId,
      'dueAt': dueAt.toJson(),
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

class _EscalationFutureCallSlotDueModelImpl
    extends EscalationFutureCallSlotDueModel {
  _EscalationFutureCallSlotDueModelImpl({
    required int medicineId,
    required DateTime dueAt,
  }) : super._(
         medicineId: medicineId,
         dueAt: dueAt,
       );

  /// Returns a shallow copy of this [EscalationFutureCallSlotDueModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EscalationFutureCallSlotDueModel copyWith({
    int? medicineId,
    DateTime? dueAt,
  }) {
    return EscalationFutureCallSlotDueModel(
      medicineId: medicineId ?? this.medicineId,
      dueAt: dueAt ?? this.dueAt,
    );
  }
}
