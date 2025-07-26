import 'package:get_it/get_it.dart';
import 'package:your_store_app/core/network/domain/network_service.dart';
import 'package:your_store_app/core/network/data/network_service_impl.dart';
import '../db/drift/app_database.dart';

final sl = GetIt.instance;

Future<void> initCore() async {
  // Drift database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Network service
  sl.registerLazySingleton<NetworkService>(() => NetworkServiceImpl());
}
