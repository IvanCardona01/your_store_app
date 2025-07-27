import 'package:your_store_app/core/network/domain/network_service.dart';
import 'package:your_store_app/core/network/endpoints.dart';
import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/home/domain/home_database_service.dart';
import 'package:your_store_app/features/home/domain/home_repository.dart';
import 'package:your_store_app/features/home/models/category_model.dart';
import 'package:your_store_app/features/home/models/product_model.dart';
import 'package:your_store_app/features/home/models/product_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkService _networkService;
  final HomeDatabaseService _homeDatabaseService;
  HomeRepositoryImpl(this._networkService, this._homeDatabaseService);

  @override
  Future<ProductResponse> getProducts({
    int skip = 0,
    int limit = 10,
    String categorySlug = '',
  }) async {
    final response = await _networkService.get(
      '${Endpoints.products}${categorySlug.isNotEmpty ? '/category/$categorySlug' : ''}',
      queryParameters: {'skip': skip, 'limit': limit},
    );

    return response.when(
      success: (data) => ProductResponse.fromJson(data.data),
      failure: (message) =>
          ProductResponse(products: [], total: 0, skip: 0, limit: 0),
    );
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _networkService.get(Endpoints.categories);

    return response.when(
      success: (res) {
        final list = (res.data as List)
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return list;
      },
      failure: (message) => <CategoryModel>[],
    );
  }

  @override
  Future<Result> addProductToCart(ProductModel product, int quantity) async {
    return await _homeDatabaseService.addProductToCart(product, quantity);
  }
}
