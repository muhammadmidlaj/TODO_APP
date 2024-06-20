import 'package:dartz/dartz.dart';
import 'package:todo/configs/db/app_database.dart';
import 'package:todo/core/error_handling/failures.dart';
import 'package:todo/core/utils/typedefs.dart';
import 'package:todo/model/todo.dart';

class TodoRepository {
  final AppDataBase appDataBase;

  TodoRepository(this.appDataBase);

  FutureResult<bool> createNewTodo(Todo todo) async {
    try {
      await appDataBase.insertNewTodo(todo.toTbl());
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  FutureResult<bool> updateNewTodo(Todo todo) async {
    try {
      final response = await appDataBase.updateTodo(todo.toTbl());
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  FutureResult<bool> deleteTodo(String todoid) async {
    try {
      await appDataBase.deleteTodo(todoid);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

   FutureResult<bool> markAsComplted(String todoid) async {
    try {
      await appDataBase.markAsCompleted(todoid);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

   FutureResult<bool> markAsUnCompleted(String todoid) async {
    try {
      await appDataBase.markAsUnCompleted(todoid);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Stream<List<Todo>> watchAllTodos() {
    return appDataBase.watchAllToDos();
  }

  Stream<List<Todo>> watchCompltedTodos() {
    return appDataBase.watchCompletedTodos();
  }
}
