import 'package:get_it/get_it.dart';
import 'package:test_task/feature/domain/usecases/auth_usecases.dart';
import 'package:test_task/feature/presentation/viewmodels/login_screen_viewmodel.dart';

class InjectionContainer {
  static final GetIt sl = GetIt.instance;

  static Future<void> init() async {

    sl.registerLazySingleton<AuthUsecases>(() => AuthUsecases());
    
    sl.registerFactory<LoginScreenViewmodel>(() => LoginScreenViewmodel(sl()));
  }
}