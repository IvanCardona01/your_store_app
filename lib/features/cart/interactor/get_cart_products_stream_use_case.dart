import 'package:your_store_app/features/cart/domain/cart_repository.dart';
import 'package:your_store_app/shared/models/cart_product.dart';

class GetCartProductsStreamUseCase {
  final CartRepository repository;

  GetCartProductsStreamUseCase(this.repository);

  Stream<List<CartProduct>> call() {
    return repository.watchCartProducts();
  }
}