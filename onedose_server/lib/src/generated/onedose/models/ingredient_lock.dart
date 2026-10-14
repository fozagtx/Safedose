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

/// The single row locked while a dose of an ingredient is checked.
abstract class IngredientLock
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IngredientLock._({
    this.id,
    required this.childId,
    required this.ingredient,
    this.lastGivenAt,
    this.lastGivenBy,
  });

  factory IngredientLock({
    int? id,
    required int childId,
    required String ingredient,
    DateTime? lastGivenAt,
    String? lastGivenBy,
  }) = _IngredientLockImpl;

  factory IngredientLock.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngredientLock(
      id: jsonSerialization['id'] as int?,
      childId: jsonSerialization['childId'] as int,
      ingredient: jsonSerialization['ingredient'] as String,
      lastGivenAt: jsonSerialization['lastGivenAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastGivenAt'],
            ),
      lastGivenBy: jsonSerialization['lastGivenBy'] as String?,
    );
  }

  static final t = IngredientLockTable();

  static const db = IngredientLockRepository._();

  @override
  int? id;

  int childId;

  String ingredient;

  DateTime? lastGivenAt;

  String? lastGivenBy;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IngredientLock]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IngredientLock copyWith({
    int? id,
    int? childId,
    String? ingredient,
    DateTime? lastGivenAt,
    String? lastGivenBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngredientLock',
      if (id != null) 'id': id,
      'childId': childId,
      'ingredient': ingredient,
      if (lastGivenAt != null) 'lastGivenAt': lastGivenAt?.toJson(),
      if (lastGivenBy != null) 'lastGivenBy': lastGivenBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IngredientLock',
      if (id != null) 'id': id,
      'childId': childId,
      'ingredient': ingredient,
      if (lastGivenAt != null) 'lastGivenAt': lastGivenAt?.toJson(),
      if (lastGivenBy != null) 'lastGivenBy': lastGivenBy,
    };
  }

  static IngredientLockInclude include() {
    return IngredientLockInclude._();
  }

  static IngredientLockIncludeList includeList({
    _is.WhereExpressionBuilder<IngredientLockTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IngredientLockTable>? orderBy,
    _is.OrderByListBuilder<IngredientLockTable>? orderByList,
    IngredientLockInclude? include,
  }) {
    return IngredientLockIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IngredientLock.t),
      orderByList: orderByList?.call(IngredientLock.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IngredientLockImpl extends IngredientLock {
  _IngredientLockImpl({
    int? id,
    required int childId,
    required String ingredient,
    DateTime? lastGivenAt,
    String? lastGivenBy,
  }) : super._(
         id: id,
         childId: childId,
         ingredient: ingredient,
         lastGivenAt: lastGivenAt,
         lastGivenBy: lastGivenBy,
       );

  /// Returns a shallow copy of this [IngredientLock]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IngredientLock copyWith({
    Object? id = _Undefined,
    int? childId,
    String? ingredient,
    Object? lastGivenAt = _Undefined,
    Object? lastGivenBy = _Undefined,
  }) {
    return IngredientLock(
      id: id is int? ? id : this.id,
      childId: childId ?? this.childId,
      ingredient: ingredient ?? this.ingredient,
      lastGivenAt: lastGivenAt is DateTime? ? lastGivenAt : this.lastGivenAt,
      lastGivenBy: lastGivenBy is String? ? lastGivenBy : this.lastGivenBy,
    );
  }
}

class IngredientLockUpdateTable extends _is.UpdateTable<IngredientLockTable> {
  IngredientLockUpdateTable(super.table);

  _is.ColumnValue<int, int> childId(int value) => _is.ColumnValue(
    table.childId,
    value,
  );

  _is.ColumnValue<String, String> ingredient(String value) => _is.ColumnValue(
    table.ingredient,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastGivenAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastGivenAt,
        value,
      );

  _is.ColumnValue<String, String> lastGivenBy(String? value) => _is.ColumnValue(
    table.lastGivenBy,
    value,
  );
}

class IngredientLockTable extends _is.Table<int?> {
  IngredientLockTable({super.tableRelation})
    : super(tableName: 'ingredient_lock') {
    updateTable = IngredientLockUpdateTable(this);
    childId = _is.ColumnInt(
      'childId',
      this,
    );
    ingredient = _is.ColumnString(
      'ingredient',
      this,
    );
    lastGivenAt = _is.ColumnDateTime(
      'lastGivenAt',
      this,
    );
    lastGivenBy = _is.ColumnString(
      'lastGivenBy',
      this,
    );
  }

  late final IngredientLockUpdateTable updateTable;

  late final _is.ColumnInt childId;

  late final _is.ColumnString ingredient;

  late final _is.ColumnDateTime lastGivenAt;

  late final _is.ColumnString lastGivenBy;

  @override
  List<_is.Column> get columns => [
    id,
    childId,
    ingredient,
    lastGivenAt,
    lastGivenBy,
  ];
}

class IngredientLockInclude extends _is.IncludeObject {
  IngredientLockInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IngredientLock.t;
}

class IngredientLockIncludeList extends _is.IncludeList {
  IngredientLockIncludeList._({
    _is.WhereExpressionBuilder<IngredientLockTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IngredientLock.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IngredientLock.t;
}

class IngredientLockRepository {
  const IngredientLockRepository._();

  /// Returns a list of [IngredientLock]s matching the given query parameters.
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
  Future<List<IngredientLock>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IngredientLockTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IngredientLockTable>? orderBy,
    _is.OrderByListBuilder<IngredientLockTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IngredientLock>(
      where: where?.call(IngredientLock.t),
      orderBy: orderBy?.call(IngredientLock.t),
      orderByList: orderByList?.call(IngredientLock.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IngredientLock] matching the given query parameters.
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
  Future<IngredientLock?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IngredientLockTable>? where,
    int? offset,
    _is.OrderByBuilder<IngredientLockTable>? orderBy,
    _is.OrderByListBuilder<IngredientLockTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IngredientLock>(
      where: where?.call(IngredientLock.t),
      orderBy: orderBy?.call(IngredientLock.t),
      orderByList: orderByList?.call(IngredientLock.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IngredientLock] by its [id] or null if no such row exists.
  Future<IngredientLock?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IngredientLock>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IngredientLock]s in the list and returns the inserted rows.
  ///
  /// The returned [IngredientLock]s will have their `id` fields set.
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
  Future<List<IngredientLock>> insert(
    _is.DatabaseSession session,
    List<IngredientLock> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IngredientLock>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IngredientLock] and returns the inserted row.
  ///
  /// The returned [IngredientLock] will have its `id` field set.
  Future<IngredientLock> insertRow(
    _is.DatabaseSession session,
    IngredientLock row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IngredientLock>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IngredientLock]s in the list and returns the resulting rows.
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
  /// The returned [IngredientLock]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IngredientLock>> upsert(
    _is.DatabaseSession session,
    List<IngredientLock> rows, {
    required _is.ColumnSelections<IngredientLockTable> conflictColumns,
    _is.ColumnSelections<IngredientLockTable>? updateColumns,
    _is.WhereExpressionBuilder<IngredientLockTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IngredientLock>(
      rows,
      conflictColumns: conflictColumns(IngredientLock.t),
      updateColumns: updateColumns?.call(IngredientLock.t),
      updateWhere: updateWhere?.call(IngredientLock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IngredientLock] and returns the resulting row.
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
  /// The returned [IngredientLock] will have its `id` field set.
  Future<IngredientLock?> upsertRow(
    _is.DatabaseSession session,
    IngredientLock row, {
    required _is.ColumnSelections<IngredientLockTable> conflictColumns,
    _is.ColumnSelections<IngredientLockTable>? updateColumns,
    _is.WhereExpressionBuilder<IngredientLockTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IngredientLock>(
      row,
      conflictColumns: conflictColumns(IngredientLock.t),
      updateColumns: updateColumns?.call(IngredientLock.t),
      updateWhere: updateWhere?.call(IngredientLock.t),
      transaction: transaction,
    );
  }

  /// Updates all [IngredientLock]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IngredientLock>> update(
    _is.DatabaseSession session,
    List<IngredientLock> rows, {
    _is.ColumnSelections<IngredientLockTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IngredientLock>(
      rows,
      columns: columns?.call(IngredientLock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IngredientLock]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IngredientLock> updateRow(
    _is.DatabaseSession session,
    IngredientLock row, {
    _is.ColumnSelections<IngredientLockTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IngredientLock>(
      row,
      columns: columns?.call(IngredientLock.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IngredientLock] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IngredientLock?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IngredientLockUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IngredientLock>(
      id,
      columnValues: columnValues(IngredientLock.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IngredientLock]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IngredientLock>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IngredientLockUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IngredientLockTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IngredientLockTable>? orderBy,
    _is.OrderByListBuilder<IngredientLockTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IngredientLock>(
      columnValues: columnValues(IngredientLock.t.updateTable),
      where: where(IngredientLock.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IngredientLock.t),
      orderByList: orderByList?.call(IngredientLock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IngredientLock]s in the list and returns the deleted rows.
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
  Future<List<IngredientLock>> delete(
    _is.DatabaseSession session,
    List<IngredientLock> rows, {
    _is.OrderByBuilder<IngredientLockTable>? orderBy,
    _is.OrderByListBuilder<IngredientLockTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IngredientLock>(
      rows,
      orderBy: orderBy?.call(IngredientLock.t),
      orderByList: orderByList?.call(IngredientLock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IngredientLock].
  Future<IngredientLock> deleteRow(
    _is.DatabaseSession session,
    IngredientLock row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IngredientLock>(
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
  Future<List<IngredientLock>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IngredientLockTable> where,
    _is.OrderByBuilder<IngredientLockTable>? orderBy,
    _is.OrderByListBuilder<IngredientLockTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IngredientLock>(
      where: where(IngredientLock.t),
      orderBy: orderBy?.call(IngredientLock.t),
      orderByList: orderByList?.call(IngredientLock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IngredientLockTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IngredientLock>(
      where: where?.call(IngredientLock.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IngredientLock] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IngredientLockTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IngredientLock>(
      where: where(IngredientLock.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
