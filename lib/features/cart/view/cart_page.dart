import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_store_app/features/cart/presenter/cart_presenter.dart';
import 'package:your_store_app/features/cart/presenter/events/cart_event.dart';
import 'package:your_store_app/features/cart/presenter/states/cart_state.dart';
import 'package:your_store_app/shared/models/cart_product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartPresenter>().add(CartStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Carrito')),
      body: BlocBuilder<CartPresenter, CartState>(
        builder: (context, state) {
          if (state is CartLoading || state is CartInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartFailure) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)),
            );
          }

          if (state is CartEmpty) {
            return const Center(
              child: Text(
                "Tu carrito está vacío",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          if (state is CartLoaded) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Total a pagar: \$${state.total.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final cartProduct = state.products[index];
                      return _CartProductCard(cartProduct: cartProduct);
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}


class _CartProductCard extends StatelessWidget {
  final CartProduct cartProduct;

  const _CartProductCard({required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    final totalProductPrice =
        cartProduct.unitPrice * cartProduct.quantity;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cartProduct.product.thumbnail,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartProduct.product.title,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('Valor unitario: \$${cartProduct.unitPrice.toStringAsFixed(2)}'),
                  Text('Cantidad: ${cartProduct.quantity}'),
                  Text('Total: \$${totalProductPrice.toStringAsFixed(2)}'),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<CartPresenter>().add(
                  CartProductRemoved(cartProduct),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
