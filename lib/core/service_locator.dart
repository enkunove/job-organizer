import 'package:get_it/get_it.dart';
import 'package:test_task/feature/data/datasources/remote/user_datasource.dart';
import 'package:test_task/feature/data/repositories/user_repository_impl.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';
import 'package:test_task/feature/domain/usecases/auth_usecases.dart';
import 'package:test_task/feature/presentation/viewmodels/login_screen_viewmodel.dart';
import 'package:test_task/feature/presentation/viewmodels/registration_screen_viewmodel.dart';

class InjectionContainer {
  static final GetIt sl = GetIt.instance;

  static Future<void> init() async {
    sl.registerLazySingleton<UserDatasource>(() => UserDatasource());

    sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(datasource: sl()));

    sl.registerLazySingleton<AuthUsecases>(() => AuthUsecases(repository: sl()));

    sl.registerFactory<LoginScreenViewmodel>(() => LoginScreenViewmodel(usecases: sl()));
    sl.registerFactory<RegistrationScreenViewmodel>(() => RegistrationScreenViewmodel(usecases: sl()));
  }
}