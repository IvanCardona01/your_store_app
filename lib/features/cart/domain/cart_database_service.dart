import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/shared/models/cart_product.dart';

abstract class CartDatabaseService {
  Stream<List<CartProduct>> watchCartProducts();
  Stream<int> watchCartCount();
  Future<Result<void>> removeProductFromCart(int productId);
}