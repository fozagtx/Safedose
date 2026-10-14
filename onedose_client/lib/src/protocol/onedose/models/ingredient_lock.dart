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

/// The single row locked while a dose of an ingredient is checked.
abstract class IngredientLock
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IngredientLock._({
    this.id,
    required this.childId,
    required this.ingredient,
    this.lastGivenAt,
    this.lastGivenBy,
  });

  factory IngredientLock({
    int? id,
    required int childId,
    required String ingredient,
    DateTime? lastGivenAt,
    String? lastGivenBy,
  }) = _IngredientLockImpl;

  factory IngredientLock.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngredientLock(
      id: jsonSerialization['id'] as int?,
      childId: jsonSerialization['childId'] as int,
      ingredient: jsonSerialization['ingredient'] as String,
      lastGivenAt: jsonSerialization['lastGivenAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastGivenAt'],
            ),
      lastGivenBy: jsonSerialization['lastGivenBy'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int childId;

  String ingredient;

  DateTime? lastGivenAt;

  String? lastGivenBy;

  /// Returns a shallow copy of this [IngredientLock]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IngredientLock copyWith({
    int? id,
    int? childId,
    String? ingredient,
    DateTime? lastGivenAt,
    String? lastGivenBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngredientLock',
      if (id != null) 'id': id,
      'childId': childId,
      'ingredient': ingredient,
      if (lastGivenAt != null) 'lastGivenAt': lastGivenAt?.toJson(),
      if (lastGivenBy != null) 'lastGivenBy': lastGivenBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IngredientLock',
      if (id != null) 'id': id,
      'childId': childId,
      'ingredient': ingredient,
      if (lastGivenAt != null) 'lastGivenAt': lastGivenAt?.toJson(),
      if (lastGivenBy != null) 'lastGivenBy': lastGivenBy,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IngredientLockImpl extends IngredientLock {
  _IngredientLockImpl({
    int? id,
    required int childId,
    required String ingredient,
    DateTime? lastGivenAt,
    String? lastGivenBy,
  }) : super._(
         id: id,
         childId: childId,
         ingredient: ingredient,
         lastGivenAt: lastGivenAt,
         lastGivenBy: lastGivenBy,
       );

  /// Returns a shallow copy of this [IngredientLock]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IngredientLock copyWith({
    Object? id = _Undefined,
    int? childId,
    String? ingredient,
    Object? lastGivenAt = _Undefined,
    Object? lastGivenBy = _Undefined,
  }) {
    return IngredientLock(
      id: id is int? ? id : this.id,
      childId: childId ?? this.childId,
      ingredient: ingredient ?? this.ingredient,
      lastGivenAt: lastGivenAt is DateTime? ? lastGivenAt : this.lastGivenAt,
      lastGivenBy: lastGivenBy is String? ? lastGivenBy : this.lastGivenBy,
    );
  }
}
