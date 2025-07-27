import 'package:your_store_app/features/home/models/category_model.dart';
import 'package:your_store_app/features/home/models/product_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final bool hasMore;
  final bool isLoadingMore;

  const HomeLoaded({
    required this.products,
    required this.categories,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  HomeLoaded copyWith({
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class HomeProductAdded extends HomeState {
  final ProductModel product;
  final int quantity;
  const HomeProductAdded(this.product, this.quantity);
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
