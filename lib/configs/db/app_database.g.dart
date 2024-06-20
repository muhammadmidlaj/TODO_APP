// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TodoTableTable extends TodoTable
    with TableInfo<$TodoTableTable, TodoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _todoPkMeta = const VerificationMeta('todoPk');
  @override
  late final GeneratedColumn<String> todoPk = GeneratedColumn<String>(
      'todo_pk', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => uuid.v4());
  static const VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  @override
  late final GeneratedColumn<DateTime> dateCreated = GeneratedColumn<DateTime>(
      'date_created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      clientDefault: () => false);
  @override
  List<GeneratedColumn> get $columns =>
      [todoPk, dateCreated, title, description, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_table';
  @override
  VerificationContext validateIntegrity(Insertable<TodoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('todo_pk')) {
      context.handle(_todoPkMeta,
          todoPk.isAcceptableOrUnknown(data['todo_pk']!, _todoPkMeta));
    }
    if (data.containsKey('date_created')) {
      context.handle(
          _dateCreatedMeta,
          dateCreated.isAcceptableOrUnknown(
              data['date_created']!, _dateCreatedMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {todoPk};
  @override
  TodoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoTableData(
      todoPk: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}todo_pk'])!,
      dateCreated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_created'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $TodoTableTable createAlias(String alias) {
    return $TodoTableTable(attachedDatabase, alias);
  }
}

class TodoTableData extends DataClass implements Insertable<TodoTableData> {
  final String todoPk;
  final DateTime dateCreated;
  final String title;
  final String? description;
  final bool isCompleted;
  const TodoTableData(
      {required this.todoPk,
      required this.dateCreated,
      required this.title,
      this.description,
      required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['todo_pk'] = Variable<String>(todoPk);
    map['date_created'] = Variable<DateTime>(dateCreated);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  TodoTableCompanion toCompanion(bool nullToAbsent) {
    return TodoTableCompanion(
      todoPk: Value(todoPk),
      dateCreated: Value(dateCreated),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isCompleted: Value(isCompleted),
    );
  }

  factory TodoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoTableData(
      todoPk: serializer.fromJson<String>(json['todoPk']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'todoPk': serializer.toJson<String>(todoPk),
      'dateCreated': serializer.toJson<DateTime>(dateCreated),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  TodoTableData copyWith(
          {String? todoPk,
          DateTime? dateCreated,
          String? title,
          Value<String?> description = const Value.absent(),
          bool? isCompleted}) =>
      TodoTableData(
        todoPk: todoPk ?? this.todoPk,
        dateCreated: dateCreated ?? this.dateCreated,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  @override
  String toString() {
    return (StringBuffer('TodoTableData(')
          ..write('todoPk: $todoPk, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(todoPk, dateCreated, title, description, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoTableData &&
          other.todoPk == this.todoPk &&
          other.dateCreated == this.dateCreated &&
          other.title == this.title &&
          other.description == this.description &&
          other.isCompleted == this.isCompleted);
}

class TodoTableCompanion extends UpdateCompanion<TodoTableData> {
  final Value<String> todoPk;
  final Value<DateTime> dateCreated;
  final Value<String> title;
  final Value<String?> description;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const TodoTableCompanion({
    this.todoPk = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TodoTableCompanion.insert({
    this.todoPk = const Value.absent(),
    this.dateCreated = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TodoTableData> custom({
    Expression<String>? todoPk,
    Expression<DateTime>? dateCreated,
    Expression<String>? title,
    Expression<String>? description,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (todoPk != null) 'todo_pk': todoPk,
      if (dateCreated != null) 'date_created': dateCreated,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TodoTableCompanion copyWith(
      {Value<String>? todoPk,
      Value<DateTime>? dateCreated,
      Value<String>? title,
      Value<String?>? description,
      Value<bool>? isCompleted,
      Value<int>? rowid}) {
    return TodoTableCompanion(
      todoPk: todoPk ?? this.todoPk,
      dateCreated: dateCreated ?? this.dateCreated,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (todoPk.present) {
      map['todo_pk'] = Variable<String>(todoPk.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime>(dateCreated.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoTableCompanion(')
          ..write('todoPk: $todoPk, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  _$AppDataBaseManager get managers => _$AppDataBaseManager(this);
  late final $TodoTableTable todoTable = $TodoTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoTable];
}

typedef $$TodoTableTableInsertCompanionBuilder = TodoTableCompanion Function({
  Value<String> todoPk,
  Value<DateTime> dateCreated,
  required String title,
  Value<String?> description,
  Value<bool> isCompleted,
  Value<int> rowid,
});
typedef $$TodoTableTableUpdateCompanionBuilder = TodoTableCompanion Function({
  Value<String> todoPk,
  Value<DateTime> dateCreated,
  Value<String> title,
  Value<String?> description,
  Value<bool> isCompleted,
  Value<int> rowid,
});

class $$TodoTableTableTableManager extends RootTableManager<
    _$AppDataBase,
    $TodoTableTable,
    TodoTableData,
    $$TodoTableTableFilterComposer,
    $$TodoTableTableOrderingComposer,
    $$TodoTableTableProcessedTableManager,
    $$TodoTableTableInsertCompanionBuilder,
    $$TodoTableTableUpdateCompanionBuilder> {
  $$TodoTableTableTableManager(_$AppDataBase db, $TodoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TodoTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TodoTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TodoTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> todoPk = const Value.absent(),
            Value<DateTime> dateCreated = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TodoTableCompanion(
            todoPk: todoPk,
            dateCreated: dateCreated,
            title: title,
            description: description,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            Value<String> todoPk = const Value.absent(),
            Value<DateTime> dateCreated = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TodoTableCompanion.insert(
            todoPk: todoPk,
            dateCreated: dateCreated,
            title: title,
            description: description,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
        ));
}

class $$TodoTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDataBase,
    $TodoTableTable,
    TodoTableData,
    $$TodoTableTableFilterComposer,
    $$TodoTableTableOrderingComposer,
    $$TodoTableTableProcessedTableManager,
    $$TodoTableTableInsertCompanionBuilder,
    $$TodoTableTableUpdateCompanionBuilder> {
  $$TodoTableTableProcessedTableManager(super.$state);
}

class $$TodoTableTableFilterComposer
    extends FilterComposer<_$AppDataBase, $TodoTableTable> {
  $$TodoTableTableFilterComposer(super.$state);
  ColumnFilters<String> get todoPk => $state.composableBuilder(
      column: $state.table.todoPk,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dateCreated => $state.composableBuilder(
      column: $state.table.dateCreated,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TodoTableTableOrderingComposer
    extends OrderingComposer<_$AppDataBase, $TodoTableTable> {
  $$TodoTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get todoPk => $state.composableBuilder(
      column: $state.table.todoPk,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dateCreated => $state.composableBuilder(
      column: $state.table.dateCreated,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDataBaseManager {
  final _$AppDataBase _db;
  _$AppDataBaseManager(this._db);
  $$TodoTableTableTableManager get todoTable =>
      $$TodoTableTableTableManager(_db, _db.todoTable);
}
