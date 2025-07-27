import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/home/models/product_model.dart';
import 'package:your_store_app/features/home/models/product_response.dart';
import 'package:your_store_app/features/home/models/category_model.dart';

abstract class HomeRepository {
  Future<ProductResponse> getProducts({int skip = 0, int limit = 10, String categorySlug = ''});
  Future<List<CategoryModel>> getCategories();
  Future<Result> addProductToCart(ProductModel product, int quantity);
}