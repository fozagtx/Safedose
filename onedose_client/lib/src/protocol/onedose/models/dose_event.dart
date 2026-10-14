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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../onedose/models/dose_outcome.dart' as _ib9gikq8;

/// Every dose attempt, accepted or refused. Never deleted.
abstract class DoseEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DoseEvent._({
    this.id,
    required this.childId,
    required this.medicineId,
    required this.medicineName,
    required this.ingredient,
    required this.doseText,
    required this.caregiverId,
    required this.caregiverName,
    required this.at,
    required this.outcome,
    this.reason,
    this.nextAllowedAt,
    this.undoneAt,
  });

  factory DoseEvent({
    int? id,
    required int childId,
    required int medicineId,
    required String medicineName,
    required String ingredient,
    required String doseText,
    required _isc.UuidValue caregiverId,
    required String caregiverName,
    required DateTime at,
    required _ib9gikq8.DoseOutcome outcome,
    String? reason,
    DateTime? nextAllowedAt,
    DateTime? undoneAt,
  }) = _DoseEventImpl;

  factory DoseEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return DoseEvent(
      id: jsonSerialization['id'] as int?,
      childId: jsonSerialization['childId'] as int,
      medicineId: jsonSerialization['medicineId'] as int,
      medicineName: jsonSerialization['medicineName'] as String,
      ingredient: jsonSerialization['ingredient'] as String,
      doseText: jsonSerialization['doseText'] as String,
      caregiverId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['caregiverId'],
      ),
      caregiverName: jsonSerialization['caregiverName'] as String,
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
      outcome: _ib9gikq8.DoseOutcome.fromJson(
        (jsonSerialization['outcome'] as String),
      ),
      reason: jsonSerialization['reason'] as String?,
      nextAllowedAt: jsonSerialization['nextAllowedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextAllowedAt'],
            ),
      undoneAt: jsonSerialization['undoneAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['undoneAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int childId;

  int medicineId;

  String medicineName;

  String ingredient;

  String doseText;

  _isc.UuidValue caregiverId;

  String caregiverName;

  DateTime at;

  _ib9gikq8.DoseOutcome outcome;

  String? reason;

  DateTime? nextAllowedAt;

  /// Set on an accepted dose that was later undone.
  DateTime? undoneAt;

  /// Returns a shallow copy of this [DoseEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DoseEvent copyWith({
    int? id,
    int? childId,
    int? medicineId,
    String? medicineName,
    String? ingredient,
    String? doseText,
    _isc.UuidValue? caregiverId,
    String? caregiverName,
    DateTime? at,
    _ib9gikq8.DoseOutcome? outcome,
    String? reason,
    DateTime? nextAllowedAt,
    DateTime? undoneAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DoseEvent',
      if (id != null) 'id': id,
      'childId': childId,
      'medicineId': medicineId,
      'medicineName': medicineName,
      'ingredient': ingredient,
      'doseText': doseText,
      'caregiverId': caregiverId.toJson(),
      'caregiverName': caregiverName,
      'at': at.toJson(),
      'outcome': outcome.toJson(),
      if (reason != null) 'reason': reason,
      if (nextAllowedAt != null) 'nextAllowedAt': nextAllowedAt?.toJson(),
      if (undoneAt != null) 'undoneAt': undoneAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DoseEvent',
      if (id != null) 'id': id,
      'childId': childId,
      'medicineId': medicineId,
      'medicineName': medicineName,
      'ingredient': ingredient,
      'doseText': doseText,
      'caregiverId': caregiverId.toJson(),
      'caregiverName': caregiverName,
      'at': at.toJson(),
      'outcome': outcome.toJson(),
      if (reason != null) 'reason': reason,
      if (nextAllowedAt != null) 'nextAllowedAt': nextAllowedAt?.toJson(),
      if (undoneAt != null) 'undoneAt': undoneAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DoseEventImpl extends DoseEvent {
  _DoseEventImpl({
    int? id,
    required int childId,
    required int medicineId,
    required String medicineName,
    required String ingredient,
    required String doseText,
    required _isc.UuidValue caregiverId,
    required String caregiverName,
    required DateTime at,
    required _ib9gikq8.DoseOutcome outcome,
    String? reason,
    DateTime? nextAllowedAt,
    DateTime? undoneAt,
  }) : super._(
         id: id,
         childId: childId,
         medicineId: medicineId,
         medicineName: medicineName,
         ingredient: ingredient,
         doseText: doseText,
         caregiverId: caregiverId,
         caregiverName: caregiverName,
         at: at,
         outcome: outcome,
         reason: reason,
         nextAllowedAt: nextAllowedAt,
         undoneAt: undoneAt,
       );

  /// Returns a shallow copy of this [DoseEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DoseEvent copyWith({
    Object? id = _Undefined,
    int? childId,
    int? medicineId,
    String? medicineName,
    String? ingredient,
    String? doseText,
    _isc.UuidValue? caregiverId,
    String? caregiverName,
    DateTime? at,
    _ib9gikq8.DoseOutcome? outcome,
    Object? reason = _Undefined,
    Object? nextAllowedAt = _Undefined,
    Object? undoneAt = _Undefined,
  }) {
    return DoseEvent(
      id: id is int? ? id : this.id,
      childId: childId ?? this.childId,
      medicineId: medicineId ?? this.medicineId,
      medicineName: medicineName ?? this.medicineName,
      ingredient: ingredient ?? this.ingredient,
      doseText: doseText ?? this.doseText,
      caregiverId: caregiverId ?? this.caregiverId,
      caregiverName: caregiverName ?? this.caregiverName,
      at: at ?? this.at,
      outcome: outcome ?? this.outcome,
      reason: reason is String? ? reason : this.reason,
      nextAllowedAt: nextAllowedAt is DateTime?
          ? nextAllowedAt
          : this.nextAllowedAt,
      undoneAt: undoneAt is DateTime? ? undoneAt : this.undoneAt,
    );
  }
}
