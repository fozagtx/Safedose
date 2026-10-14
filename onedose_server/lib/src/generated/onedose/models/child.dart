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

/// A child at the centre of one care circle.
abstract class Child implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue ownerId,
    int? utcOffsetMinutes,
  }) = _ChildImpl;

  factory Child.fromJson(Map<String, dynamic> jsonSerialization) {
    return Child(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      photoUrl: jsonSerialization['photoUrl'] as String?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      utcOffsetMinutes: jsonSerialization['utcOffsetMinutes'] as int?,
    );
  }

  static final t = ChildTable();

  static const db = ChildRepository._();

  @override
  int? id;

  String name;

  String? photoUrl;

  _is.UuidValue ownerId;

  /// Offset from UTC of the family's local time, used for fixed dose times
  /// and for the times written into refusal messages.
  int utcOffsetMinutes;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Child]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Child copyWith({
    int? id,
    String? name,
    String? photoUrl,
    _is.UuidValue? ownerId,
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

  static ChildInclude include() {
    return ChildInclude._();
  }

  static ChildIncludeList includeList({
    _is.WhereExpressionBuilder<ChildTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChildTable>? orderBy,
    _is.OrderByListBuilder<ChildTable>? orderByList,
    ChildInclude? include,
  }) {
    return ChildIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Child.t),
      orderByList: orderByList?.call(Child.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChildImpl extends Child {
  _ChildImpl({
    int? id,
    required String name,
    String? photoUrl,
    required _is.UuidValue ownerId,
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
  @_is.useResult
  @override
  Child copyWith({
    Object? id = _Undefined,
    String? name,
    Object? photoUrl = _Undefined,
    _is.UuidValue? ownerId,
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

class ChildUpdateTable extends _is.UpdateTable<ChildTable> {
  ChildUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> photoUrl(String? value) => _is.ColumnValue(
    table.photoUrl,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<int, int> utcOffsetMinutes(int value) => _is.ColumnValue(
    table.utcOffsetMinutes,
    value,
  );
}

class ChildTable extends _is.Table<int?> {
  ChildTable({super.tableRelation}) : super(tableName: 'child') {
    updateTable = ChildUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    photoUrl = _is.ColumnString(
      'photoUrl',
      this,
    );
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    utcOffsetMinutes = _is.ColumnInt(
      'utcOffsetMinutes',
      this,
      hasDefault: true,
    );
  }

  late final ChildUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString photoUrl;

  late final _is.ColumnUuid ownerId;

  /// Offset from UTC of the family's local time, used for fixed dose times
  /// and for the times written into refusal messages.
  late final _is.ColumnInt utcOffsetMinutes;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    photoUrl,
    ownerId,
    utcOffsetMinutes,
  ];
}

class ChildInclude extends _is.IncludeObject {
  ChildInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Child.t;
}

class ChildIncludeList extends _is.IncludeList {
  ChildIncludeList._({
    _is.WhereExpressionBuilder<ChildTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Child.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Child.t;
}

class ChildRepository {
  const ChildRepository._();

  /// Returns a list of [Child]s matching the given query parameters.
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
  Future<List<Child>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChildTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChildTable>? orderBy,
    _is.OrderByListBuilder<ChildTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Child>(
      where: where?.call(Child.t),
      orderBy: orderBy?.call(Child.t),
      orderByList: orderByList?.call(Child.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Child] matching the given query parameters.
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
  Future<Child?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChildTable>? where,
    int? offset,
    _is.OrderByBuilder<ChildTable>? orderBy,
    _is.OrderByListBuilder<ChildTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Child>(
      where: where?.call(Child.t),
      orderBy: orderBy?.call(Child.t),
      orderByList: orderByList?.call(Child.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Child] by its [id] or null if no such row exists.
  Future<Child?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Child>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Child]s in the list and returns the inserted rows.
  ///
  /// The returned [Child]s will have their `id` fields set.
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
  Future<List<Child>> insert(
    _is.DatabaseSession session,
    List<Child> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Child>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Child] and returns the inserted row.
  ///
  /// The returned [Child] will have its `id` field set.
  Future<Child> insertRow(
    _is.DatabaseSession session,
    Child row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Child>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Child]s in the list and returns the resulting rows.
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
  /// The returned [Child]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Child>> upsert(
    _is.DatabaseSession session,
    List<Child> rows, {
    required _is.ColumnSelections<ChildTable> conflictColumns,
    _is.ColumnSelections<ChildTable>? updateColumns,
    _is.WhereExpressionBuilder<ChildTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Child>(
      rows,
      conflictColumns: conflictColumns(Child.t),
      updateColumns: updateColumns?.call(Child.t),
      updateWhere: updateWhere?.call(Child.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Child] and returns the resulting row.
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
  /// The returned [Child] will have its `id` field set.
  Future<Child?> upsertRow(
    _is.DatabaseSession session,
    Child row, {
    required _is.ColumnSelections<ChildTable> conflictColumns,
    _is.ColumnSelections<ChildTable>? updateColumns,
    _is.WhereExpressionBuilder<ChildTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Child>(
      row,
      conflictColumns: conflictColumns(Child.t),
      updateColumns: updateColumns?.call(Child.t),
      updateWhere: updateWhere?.call(Child.t),
      transaction: transaction,
    );
  }

  /// Updates all [Child]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Child>> update(
    _is.DatabaseSession session,
    List<Child> rows, {
    _is.ColumnSelections<ChildTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Child>(
      rows,
      columns: columns?.call(Child.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Child]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Child> updateRow(
    _is.DatabaseSession session,
    Child row, {
    _is.ColumnSelections<ChildTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Child>(
      row,
      columns: columns?.call(Child.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Child] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Child?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChildUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Child>(
      id,
      columnValues: columnValues(Child.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Child]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Child>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChildUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ChildTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChildTable>? orderBy,
    _is.OrderByListBuilder<ChildTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Child>(
      columnValues: columnValues(Child.t.updateTable),
      where: where(Child.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Child.t),
      orderByList: orderByList?.call(Child.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Child]s in the list and returns the deleted rows.
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
  Future<List<Child>> delete(
    _is.DatabaseSession session,
    List<Child> rows, {
    _is.OrderByBuilder<ChildTable>? orderBy,
    _is.OrderByListBuilder<ChildTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Child>(
      rows,
      orderBy: orderBy?.call(Child.t),
      orderByList: orderByList?.call(Child.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Child].
  Future<Child> deleteRow(
    _is.DatabaseSession session,
    Child row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Child>(
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
  Future<List<Child>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChildTable> where,
    _is.OrderByBuilder<ChildTable>? orderBy,
    _is.OrderByListBuilder<ChildTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Child>(
      where: where(Child.t),
      orderBy: orderBy?.call(Child.t),
      orderByList: orderByList?.call(Child.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChildTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Child>(
      where: where?.call(Child.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Child] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChildTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Child>(
      where: where(Child.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
