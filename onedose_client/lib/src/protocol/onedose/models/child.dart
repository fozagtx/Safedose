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

/// A child at the centre of one care circle.
abstract class Child
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Child._({
    this.id,
    required this.name,
    this.photoUrl,
    required this.ownerId,
    int? utcOffsetMinutes,
  }) : utcOffsetMinutes = utcOffsetMinutes ?? 0;

  factory Child({
    int? id,
    required String name,
    String? photoUrl,
    required _isc.UuidValue ownerId,
    int? utcOffsetMinutes,
  }) = _ChildImpl;

  factory Child.fromJson(Map<String, dynamic> jsonSerialization) {
    return Child(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      photoUrl: jsonSerialization['photoUrl'] as String?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      utcOffsetMinutes: jsonSerialization['utcOffsetMinutes'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? photoUrl;

  _isc.UuidValue ownerId;

  /// Offset from UTC of the family's local time, used for fixed dose times
  /// and for the times written into refusal messages.
  int utcOffsetMinutes;

  /// Returns a shallow copy of this [Child]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Child copyWith({
    int? id,
    String? name,
    String? photoUrl,
    _isc.UuidValue? ownerId,
    int? utcOffsetMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Child',
      if (id != null) 'id': id,
      'name': name,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'ownerId': ownerId.toJson(),
      'utcOffsetMinutes': utcOffsetMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Child',
      if (id != null) 'id': id,
      'name': name,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'ownerId': ownerId.toJson(),
      'utcOffsetMinutes': utcOffsetMinutes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChildImpl extends Child {
  _ChildImpl({
    int? id,
    required String name,
    String? photoUrl,
    required _isc.UuidValue ownerId,
    int? utcOffsetMinutes,
  }) : super._(
         id: id,
         name: name,
         photoUrl: photoUrl,
         ownerId: ownerId,
         utcOffsetMinutes: utcOffsetMinutes,
       );

  /// Returns a shallow copy of this [Child]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Child copyWith({
    Object? id = _Undefined,
    String? name,
    Object? photoUrl = _Undefined,
    _isc.UuidValue? ownerId,
    int? utcOffsetMinutes,
  }) {
    return Child(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      photoUrl: photoUrl is String? ? photoUrl : this.photoUrl,
      ownerId: ownerId ?? this.ownerId,
      utcOffsetMinutes: utcOffsetMinutes ?? this.utcOffsetMinutes,
    );
  }
}
