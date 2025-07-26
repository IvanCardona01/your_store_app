import 'package:your_store_app/features/home/models/product_response.dart';
import 'package:your_store_app/features/home/domain/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  Future<ProductResponse> call({int skip = 0, int limit = 10}) async {
    return await repository.getProducts(skip: skip, limit: limit);
  }
}
