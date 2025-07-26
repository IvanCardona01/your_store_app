import 'package:your_store_app/core/db/drift/app_database.dart';
import '../domain/auth_repository.dart';
import '../domain/database_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DataBaseService _db;

  AuthRepositoryImpl(this._db);

  @override
  Future<User?> login(String email, String password) {
    return _db.login(email, password);
  }
}