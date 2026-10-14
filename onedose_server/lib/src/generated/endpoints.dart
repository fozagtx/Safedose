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
import 'package:onedose_server/src/generated/future_calls.dart' as _ig1taa2k;
import 'package:onedose_server/src/generated/onedose/models/child.dart'
    as _idzwrgrh;
import 'package:onedose_server/src/generated/onedose/models/enums.dart'
    as _ikehuok3;
import 'package:onedose_server/src/generated/onedose/models/medicine.dart'
    as _i066tflg;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../onedose/endpoints/child_endpoint.dart' as _i0gnzixv;
import '../onedose/endpoints/circle_endpoint.dart' as _iv2pave5;
import '../onedose/endpoints/dose_endpoint.dart' as _ic3f9647;
import '../onedose/endpoints/history_endpoint.dart' as _iuaz7b38;
import '../onedose/endpoints/invite_endpoint.dart' as _i0xdx94q;
import '../onedose/endpoints/medicine_endpoint.dart' as _if18bwrp;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'child': _i0gnzixv.ChildEndpoint()
        ..initialize(
          server,
          'child',
          null,
        ),
      'circle': _iv2pave5.CircleEndpoint()
        ..initialize(
          server,
          'circle',
          null,
        ),
      'dose': _ic3f9647.DoseEndpoint()
        ..initialize(
          server,
          'dose',
          null,
        ),
      'history': _iuaz7b38.HistoryEndpoint()
        ..initialize(
          server,
          'history',
          null,
        ),
      'invite': _i0xdx94q.InviteEndpoint()
        ..initialize(
          server,
          'invite',
          null,
        ),
      'medicine': _if18bwrp.MedicineEndpoint()
        ..initialize(
          server,
          'medicine',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['child'] = _is.EndpointConnector(
      name: 'child',
      endpoint: endpoints['child']!,
      methodConnectors: {
        'mine': _is.MethodConnector(
          name: 'mine',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['child'] as _i0gnzixv.ChildEndpoint).mine(session),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'ownerName': _is.ParameterDescription(
              name: 'ownerName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'utcOffsetMinutes': _is.ParameterDescription(
              name: 'utcOffsetMinutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'photoUrl': _is.ParameterDescription(
              name: 'photoUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['child'] as _i0gnzixv.ChildEndpoint).create(
                session,
                name: params['name'],
                ownerName: params['ownerName'],
                utcOffsetMinutes: params['utcOffsetMinutes'],
                photoUrl: params['photoUrl'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'child': _is.ParameterDescription(
              name: 'child',
              type: _is.getType<_idzwrgrh.Child>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['child'] as _i0gnzixv.ChildEndpoint).update(
                session,
                params['child'],
              ),
        ),
        'demoMode': _is.MethodConnector(
          name: 'demoMode',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['child'] as _i0gnzixv.ChildEndpoint)
                  .demoMode(session),
        ),
      },
    );
    connectors['circle'] = _is.EndpointConnector(
      name: 'circle',
      endpoint: endpoints['circle']!,
      methodConnectors: {
        'members': _is.MethodConnector(
          name: 'members',
          params: {
            'childId': _is.ParameterDescription(
              name: 'childId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['circle'] as _iv2pave5.CircleEndpoint).members(
                    session,
                    params['childId'],
                  ),
        ),
        'revoke': _is.MethodConnector(
          name: 'revoke',
          params: {
            'memberId': _is.ParameterDescription(
              name: 'memberId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['circle'] as _iv2pave5.CircleEndpoint).revoke(
                    session,
                    params['memberId'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'childId': _is.ParameterDescription(
              name: 'childId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['circle'] as _iv2pave5.CircleEndpoint).watch(
                session,
                params['childId'],
              ),
        ),
      },
    );
    connectors['dose'] = _is.EndpointConnector(
      name: 'dose',
      endpoint: endpoints['dose']!,
      methodConnectors: {
        'logDose': _is.MethodConnector(
          name: 'logDose',
          params: {
            'medicineId': _is.ParameterDescription(
              name: 'medicineId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dose'] as _ic3f9647.DoseEndpoint).logDose(
                session,
                params['medicineId'],
              ),
        ),
        'overrideDose': _is.MethodConnector(
          name: 'overrideDose',
          params: {
            'medicineId': _is.ParameterDescription(
              name: 'medicineId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dose'] as _ic3f9647.DoseEndpoint).overrideDose(
                    session,
                    params['medicineId'],
                    params['reason'],
                  ),
        ),
        'undo': _is.MethodConnector(
          name: 'undo',
          params: {
            'doseEventId': _is.ParameterDescription(
              name: 'doseEventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dose'] as _ic3f9647.DoseEndpoint).undo(
                session,
                params['doseEventId'],
              ),
        ),
        'status': _is.MethodConnector(
          name: 'status',
          params: {
            'childId': _is.ParameterDescription(
              name: 'childId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dose'] as _ic3f9647.DoseEndpoint).status(
                session,
                params['childId'],
              ),
        ),
      },
    );
    connectors['history'] = _is.EndpointConnector(
      name: 'history',
      endpoint: endpoints['history']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'childId': _is.ParameterDescription(
              name: 'childId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['history'] as _iuaz7b38.HistoryEndpoint).list(
                    session,
                    params['childId'],
                  ),
        ),
      },
    );
    connectors['invite'] = _is.EndpointConnector(
      name: 'invite',
      endpoint: endpoints['invite']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'childId': _is.ParameterDescription(
              name: 'childId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_ikehuok3.CareRole>(),
              nullable: false,
            ),
            'shiftStart': _is.ParameterDescription(
              name: 'shiftStart',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'shiftEnd': _is.ParameterDescription(
              name: 'shiftEnd',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invite'] as _i0xdx94q.InviteEndpoint).create(
                    session,
                    childId: params['childId'],
                    displayName: params['displayName'],
                    role: params['role'],
                    shiftStart: params['shiftStart'],
                    shiftEnd: params['shiftEnd'],
                  ),
        ),
        'accept': _is.MethodConnector(
          name: 'accept',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invite'] as _i0xdx94q.InviteEndpoint).accept(
                    session,
                    params['token'],
                  ),
        ),
      },
    );
    connectors['medicine'] = _is.EndpointConnector(
      name: 'medicine',
      endpoint: endpoints['medicine']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'childId': _is.ParameterDescription(
              name: 'childId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['medicine'] as _if18bwrp.MedicineEndpoint).list(
                    session,
                    params['childId'],
                  ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'medicine': _is.ParameterDescription(
              name: 'medicine',
              type: _is.getType<_i066tflg.Medicine>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['medicine'] as _if18bwrp.MedicineEndpoint).add(
                    session,
                    params['medicine'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'medicine': _is.ParameterDescription(
              name: 'medicine',
              type: _is.getType<_i066tflg.Medicine>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['medicine'] as _if18bwrp.MedicineEndpoint).update(
                    session,
                    params['medicine'],
                  ),
        ),
        'archive': _is.MethodConnector(
          name: 'archive',
          params: {
            'medicineId': _is.ParameterDescription(
              name: 'medicineId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['medicine'] as _if18bwrp.MedicineEndpoint).archive(
                    session,
                    params['medicineId'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _ig1taa2k.FutureCalls();
  }
}
