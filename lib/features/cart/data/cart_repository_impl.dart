import 'package:your_store_app/features/cart/domain/cart_repository.dart';
import 'package:your_store_app/features/cart/domain/cart_database_service.dart';
import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/shared/models/cart_product.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDatabaseService _cartDatabaseService;

  CartRepositoryImpl(this._cartDatabaseService);

  @override
  Stream<List<CartProduct>> watchCartProducts() {
    return _cartDatabaseService.watchCartProducts();
  }

  @override
  Future<Result> removeProductFromCart(CartProduct cartProduct) async {
    return await _cartDatabaseService.removeProductFromCart(cartProduct.product.id);
  }
}