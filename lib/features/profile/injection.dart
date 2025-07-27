import 'package:your_store_app/core/db/drift/app_database.dart';
import 'package:your_store_app/core/di/injection.dart';
import 'package:your_store_app/features/profile/data/profile_database_service_impl.dart';
import 'package:your_store_app/features/profile/data/profile_repository_impl.dart';
import 'package:your_store_app/features/profile/domain/profile_database_service.dart';
import 'package:your_store_app/features/profile/domain/profile_repository.dart';
import 'package:your_store_app/features/profile/interactor/get_profile_use_case.dart';
import 'package:your_store_app/features/profile/interactor/logout_use_case.dart';
import 'package:your_store_app/features/profile/interactor/update_user_use_case.dart';
import 'package:your_store_app/features/profile/presenter/profile_presenter.dart';

void initProfile() {
  if (sl.isRegistered<ProfilePresenter>()) return;

  sl.registerFactory<ProfileDatabaseService>(() => ProfileDatabaseServiceImpl(sl<AppDatabase>()));
  sl.registerFactory<ProfileRepository>(() => ProfileRepositoryImpl(sl<ProfileDatabaseService>()));
  sl.registerFactory<GetProfileUseCase>(() => GetProfileUseCase(sl<ProfileRepository>()));
  sl.registerFactory<UpdateUserUseCase>(() => UpdateUserUseCase(sl<ProfileRepository>()));
  sl.registerFactory<LogoutUseCase>(() => LogoutUseCase(sl<ProfileRepository>()));
  sl.registerFactory<ProfilePresenter>(() => ProfilePresenter(sl<GetProfileUseCase>(), sl<UpdateUserUseCase>(), sl<LogoutUseCase>()));
}