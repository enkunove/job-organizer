import 'package:get_it/get_it.dart';
import 'package:test_task/feature/data/datasources/local/settings_datasource.dart';
import 'package:test_task/feature/data/datasources/remote/boards_datasource.dart';
import 'package:test_task/feature/data/datasources/remote/tasks_datasource.dart';
import 'package:test_task/feature/data/datasources/remote/user_datasource.dart';
import 'package:test_task/feature/data/repositories/tasks_repository_impl.dart';
import 'package:test_task/feature/data/repositories/user_repository_impl.dart';
import 'package:test_task/feature/domain/repositories/boards_repository.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';
import 'package:test_task/feature/domain/usecases/auth_usecases.dart';
import 'package:test_task/feature/domain/usecases/boards_usecases.dart';
import 'package:test_task/feature/domain/usecases/tasks_usecases.dart';
import 'package:test_task/feature/presentation/view/screens/board_create_screen.dart';
import 'package:test_task/feature/presentation/viewmodels/board_create_viewmodel.dart';
import 'package:test_task/feature/presentation/viewmodels/login_screen_viewmodel.dart';
import 'package:test_task/feature/presentation/viewmodels/registration_screen_viewmodel.dart';
import 'package:test_task/feature/presentation/viewmodels/splash_screen_viewmodel.dart';
import 'package:test_task/feature/presentation/viewmodels/tasks_screen_viewmodel.dart';

import '../feature/data/repositories/boards_repository_impl.dart';
import '../feature/domain/repositories/tasks_repository.dart';

class InjectionContainer {
  static final GetIt sl = GetIt.instance;

  static Future<void> init() async {
    sl.registerLazySingleton<UserDatasource>(() => UserDatasource());
    sl.registerLazySingleton<BoardsDatasource>(() => BoardsDatasource());
    sl.registerLazySingleton<TasksDatasource>(() => TasksDatasource());
    sl.registerLazySingleton<SettingsDatasource>(() => SettingsDatasource());

    sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(userDatasource: sl(), settingsDatasource: sl()));
    sl.registerLazySingleton<BoardsRepository>(() => BoardsRepositoryImpl(datasource: sl()));
    sl.registerLazySingleton<TasksRepository>(() => TasksRepositoryImpl(datasource: sl()));

    sl.registerLazySingleton<AuthUsecases>(() => AuthUsecases(repository: sl()));
    sl.registerLazySingleton<BoardsUsecases>(() => BoardsUsecases(repository: sl()));
    sl.registerLazySingleton<TasksUsecases>(() => TasksUsecases(repository: sl()));

    sl.registerFactory<LoginScreenViewmodel>(() => LoginScreenViewmodel(usecases: sl()));
    sl.registerFactory<RegistrationScreenViewmodel>(() => RegistrationScreenViewmodel(usecases: sl()));
    sl.registerFactory<BoardCreateViewModel>(() => BoardCreateViewModel(usecases: sl()));
    sl.registerFactory<TasksScreenViewmodel>(() => TasksScreenViewmodel(boardsUsecases: sl(), tasksUsecases: sl()));

    sl.registerSingleton<AppState>(AppState(usecases: sl()));

  }
}