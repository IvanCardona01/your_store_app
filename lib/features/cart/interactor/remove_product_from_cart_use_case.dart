import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/cart/domain/cart_repository.dart';
import 'package:your_store_app/shared/models/cart_product.dart';

class RemoveProductFromCartUseCase {
  final CartRepository repository;

  RemoveProductFromCartUseCase(this.repository);

  Future<Result<void>> call(CartProduct product) async {
    return await repository.removeProductFromCart(product);
  }
}
