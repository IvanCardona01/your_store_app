import 'package:your_store_app/core/db/drift/app_database.dart';
import '../models/user_model.dart';

abstract class AuthDatabaseService {
  Future<User?> login(String email, String password);
  Future<User> createUser(UserModel user);
  Future<bool> emailExists(String email);
}