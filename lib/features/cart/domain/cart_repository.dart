import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/shared/models/cart_product.dart';

abstract class CartRepository {
  Future<Result<List<CartProduct>>> getCartProducts();
  Future<Result> removeProductFromCart(CartProduct product);
}