import 'package:get_it/get_it.dart';
import 'package:todo/configs/db/app_database.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/view_model/cubit/todo_cubit.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final sl = GetIt.instance;

initDi() async {
  AppDataBase database = await constructDb('todoDB');

  sl.registerLazySingleton<AppDataBase>(() => database);

  sl.registerLazySingleton(
    () => TodoRepository(sl()),
  );

  sl.registerFactory(
    () => TodoCubit(sl()),
  );
}
