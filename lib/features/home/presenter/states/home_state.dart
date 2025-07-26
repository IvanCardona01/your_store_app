import 'package:your_store_app/features/home/models/product_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<ProductModel> products;
  final bool hasMore;
  final bool isLoadingMore;

  const HomeLoaded({
    required this.products,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  HomeLoaded copyWith({
    List<ProductModel>? products,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      products: products ?? this.products,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
