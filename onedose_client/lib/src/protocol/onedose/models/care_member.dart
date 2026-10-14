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
import '../../onedose/models/enums.dart' as _idkclkk2;

/// A person who can see and log doses for a child.
abstract class CareMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CareMember._({
    this.id,
    required this.childId,
    required this.userId,
    required this.displayName,
    required this.role,
    this.shiftStart,
    this.shiftEnd,
    this.revokedAt,
  });

  factory CareMember({
    int? id,
    required int childId,
    required _isc.UuidValue userId,
    required String displayName,
    required _idkclkk2.CareRole role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
    DateTime? revokedAt,
  }) = _CareMemberImpl;

  factory CareMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return CareMember(
      id: jsonSerialization['id'] as int?,
      childId: jsonSerialization['childId'] as int,
      userId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      displayName: jsonSerialization['displayName'] as String,
      role: _idkclkk2.CareRole.fromJson((jsonSerialization['role'] as String)),
      shiftStart: jsonSerialization['shiftStart'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['shiftStart'],
            ),
      shiftEnd: jsonSerialization['shiftEnd'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['shiftEnd']),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int childId;

  _isc.UuidValue userId;

  String displayName;

  _idkclkk2.CareRole role;

  /// Only set for sitters: access is valid in [shiftStart, shiftEnd).
  DateTime? shiftStart;

  DateTime? shiftEnd;

  DateTime? revokedAt;

  /// Returns a shallow copy of this [CareMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CareMember copyWith({
    int? id,
    int? childId,
    _isc.UuidValue? userId,
    String? displayName,
    _idkclkk2.CareRole? role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
    DateTime? revokedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CareMember',
      if (id != null) 'id': id,
      'childId': childId,
      'userId': userId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      if (shiftStart != null) 'shiftStart': shiftStart?.toJson(),
      if (shiftEnd != null) 'shiftEnd': shiftEnd?.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CareMember',
      if (id != null) 'id': id,
      'childId': childId,
      'userId': userId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      if (shiftStart != null) 'shiftStart': shiftStart?.toJson(),
      if (shiftEnd != null) 'shiftEnd': shiftEnd?.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CareMemberImpl extends CareMember {
  _CareMemberImpl({
    int? id,
    required int childId,
    required _isc.UuidValue userId,
    required String displayName,
    required _idkclkk2.CareRole role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
    DateTime? revokedAt,
  }) : super._(
         id: id,
         childId: childId,
         userId: userId,
         displayName: displayName,
         role: role,
         shiftStart: shiftStart,
         shiftEnd: shiftEnd,
         revokedAt: revokedAt,
       );

  /// Returns a shallow copy of this [CareMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CareMember copyWith({
    Object? id = _Undefined,
    int? childId,
    _isc.UuidValue? userId,
    String? displayName,
    _idkclkk2.CareRole? role,
    Object? shiftStart = _Undefined,
    Object? shiftEnd = _Undefined,
    Object? revokedAt = _Undefined,
  }) {
    return CareMember(
      id: id is int? ? id : this.id,
      childId: childId ?? this.childId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      shiftStart: shiftStart is DateTime? ? shiftStart : this.shiftStart,
      shiftEnd: shiftEnd is DateTime? ? shiftEnd : this.shiftEnd,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
    );
  }
}
