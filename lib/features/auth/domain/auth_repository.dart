import '../../../core/db/drift/app_database.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
  Future<User> createUser(UserModel user);
  
}
