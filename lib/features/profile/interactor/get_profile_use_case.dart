import '../../../core/db/drift/app_database.dart';
import '../../../core/network/models/result.dart';
import '../domain/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Result<User?>> call() {
    return _repository.getUser();
  }
}