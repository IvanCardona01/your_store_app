import 'package:your_store_app/features/cart/domain/cart_repository.dart';

class WatchCartCountUseCase {
  final CartRepository repository;

  WatchCartCountUseCase(this.repository);

  Stream<int> call() {
    return repository.watchCartCount();
  }
}