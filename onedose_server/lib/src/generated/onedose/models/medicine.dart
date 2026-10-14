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
import 'package:onedose_server/src/generated/protocol.dart' as _i5l0e3aj;
import 'package:serverpod/serverpod.dart' as _is;

/// A medicine and its limits, copied by the owner from the label or doctor.
abstract class Medicine
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Medicine._({
    this.id,
    required this.childId,
    required this.name,
    required this.ingredient,
    required this.doseText,
    required this.minHoursBetween,
    required this.maxPer24h,
    required this.fixedTimes,
    this.archivedAt,
  });

  factory Medicine({
    int? id,
    required int childId,
    required String name,
    required String ingredient,
    required String doseText,
    required double minHoursBetween,
    required int maxPer24h,
    required List<String> fixedTimes,
    DateTime? archivedAt,
  }) = _MedicineImpl;

  factory Medicine.fromJson(Map<String, dynamic> jsonSerialization) {
    return Medicine(
      id: jsonSerialization['id'] as int?,
      childId: jsonSerialization['childId'] as int,
      name: jsonSerialization['name'] as String,
      ingredient: jsonSerialization['ingredient'] as String,
      doseText: jsonSerialization['doseText'] as String,
      minHoursBetween: (jsonSerialization['minHoursBetween'] as num).toDouble(),
      maxPer24h: jsonSerialization['maxPer24h'] as int,
      fixedTimes: _i5l0e3aj.Protocol().deserialize<List<String>>(
        jsonSerialization['fixedTimes'],
      ),
      archivedAt: jsonSerialization['archivedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['archivedAt']),
    );
  }

  static final t = MedicineTable();

  static const db = MedicineRepository._();

  @override
  int? id;

  int childId;

  String name;

  /// Active ingredient, normalised to lower case. Lockouts are keyed on it.
  String ingredient;

  String doseText;

  double minHoursBetween;

  int maxPer24h;

  /// Local fixed times as "HH:mm", e.g. ["08:00", "20:00"].
  List<String> fixedTimes;

  DateTime? archivedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Medicine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Medicine copyWith({
    int? id,
    int? childId,
    String? name,
    String? ingredient,
    String? doseText,
    double? minHoursBetween,
    int? maxPer24h,
    List<String>? fixedTimes,
    DateTime? archivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Medicine',
      if (id != null) 'id': id,
      'childId': childId,
      'name': name,
      'ingredient': ingredient,
      'doseText': doseText,
      'minHoursBetween': minHoursBetween,
      'maxPer24h': maxPer24h,
      'fixedTimes': fixedTimes.toJson(),
      if (archivedAt != null) 'archivedAt': archivedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Medicine',
      if (id != null) 'id': id,
      'childId': childId,
      'name': name,
      'ingredient': ingredient,
      'doseText': doseText,
      'minHoursBetween': minHoursBetween,
      'maxPer24h': maxPer24h,
      'fixedTimes': fixedTimes.toJson(),
      if (archivedAt != null) 'archivedAt': archivedAt?.toJson(),
    };
  }

  static MedicineInclude include() {
    return MedicineInclude._();
  }

  static MedicineIncludeList includeList({
    _is.WhereExpressionBuilder<MedicineTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MedicineTable>? orderBy,
    _is.OrderByListBuilder<MedicineTable>? orderByList,
    MedicineInclude? include,
  }) {
    return MedicineIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Medicine.t),
      orderByList: orderByList?.call(Medicine.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MedicineImpl extends Medicine {
  _MedicineImpl({
    int? id,
    required int childId,
    required String name,
    required String ingredient,
    required String doseText,
    required double minHoursBetween,
    required int maxPer24h,
    required List<String> fixedTimes,
    DateTime? archivedAt,
  }) : super._(
         id: id,
         childId: childId,
         name: name,
         ingredient: ingredient,
         doseText: doseText,
         minHoursBetween: minHoursBetween,
         maxPer24h: maxPer24h,
         fixedTimes: fixedTimes,
         archivedAt: archivedAt,
       );

  /// Returns a shallow copy of this [Medicine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Medicine copyWith({
    Object? id = _Undefined,
    int? childId,
    String? name,
    String? ingredient,
    String? doseText,
    double? minHoursBetween,
    int? maxPer24h,
    List<String>? fixedTimes,
    Object? archivedAt = _Undefined,
  }) {
    return Medicine(
      id: id is int? ? id : this.id,
      childId: childId ?? this.childId,
      name: name ?? this.name,
      ingredient: ingredient ?? this.ingredient,
      doseText: doseText ?? this.doseText,
      minHoursBetween: minHoursBetween ?? this.minHoursBetween,
      maxPer24h: maxPer24h ?? this.maxPer24h,
      fixedTimes: fixedTimes ?? this.fixedTimes.map((e0) => e0).toList(),
      archivedAt: archivedAt is DateTime? ? archivedAt : this.archivedAt,
    );
  }
}

class MedicineUpdateTable extends _is.UpdateTable<MedicineTable> {
  MedicineUpdateTable(super.table);

  _is.ColumnValue<int, int> childId(int value) => _is.ColumnValue(
    table.childId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
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

  _is.ColumnValue<double, double> minHoursBetween(double value) =>
      _is.ColumnValue(
        table.minHoursBetween,
        value,
      );

  _is.ColumnValue<int, int> maxPer24h(int value) => _is.ColumnValue(
    table.maxPer24h,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> fixedTimes(List<String> value) =>
      _is.ColumnValue(
        table.fixedTimes,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> archivedAt(DateTime? value) =>
      _is.ColumnValue(
        table.archivedAt,
        value,
      );
}

class MedicineTable extends _is.Table<int?> {
  MedicineTable({super.tableRelation}) : super(tableName: 'medicine') {
    updateTable = MedicineUpdateTable(this);
    childId = _is.ColumnInt(
      'childId',
      this,
    );
    name = _is.ColumnString(
      'name',
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
    minHoursBetween = _is.ColumnDouble(
      'minHoursBetween',
      this,
    );
    maxPer24h = _is.ColumnInt(
      'maxPer24h',
      this,
    );
    fixedTimes = _is.ColumnSerializable<List<String>>(
      'fixedTimes',
      this,
    );
    archivedAt = _is.ColumnDateTime(
      'archivedAt',
      this,
    );
  }

  late final MedicineUpdateTable updateTable;

  late final _is.ColumnInt childId;

  late final _is.ColumnString name;

  /// Active ingredient, normalised to lower case. Lockouts are keyed on it.
  late final _is.ColumnString ingredient;

  late final _is.ColumnString doseText;

  late final _is.ColumnDouble minHoursBetween;

  late final _is.ColumnInt maxPer24h;

  /// Local fixed times as "HH:mm", e.g. ["08:00", "20:00"].
  late final _is.ColumnSerializable<List<String>> fixedTimes;

  late final _is.ColumnDateTime archivedAt;

  @override
  List<_is.Column> get columns => [
    id,
    childId,
    name,
    ingredient,
    doseText,
    minHoursBetween,
    maxPer24h,
    fixedTimes,
    archivedAt,
  ];
}

class MedicineInclude extends _is.IncludeObject {
  MedicineInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Medicine.t;
}

class MedicineIncludeList extends _is.IncludeList {
  MedicineIncludeList._({
    _is.WhereExpressionBuilder<MedicineTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Medicine.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Medicine.t;
}

class MedicineRepository {
  const MedicineRepository._();

  /// Returns a list of [Medicine]s matching the given query parameters.
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
  Future<List<Medicine>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MedicineTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MedicineTable>? orderBy,
    _is.OrderByListBuilder<MedicineTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Medicine>(
      where: where?.call(Medicine.t),
      orderBy: orderBy?.call(Medicine.t),
      orderByList: orderByList?.call(Medicine.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Medicine] matching the given query parameters.
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
  Future<Medicine?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MedicineTable>? where,
    int? offset,
    _is.OrderByBuilder<MedicineTable>? orderBy,
    _is.OrderByListBuilder<MedicineTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Medicine>(
      where: where?.call(Medicine.t),
      orderBy: orderBy?.call(Medicine.t),
      orderByList: orderByList?.call(Medicine.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Medicine] by its [id] or null if no such row exists.
  Future<Medicine?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Medicine>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Medicine]s in the list and returns the inserted rows.
  ///
  /// The returned [Medicine]s will have their `id` fields set.
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
  Future<List<Medicine>> insert(
    _is.DatabaseSession session,
    List<Medicine> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Medicine>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Medicine] and returns the inserted row.
  ///
  /// The returned [Medicine] will have its `id` field set.
  Future<Medicine> insertRow(
    _is.DatabaseSession session,
    Medicine row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Medicine>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Medicine]s in the list and returns the resulting rows.
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
  /// The returned [Medicine]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Medicine>> upsert(
    _is.DatabaseSession session,
    List<Medicine> rows, {
    required _is.ColumnSelections<MedicineTable> conflictColumns,
    _is.ColumnSelections<MedicineTable>? updateColumns,
    _is.WhereExpressionBuilder<MedicineTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Medicine>(
      rows,
      conflictColumns: conflictColumns(Medicine.t),
      updateColumns: updateColumns?.call(Medicine.t),
      updateWhere: updateWhere?.call(Medicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Medicine] and returns the resulting row.
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
  /// The returned [Medicine] will have its `id` field set.
  Future<Medicine?> upsertRow(
    _is.DatabaseSession session,
    Medicine row, {
    required _is.ColumnSelections<MedicineTable> conflictColumns,
    _is.ColumnSelections<MedicineTable>? updateColumns,
    _is.WhereExpressionBuilder<MedicineTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Medicine>(
      row,
      conflictColumns: conflictColumns(Medicine.t),
      updateColumns: updateColumns?.call(Medicine.t),
      updateWhere: updateWhere?.call(Medicine.t),
      transaction: transaction,
    );
  }

  /// Updates all [Medicine]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Medicine>> update(
    _is.DatabaseSession session,
    List<Medicine> rows, {
    _is.ColumnSelections<MedicineTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Medicine>(
      rows,
      columns: columns?.call(Medicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Medicine]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Medicine> updateRow(
    _is.DatabaseSession session,
    Medicine row, {
    _is.ColumnSelections<MedicineTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Medicine>(
      row,
      columns: columns?.call(Medicine.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Medicine] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Medicine?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MedicineUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Medicine>(
      id,
      columnValues: columnValues(Medicine.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Medicine]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Medicine>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MedicineUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MedicineTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MedicineTable>? orderBy,
    _is.OrderByListBuilder<MedicineTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Medicine>(
      columnValues: columnValues(Medicine.t.updateTable),
      where: where(Medicine.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Medicine.t),
      orderByList: orderByList?.call(Medicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Medicine]s in the list and returns the deleted rows.
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
  Future<List<Medicine>> delete(
    _is.DatabaseSession session,
    List<Medicine> rows, {
    _is.OrderByBuilder<MedicineTable>? orderBy,
    _is.OrderByListBuilder<MedicineTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Medicine>(
      rows,
      orderBy: orderBy?.call(Medicine.t),
      orderByList: orderByList?.call(Medicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Medicine].
  Future<Medicine> deleteRow(
    _is.DatabaseSession session,
    Medicine row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Medicine>(
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
  Future<List<Medicine>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MedicineTable> where,
    _is.OrderByBuilder<MedicineTable>? orderBy,
    _is.OrderByListBuilder<MedicineTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Medicine>(
      where: where(Medicine.t),
      orderBy: orderBy?.call(Medicine.t),
      orderByList: orderByList?.call(Medicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MedicineTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Medicine>(
      where: where?.call(Medicine.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Medicine] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MedicineTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Medicine>(
      where: where(Medicine.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
