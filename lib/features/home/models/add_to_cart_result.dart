import 'package:your_store_app/features/home/models/product_model.dart';

class AddToCartResult {
  final ProductModel product;
  final int quantity;

  AddToCartResult(this.product, this.quantity);
}