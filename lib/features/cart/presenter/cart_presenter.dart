import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_store_app/features/cart/interactor/get_cart_products_stream_use_case.dart';
import 'package:your_store_app/features/cart/interactor/remove_product_from_cart_use_case.dart';

import 'events/cart_event.dart';
import 'states/cart_state.dart';

class CartPresenter extends Bloc<CartEvent, CartState> {
  final GetCartProductsStreamUseCase _getCartProductsStreamUseCase;
  final RemoveProductFromCartUseCase _removeProductFromCartUseCase;

  StreamSubscription? _cartSubscription;

  CartPresenter(
    this._getCartProductsStreamUseCase,
    this._removeProductFromCartUseCase,
  ) : super(CartInitial()) {
    on<CartStarted>(_onCartStarted);
    on<CartProductsUpdated>(_onCartProductsUpdated);
    on<CartProductRemoved>(_onCartProductRemoved);
  }

  Future<void> _onCartStarted(
      CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());

    await _cartSubscription?.cancel();

    _cartSubscription = _getCartProductsStreamUseCase().listen((products) {
      add(CartProductsUpdated(products));
    }, onError: (error) {
      addError(error);
      emit(CartFailure(error.toString()));
    });
  }

  Future<void> _onCartProductsUpdated(
      CartProductsUpdated event, Emitter<CartState> emit) async {
    if (event.products.isEmpty) {
      emit(CartEmpty());
    } else {
      final total = event.products.fold<double>(
        0,
        (sum, item) => sum + (item.unitPrice * item.quantity),
      );
      emit(CartLoaded(products: event.products, total: total));
    }
  }

  Future<void> _onCartProductRemoved(
      CartProductRemoved event, Emitter<CartState> emit) async {
    final result = await _removeProductFromCartUseCase(event.product);
    result.when(
      success: (_) {},
      failure: (message) => emit(CartFailure(message)),
    );
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
