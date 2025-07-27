import '../../../core/network/models/result.dart';
import '../domain/profile_repository.dart';

class LogoutUseCase {
  final ProfileRepository _repository;

  LogoutUseCase(this._repository);

  Future<Result> call() {
    return _repository.logout();
  }
}