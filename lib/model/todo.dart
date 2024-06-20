import 'package:drift/drift.dart';
import 'package:todo/configs/db/app_database.dart';

class Todo {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory Todo.fromTableData(TodoTableData todo) => Todo(
      id: todo.todoPk,
      title: todo.title,
      description: todo.description,
      isCompleted: todo.isCompleted);

  TodoTableCompanion toTbl() => TodoTableCompanion.insert(
        title: title,
        description: Value(description),
        isCompleted: Value(isCompleted),
        todoPk: Value(id),
      );
}
