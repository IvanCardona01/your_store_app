import 'package:your_store_app/core/db/drift/app_database.dart';
import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/auth/models/user_model.dart';
import 'package:your_store_app/features/profile/domain/profile_database_service.dart';
import 'package:your_store_app/features/profile/domain/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatabaseService _db;

  ProfileRepositoryImpl(this._db);

  @override
  Future<Result<User?>> getUser() async {
    return _db.getUser();
  }

  @override
  Future<Result<User?>> updateUser(UserModel user) async {
    return _db.updateUser(user);
  }

  @override
  Future<Result> logout() async {
    return _db.logout();
  }
}