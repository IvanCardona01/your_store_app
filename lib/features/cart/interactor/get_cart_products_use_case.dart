import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/cart/domain/cart_repository.dart';
import 'package:your_store_app/shared/models/cart_product.dart';

class GetCartProductsUseCase {
  final CartRepository repository;

  GetCartProductsUseCase(this.repository);

  Future<Result<List<CartProduct>>> call() async {
    return await repository.getCartProducts();
  }
}
