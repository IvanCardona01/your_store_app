import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/home/models/product_model.dart';

abstract class HomeDatabaseService {
  Future<Result> addProductToCart(ProductModel product, int quantity);
}