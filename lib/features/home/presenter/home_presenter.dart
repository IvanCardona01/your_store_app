import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/home_event.dart';
import 'states/home_state.dart';
import 'package:your_store_app/features/home/models/product_model.dart';
import 'package:your_store_app/features/home/interactor/get_product_use_case.dart';

class HomePresenter extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase _getProducts;

  int _skip = 0;
  final int _limit = 10;
  int _total = 0;

  final List<ProductModel> _products = [];

  bool _isFetching = false;

  HomePresenter(this._getProducts) : super(const HomeLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<RefreshProducts>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<HomeState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;

    emit(const HomeLoading());
    _resetPaging();

    final result = await _getProducts(skip: _skip, limit: _limit);

    _total = result.total;
    _products
      ..clear()
      ..addAll(result.products);

    final hasMore = _products.length < _total;

    emit(HomeLoaded(products: List.unmodifiable(_products), hasMore: hasMore));

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

    final result = await _getProducts(skip: _skip, limit: _limit);
    _total = result.total;
    _products.addAll(result.products);

    final hasMore = _products.length < _total;

    emit(
      HomeLoaded(
        products: List.unmodifiable(_products),
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

  void _resetPaging() {
    _skip = 0;
    _total = 0;
  }
}
