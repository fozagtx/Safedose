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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:onedose_client/src/protocol/onedose/models/care_member.dart'
    as _i1pspixp;
import 'package:onedose_client/src/protocol/onedose/models/child.dart'
    as _imi16xby;
import 'package:onedose_client/src/protocol/onedose/models/circle_event.dart'
    as _i4w5ermu;
import 'package:onedose_client/src/protocol/onedose/models/circle_summary.dart'
    as _ilxn3xsb;
import 'package:onedose_client/src/protocol/onedose/models/dose_event.dart'
    as _iayc6ykj;
import 'package:onedose_client/src/protocol/onedose/models/dose_result.dart'
    as _i5xmtuua;
import 'package:onedose_client/src/protocol/onedose/models/enums.dart'
    as _ih0ln9m9;
import 'package:onedose_client/src/protocol/onedose/models/invite_preview.dart'
    as _ic1f3hwm;
import 'package:onedose_client/src/protocol/onedose/models/medicine.dart'
    as _i9aaswpj;
import 'package:onedose_client/src/protocol/onedose/models/medicine_status.dart'
    as _ifl8ewdn;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// The signed-in caregiver's circles, and setting up a child.
/// {@category Endpoint}
class EndpointChild extends _isc.EndpointRef {
  EndpointChild(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'child';

  /// Circles the caller belongs to and can act in right now.
  _ida.Future<List<_ilxn3xsb.CircleSummary>> mine() =>
      caller.callServerEndpoint<List<_ilxn3xsb.CircleSummary>>(
        'child',
        'mine',
        {},
      );

  /// Creates a child with the caller as owner. One child per account.
  _ida.Future<_ilxn3xsb.CircleSummary> create({
    required String name,
    required String ownerName,
    required int utcOffsetMinutes,
    String? photoUrl,
  }) => caller.callServerEndpoint<_ilxn3xsb.CircleSummary>(
    'child',
    'create',
    {
      'name': name,
      'ownerName': ownerName,
      'utcOffsetMinutes': utcOffsetMinutes,
      'photoUrl': photoUrl,
    },
  );

  /// Owner only: rename, change photo or time zone.
  _ida.Future<_imi16xby.Child> update(_imi16xby.Child child) =>
      caller.callServerEndpoint<_imi16xby.Child>(
        'child',
        'update',
        {'child': child},
      );

  /// Whether the server runs shortened demo timings.
  _ida.Future<bool> demoMode() => caller.callServerEndpoint<bool>(
    'child',
    'demoMode',
    {},
  );
}

/// The care circle: who is in it, and the live stream every phone watches.
/// {@category Endpoint}
class EndpointCircle extends _isc.EndpointRef {
  EndpointCircle(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'circle';

  /// Streams everything that happens in the circle. The first event is a
  /// snapshot of every medicine's status; every later event carries fresh
  /// statuses too, so a phone never has to refresh. Access is re-checked on
  /// every event: when a sitter's shift ends the stream sends `shiftEnded`
  /// and closes with an error.
  _ida.Stream<_i4w5ermu.CircleEvent> watch(int childId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i4w5ermu.CircleEvent>,
        _i4w5ermu.CircleEvent
      >(
        'circle',
        'watch',
        {'childId': childId},
        {},
      );

  /// Everyone in the circle. Owners see all members; others see who is
  /// active now.
  _ida.Future<List<_i1pspixp.CareMember>> members(int childId) =>
      caller.callServerEndpoint<List<_i1pspixp.CareMember>>(
        'circle',
        'members',
        {'childId': childId},
      );

  /// Owner only: remove someone. Their open stream closes on the next event.
  _ida.Future<void> revoke(int memberId) => caller.callServerEndpoint<void>(
    'circle',
    'revoke',
    {'memberId': memberId},
  );
}

/// "Can I give this now?" and "I gave it."
/// {@category Endpoint}
class EndpointDose extends _isc.EndpointRef {
  EndpointDose(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dose';

  /// Logs a dose. The server accepts it or refuses it with who gave the
  /// blocking dose, when, and when the next one is allowed.
  _ida.Future<_i5xmtuua.DoseResult> logDose(int medicineId) =>
      caller.callServerEndpoint<_i5xmtuua.DoseResult>(
        'dose',
        'logDose',
        {'medicineId': medicineId},
      );

  /// Owner only: log a dose despite a refusal, with a typed reason (for a
  /// doctor-advised change). Shown in red in the history.
  _ida.Future<_i5xmtuua.DoseResult> overrideDose(
    int medicineId,
    String reason,
  ) => caller.callServerEndpoint<_i5xmtuua.DoseResult>(
    'dose',
    'overrideDose',
    {
      'medicineId': medicineId,
      'reason': reason,
    },
  );

  /// Undo a dose logged by mistake, within 2 minutes.
  _ida.Future<_iayc6ykj.DoseEvent> undo(int doseEventId) =>
      caller.callServerEndpoint<_iayc6ykj.DoseEvent>(
        'dose',
        'undo',
        {'doseEventId': doseEventId},
      );

  /// Green / amber / red for each medicine right now.
  _ida.Future<List<_ifl8ewdn.MedicineStatus>> status(int childId) =>
      caller.callServerEndpoint<List<_ifl8ewdn.MedicineStatus>>(
        'dose',
        'status',
        {'childId': childId},
      );
}

/// The audit trail: every attempt, accepted or refused.
/// {@category Endpoint}
class EndpointHistory extends _isc.EndpointRef {
  EndpointHistory(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'history';

  /// Newest first. Sitters only see what happened during their shift.
  _ida.Future<List<_iayc6ykj.DoseEvent>> list(int childId) =>
      caller.callServerEndpoint<List<_iayc6ykj.DoseEvent>>(
        'history',
        'list',
        {'childId': childId},
      );
}

/// One-time links that add a sitter for one shift, or a co-parent.
/// {@category Endpoint}
class EndpointInvite extends _isc.EndpointRef {
  EndpointInvite(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'invite';

  _ida.Future<_ic1f3hwm.InviteCreated> create({
    required int childId,
    required String displayName,
    required _ih0ln9m9.CareRole role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
  }) => caller.callServerEndpoint<_ic1f3hwm.InviteCreated>(
    'invite',
    'create',
    {
      'childId': childId,
      'displayName': displayName,
      'role': role,
      'shiftStart': shiftStart,
      'shiftEnd': shiftEnd,
    },
  );

  /// Joins the circle. The membership is scoped to the invite's shift, and
  /// a future call revokes it when the shift ends.
  _ida.Future<_ilxn3xsb.CircleSummary> accept(String token) =>
      caller.callServerEndpoint<_ilxn3xsb.CircleSummary>(
        'invite',
        'accept',
        {'token': token},
      );
}

/// Medicines and their limits. Limits come from the label or the doctor;
/// OneDose never suggests them. Only the owner can change them.
/// {@category Endpoint}
class EndpointMedicine extends _isc.EndpointRef {
  EndpointMedicine(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'medicine';

  _ida.Future<List<_i9aaswpj.Medicine>> list(int childId) =>
      caller.callServerEndpoint<List<_i9aaswpj.Medicine>>(
        'medicine',
        'list',
        {'childId': childId},
      );

  _ida.Future<_i9aaswpj.Medicine> add(_i9aaswpj.Medicine medicine) =>
      caller.callServerEndpoint<_i9aaswpj.Medicine>(
        'medicine',
        'add',
        {'medicine': medicine},
      );

  _ida.Future<_i9aaswpj.Medicine> update(_i9aaswpj.Medicine medicine) =>
      caller.callServerEndpoint<_i9aaswpj.Medicine>(
        'medicine',
        'update',
        {'medicine': medicine},
      );

  /// Removes a medicine from the card. Its dose history is kept.
  _ida.Future<void> archive(int medicineId) => caller.callServerEndpoint<void>(
    'medicine',
    'archive',
    {'medicineId': medicineId},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    child = EndpointChild(this);
    circle = EndpointCircle(this);
    dose = EndpointDose(this);
    history = EndpointHistory(this);
    invite = EndpointInvite(this);
    medicine = EndpointMedicine(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointChild child;

  late final EndpointCircle circle;

  late final EndpointDose dose;

  late final EndpointHistory history;

  late final EndpointInvite invite;

  late final EndpointMedicine medicine;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'child': child,
    'circle': circle,
    'dose': dose,
    'history': history,
    'invite': invite,
    'medicine': medicine,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
