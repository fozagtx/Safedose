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
import 'package:serverpod/serverpod.dart' as _is;
import '../../onedose/models/error_code.dart' as _iwxpfndm;

abstract class OneDoseException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  OneDoseException._({
    required this.code,
    required this.message,
  });

  factory OneDoseException({
    required _iwxpfndm.OneDoseErrorCode code,
    required String message,
  }) = _OneDoseExceptionImpl;

  factory OneDoseException.fromJson(Map<String, dynamic> jsonSerialization) {
    return OneDoseException(
      code: _iwxpfndm.OneDoseErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
      message: jsonSerialization['message'] as String,
    );
  }

  _iwxpfndm.OneDoseErrorCode code;

  String message;

  /// Returns a shallow copy of this [OneDoseException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OneDoseException copyWith({
    _iwxpfndm.OneDoseErrorCode? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OneDoseException',
      'code': code.toJson(),
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OneDoseException',
      'code': code.toJson(),
      'message': message,
    };
  }

  @override
  String toString() {
    return 'OneDoseException(code: $code, message: $message)';
  }
}

class _OneDoseExceptionImpl extends OneDoseException {
  _OneDoseExceptionImpl({
    required _iwxpfndm.OneDoseErrorCode code,
    required String message,
  }) : super._(
         code: code,
         message: message,
       );

  /// Returns a shallow copy of this [OneDoseException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OneDoseException copyWith({
    _iwxpfndm.OneDoseErrorCode? code,
    String? message,
  }) {
    return OneDoseException(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
