import 'package:dartz/dartz.dart';
import 'package:todo/core/error_handling/failures.dart';
import 'package:todo/model/todo.dart';

typedef DataMap = Map<String, dynamic>;
typedef FutureResult<T> = Future<Either<Failure,T>>;
typedef TodoList = List<Todo>;
