import 'package:your_store_app/core/db/drift/app_database.dart';
import 'package:your_store_app/features/cart/domain/cart_database_service.dart';
import 'package:your_store_app/core/network/models/result.dart';
import 'package:drift/drift.dart';
import 'package:your_store_app/features/home/models/product_model.dart';
import 'package:your_store_app/shared/models/cart_product.dart';

class CartDatabaseServiceImpl implements CartDatabaseService {
  final AppDatabase _db;

  CartDatabaseServiceImpl(this._db);

  @override
  Future<Result<List<CartProduct>>> getCartProducts() async {
    try {
      final activeSession = await _db
          .select(_db.activeSessions)
          .getSingleOrNull();
      if (activeSession == null) {
        return Result.failure('No active session found');
      }

      final cart =
          await (_db.select(_db.carts)
                ..where((tbl) => tbl.userId.equals(activeSession.userId)))
              .getSingleOrNull();

      if (cart == null) {
        return Result.success([]);
      }

      final query = await (_db.select(_db.cartItems).join([
        innerJoin(
          _db.products,
          _db.products.id.equalsExp(_db.cartItems.productId),
        ),
      ])..where(_db.cartItems.cartId.equals(cart.id))).get();

      final products = query.map((row) {
        final product = row.readTable(_db.products);
        final cartItem = row.readTable(_db.cartItems);

        return CartProduct(
          ProductModel(
            id: product.id,
            title: product.title,
            description: product.description,
            category: product.category ?? '',
            discountPercentage: product.discountPercentage ?? 0,
            price: product.price,
            rating: product.rating ?? 0,
            stock: product.stock,
            sku: product.sku ?? '',
            warrantyInformation: product.warrantyInformation ?? '',
            shippingInformation: product.shippingInformation ?? '',
            availabilityStatus: product.availabilityStatus ?? '',
            returnPolicy: product.returnPolicy ?? '',
            thumbnail: product.thumbnail ?? '',
          ),
          cartItem.quantity,
          cartItem.unitPrice,
        );
      }).toList();

      return Result.success(products);
    } catch (e) {
      return Result.failure('Error fetching cart products: $e');
    }
  }

  @override
  Future<Result<void>> removeProductFromCart(int productId) async {
    try {
      final activeSession = await _db
          .select(_db.activeSessions)
          .getSingleOrNull();

      if (activeSession == null) {
        return Result.failure('No active session found');
      }

      final cart =
          await (_db.select(_db.carts)
                ..where((tbl) => tbl.userId.equals(activeSession.userId)))
              .getSingleOrNull();

      if (cart == null) {
        return Result.failure('Cart not found');
      }

      final rowsDeleted =
          await (_db.delete(_db.cartItems)..where(
                (tbl) =>
                    tbl.cartId.equals(cart.id) &
                    tbl.productId.equals(productId),
              ))
              .go();

      if (rowsDeleted == 0) {
        return Result.failure('Product not found in cart');
      }

      return Result.success(null);
    } catch (e) {
      return Result.failure('Error removing product from cart: $e');
    }
  }
}
