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
import '../../onedose/models/care_member.dart' as _is3phlqs;
import '../../onedose/models/child.dart' as _i872h1sf;

/// A child as seen by the signed-in caregiver.
abstract class CircleSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CircleSummary._({
    required this.child,
    required this.me,
  });

  factory CircleSummary({
    required _i872h1sf.Child child,
    required _is3phlqs.CareMember me,
  }) = _CircleSummaryImpl;

  factory CircleSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return CircleSummary(
      child: _idb35kp4.Protocol().deserialize<_i872h1sf.Child>(
        jsonSerialization['child'],
      ),
      me: _idb35kp4.Protocol().deserialize<_is3phlqs.CareMember>(
        jsonSerialization['me'],
      ),
    );
  }

  _i872h1sf.Child child;

  _is3phlqs.CareMember me;

  /// Returns a shallow copy of this [CircleSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CircleSummary copyWith({
    _i872h1sf.Child? child,
    _is3phlqs.CareMember? me,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CircleSummary',
      'child': child.toJson(),
      'me': me.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CircleSummary',
      'child': child.toJsonForProtocol(),
      'me': me.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _CircleSummaryImpl extends CircleSummary {
  _CircleSummaryImpl({
    required _i872h1sf.Child child,
    required _is3phlqs.CareMember me,
  }) : super._(
         child: child,
         me: me,
       );

  /// Returns a shallow copy of this [CircleSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CircleSummary copyWith({
    _i872h1sf.Child? child,
    _is3phlqs.CareMember? me,
  }) {
    return CircleSummary(
      child: child ?? this.child.copyWith(),
      me: me ?? this.me.copyWith(),
    );
  }
}
