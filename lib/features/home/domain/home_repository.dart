import 'package:your_store_app/features/home/models/product_response.dart';

abstract class HomeRepository {
  Future<ProductResponse> getProducts({int skip = 0, int limit = 10});
}