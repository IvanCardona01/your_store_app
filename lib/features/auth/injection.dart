import 'package:get_it/get_it.dart';
import 'package:your_store_app/features/auth/interactor/register_use_case.dart';
import 'package:your_store_app/features/auth/presenter/register_presenter.dart';

import '../../core/db/drift/app_database.dart';
import 'data/auth_repository_impl.dart';
import 'domain/database_service.dart';
import 'data/database_service_impl.dart';
import 'domain/auth_repository.dart';
import 'interactor/login_use_case.dart';
import 'presenter/login_presenter.dart';

final sl = GetIt.instance;

void initAuth() {
  if (sl.isRegistered<LoginPresenter>()) return;

  // Services (Drift access)
  sl.registerLazySingleton<DataBaseService>(() => DataBaseServiceImpl(sl<AppDatabase>()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<DataBaseService>()));

  // UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()));

  // Presenters
  sl.registerFactory<LoginPresenter>(() => LoginPresenter(sl<LoginUseCase>()));
}


void initAuthRegister() {
  if (sl.isRegistered<RegisterPresenter>()) return;

  // UseCase
  sl.registerLazySingleton<RegisterUserUseCase>(() => RegisterUserUseCase(sl<AuthRepository>()));

  // Presenter
  sl.registerFactory<RegisterPresenter>(() => RegisterPresenter(sl<RegisterUserUseCase>()));
}