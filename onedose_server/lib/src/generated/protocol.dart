/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:onedose_server/src/generated/onedose/models/care_member.dart'
    as _ihmshfqi;
import 'package:onedose_server/src/generated/onedose/models/circle_summary.dart'
    as _i17l9ama;
import 'package:onedose_server/src/generated/onedose/models/dose_event.dart'
    as _ilskunir;
import 'package:onedose_server/src/generated/onedose/models/medicine.dart'
    as _i066tflg;
import 'package:onedose_server/src/generated/onedose/models/medicine_status.dart'
    as _ixu0owe9;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'future_calls_generated_models/escalation_future_call_missed_dose_check_model.dart'
    as _i6rfisfz;
import 'future_calls_generated_models/escalation_future_call_shift_expiry_model.dart'
    as _iu2jkarh;
import 'future_calls_generated_models/escalation_future_call_slot_due_model.dart'
    as _ihh2y04m;
import 'onedose/models/care_member.dart' as _iq25v74h;
import 'onedose/models/child.dart' as _ixfwt8j5;
import 'onedose/models/circle_event.dart' as _iwyprj06;
import 'onedose/models/circle_event_type.dart' as _iy6yb3zw;
import 'onedose/models/circle_summary.dart' as _ire8j3dz;
import 'onedose/models/dose_event.dart' as _iyt8dqsq;
import 'onedose/models/dose_outcome.dart' as _i3n8cunl;
import 'onedose/models/dose_result.dart' as _iw3hqc14;
import 'onedose/models/enums.dart' as _i4r0gy9o;
import 'onedose/models/error_code.dart' as _ikpfm01t;
import 'onedose/models/ingredient_lock.dart' as _ilkedwcd;
import 'onedose/models/invite.dart' as _im0892wf;
import 'onedose/models/invite_preview.dart' as _i3k33a72;
import 'onedose/models/medicine.dart' as _ivc5j21c;
import 'onedose/models/medicine_status.dart' as _ieilolm8;
import 'onedose/models/one_dose_exception.dart' as _ipygw1ot;
import 'onedose/models/status_light.dart' as _ifwrwu8f;
export 'onedose/models/care_member.dart';
export 'onedose/models/child.dart';
export 'onedose/models/circle_event.dart';
export 'onedose/models/circle_event_type.dart';
export 'onedose/models/circle_summary.dart';
export 'onedose/models/dose_event.dart';
export 'onedose/models/dose_outcome.dart';
export 'onedose/models/dose_result.dart';
export 'onedose/models/enums.dart';
export 'onedose/models/error_code.dart';
export 'onedose/models/ingredient_lock.dart';
export 'onedose/models/invite.dart';
export 'onedose/models/invite_preview.dart';
export 'onedose/models/medicine.dart';
export 'onedose/models/medicine_status.dart';
export 'onedose/models/one_dose_exception.dart';
export 'onedose/models/status_light.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'care_member',
      dartName: 'CareMember',
      schema: 'public',
      module: 'onedose',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'childId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CareRole',
        ),
        _isp.ColumnDefinition(
          name: 'shiftStart',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'shiftEnd',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'revokedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'care_member_child_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'childId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'child',
      dartName: 'Child',
      schema: 'public',
      module: 'onedose',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'photoUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'utcOffsetMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dose_event',
      dartName: 'DoseEvent',
      schema: 'public',
      module: 'onedose',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'childId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'medicineId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'medicineName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'ingredient',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'doseText',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'caregiverId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'caregiverName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'outcome',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DoseOutcome',
        ),
        _isp.ColumnDefinition(
          name: 'reason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'nextAllowedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'undoneAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dose_event_child_at_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'childId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'at',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'dose_event_child_ingredient_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'childId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ingredient',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'ingredient_lock',
      dartName: 'IngredientLock',
      schema: 'public',
      module: 'onedose',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'childId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'ingredient',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'lastGivenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastGivenBy',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'ingredient_lock_child_ingredient_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'childId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ingredient',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'invite',
      dartName: 'Invite',
      schema: 'public',
      module: 'onedose',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'token',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'childId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CareRole',
        ),
        _isp.ColumnDefinition(
          name: 'shiftStart',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'shiftEnd',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'usedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'invite_token_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'token',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'medicine',
      dartName: 'Medicine',
      schema: 'public',
      module: 'onedose',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'childId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'ingredient',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'doseText',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'minHoursBetween',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'maxPer24h',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'fixedTimes',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'archivedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'medicine_child_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'childId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i6rfisfz.EscalationFutureCallMissedDoseCheckModel) {
      return _i6rfisfz.EscalationFutureCallMissedDoseCheckModel.fromJson(data)
          as T;
    }
    if (t == _iu2jkarh.EscalationFutureCallShiftExpiryModel) {
      return _iu2jkarh.EscalationFutureCallShiftExpiryModel.fromJson(data) as T;
    }
    if (t == _ihh2y04m.EscalationFutureCallSlotDueModel) {
      return _ihh2y04m.EscalationFutureCallSlotDueModel.fromJson(data) as T;
    }
    if (t == _iq25v74h.CareMember) {
      return _iq25v74h.CareMember.fromJson(data) as T;
    }
    if (t == _ixfwt8j5.Child) {
      return _ixfwt8j5.Child.fromJson(data) as T;
    }
    if (t == _iwyprj06.CircleEvent) {
      return _iwyprj06.CircleEvent.fromJson(data) as T;
    }
    if (t == _iy6yb3zw.CircleEventType) {
      return _iy6yb3zw.CircleEventType.fromJson(data) as T;
    }
    if (t == _ire8j3dz.CircleSummary) {
      return _ire8j3dz.CircleSummary.fromJson(data) as T;
    }
    if (t == _iyt8dqsq.DoseEvent) {
      return _iyt8dqsq.DoseEvent.fromJson(data) as T;
    }
    if (t == _i3n8cunl.DoseOutcome) {
      return _i3n8cunl.DoseOutcome.fromJson(data) as T;
    }
    if (t == _iw3hqc14.DoseResult) {
      return _iw3hqc14.DoseResult.fromJson(data) as T;
    }
    if (t == _i4r0gy9o.CareRole) {
      return _i4r0gy9o.CareRole.fromJson(data) as T;
    }
    if (t == _ikpfm01t.OneDoseErrorCode) {
      return _ikpfm01t.OneDoseErrorCode.fromJson(data) as T;
    }
    if (t == _ilkedwcd.IngredientLock) {
      return _ilkedwcd.IngredientLock.fromJson(data) as T;
    }
    if (t == _im0892wf.Invite) {
      return _im0892wf.Invite.fromJson(data) as T;
    }
    if (t == _i3k33a72.InviteCreated) {
      return _i3k33a72.InviteCreated.fromJson(data) as T;
    }
    if (t == _ivc5j21c.Medicine) {
      return _ivc5j21c.Medicine.fromJson(data) as T;
    }
    if (t == _ieilolm8.MedicineStatus) {
      return _ieilolm8.MedicineStatus.fromJson(data) as T;
    }
    if (t == _ipygw1ot.OneDoseException) {
      return _ipygw1ot.OneDoseException.fromJson(data) as T;
    }
    if (t == _ifwrwu8f.StatusLight) {
      return _ifwrwu8f.StatusLight.fromJson(data) as T;
    }
    if (t ==
        _is.getType<_i6rfisfz.EscalationFutureCallMissedDoseCheckModel?>()) {
      return (data != null
              ? _i6rfisfz.EscalationFutureCallMissedDoseCheckModel.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t == _is.getType<_iu2jkarh.EscalationFutureCallShiftExpiryModel?>()) {
      return (data != null
              ? _iu2jkarh.EscalationFutureCallShiftExpiryModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ihh2y04m.EscalationFutureCallSlotDueModel?>()) {
      return (data != null
              ? _ihh2y04m.EscalationFutureCallSlotDueModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iq25v74h.CareMember?>()) {
      return (data != null ? _iq25v74h.CareMember.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixfwt8j5.Child?>()) {
      return (data != null ? _ixfwt8j5.Child.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwyprj06.CircleEvent?>()) {
      return (data != null ? _iwyprj06.CircleEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iy6yb3zw.CircleEventType?>()) {
      return (data != null ? _iy6yb3zw.CircleEventType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ire8j3dz.CircleSummary?>()) {
      return (data != null ? _ire8j3dz.CircleSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iyt8dqsq.DoseEvent?>()) {
      return (data != null ? _iyt8dqsq.DoseEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3n8cunl.DoseOutcome?>()) {
      return (data != null ? _i3n8cunl.DoseOutcome.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iw3hqc14.DoseResult?>()) {
      return (data != null ? _iw3hqc14.DoseResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4r0gy9o.CareRole?>()) {
      return (data != null ? _i4r0gy9o.CareRole.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikpfm01t.OneDoseErrorCode?>()) {
      return (data != null ? _ikpfm01t.OneDoseErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ilkedwcd.IngredientLock?>()) {
      return (data != null ? _ilkedwcd.IngredientLock.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_im0892wf.Invite?>()) {
      return (data != null ? _im0892wf.Invite.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3k33a72.InviteCreated?>()) {
      return (data != null ? _i3k33a72.InviteCreated.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivc5j21c.Medicine?>()) {
      return (data != null ? _ivc5j21c.Medicine.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ieilolm8.MedicineStatus?>()) {
      return (data != null ? _ieilolm8.MedicineStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ipygw1ot.OneDoseException?>()) {
      return (data != null ? _ipygw1ot.OneDoseException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ifwrwu8f.StatusLight?>()) {
      return (data != null ? _ifwrwu8f.StatusLight.fromJson(data) : null) as T;
    }
    if (t == List<_ieilolm8.MedicineStatus>) {
      return (data as List)
              .map((e) => deserialize<_ieilolm8.MedicineStatus>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_ieilolm8.MedicineStatus>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ieilolm8.MedicineStatus>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i17l9ama.CircleSummary>) {
      return (data as List)
              .map((e) => deserialize<_i17l9ama.CircleSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_ihmshfqi.CareMember>) {
      return (data as List)
              .map((e) => deserialize<_ihmshfqi.CareMember>(e))
              .toList()
          as T;
    }
    if (t == List<_ixu0owe9.MedicineStatus>) {
      return (data as List)
              .map((e) => deserialize<_ixu0owe9.MedicineStatus>(e))
              .toList()
          as T;
    }
    if (t == List<_ilskunir.DoseEvent>) {
      return (data as List)
              .map((e) => deserialize<_ilskunir.DoseEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i066tflg.Medicine>) {
      return (data as List)
              .map((e) => deserialize<_i066tflg.Medicine>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i6rfisfz.EscalationFutureCallMissedDoseCheckModel =>
        'EscalationFutureCallMissedDoseCheckModel',
      _iu2jkarh.EscalationFutureCallShiftExpiryModel =>
        'EscalationFutureCallShiftExpiryModel',
      _ihh2y04m.EscalationFutureCallSlotDueModel =>
        'EscalationFutureCallSlotDueModel',
      _iq25v74h.CareMember => 'CareMember',
      _ixfwt8j5.Child => 'Child',
      _iwyprj06.CircleEvent => 'CircleEvent',
      _iy6yb3zw.CircleEventType => 'CircleEventType',
      _ire8j3dz.CircleSummary => 'CircleSummary',
      _iyt8dqsq.DoseEvent => 'DoseEvent',
      _i3n8cunl.DoseOutcome => 'DoseOutcome',
      _iw3hqc14.DoseResult => 'DoseResult',
      _i4r0gy9o.CareRole => 'CareRole',
      _ikpfm01t.OneDoseErrorCode => 'OneDoseErrorCode',
      _ilkedwcd.IngredientLock => 'IngredientLock',
      _im0892wf.Invite => 'Invite',
      _i3k33a72.InviteCreated => 'InviteCreated',
      _ivc5j21c.Medicine => 'Medicine',
      _ieilolm8.MedicineStatus => 'MedicineStatus',
      _ipygw1ot.OneDoseException => 'OneDoseException',
      _ifwrwu8f.StatusLight => 'StatusLight',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('onedose.', '');
    }

    switch (data) {
      case _i6rfisfz.EscalationFutureCallMissedDoseCheckModel():
        return 'EscalationFutureCallMissedDoseCheckModel';
      case _iu2jkarh.EscalationFutureCallShiftExpiryModel():
        return 'EscalationFutureCallShiftExpiryModel';
      case _ihh2y04m.EscalationFutureCallSlotDueModel():
        return 'EscalationFutureCallSlotDueModel';
      case _iq25v74h.CareMember():
        return 'CareMember';
      case _ixfwt8j5.Child():
        return 'Child';
      case _iwyprj06.CircleEvent():
        return 'CircleEvent';
      case _iy6yb3zw.CircleEventType():
        return 'CircleEventType';
      case _ire8j3dz.CircleSummary():
        return 'CircleSummary';
      case _iyt8dqsq.DoseEvent():
        return 'DoseEvent';
      case _i3n8cunl.DoseOutcome():
        return 'DoseOutcome';
      case _iw3hqc14.DoseResult():
        return 'DoseResult';
      case _i4r0gy9o.CareRole():
        return 'CareRole';
      case _ikpfm01t.OneDoseErrorCode():
        return 'OneDoseErrorCode';
      case _ilkedwcd.IngredientLock():
        return 'IngredientLock';
      case _im0892wf.Invite():
        return 'Invite';
      case _i3k33a72.InviteCreated():
        return 'InviteCreated';
      case _ivc5j21c.Medicine():
        return 'Medicine';
      case _ieilolm8.MedicineStatus():
        return 'MedicineStatus';
      case _ipygw1ot.OneDoseException():
        return 'OneDoseException';
      case _ifwrwu8f.StatusLight():
        return 'StatusLight';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'EscalationFutureCallMissedDoseCheckModel') {
      return deserialize<_i6rfisfz.EscalationFutureCallMissedDoseCheckModel>(
        data['data'],
      );
    }
    if (dataClassName == 'EscalationFutureCallShiftExpiryModel') {
      return deserialize<_iu2jkarh.EscalationFutureCallShiftExpiryModel>(
        data['data'],
      );
    }
    if (dataClassName == 'EscalationFutureCallSlotDueModel') {
      return deserialize<_ihh2y04m.EscalationFutureCallSlotDueModel>(
        data['data'],
      );
    }
    if (dataClassName == 'CareMember') {
      return deserialize<_iq25v74h.CareMember>(data['data']);
    }
    if (dataClassName == 'Child') {
      return deserialize<_ixfwt8j5.Child>(data['data']);
    }
    if (dataClassName == 'CircleEvent') {
      return deserialize<_iwyprj06.CircleEvent>(data['data']);
    }
    if (dataClassName == 'CircleEventType') {
      return deserialize<_iy6yb3zw.CircleEventType>(data['data']);
    }
    if (dataClassName == 'CircleSummary') {
      return deserialize<_ire8j3dz.CircleSummary>(data['data']);
    }
    if (dataClassName == 'DoseEvent') {
      return deserialize<_iyt8dqsq.DoseEvent>(data['data']);
    }
    if (dataClassName == 'DoseOutcome') {
      return deserialize<_i3n8cunl.DoseOutcome>(data['data']);
    }
    if (dataClassName == 'DoseResult') {
      return deserialize<_iw3hqc14.DoseResult>(data['data']);
    }
    if (dataClassName == 'CareRole') {
      return deserialize<_i4r0gy9o.CareRole>(data['data']);
    }
    if (dataClassName == 'OneDoseErrorCode') {
      return deserialize<_ikpfm01t.OneDoseErrorCode>(data['data']);
    }
    if (dataClassName == 'IngredientLock') {
      return deserialize<_ilkedwcd.IngredientLock>(data['data']);
    }
    if (dataClassName == 'Invite') {
      return deserialize<_im0892wf.Invite>(data['data']);
    }
    if (dataClassName == 'InviteCreated') {
      return deserialize<_i3k33a72.InviteCreated>(data['data']);
    }
    if (dataClassName == 'Medicine') {
      return deserialize<_ivc5j21c.Medicine>(data['data']);
    }
    if (dataClassName == 'MedicineStatus') {
      return deserialize<_ieilolm8.MedicineStatus>(data['data']);
    }
    if (dataClassName == 'OneDoseException') {
      return deserialize<_ipygw1ot.OneDoseException>(data['data']);
    }
    if (dataClassName == 'StatusLight') {
      return deserialize<_ifwrwu8f.StatusLight>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('onedose', this);
    _iacs.Protocol().registerHostProtocol('onedose', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _iq25v74h.CareMember:
        return _iq25v74h.CareMember.t;
      case _ixfwt8j5.Child:
        return _ixfwt8j5.Child.t;
      case _iyt8dqsq.DoseEvent:
        return _iyt8dqsq.DoseEvent.t;
      case _ilkedwcd.IngredientLock:
        return _ilkedwcd.IngredientLock.t;
      case _im0892wf.Invite:
        return _im0892wf.Invite.t;
      case _ivc5j21c.Medicine:
        return _ivc5j21c.Medicine.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'onedose';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
