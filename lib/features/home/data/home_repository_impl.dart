import 'package:your_store_app/core/network/domain/network_service.dart';
import 'package:your_store_app/core/network/endpoints.dart';
import 'package:your_store_app/features/home/domain/home_repository.dart';
import 'package:your_store_app/features/home/models/product_response.dart';


class HomeRepositoryImpl implements HomeRepository {
  final NetworkService _networkService;
  HomeRepositoryImpl(this._networkService);

  @override
  Future<ProductResponse> getProducts({int skip = 0, int limit = 10}) async {
    final response = await _networkService.get(
      Endpoints.products,
      queryParameters: {'skip': skip, 'limit': limit},
    );

    return response.when(
      success: (data) => ProductResponse.fromJson(data.data),
      failure: (message) => ProductResponse(products: [], total: 0, skip: 0, limit: 0),
    );
  }
}
