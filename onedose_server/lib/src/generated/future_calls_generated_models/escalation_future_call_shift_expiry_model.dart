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

abstract class EscalationFutureCallShiftExpiryModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EscalationFutureCallShiftExpiryModel._({required this.memberId});

  factory EscalationFutureCallShiftExpiryModel({required int memberId}) =
      _EscalationFutureCallShiftExpiryModelImpl;

  factory EscalationFutureCallShiftExpiryModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EscalationFutureCallShiftExpiryModel(
      memberId: jsonSerialization['memberId'] as int,
    );
  }

  int memberId;

  /// Returns a shallow copy of this [EscalationFutureCallShiftExpiryModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EscalationFutureCallShiftExpiryModel copyWith({int? memberId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EscalationFutureCallShiftExpiryModel',
      'memberId': memberId,
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

class _EscalationFutureCallShiftExpiryModelImpl
    extends EscalationFutureCallShiftExpiryModel {
  _EscalationFutureCallShiftExpiryModelImpl({required int memberId})
    : super._(memberId: memberId);

  /// Returns a shallow copy of this [EscalationFutureCallShiftExpiryModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EscalationFutureCallShiftExpiryModel copyWith({int? memberId}) {
    return EscalationFutureCallShiftExpiryModel(
      memberId: memberId ?? this.memberId,
    );
  }
}
