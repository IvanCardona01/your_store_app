import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_store_app/features/home/interactor/get_categories_use_case.dart';
import 'package:your_store_app/features/home/models/category_model.dart';

import 'events/home_event.dart';
import 'states/home_state.dart';
import 'package:your_store_app/features/home/models/product_model.dart';
import 'package:your_store_app/features/home/interactor/get_product_use_case.dart';

class HomePresenter extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase _getProducts;
  final GetCategoriesUseCase _getCategories;

  int _skip = 0;
  final int _limit = 10;
  int _total = 0;
  String _categorySlug = '';

  final List<ProductModel> _products = [];
  final List<CategoryModel> _categories = [];

  bool _isFetching = false;

  HomePresenter(this._getProducts, this._getCategories) : super(const HomeLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<RefreshProducts>(_onRefreshProducts);
    on<LoadCategories>(_onLoadCategories);
    on<SetCategory>(_onSetCategory);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<HomeState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;

    emit(const HomeLoading());
    _resetPaging();

    final result = await _getProducts(skip: _skip, limit: _limit, categorySlug: _categorySlug);

    _total = result.total;
    _products
      ..clear()
      ..addAll(result.products);

    final hasMore = _products.length < _total;

    emit(HomeLoaded(products: List.unmodifiable(_products), categories: List.unmodifiable(_categories), hasMore: hasMore));

    _isFetching = false;
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<HomeState> emit,
  ) async {
    if (_isFetching) return;
    final currentState = state;
    if (currentState is! HomeLoaded) return;
    if (!currentState.hasMore) return;

    _isFetching = true;

    emit(currentState.copyWith(isLoadingMore: true));

    _skip += _limit;

    final result = await _getProducts(skip: _skip, limit: _limit, categorySlug: _categorySlug);
    _total = result.total;
    _products.addAll(result.products);

    final hasMore = _products.length < _total;

    emit(
      HomeLoaded(
        products: List.unmodifiable(_products),
        categories: List.unmodifiable(_categories),
        hasMore: hasMore,
        isLoadingMore: false,
      ),
    );

    _isFetching = false;
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<HomeState> emit,
  ) async {
    return _onLoadProducts(const LoadProducts(), emit);
  }

  Future<void> _onLoadCategories(
  LoadCategories event,
  Emitter<HomeState> emit,
) async {
  final result = await _getCategories();
  final allCategories = [
    const CategoryModel(slug: '', name: 'Todos', url: ''),
    ...result
  ];
  _categories.clear();
  _categories.addAll(allCategories);

  emit(HomeLoaded(products: _products, categories: List.unmodifiable(_categories)));
}

  Future<void> _onSetCategory(
    SetCategory event,
    Emitter<HomeState> emit,
  ) async {
    _categorySlug = event.slug;
    return _onLoadProducts(const LoadProducts(), emit);
  }

  void _resetPaging() {
    _skip = 0;
    _total = 0;
  }
}
