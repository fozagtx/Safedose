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

/// A medicine and its limits, copied by the owner from the label or doctor.
abstract class Medicine
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Medicine._({
    this.id,
    required this.childId,
    required this.name,
    required this.ingredient,
    required this.doseText,
    required this.minHoursBetween,
    required this.maxPer24h,
    required this.fixedTimes,
    this.archivedAt,
  });

  factory Medicine({
    int? id,
    required int childId,
    required String name,
    required String ingredient,
    required String doseText,
    required double minHoursBetween,
    required int maxPer24h,
    required List<String> fixedTimes,
    DateTime? archivedAt,
  }) = _MedicineImpl;

  factory Medicine.fromJson(Map<String, dynamic> jsonSerialization) {
    return Medicine(
      id: jsonSerialization['id'] as int?,
      childId: jsonSerialization['childId'] as int,
      name: jsonSerialization['name'] as String,
      ingredient: jsonSerialization['ingredient'] as String,
      doseText: jsonSerialization['doseText'] as String,
      minHoursBetween: (jsonSerialization['minHoursBetween'] as num).toDouble(),
      maxPer24h: jsonSerialization['maxPer24h'] as int,
      fixedTimes: _idb35kp4.Protocol().deserialize<List<String>>(
        jsonSerialization['fixedTimes'],
      ),
      archivedAt: jsonSerialization['archivedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['archivedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int childId;

  String name;

  /// Active ingredient, normalised to lower case. Lockouts are keyed on it.
  String ingredient;

  String doseText;

  double minHoursBetween;

  int maxPer24h;

  /// Local fixed times as "HH:mm", e.g. ["08:00", "20:00"].
  List<String> fixedTimes;

  DateTime? archivedAt;

  /// Returns a shallow copy of this [Medicine]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Medicine copyWith({
    int? id,
    int? childId,
    String? name,
    String? ingredient,
    String? doseText,
    double? minHoursBetween,
    int? maxPer24h,
    List<String>? fixedTimes,
    DateTime? archivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Medicine',
      if (id != null) 'id': id,
      'childId': childId,
      'name': name,
      'ingredient': ingredient,
      'doseText': doseText,
      'minHoursBetween': minHoursBetween,
      'maxPer24h': maxPer24h,
      'fixedTimes': fixedTimes.toJson(),
      if (archivedAt != null) 'archivedAt': archivedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Medicine',
      if (id != null) 'id': id,
      'childId': childId,
      'name': name,
      'ingredient': ingredient,
      'doseText': doseText,
      'minHoursBetween': minHoursBetween,
      'maxPer24h': maxPer24h,
      'fixedTimes': fixedTimes.toJson(),
      if (archivedAt != null) 'archivedAt': archivedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MedicineImpl extends Medicine {
  _MedicineImpl({
    int? id,
    required int childId,
    required String name,
    required String ingredient,
    required String doseText,
    required double minHoursBetween,
    required int maxPer24h,
    required List<String> fixedTimes,
    DateTime? archivedAt,
  }) : super._(
         id: id,
         childId: childId,
         name: name,
         ingredient: ingredient,
         doseText: doseText,
         minHoursBetween: minHoursBetween,
         maxPer24h: maxPer24h,
         fixedTimes: fixedTimes,
         archivedAt: archivedAt,
       );

  /// Returns a shallow copy of this [Medicine]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Medicine copyWith({
    Object? id = _Undefined,
    int? childId,
    String? name,
    String? ingredient,
    String? doseText,
    double? minHoursBetween,
    int? maxPer24h,
    List<String>? fixedTimes,
    Object? archivedAt = _Undefined,
  }) {
    return Medicine(
      id: id is int? ? id : this.id,
      childId: childId ?? this.childId,
      name: name ?? this.name,
      ingredient: ingredient ?? this.ingredient,
      doseText: doseText ?? this.doseText,
      minHoursBetween: minHoursBetween ?? this.minHoursBetween,
      maxPer24h: maxPer24h ?? this.maxPer24h,
      fixedTimes: fixedTimes ?? this.fixedTimes.map((e0) => e0).toList(),
      archivedAt: archivedAt is DateTime? ? archivedAt : this.archivedAt,
    );
  }
}
