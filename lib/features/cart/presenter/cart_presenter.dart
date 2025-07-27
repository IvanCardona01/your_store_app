import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_store_app/features/cart/interactor/get_cart_products_use_case.dart';
import 'package:your_store_app/features/cart/interactor/remove_product_from_cart_use_case.dart';


import 'events/cart_event.dart';
import 'states/cart_state.dart';

class CartPresenter extends Bloc<CartEvent, CartState> {
  final GetCartProductsUseCase _getCartProductsUseCase;
  final RemoveProductFromCartUseCase _removeProductFromCartUseCase;

  CartPresenter(this._getCartProductsUseCase, this._removeProductFromCartUseCase)
      : super(CartInitial()) {
    on<CartStarted>(_onCartStarted);
    on<CartProductRemoved>(_onCartProductRemoved);
  }

  Future<void> _onCartStarted(
      CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final result = await _getCartProductsUseCase();

    result.when(
      success: (products) {
        if (products.isEmpty) {
          emit(CartEmpty());
        } else {
          final total = products.fold<double>(
              0, (sum, item) => sum + (item.unitPrice * item.quantity));
          emit(CartLoaded(products: products, total: total));
        }
      },
      failure: (message) => emit(CartFailure(message)),
    );
  }

  Future<void> _onCartProductRemoved(
      CartProductRemoved event, Emitter<CartState> emit) async {
    final result = await _removeProductFromCartUseCase(event.product);
    result.when(
      success: (_) => add(CartStarted()),
      failure: (message) => emit(CartFailure(message)),
    );
  }
}
