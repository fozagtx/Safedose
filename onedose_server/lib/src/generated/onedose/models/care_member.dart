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

/// A person who can see and log doses for a child.
abstract class CareMember
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CareMember._({
    this.id,
    required this.childId,
    required this.userId,
    required this.displayName,
    required this.role,
    this.shiftStart,
    this.shiftEnd,
    this.revokedAt,
  });

  factory CareMember({
    int? id,
    required int childId,
    required _is.UuidValue userId,
    required String displayName,
    required _idkclkk2.CareRole role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
    DateTime? revokedAt,
  }) = _CareMemberImpl;

  factory CareMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return CareMember(
      id: jsonSerialization['id'] as int?,
      childId: jsonSerialization['childId'] as int,
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      displayName: jsonSerialization['displayName'] as String,
      role: _idkclkk2.CareRole.fromJson((jsonSerialization['role'] as String)),
      shiftStart: jsonSerialization['shiftStart'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['shiftStart']),
      shiftEnd: jsonSerialization['shiftEnd'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['shiftEnd']),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
    );
  }

  static final t = CareMemberTable();

  static const db = CareMemberRepository._();

  @override
  int? id;

  int childId;

  _is.UuidValue userId;

  String displayName;

  _idkclkk2.CareRole role;

  /// Only set for sitters: access is valid in [shiftStart, shiftEnd).
  DateTime? shiftStart;

  DateTime? shiftEnd;

  DateTime? revokedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CareMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CareMember copyWith({
    int? id,
    int? childId,
    _is.UuidValue? userId,
    String? displayName,
    _idkclkk2.CareRole? role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
    DateTime? revokedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CareMember',
      if (id != null) 'id': id,
      'childId': childId,
      'userId': userId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      if (shiftStart != null) 'shiftStart': shiftStart?.toJson(),
      if (shiftEnd != null) 'shiftEnd': shiftEnd?.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CareMember',
      if (id != null) 'id': id,
      'childId': childId,
      'userId': userId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      if (shiftStart != null) 'shiftStart': shiftStart?.toJson(),
      if (shiftEnd != null) 'shiftEnd': shiftEnd?.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
    };
  }

  static CareMemberInclude include() {
    return CareMemberInclude._();
  }

  static CareMemberIncludeList includeList({
    _is.WhereExpressionBuilder<CareMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CareMemberTable>? orderBy,
    _is.OrderByListBuilder<CareMemberTable>? orderByList,
    CareMemberInclude? include,
  }) {
    return CareMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CareMember.t),
      orderByList: orderByList?.call(CareMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CareMemberImpl extends CareMember {
  _CareMemberImpl({
    int? id,
    required int childId,
    required _is.UuidValue userId,
    required String displayName,
    required _idkclkk2.CareRole role,
    DateTime? shiftStart,
    DateTime? shiftEnd,
    DateTime? revokedAt,
  }) : super._(
         id: id,
         childId: childId,
         userId: userId,
         displayName: displayName,
         role: role,
         shiftStart: shiftStart,
         shiftEnd: shiftEnd,
         revokedAt: revokedAt,
       );

  /// Returns a shallow copy of this [CareMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CareMember copyWith({
    Object? id = _Undefined,
    int? childId,
    _is.UuidValue? userId,
    String? displayName,
    _idkclkk2.CareRole? role,
    Object? shiftStart = _Undefined,
    Object? shiftEnd = _Undefined,
    Object? revokedAt = _Undefined,
  }) {
    return CareMember(
      id: id is int? ? id : this.id,
      childId: childId ?? this.childId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      shiftStart: shiftStart is DateTime? ? shiftStart : this.shiftStart,
      shiftEnd: shiftEnd is DateTime? ? shiftEnd : this.shiftEnd,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
    );
  }
}

class CareMemberUpdateTable extends _is.UpdateTable<CareMemberTable> {
  CareMemberUpdateTable(super.table);

  _is.ColumnValue<int, int> childId(int value) => _is.ColumnValue(
    table.childId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> userId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.userId,
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

  _is.ColumnValue<DateTime, DateTime> revokedAt(DateTime? value) =>
      _is.ColumnValue(
        table.revokedAt,
        value,
      );
}

class CareMemberTable extends _is.Table<int?> {
  CareMemberTable({super.tableRelation}) : super(tableName: 'care_member') {
    updateTable = CareMemberUpdateTable(this);
    childId = _is.ColumnInt(
      'childId',
      this,
    );
    userId = _is.ColumnUuid(
      'userId',
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
    revokedAt = _is.ColumnDateTime(
      'revokedAt',
      this,
    );
  }

  late final CareMemberUpdateTable updateTable;

  late final _is.ColumnInt childId;

  late final _is.ColumnUuid userId;

  late final _is.ColumnString displayName;

  late final _is.ColumnEnum<_idkclkk2.CareRole> role;

  /// Only set for sitters: access is valid in [shiftStart, shiftEnd).
  late final _is.ColumnDateTime shiftStart;

  late final _is.ColumnDateTime shiftEnd;

  late final _is.ColumnDateTime revokedAt;

  @override
  List<_is.Column> get columns => [
    id,
    childId,
    userId,
    displayName,
    role,
    shiftStart,
    shiftEnd,
    revokedAt,
  ];
}

class CareMemberInclude extends _is.IncludeObject {
  CareMemberInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CareMember.t;
}

class CareMemberIncludeList extends _is.IncludeList {
  CareMemberIncludeList._({
    _is.WhereExpressionBuilder<CareMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CareMember.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CareMember.t;
}

class CareMemberRepository {
  const CareMemberRepository._();

  /// Returns a list of [CareMember]s matching the given query parameters.
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
  Future<List<CareMember>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CareMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CareMemberTable>? orderBy,
    _is.OrderByListBuilder<CareMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CareMember>(
      where: where?.call(CareMember.t),
      orderBy: orderBy?.call(CareMember.t),
      orderByList: orderByList?.call(CareMember.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CareMember] matching the given query parameters.
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
  Future<CareMember?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CareMemberTable>? where,
    int? offset,
    _is.OrderByBuilder<CareMemberTable>? orderBy,
    _is.OrderByListBuilder<CareMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CareMember>(
      where: where?.call(CareMember.t),
      orderBy: orderBy?.call(CareMember.t),
      orderByList: orderByList?.call(CareMember.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CareMember] by its [id] or null if no such row exists.
  Future<CareMember?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CareMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CareMember]s in the list and returns the inserted rows.
  ///
  /// The returned [CareMember]s will have their `id` fields set.
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
  Future<List<CareMember>> insert(
    _is.DatabaseSession session,
    List<CareMember> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CareMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CareMember] and returns the inserted row.
  ///
  /// The returned [CareMember] will have its `id` field set.
  Future<CareMember> insertRow(
    _is.DatabaseSession session,
    CareMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CareMember>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CareMember]s in the list and returns the resulting rows.
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
  /// The returned [CareMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CareMember>> upsert(
    _is.DatabaseSession session,
    List<CareMember> rows, {
    required _is.ColumnSelections<CareMemberTable> conflictColumns,
    _is.ColumnSelections<CareMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<CareMemberTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CareMember>(
      rows,
      conflictColumns: conflictColumns(CareMember.t),
      updateColumns: updateColumns?.call(CareMember.t),
      updateWhere: updateWhere?.call(CareMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CareMember] and returns the resulting row.
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
  /// The returned [CareMember] will have its `id` field set.
  Future<CareMember?> upsertRow(
    _is.DatabaseSession session,
    CareMember row, {
    required _is.ColumnSelections<CareMemberTable> conflictColumns,
    _is.ColumnSelections<CareMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<CareMemberTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CareMember>(
      row,
      conflictColumns: conflictColumns(CareMember.t),
      updateColumns: updateColumns?.call(CareMember.t),
      updateWhere: updateWhere?.call(CareMember.t),
      transaction: transaction,
    );
  }

  /// Updates all [CareMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CareMember>> update(
    _is.DatabaseSession session,
    List<CareMember> rows, {
    _is.ColumnSelections<CareMemberTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CareMember>(
      rows,
      columns: columns?.call(CareMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CareMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CareMember> updateRow(
    _is.DatabaseSession session,
    CareMember row, {
    _is.ColumnSelections<CareMemberTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CareMember>(
      row,
      columns: columns?.call(CareMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CareMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CareMember?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CareMemberUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CareMember>(
      id,
      columnValues: columnValues(CareMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CareMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CareMember>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CareMemberUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CareMemberTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CareMemberTable>? orderBy,
    _is.OrderByListBuilder<CareMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CareMember>(
      columnValues: columnValues(CareMember.t.updateTable),
      where: where(CareMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CareMember.t),
      orderByList: orderByList?.call(CareMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CareMember]s in the list and returns the deleted rows.
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
  Future<List<CareMember>> delete(
    _is.DatabaseSession session,
    List<CareMember> rows, {
    _is.OrderByBuilder<CareMemberTable>? orderBy,
    _is.OrderByListBuilder<CareMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CareMember>(
      rows,
      orderBy: orderBy?.call(CareMember.t),
      orderByList: orderByList?.call(CareMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CareMember].
  Future<CareMember> deleteRow(
    _is.DatabaseSession session,
    CareMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CareMember>(
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
  Future<List<CareMember>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CareMemberTable> where,
    _is.OrderByBuilder<CareMemberTable>? orderBy,
    _is.OrderByListBuilder<CareMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CareMember>(
      where: where(CareMember.t),
      orderBy: orderBy?.call(CareMember.t),
      orderByList: orderByList?.call(CareMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CareMemberTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CareMember>(
      where: where?.call(CareMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CareMember] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CareMemberTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CareMember>(
      where: where(CareMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
