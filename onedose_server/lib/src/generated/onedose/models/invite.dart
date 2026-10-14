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
import '../../onedose/models/enums.dart' as _idkclkk2;

/// A one-time link that adds a sitter (or co-parent) to a circle.
abstract class Invite implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['shiftStart']),
      shiftEnd: jsonSerialization['shiftEnd'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['shiftEnd']),
      usedAt: jsonSerialization['usedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['usedAt']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = InviteTable();

  static const db = InviteRepository._();

  @override
  int? id;

  String token;

  int childId;

  String displayName;

  _idkclkk2.CareRole role;

  DateTime? shiftStart;

  DateTime? shiftEnd;

  DateTime? usedAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Invite]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static InviteInclude include() {
    return InviteInclude._();
  }

  static InviteIncludeList includeList({
    _is.WhereExpressionBuilder<InviteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InviteTable>? orderBy,
    _is.OrderByListBuilder<InviteTable>? orderByList,
    InviteInclude? include,
  }) {
    return InviteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Invite.t),
      orderByList: orderByList?.call(Invite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class InviteUpdateTable extends _is.UpdateTable<InviteTable> {
  InviteUpdateTable(super.table);

  _is.ColumnValue<String, String> token(String value) => _is.ColumnValue(
    table.token,
    value,
  );

  _is.ColumnValue<int, int> childId(int value) => _is.ColumnValue(
    table.childId,
    value,
  );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<_idkclkk2.CareRole, _idkclkk2.CareRole> role(
    _idkclkk2.CareRole value,
  ) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> shiftStart(DateTime? value) =>
      _is.ColumnValue(
        table.shiftStart,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> shiftEnd(DateTime? value) =>
      _is.ColumnValue(
        table.shiftEnd,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> usedAt(DateTime? value) =>
      _is.ColumnValue(
        table.usedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class InviteTable extends _is.Table<int?> {
  InviteTable({super.tableRelation}) : super(tableName: 'invite') {
    updateTable = InviteUpdateTable(this);
    token = _is.ColumnString(
      'token',
      this,
    );
    childId = _is.ColumnInt(
      'childId',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    role = _is.ColumnEnum(
      'role',
      this,
      _is.EnumSerialization.byName,
    );
    shiftStart = _is.ColumnDateTime(
      'shiftStart',
      this,
    );
    shiftEnd = _is.ColumnDateTime(
      'shiftEnd',
      this,
    );
    usedAt = _is.ColumnDateTime(
      'usedAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final InviteUpdateTable updateTable;

  late final _is.ColumnString token;

  late final _is.ColumnInt childId;

  late final _is.ColumnString displayName;

  late final _is.ColumnEnum<_idkclkk2.CareRole> role;

  late final _is.ColumnDateTime shiftStart;

  late final _is.ColumnDateTime shiftEnd;

  late final _is.ColumnDateTime usedAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    token,
    childId,
    displayName,
    role,
    shiftStart,
    shiftEnd,
    usedAt,
    createdAt,
  ];
}

class InviteInclude extends _is.IncludeObject {
  InviteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Invite.t;
}

class InviteIncludeList extends _is.IncludeList {
  InviteIncludeList._({
    _is.WhereExpressionBuilder<InviteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Invite.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Invite.t;
}

class InviteRepository {
  const InviteRepository._();

  /// Returns a list of [Invite]s matching the given query parameters.
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
  Future<List<Invite>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InviteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InviteTable>? orderBy,
    _is.OrderByListBuilder<InviteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Invite>(
      where: where?.call(Invite.t),
      orderBy: orderBy?.call(Invite.t),
      orderByList: orderByList?.call(Invite.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Invite] matching the given query parameters.
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
  Future<Invite?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InviteTable>? where,
    int? offset,
    _is.OrderByBuilder<InviteTable>? orderBy,
    _is.OrderByListBuilder<InviteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Invite>(
      where: where?.call(Invite.t),
      orderBy: orderBy?.call(Invite.t),
      orderByList: orderByList?.call(Invite.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Invite] by its [id] or null if no such row exists.
  Future<Invite?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Invite>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Invite]s in the list and returns the inserted rows.
  ///
  /// The returned [Invite]s will have their `id` fields set.
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
  Future<List<Invite>> insert(
    _is.DatabaseSession session,
    List<Invite> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Invite>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Invite] and returns the inserted row.
  ///
  /// The returned [Invite] will have its `id` field set.
  Future<Invite> insertRow(
    _is.DatabaseSession session,
    Invite row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Invite>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Invite]s in the list and returns the resulting rows.
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
  /// The returned [Invite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invite>> upsert(
    _is.DatabaseSession session,
    List<Invite> rows, {
    required _is.ColumnSelections<InviteTable> conflictColumns,
    _is.ColumnSelections<InviteTable>? updateColumns,
    _is.WhereExpressionBuilder<InviteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Invite>(
      rows,
      conflictColumns: conflictColumns(Invite.t),
      updateColumns: updateColumns?.call(Invite.t),
      updateWhere: updateWhere?.call(Invite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Invite] and returns the resulting row.
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
  /// The returned [Invite] will have its `id` field set.
  Future<Invite?> upsertRow(
    _is.DatabaseSession session,
    Invite row, {
    required _is.ColumnSelections<InviteTable> conflictColumns,
    _is.ColumnSelections<InviteTable>? updateColumns,
    _is.WhereExpressionBuilder<InviteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Invite>(
      row,
      conflictColumns: conflictColumns(Invite.t),
      updateColumns: updateColumns?.call(Invite.t),
      updateWhere: updateWhere?.call(Invite.t),
      transaction: transaction,
    );
  }

  /// Updates all [Invite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invite>> update(
    _is.DatabaseSession session,
    List<Invite> rows, {
    _is.ColumnSelections<InviteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Invite>(
      rows,
      columns: columns?.call(Invite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Invite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Invite> updateRow(
    _is.DatabaseSession session,
    Invite row, {
    _is.ColumnSelections<InviteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Invite>(
      row,
      columns: columns?.call(Invite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Invite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Invite?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InviteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Invite>(
      id,
      columnValues: columnValues(Invite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Invite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invite>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InviteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<InviteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InviteTable>? orderBy,
    _is.OrderByListBuilder<InviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Invite>(
      columnValues: columnValues(Invite.t.updateTable),
      where: where(Invite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Invite.t),
      orderByList: orderByList?.call(Invite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Invite]s in the list and returns the deleted rows.
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
  Future<List<Invite>> delete(
    _is.DatabaseSession session,
    List<Invite> rows, {
    _is.OrderByBuilder<InviteTable>? orderBy,
    _is.OrderByListBuilder<InviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Invite>(
      rows,
      orderBy: orderBy?.call(Invite.t),
      orderByList: orderByList?.call(Invite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Invite].
  Future<Invite> deleteRow(
    _is.DatabaseSession session,
    Invite row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Invite>(
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
  Future<List<Invite>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InviteTable> where,
    _is.OrderByBuilder<InviteTable>? orderBy,
    _is.OrderByListBuilder<InviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Invite>(
      where: where(Invite.t),
      orderBy: orderBy?.call(Invite.t),
      orderByList: orderByList?.call(Invite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InviteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Invite>(
      where: where?.call(Invite.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Invite] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InviteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Invite>(
      where: where(Invite.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
