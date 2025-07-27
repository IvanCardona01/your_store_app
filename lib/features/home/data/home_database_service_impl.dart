import 'package:your_store_app/core/db/drift/app_database.dart';
import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/home/domain/home_database_service.dart';
import 'package:your_store_app/features/home/models/product_model.dart';
import 'package:drift/drift.dart';

class HomeDatabaseServiceImpl implements HomeDatabaseService {
  final AppDatabase _db;

  HomeDatabaseServiceImpl(this._db);

  @override
  Future<Result> addProductToCart(ProductModel product, int quantity) async {
    return _db.transaction(() async {
      try {
        final existingProduct = await (_db.select(_db.products)
              ..where((p) => p.sku.equals(product.sku ?? '')))
            .getSingleOrNull();

        int productId;
        if (existingProduct != null) {
          productId = existingProduct.id;
        } else {
          final productCompanion = ProductsCompanion.insert(
            title: product.title,
            description: product.description,
            category: Value(product.category),
            discountPercentage: Value(product.discountPercentage),
            price: product.price,
            rating: Value(product.rating),
            stock: Value(product.stock ?? 0),
            sku: Value(product.sku ?? ''),
            warrantyInformation: Value(product.warrantyInformation),
            shippingInformation: Value(product.shippingInformation),
            availabilityStatus: Value(product.availabilityStatus),
            returnPolicy: Value(product.returnPolicy),
            images: Value(product.images?.join(',')),
            thumbnail: Value(product.thumbnail),
          );
          productId = await _db.into(_db.products).insert(productCompanion);
        }

        final activeSession =
            await _db.select(_db.activeSessions).getSingleOrNull();
        if (activeSession == null) {
          return Result.failure('No active session found');
        }

        final existingCart = await (_db.select(_db.carts)
              ..where((tbl) => tbl.userId.equals(activeSession.userId)))
            .getSingleOrNull();

        int cartId;
        if (existingCart == null) {
          cartId = await _db.into(_db.carts).insert(
                CartsCompanion.insert(userId: activeSession.userId),
              );
        } else {
          cartId = existingCart.id;
        }

        final existingCartItem = await (_db.select(_db.cartItems)
              ..where((tbl) =>
                  tbl.cartId.equals(cartId) & tbl.productId.equals(productId)))
            .getSingleOrNull();

        if (existingCartItem == null) {
          await _db.into(_db.cartItems).insert(
                CartItemsCompanion.insert(
                  cartId: cartId,
                  productId: productId,
                  quantity: quantity,
                  unitPrice: product.price,
                ),
              );
        } else {
          await (_db.update(_db.cartItems)
                ..where((tbl) => tbl.id.equals(existingCartItem.id)))
              .write(CartItemsCompanion(
                quantity: Value(existingCartItem.quantity + quantity),
              ));
        }
        return Result.success(null);
      } catch (e) {
        return Result.failure('Error adding product to cart: $e');
      }
    });
  }
}
