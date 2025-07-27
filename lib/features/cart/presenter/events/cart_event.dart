import 'package:equatable/equatable.dart';
import 'package:your_store_app/shared/models/cart_product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartStarted extends CartEvent {}

class CartProductRemoved extends CartEvent {
  final CartProduct product;

  const CartProductRemoved(this.product);

  @override
  List<Object?> get props => [product];
}

class CartProductsUpdated extends CartEvent {
  final List<CartProduct> products;

  const CartProductsUpdated(this.products);
}