import '../../../core/db/drift/app_database.dart';
import '../domain/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<User?> call(String email, String password) {
    return _repository.login(email, password);
  }
}