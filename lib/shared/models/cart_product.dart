import 'package:your_store_app/features/home/models/product_model.dart';

class CartProduct {
  final ProductModel product;
  final int quantity;
  final double unitPrice;

  CartProduct(this.product, this.quantity, this.unitPrice);
}