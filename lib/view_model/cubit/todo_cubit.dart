import 'package:bloc/bloc.dart';

import 'package:todo/core/error_handling/failures.dart';
import 'package:todo/core/utils/typedefs.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/repository/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;
  TodoCubit(this.repository) : super(TodoInitial());

  Future<void> createNewTodo(Todo todo) async {
    emit(TodoLoading());
    final response = await repository.createNewTodo(todo);
    response.fold(
      (failure) => emit(TodoFailure(failure)),
      (r) => emit(TodoCreated()),
    );
  }

  Future<void> updateTodo(Todo todo) async {
    
    final response = await repository.updateNewTodo(todo);
    response.fold(
      (failure) => emit(TodoFailure(failure)),
      (r) => emit(TodoUpdated()),
    );
  }

  Future<void> deleteTodo(String todoid) async {
   
    final response = await repository.deleteTodo(todoid);
    response.fold(
      (failure) => emit(TodoFailure(failure)),
      (r) => emit(TodoDeleted()),
    );
  }

  Future<void> markAsCompleted(String todoid)async{
    final response = await repository.markAsComplted(todoid);
    response.fold(
      (failure) => emit(TodoFailure(failure)),
      (r) => emit(TodoStatusChanged(status: true)),
    );
  }

  Future<void> markAsUnCompleted(String todoid)async{
    final response = await repository.markAsUnCompleted(todoid);
    response.fold(
      (failure) => emit(TodoFailure(failure)),
      (r) => emit(TodoStatusChanged(status: false)),
    );
  }

  Stream<TodoList> watchAllTodos() {
    return repository.watchAllTodos();
  }

   Stream<TodoList> watchCompletedTodos() {
    return repository.watchCompltedTodos();
  }
}
