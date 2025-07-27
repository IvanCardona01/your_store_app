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
  Stream<List<CartProduct>> watchCartProducts() async* {
    final activeSession = await _db
        .select(_db.activeSessions)
        .getSingleOrNull();
    if (activeSession == null) {
      yield [];
      return;
    }

    final userCart =
        await (_db.select(_db.carts)
              ..where((tbl) => tbl.userId.equals(activeSession.userId)))
            .getSingleOrNull();

    if (userCart == null) {
      yield [];
      return;
    }

    yield* (_db.select(_db.cartItems).join([
      innerJoin(
        _db.products,
        _db.products.id.equalsExp(_db.cartItems.productId),
      ),
    ])..where(_db.cartItems.cartId.equals(userCart.id))).watch().map((rows) {
      return rows.map((row) {
        final product = row.readTable(_db.products);
        final cartItem = row.readTable(_db.cartItems);

        return CartProduct(
          ProductModel(
            id: product.id,
            title: product.title,
            description: product.description,
            category: product.category ?? '',
            price: product.price,
            discountPercentage: product.discountPercentage ?? 0,
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
    });
  }

  @override
  Stream<int> watchCartCount() async* {
    final activeSession = await _db
        .select(_db.activeSessions)
        .getSingleOrNull();
    if (activeSession == null) {
      yield 0;
      return;
    }

    final userCart =
        await (_db.select(_db.carts)
              ..where((tbl) => tbl.userId.equals(activeSession.userId)))
            .getSingleOrNull();

    if (userCart == null) {
      yield 0;
      return;
    }

    yield* (_db.select(_db.cartItems)
          ..where((tbl) => tbl.cartId.equals(userCart.id)))
        .watch()
        .map((items) => items.fold<int>(0, (sum, item) => sum + item.quantity));
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

      if (cart == null) return Result.failure('Cart not found');

      await (_db.delete(_db.cartItems)..where(
            (tbl) =>
                tbl.cartId.equals(cart.id) & tbl.productId.equals(productId),
          ))
          .go();

      return Result.success(null);
    } catch (e) {
      return Result.failure('Error removing product from cart: $e');
    }
  }
}
