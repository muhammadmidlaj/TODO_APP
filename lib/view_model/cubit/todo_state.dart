part of 'todo_cubit.dart';

sealed class TodoState {}

final class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoFailure extends TodoState {
  final Failure failure;

  TodoFailure(this.failure);
}

class TodoUpdated extends TodoState {}

class TodoDeleted extends TodoState {}

class TodoCreated extends TodoState {}

class TodoStatusChanged extends TodoState {
  final bool status;

  TodoStatusChanged({required this.status});
}
