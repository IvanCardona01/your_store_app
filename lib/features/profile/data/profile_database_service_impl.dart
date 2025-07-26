import 'package:drift/drift.dart' hide Column;
import 'package:your_store_app/core/db/drift/app_database.dart';
import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/auth/models/user_model.dart';
import 'package:your_store_app/features/profile/domain/profile_database_service.dart';

class ProfileDatabaseServiceImpl implements ProfileDatabaseService {
  final AppDatabase _db;

  ProfileDatabaseServiceImpl(this._db);

  @override
  Future<Result<User?>> getUser() async {
    final query = _db.select(_db.activeSessions);
    final activeSession = await query.getSingleOrNull();
    if (activeSession == null) {
      return Result.failure('No active session');
    }
    final user = await (_db.select(
      _db.users,
    )..where((tbl) => tbl.id.equals(activeSession.userId))).getSingleOrNull();
    if (user == null) {
      return Result.failure('User not found');
    }
    return Result.success(user);
  }

  @override
  Future<Result<User?>> updateUser(UserModel user) async {
    final query = _db.select(_db.activeSessions);
    final activeSession = await query.getSingleOrNull();
    if (activeSession == null) {
      return Result.failure('No active session');
    }
    await (_db.update(_db.users)..where((t) => t.id.equals(activeSession.userId))).write(
      UsersCompanion(
        firstName: Value(user.firstName),
        lastName: Value(user.lastName),
        email: Value(user.email),
        phone: user.phone != null ? Value(user.phone!) : const Value.absent(),
        address: user.address != null
            ? Value(user.address!)
            : const Value.absent(),
        city: user.city != null ? Value(user.city!) : const Value.absent(),
        country: user.country != null
            ? Value(user.country!)
            : const Value.absent(),
      ),
    );

    final userUpdated = await (_db.select(_db.users)..where((t) => t.id.equals(activeSession.userId))).getSingleOrNull();
    if (userUpdated == null) {
      return Result.failure('User not found');
    }
    return Result.success(userUpdated);
  }
}
