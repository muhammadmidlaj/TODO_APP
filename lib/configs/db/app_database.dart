import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo/configs/di/injection.dart';
import 'package:todo/model/todo.dart';
part 'app_database.g.dart';

Future<AppDataBase> constructDb(String dbName) async {
  final db = LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, '$dbName.sqlite'));

    QueryExecutor foregroundExecutor = NativeDatabase(file);
    QueryExecutor backgroundExecutor = NativeDatabase.createInBackground(file);
    return MultiExecutor(read: foregroundExecutor, write: backgroundExecutor);
  });

  return AppDataBase(db);
}

@DriftDatabase(
  tables: [TodoTable],
)
class AppDataBase extends _$AppDataBase {
  AppDataBase(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          // if (from == 1) {
          //   await m.addColumn(todoTable, todoTable.isCompleted);
          // }
       
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );

  Stream<List<Todo>> watchAllToDos() {
    return (select(todoTable)
          ..where(
            (tbl) => tbl.isCompleted.equals(false),
          ))
        .watch()
        .map(
          (rows) => rows.map(
            (row) {
              return Todo.fromTableData(row);
            },
          ).toList(),
        );
  }

  Stream<List<Todo>> watchCompletedTodos() {
    return (select(todoTable)
          ..where(
            (tbl) => tbl.isCompleted.equals(true),
          ))
        .watch()
        .map(
          (rows) => rows.map(
            (row) {
              return Todo.fromTableData(row);
            },
          ).toList(),
        );
  }

  Future<int> insertNewTodo(TodoTableCompanion todo) async {
    return into(todoTable).insert(todo);
  }

  Future<bool> updateTodo(TodoTableCompanion todo) async {
    return update(todoTable).replace(todo);
  }

  Future<int> deleteTodo(String todoId) async {
    return (delete(todoTable)..where((tbl) => tbl.todoPk.equals(todoId))).go();
  }

  Future<int> markAsCompleted(String todId) async {
    return (update(todoTable)..where((tbl) => tbl.todoPk.equals(todId)))
        .write(const TodoTableCompanion(isCompleted: Value(true)));
  }

  Future<int> markAsUnCompleted(String todId) async {
    return (update(todoTable)..where((tbl) => tbl.todoPk.equals(todId)))
        .write(const TodoTableCompanion(isCompleted: Value(false)));
  }
}

class TodoTable extends Table {
  TextColumn get todoPk => text().clientDefault(() => uuid.v4())();
  DateTimeColumn get dateCreated =>
      dateTime().clientDefault(() => DateTime.now())();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isCompleted => boolean().clientDefault(
        () => false,
      )();

  @override
  Set<Column> get primaryKey => {todoPk};
}
