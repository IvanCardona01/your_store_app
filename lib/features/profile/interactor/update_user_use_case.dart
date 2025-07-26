import '../../../core/db/drift/app_database.dart';
import '../../../core/network/models/result.dart';
import '../../../features/auth/models/user_model.dart';
import '../domain/profile_repository.dart';

class UpdateUserUseCase {
  final ProfileRepository _repository;

  UpdateUserUseCase(this._repository);

  Future<Result<User?>> call(UserModel user) {
    return _repository.updateUser(user);
  }
}