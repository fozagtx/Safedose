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
import '../../onedose/models/dose_outcome.dart' as _ib9gikq8;

/// Every dose attempt, accepted or refused. Never deleted.
abstract class DoseEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DoseEvent._({
    this.id,
    required this.childId,
    required this.medicineId,
    required this.medicineName,
    required this.ingredient,
    required this.doseText,
    required this.caregiverId,
    required this.caregiverName,
    required this.at,
    required this.outcome,
    this.reason,
    this.nextAllowedAt,
    this.undoneAt,
  });

  factory DoseEvent({
    int? id,
    required int childId,
    required int medicineId,
    required String medicineName,
    required String ingredient,
    required String doseText,
    required _is.UuidValue caregiverId,
    required String caregiverName,
    required DateTime at,
    required _ib9gikq8.DoseOutcome outcome,
    String? reason,
    DateTime? nextAllowedAt,
    DateTime? undoneAt,
  }) = _DoseEventImpl;

  factory DoseEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return DoseEvent(
      id: jsonSerialization['id'] as int?,
      childId: jsonSerialization['childId'] as int,
      medicineId: jsonSerialization['medicineId'] as int,
      medicineName: jsonSerialization['medicineName'] as String,
      ingredient: jsonSerialization['ingredient'] as String,
      doseText: jsonSerialization['doseText'] as String,
      caregiverId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['caregiverId'],
      ),
      caregiverName: jsonSerialization['caregiverName'] as String,
      at: _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
      outcome: _ib9gikq8.DoseOutcome.fromJson(
        (jsonSerialization['outcome'] as String),
      ),
      reason: jsonSerialization['reason'] as String?,
      nextAllowedAt: jsonSerialization['nextAllowedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextAllowedAt'],
            ),
      undoneAt: jsonSerialization['undoneAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['undoneAt']),
    );
  }

  static final t = DoseEventTable();

  static const db = DoseEventRepository._();

  @override
  int? id;

  int childId;

  int medicineId;

  String medicineName;

  String ingredient;

  String doseText;

  _is.UuidValue caregiverId;

  String caregiverName;

  DateTime at;

  _ib9gikq8.DoseOutcome outcome;

  String? reason;

  DateTime? nextAllowedAt;

  /// Set on an accepted dose that was later undone.
  DateTime? undoneAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DoseEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DoseEvent copyWith({
    int? id,
    int? childId,
    int? medicineId,
    String? medicineName,
    String? ingredient,
    String? doseText,
    _is.UuidValue? caregiverId,
    String? caregiverName,
    DateTime? at,
    _ib9gikq8.DoseOutcome? outcome,
    String? reason,
    DateTime? nextAllowedAt,
    DateTime? undoneAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DoseEvent',
      if (id != null) 'id': id,
      'childId': childId,
      'medicineId': medicineId,
      'medicineName': medicineName,
      'ingredient': ingredient,
      'doseText': doseText,
      'caregiverId': caregiverId.toJson(),
      'caregiverName': caregiverName,
      'at': at.toJson(),
      'outcome': outcome.toJson(),
      if (reason != null) 'reason': reason,
      if (nextAllowedAt != null) 'nextAllowedAt': nextAllowedAt?.toJson(),
      if (undoneAt != null) 'undoneAt': undoneAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DoseEvent',
      if (id != null) 'id': id,
      'childId': childId,
      'medicineId': medicineId,
      'medicineName': medicineName,
      'ingredient': ingredient,
      'doseText': doseText,
      'caregiverId': caregiverId.toJson(),
      'caregiverName': caregiverName,
      'at': at.toJson(),
      'outcome': outcome.toJson(),
      if (reason != null) 'reason': reason,
      if (nextAllowedAt != null) 'nextAllowedAt': nextAllowedAt?.toJson(),
      if (undoneAt != null) 'undoneAt': undoneAt?.toJson(),
    };
  }

  static DoseEventInclude include() {
    return DoseEventInclude._();
  }

  static DoseEventIncludeList includeList({
    _is.WhereExpressionBuilder<DoseEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoseEventTable>? orderBy,
    _is.OrderByListBuilder<DoseEventTable>? orderByList,
    DoseEventInclude? include,
  }) {
    return DoseEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DoseEvent.t),
      orderByList: orderByList?.call(DoseEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DoseEventImpl extends DoseEvent {
  _DoseEventImpl({
    int? id,
    required int childId,
    required int medicineId,
    required String medicineName,
    required String ingredient,
    required String doseText,
    required _is.UuidValue caregiverId,
    required String caregiverName,
    required DateTime at,
    required _ib9gikq8.DoseOutcome outcome,
    String? reason,
    DateTime? nextAllowedAt,
    DateTime? undoneAt,
  }) : super._(
         id: id,
         childId: childId,
         medicineId: medicineId,
         medicineName: medicineName,
         ingredient: ingredient,
         doseText: doseText,
         caregiverId: caregiverId,
         caregiverName: caregiverName,
         at: at,
         outcome: outcome,
         reason: reason,
         nextAllowedAt: nextAllowedAt,
         undoneAt: undoneAt,
       );

  /// Returns a shallow copy of this [DoseEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DoseEvent copyWith({
    Object? id = _Undefined,
    int? childId,
    int? medicineId,
    String? medicineName,
    String? ingredient,
    String? doseText,
    _is.UuidValue? caregiverId,
    String? caregiverName,
    DateTime? at,
    _ib9gikq8.DoseOutcome? outcome,
    Object? reason = _Undefined,
    Object? nextAllowedAt = _Undefined,
    Object? undoneAt = _Undefined,
  }) {
    return DoseEvent(
      id: id is int? ? id : this.id,
      childId: childId ?? this.childId,
      medicineId: medicineId ?? this.medicineId,
      medicineName: medicineName ?? this.medicineName,
      ingredient: ingredient ?? this.ingredient,
      doseText: doseText ?? this.doseText,
      caregiverId: caregiverId ?? this.caregiverId,
      caregiverName: caregiverName ?? this.caregiverName,
      at: at ?? this.at,
      outcome: outcome ?? this.outcome,
      reason: reason is String? ? reason : this.reason,
      nextAllowedAt: nextAllowedAt is DateTime?
          ? nextAllowedAt
          : this.nextAllowedAt,
      undoneAt: undoneAt is DateTime? ? undoneAt : this.undoneAt,
    );
  }
}

class DoseEventUpdateTable extends _is.UpdateTable<DoseEventTable> {
  DoseEventUpdateTable(super.table);

  _is.ColumnValue<int, int> childId(int value) => _is.ColumnValue(
    table.childId,
    value,
  );

  _is.ColumnValue<int, int> medicineId(int value) => _is.ColumnValue(
    table.medicineId,
    value,
  );

  _is.ColumnValue<String, String> medicineName(String value) => _is.ColumnValue(
    table.medicineName,
    value,
  );

  _is.ColumnValue<String, String> ingredient(String value) => _is.ColumnValue(
    table.ingredient,
    value,
  );

  _is.ColumnValue<String, String> doseText(String value) => _is.ColumnValue(
    table.doseText,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> caregiverId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.caregiverId,
    value,
  );

  _is.ColumnValue<String, String> caregiverName(String value) =>
      _is.ColumnValue(
        table.caregiverName,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> at(DateTime value) => _is.ColumnValue(
    table.at,
    value,
  );

  _is.ColumnValue<_ib9gikq8.DoseOutcome, _ib9gikq8.DoseOutcome> outcome(
    _ib9gikq8.DoseOutcome value,
  ) => _is.ColumnValue(
    table.outcome,
    value,
  );

  _is.ColumnValue<String, String> reason(String? value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> nextAllowedAt(DateTime? value) =>
      _is.ColumnValue(
        table.nextAllowedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> undoneAt(DateTime? value) =>
      _is.ColumnValue(
        table.undoneAt,
        value,
      );
}

class DoseEventTable extends _is.Table<int?> {
  DoseEventTable({super.tableRelation}) : super(tableName: 'dose_event') {
    updateTable = DoseEventUpdateTable(this);
    childId = _is.ColumnInt(
      'childId',
      this,
    );
    medicineId = _is.ColumnInt(
      'medicineId',
      this,
    );
    medicineName = _is.ColumnString(
      'medicineName',
      this,
    );
    ingredient = _is.ColumnString(
      'ingredient',
      this,
    );
    doseText = _is.ColumnString(
      'doseText',
      this,
    );
    caregiverId = _is.ColumnUuid(
      'caregiverId',
      this,
    );
    caregiverName = _is.ColumnString(
      'caregiverName',
      this,
    );
    at = _is.ColumnDateTime(
      'at',
      this,
    );
    outcome = _is.ColumnEnum(
      'outcome',
      this,
      _is.EnumSerialization.byName,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    nextAllowedAt = _is.ColumnDateTime(
      'nextAllowedAt',
      this,
    );
    undoneAt = _is.ColumnDateTime(
      'undoneAt',
      this,
    );
  }

  late final DoseEventUpdateTable updateTable;

  late final _is.ColumnInt childId;

  late final _is.ColumnInt medicineId;

  late final _is.ColumnString medicineName;

  late final _is.ColumnString ingredient;

  late final _is.ColumnString doseText;

  late final _is.ColumnUuid caregiverId;

  late final _is.ColumnString caregiverName;

  late final _is.ColumnDateTime at;

  late final _is.ColumnEnum<_ib9gikq8.DoseOutcome> outcome;

  late final _is.ColumnString reason;

  late final _is.ColumnDateTime nextAllowedAt;

  /// Set on an accepted dose that was later undone.
  late final _is.ColumnDateTime undoneAt;

  @override
  List<_is.Column> get columns => [
    id,
    childId,
    medicineId,
    medicineName,
    ingredient,
    doseText,
    caregiverId,
    caregiverName,
    at,
    outcome,
    reason,
    nextAllowedAt,
    undoneAt,
  ];
}

class DoseEventInclude extends _is.IncludeObject {
  DoseEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DoseEvent.t;
}

class DoseEventIncludeList extends _is.IncludeList {
  DoseEventIncludeList._({
    _is.WhereExpressionBuilder<DoseEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DoseEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DoseEvent.t;
}

class DoseEventRepository {
  const DoseEventRepository._();

  /// Returns a list of [DoseEvent]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<DoseEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoseEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoseEventTable>? orderBy,
    _is.OrderByListBuilder<DoseEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DoseEvent>(
      where: where?.call(DoseEvent.t),
      orderBy: orderBy?.call(DoseEvent.t),
      orderByList: orderByList?.call(DoseEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DoseEvent] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<DoseEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoseEventTable>? where,
    int? offset,
    _is.OrderByBuilder<DoseEventTable>? orderBy,
    _is.OrderByListBuilder<DoseEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DoseEvent>(
      where: where?.call(DoseEvent.t),
      orderBy: orderBy?.call(DoseEvent.t),
      orderByList: orderByList?.call(DoseEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DoseEvent] by its [id] or null if no such row exists.
  Future<DoseEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DoseEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DoseEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [DoseEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoseEvent>> insert(
    _is.DatabaseSession session,
    List<DoseEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DoseEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DoseEvent] and returns the inserted row.
  ///
  /// The returned [DoseEvent] will have its `id` field set.
  Future<DoseEvent> insertRow(
    _is.DatabaseSession session,
    DoseEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DoseEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DoseEvent]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [DoseEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoseEvent>> upsert(
    _is.DatabaseSession session,
    List<DoseEvent> rows, {
    required _is.ColumnSelections<DoseEventTable> conflictColumns,
    _is.ColumnSelections<DoseEventTable>? updateColumns,
    _is.WhereExpressionBuilder<DoseEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DoseEvent>(
      rows,
      conflictColumns: conflictColumns(DoseEvent.t),
      updateColumns: updateColumns?.call(DoseEvent.t),
      updateWhere: updateWhere?.call(DoseEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DoseEvent] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [DoseEvent] will have its `id` field set.
  Future<DoseEvent?> upsertRow(
    _is.DatabaseSession session,
    DoseEvent row, {
    required _is.ColumnSelections<DoseEventTable> conflictColumns,
    _is.ColumnSelections<DoseEventTable>? updateColumns,
    _is.WhereExpressionBuilder<DoseEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DoseEvent>(
      row,
      conflictColumns: conflictColumns(DoseEvent.t),
      updateColumns: updateColumns?.call(DoseEvent.t),
      updateWhere: updateWhere?.call(DoseEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [DoseEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoseEvent>> update(
    _is.DatabaseSession session,
    List<DoseEvent> rows, {
    _is.ColumnSelections<DoseEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DoseEvent>(
      rows,
      columns: columns?.call(DoseEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DoseEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DoseEvent> updateRow(
    _is.DatabaseSession session,
    DoseEvent row, {
    _is.ColumnSelections<DoseEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DoseEvent>(
      row,
      columns: columns?.call(DoseEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DoseEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DoseEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DoseEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DoseEvent>(
      id,
      columnValues: columnValues(DoseEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DoseEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoseEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DoseEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DoseEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoseEventTable>? orderBy,
    _is.OrderByListBuilder<DoseEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DoseEvent>(
      columnValues: columnValues(DoseEvent.t.updateTable),
      where: where(DoseEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DoseEvent.t),
      orderByList: orderByList?.call(DoseEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DoseEvent]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoseEvent>> delete(
    _is.DatabaseSession session,
    List<DoseEvent> rows, {
    _is.OrderByBuilder<DoseEventTable>? orderBy,
    _is.OrderByListBuilder<DoseEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DoseEvent>(
      rows,
      orderBy: orderBy?.call(DoseEvent.t),
      orderByList: orderByList?.call(DoseEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DoseEvent].
  Future<DoseEvent> deleteRow(
    _is.DatabaseSession session,
    DoseEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DoseEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoseEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DoseEventTable> where,
    _is.OrderByBuilder<DoseEventTable>? orderBy,
    _is.OrderByListBuilder<DoseEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DoseEvent>(
      where: where(DoseEvent.t),
      orderBy: orderBy?.call(DoseEvent.t),
      orderByList: orderByList?.call(DoseEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoseEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DoseEvent>(
      where: where?.call(DoseEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DoseEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DoseEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DoseEvent>(
      where: where(DoseEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
