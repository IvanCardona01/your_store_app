import 'package:get_it/get_it.dart';
import '../db/drift/app_database.dart';

final sl = GetIt.instance;

Future<void> initCore() async {

  // Drift database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
}