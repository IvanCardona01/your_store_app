import 'package:drift/drift.dart' hide Column; // para evitar choques con flutter widgets
import '../../../core/db/drift/app_database.dart';
import '../domain/database_service.dart';
import '../models/user_model.dart';

class DataBaseServiceImpl implements DataBaseService {
  final AppDatabase _db;

  DataBaseServiceImpl(this._db);

  @override
  Future<User?> login(String email, String password) async {
    final query = _db.select(_db.users)
      ..where((tbl) => tbl.email.equals(email) & tbl.password.equals(password));

    return query.getSingleOrNull();
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
            password: user.password,
            phone: Value(user.phone ?? ''),
            address: Value(user.address ?? ''),
            city: Value(user.city ?? ''),
            country: Value(user.country ?? ''),
          ),
        );
    return (await (_db.select(_db.users)..where((t) => t.id.equals(id))).getSingle());
  }
  }