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
import 'package:onedose_server/src/generated/protocol.dart' as _i5l0e3aj;
import 'package:serverpod/serverpod.dart' as _is;
import '../../onedose/models/dose_event.dart' as _ifcdgtyo;
import '../../onedose/models/dose_outcome.dart' as _ib9gikq8;

/// What the server decided about one tap on "Give dose".
abstract class DoseResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DoseResult._({
    required this.accepted,
    required this.outcome,
    required this.message,
    this.givenBy,
    this.givenAt,
    this.nextAllowedAt,
    required this.event,
  });

  factory DoseResult({
    required bool accepted,
    required _ib9gikq8.DoseOutcome outcome,
    required String message,
    String? givenBy,
    DateTime? givenAt,
    DateTime? nextAllowedAt,
    required _ifcdgtyo.DoseEvent event,
  }) = _DoseResultImpl;

  factory DoseResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return DoseResult(
      accepted: _is.BoolJsonExtension.fromJson(jsonSerialization['accepted']),
      outcome: _ib9gikq8.DoseOutcome.fromJson(
        (jsonSerialization['outcome'] as String),
      ),
      message: jsonSerialization['message'] as String,
      givenBy: jsonSerialization['givenBy'] as String?,
      givenAt: jsonSerialization['givenAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['givenAt']),
      nextAllowedAt: jsonSerialization['nextAllowedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextAllowedAt'],
            ),
      event: _i5l0e3aj.Protocol().deserialize<_ifcdgtyo.DoseEvent>(
        jsonSerialization['event'],
      ),
    );
  }

  bool accepted;

  _ib9gikq8.DoseOutcome outcome;

  String message;

  String? givenBy;

  DateTime? givenAt;

  DateTime? nextAllowedAt;

  _ifcdgtyo.DoseEvent event;

  /// Returns a shallow copy of this [DoseResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DoseResult copyWith({
    bool? accepted,
    _ib9gikq8.DoseOutcome? outcome,
    String? message,
    String? givenBy,
    DateTime? givenAt,
    DateTime? nextAllowedAt,
    _ifcdgtyo.DoseEvent? event,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DoseResult',
      'accepted': accepted,
      'outcome': outcome.toJson(),
      'message': message,
      if (givenBy != null) 'givenBy': givenBy,
      if (givenAt != null) 'givenAt': givenAt?.toJson(),
      if (nextAllowedAt != null) 'nextAllowedAt': nextAllowedAt?.toJson(),
      'event': event.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DoseResult',
      'accepted': accepted,
      'outcome': outcome.toJson(),
      'message': message,
      if (givenBy != null) 'givenBy': givenBy,
      if (givenAt != null) 'givenAt': givenAt?.toJson(),
      if (nextAllowedAt != null) 'nextAllowedAt': nextAllowedAt?.toJson(),
      'event': event.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DoseResultImpl extends DoseResult {
  _DoseResultImpl({
    required bool accepted,
    required _ib9gikq8.DoseOutcome outcome,
    required String message,
    String? givenBy,
    DateTime? givenAt,
    DateTime? nextAllowedAt,
    required _ifcdgtyo.DoseEvent event,
  }) : super._(
         accepted: accepted,
         outcome: outcome,
         message: message,
         givenBy: givenBy,
         givenAt: givenAt,
         nextAllowedAt: nextAllowedAt,
         event: event,
       );

  /// Returns a shallow copy of this [DoseResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DoseResult copyWith({
    bool? accepted,
    _ib9gikq8.DoseOutcome? outcome,
    String? message,
    Object? givenBy = _Undefined,
    Object? givenAt = _Undefined,
    Object? nextAllowedAt = _Undefined,
    _ifcdgtyo.DoseEvent? event,
  }) {
    return DoseResult(
      accepted: accepted ?? this.accepted,
      outcome: outcome ?? this.outcome,
      message: message ?? this.message,
      givenBy: givenBy is String? ? givenBy : this.givenBy,
      givenAt: givenAt is DateTime? ? givenAt : this.givenAt,
      nextAllowedAt: nextAllowedAt is DateTime?
          ? nextAllowedAt
          : this.nextAllowedAt,
      event: event ?? this.event.copyWith(),
    );
  }
}
