import 'package:your_store_app/shared/models/cart_product.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartProduct> products;
  final double total;

  CartLoaded({required this.products, required this.total});
}

class CartEmpty extends CartState {}

class CartFailure extends CartState {
  final String message;

  CartFailure(this.message);
}
