import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/home/domain/home_repository.dart';
import 'package:your_store_app/features/home/models/product_model.dart';

class AddProductToCartUseCase {
  final HomeRepository repository;

  AddProductToCartUseCase(this.repository);

  Future<Result> call(ProductModel product, int quantity) async {
    return await repository.addProductToCart(product, quantity);
  }
}
