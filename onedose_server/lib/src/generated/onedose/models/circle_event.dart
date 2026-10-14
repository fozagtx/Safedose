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
import '../../onedose/models/circle_event_type.dart' as _icv3duft;
import '../../onedose/models/dose_event.dart' as _ifcdgtyo;
import '../../onedose/models/medicine_status.dart' as _iwxfec0v;

/// One message on a child's live stream.
abstract class CircleEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CircleEvent._({
    required this.type,
    required this.childId,
    this.message,
    this.event,
    this.statuses,
    this.targetUserId,
    required this.at,
  });

  factory CircleEvent({
    required _icv3duft.CircleEventType type,
    required int childId,
    String? message,
    _ifcdgtyo.DoseEvent? event,
    List<_iwxfec0v.MedicineStatus>? statuses,
    _is.UuidValue? targetUserId,
    required DateTime at,
  }) = _CircleEventImpl;

  factory CircleEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CircleEvent(
      type: _icv3duft.CircleEventType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      childId: jsonSerialization['childId'] as int,
      message: jsonSerialization['message'] as String?,
      event: jsonSerialization['event'] == null
          ? null
          : _i5l0e3aj.Protocol().deserialize<_ifcdgtyo.DoseEvent>(
              jsonSerialization['event'],
            ),
      statuses: jsonSerialization['statuses'] == null
          ? null
          : _i5l0e3aj.Protocol().deserialize<List<_iwxfec0v.MedicineStatus>>(
              jsonSerialization['statuses'],
            ),
      targetUserId: jsonSerialization['targetUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['targetUserId'],
            ),
      at: _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  _icv3duft.CircleEventType type;

  int childId;

  String? message;

  _ifcdgtyo.DoseEvent? event;

  List<_iwxfec0v.MedicineStatus>? statuses;

  /// When set, only this user is shown the event.
  _is.UuidValue? targetUserId;

  DateTime at;

  /// Returns a shallow copy of this [CircleEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CircleEvent copyWith({
    _icv3duft.CircleEventType? type,
    int? childId,
    String? message,
    _ifcdgtyo.DoseEvent? event,
    List<_iwxfec0v.MedicineStatus>? statuses,
    _is.UuidValue? targetUserId,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CircleEvent',
      'type': type.toJson(),
      'childId': childId,
      if (message != null) 'message': message,
      if (event != null) 'event': event?.toJson(),
      if (statuses != null)
        'statuses': statuses?.toJson(valueToJson: (v) => v.toJson()),
      if (targetUserId != null) 'targetUserId': targetUserId?.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CircleEvent',
      'type': type.toJson(),
      'childId': childId,
      if (message != null) 'message': message,
      if (event != null) 'event': event?.toJsonForProtocol(),
      if (statuses != null)
        'statuses': statuses?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (targetUserId != null) 'targetUserId': targetUserId?.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CircleEventImpl extends CircleEvent {
  _CircleEventImpl({
    required _icv3duft.CircleEventType type,
    required int childId,
    String? message,
    _ifcdgtyo.DoseEvent? event,
    List<_iwxfec0v.MedicineStatus>? statuses,
    _is.UuidValue? targetUserId,
    required DateTime at,
  }) : super._(
         type: type,
         childId: childId,
         message: message,
         event: event,
         statuses: statuses,
         targetUserId: targetUserId,
         at: at,
       );

  /// Returns a shallow copy of this [CircleEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CircleEvent copyWith({
    _icv3duft.CircleEventType? type,
    int? childId,
    Object? message = _Undefined,
    Object? event = _Undefined,
    Object? statuses = _Undefined,
    Object? targetUserId = _Undefined,
    DateTime? at,
  }) {
    return CircleEvent(
      type: type ?? this.type,
      childId: childId ?? this.childId,
      message: message is String? ? message : this.message,
      event: event is _ifcdgtyo.DoseEvent? ? event : this.event?.copyWith(),
      statuses: statuses is List<_iwxfec0v.MedicineStatus>?
          ? statuses
          : this.statuses?.map((e0) => e0.copyWith()).toList(),
      targetUserId: targetUserId is _is.UuidValue?
          ? targetUserId
          : this.targetUserId,
      at: at ?? this.at,
    );
  }
}
