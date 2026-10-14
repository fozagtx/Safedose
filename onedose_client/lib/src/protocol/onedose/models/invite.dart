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

/// A one-time link that adds a sitter (or co-parent) to a circle.
abstract class Invite
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Invite._({
    this.id,
    required this.token,
    required this.childId,
    required this.displayName,
    required this.role,
    this.shiftStart,
    this.shiftEnd,
    this.usedAt,
    required this.createdAt,
  });

  factory Invite({
    int? id,
    required String token,
    required int childId,
    required String displayName,
    required _idkclkk2.CareRole role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
    DateTime? usedAt,
    required DateTime createdAt,
  }) = _InviteImpl;

  factory Invite.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invite(
      id: jsonSerialization['id'] as int?,
      token: jsonSerialization['token'] as String,
      childId: jsonSerialization['childId'] as int,
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
      usedAt: jsonSerialization['usedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['usedAt']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String token;

  int childId;

  String displayName;

  _idkclkk2.CareRole role;

  DateTime? shiftStart;

  DateTime? shiftEnd;

  DateTime? usedAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Invite]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Invite copyWith({
    int? id,
    String? token,
    int? childId,
    String? displayName,
    _idkclkk2.CareRole? role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
    DateTime? usedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Invite',
      if (id != null) 'id': id,
      'token': token,
      'childId': childId,
      'displayName': displayName,
      'role': role.toJson(),
      if (shiftStart != null) 'shiftStart': shiftStart?.toJson(),
      if (shiftEnd != null) 'shiftEnd': shiftEnd?.toJson(),
      if (usedAt != null) 'usedAt': usedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Invite',
      if (id != null) 'id': id,
      'token': token,
      'childId': childId,
      'displayName': displayName,
      'role': role.toJson(),
      if (shiftStart != null) 'shiftStart': shiftStart?.toJson(),
      if (shiftEnd != null) 'shiftEnd': shiftEnd?.toJson(),
      if (usedAt != null) 'usedAt': usedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InviteImpl extends Invite {
  _InviteImpl({
    int? id,
    required String token,
    required int childId,
    required String displayName,
    required _idkclkk2.CareRole role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
    DateTime? usedAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         token: token,
         childId: childId,
         displayName: displayName,
         role: role,
         shiftStart: shiftStart,
         shiftEnd: shiftEnd,
         usedAt: usedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Invite]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Invite copyWith({
    Object? id = _Undefined,
    String? token,
    int? childId,
    String? displayName,
    _idkclkk2.CareRole? role,
    Object? shiftStart = _Undefined,
    Object? shiftEnd = _Undefined,
    Object? usedAt = _Undefined,
    DateTime? createdAt,
  }) {
    return Invite(
      id: id is int? ? id : this.id,
      token: token ?? this.token,
      childId: childId ?? this.childId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      shiftStart: shiftStart is DateTime? ? shiftStart : this.shiftStart,
      shiftEnd: shiftEnd is DateTime? ? shiftEnd : this.shiftEnd,
      usedAt: usedAt is DateTime? ? usedAt : this.usedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
