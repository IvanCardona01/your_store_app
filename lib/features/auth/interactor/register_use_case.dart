import '../../../core/db/drift/app_database.dart';
import '../domain/auth_repository.dart';
import '../models/user_model.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<User> call(UserModel user) async {
    return repository.createUser(user);
  }
}
