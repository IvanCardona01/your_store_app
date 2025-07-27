import 'package:your_store_app/core/db/drift/app_database.dart';
import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/auth/models/user_model.dart';

abstract class ProfileRepository {
  Future<Result<User?>> getUser();
  Future<Result<User?>> updateUser(UserModel user);
  Future<Result> logout();
}