import '../../../core/db/drift/app_database.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
}