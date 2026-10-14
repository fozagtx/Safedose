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
import 'package:onedose_client/src/protocol/protocol.dart' as _idb35kp4;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../onedose/models/medicine.dart' as _ihj6knyx;
import '../../onedose/models/status_light.dart' as _im9kft7r;

/// "Can I give this now?" for one medicine.
abstract class MedicineStatus
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MedicineStatus._({
    required this.medicine,
    required this.light,
    required this.message,
    this.lastGivenAt,
    this.lastGivenBy,
    this.nextAllowedAt,
    required this.dosesLast24h,
    required this.maxPer24h,
  });

  factory MedicineStatus({
    required _ihj6knyx.Medicine medicine,
    required _im9kft7r.StatusLight light,
    required String message,
    DateTime? lastGivenAt,
    String? lastGivenBy,
    DateTime? nextAllowedAt,
    required int dosesLast24h,
    required int maxPer24h,
  }) = _MedicineStatusImpl;

  factory MedicineStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return MedicineStatus(
      medicine: _idb35kp4.Protocol().deserialize<_ihj6knyx.Medicine>(
        jsonSerialization['medicine'],
      ),
      light: _im9kft7r.StatusLight.fromJson(
        (jsonSerialization['light'] as String),
      ),
      message: jsonSerialization['message'] as String,
      lastGivenAt: jsonSerialization['lastGivenAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastGivenAt'],
            ),
      lastGivenBy: jsonSerialization['lastGivenBy'] as String?,
      nextAllowedAt: jsonSerialization['nextAllowedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextAllowedAt'],
            ),
      dosesLast24h: jsonSerialization['dosesLast24h'] as int,
      maxPer24h: jsonSerialization['maxPer24h'] as int,
    );
  }

  _ihj6knyx.Medicine medicine;

  _im9kft7r.StatusLight light;

  String message;

  DateTime? lastGivenAt;

  String? lastGivenBy;

  DateTime? nextAllowedAt;

  int dosesLast24h;

  int maxPer24h;

  /// Returns a shallow copy of this [MedicineStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MedicineStatus copyWith({
    _ihj6knyx.Medicine? medicine,
    _im9kft7r.StatusLight? light,
    String? message,
    DateTime? lastGivenAt,
    String? lastGivenBy,
    DateTime? nextAllowedAt,
    int? dosesLast24h,
    int? maxPer24h,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MedicineStatus',
      'medicine': medicine.toJson(),
      'light': light.toJson(),
      'message': message,
      if (lastGivenAt != null) 'lastGivenAt': lastGivenAt?.toJson(),
      if (lastGivenBy != null) 'lastGivenBy': lastGivenBy,
      if (nextAllowedAt != null) 'nextAllowedAt': nextAllowedAt?.toJson(),
      'dosesLast24h': dosesLast24h,
      'maxPer24h': maxPer24h,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MedicineStatus',
      'medicine': medicine.toJsonForProtocol(),
      'light': light.toJson(),
      'message': message,
      if (lastGivenAt != null) 'lastGivenAt': lastGivenAt?.toJson(),
      if (lastGivenBy != null) 'lastGivenBy': lastGivenBy,
      if (nextAllowedAt != null) 'nextAllowedAt': nextAllowedAt?.toJson(),
      'dosesLast24h': dosesLast24h,
      'maxPer24h': maxPer24h,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MedicineStatusImpl extends MedicineStatus {
  _MedicineStatusImpl({
    required _ihj6knyx.Medicine medicine,
    required _im9kft7r.StatusLight light,
    required String message,
    DateTime? lastGivenAt,
    String? lastGivenBy,
    DateTime? nextAllowedAt,
    required int dosesLast24h,
    required int maxPer24h,
  }) : super._(
         medicine: medicine,
         light: light,
         message: message,
         lastGivenAt: lastGivenAt,
         lastGivenBy: lastGivenBy,
         nextAllowedAt: nextAllowedAt,
         dosesLast24h: dosesLast24h,
         maxPer24h: maxPer24h,
       );

  /// Returns a shallow copy of this [MedicineStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MedicineStatus copyWith({
    _ihj6knyx.Medicine? medicine,
    _im9kft7r.StatusLight? light,
    String? message,
    Object? lastGivenAt = _Undefined,
    Object? lastGivenBy = _Undefined,
    Object? nextAllowedAt = _Undefined,
    int? dosesLast24h,
    int? maxPer24h,
  }) {
    return MedicineStatus(
      medicine: medicine ?? this.medicine.copyWith(),
      light: light ?? this.light,
      message: message ?? this.message,
      lastGivenAt: lastGivenAt is DateTime? ? lastGivenAt : this.lastGivenAt,
      lastGivenBy: lastGivenBy is String? ? lastGivenBy : this.lastGivenBy,
      nextAllowedAt: nextAllowedAt is DateTime?
          ? nextAllowedAt
          : this.nextAllowedAt,
      dosesLast24h: dosesLast24h ?? this.dosesLast24h,
      maxPer24h: maxPer24h ?? this.maxPer24h,
    );
  }
}
