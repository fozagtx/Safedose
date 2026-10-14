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
import '../../onedose/models/invite.dart' as _i3smxva1;

abstract class InviteCreated
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InviteCreated._({
    required this.token,
    required this.invite,
  });

  factory InviteCreated({
    required String token,
    required _i3smxva1.Invite invite,
  }) = _InviteCreatedImpl;

  factory InviteCreated.fromJson(Map<String, dynamic> jsonSerialization) {
    return InviteCreated(
      token: jsonSerialization['token'] as String,
      invite: _idb35kp4.Protocol().deserialize<_i3smxva1.Invite>(
        jsonSerialization['invite'],
      ),
    );
  }

  String token;

  _i3smxva1.Invite invite;

  /// Returns a shallow copy of this [InviteCreated]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InviteCreated copyWith({
    String? token,
    _i3smxva1.Invite? invite,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InviteCreated',
      'token': token,
      'invite': invite.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InviteCreated',
      'token': token,
      'invite': invite.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _InviteCreatedImpl extends InviteCreated {
  _InviteCreatedImpl({
    required String token,
    required _i3smxva1.Invite invite,
  }) : super._(
         token: token,
         invite: invite,
       );

  /// Returns a shallow copy of this [InviteCreated]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InviteCreated copyWith({
    String? token,
    _i3smxva1.Invite? invite,
  }) {
    return InviteCreated(
      token: token ?? this.token,
      invite: invite ?? this.invite.copyWith(),
    );
  }
}
