import 'package:drift/drift.dart' hide Column; // para evitar choques con flutter widgets
import '../../../core/db/drift/app_database.dart';
import '../domain/auth_database_service.dart';
import '../models/user_model.dart';

class AuthDatabaseServiceImpl implements AuthDatabaseService {
  final AppDatabase _db;

  AuthDatabaseServiceImpl(this._db);

  @override
  Future<User?> login(String email, String password) async {
    final query = _db.select(_db.users)
      ..where((tbl) => tbl.email.equals(email) & tbl.password.equals(password));

    final user = await query.getSingleOrNull();
    if (user == null) {
      return null;
    }

    _db.into(_db.activeSessions).insert(
      ActiveSessionsCompanion.insert(
        userId: user.id,
      ),
    );

    return user;
  }

  @override
  Future<bool> emailExists(String email) async {
    final query = _db.select(_db.users)..where((tbl) => tbl.email.equals(email));
    final user = await query.getSingleOrNull();
    return user != null;
  }

  @override
  Future<User> createUser(UserModel user) async {
    final id = await _db.into(_db.users).insert(
          UsersCompanion.insert(
            firstName: user.firstName,
            lastName: user.lastName,
            email: user.email,
            password: user.password ?? '',
            phone: Value(user.phone ?? ''),
            address: Value(user.address ?? ''),
            city: Value(user.city ?? ''),
            country: Value(user.country ?? ''),
          ),
        );

    final createdUser = await (_db.select(_db.users)..where((t) => t.id.equals(id))).getSingle();
    _db.into(_db.activeSessions).insert(
      ActiveSessionsCompanion.insert(
        userId: createdUser.id,
      ),
    );
    return createdUser;
  }
}