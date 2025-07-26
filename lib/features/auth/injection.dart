import 'package:get_it/get_it.dart';

import '../../core/db/drift/app_database.dart';
import 'domain/database_service.dart';
import 'data/database_service_impl.dart';
import 'presenter/login_presenter.dart';

final sl = GetIt.instance;

void initAuth() {
  if (sl.isRegistered<LoginPresenter>()) return;

  sl.registerLazySingleton<DataBaseService>(() => DataBaseServiceImpl(sl<AppDatabase>()));

  sl.registerFactory<LoginPresenter>(() => LoginPresenter(sl<DataBaseService>()));
}