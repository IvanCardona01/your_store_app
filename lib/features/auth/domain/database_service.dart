import 'package:your_store_app/core/db/drift/app_database.dart';

abstract class DataBaseService {
  Future<User?> login(String email, String password);
}