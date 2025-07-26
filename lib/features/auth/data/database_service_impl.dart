import 'package:drift/drift.dart' hide Column; // para evitar choques con flutter widgets
import '../../../core/db/drift/app_database.dart';
import '../domain/database_service.dart';

class DataBaseServiceImpl implements DataBaseService {
  final AppDatabase _db;

  DataBaseServiceImpl(this._db);

  @override
  Future<User?> login(String email, String password) async {
    final query = _db.select(_db.users)
      ..where((tbl) => tbl.email.equals(email) & tbl.password.equals(password));

    return query.getSingleOrNull();
  }
}