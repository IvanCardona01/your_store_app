import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_store_app/shared/models/cart_product.dart';
import 'package:your_store_app/features/home/presenter/home_presenter.dart';
import 'package:your_store_app/features/home/presenter/states/home_state.dart';
import 'package:your_store_app/features/home/presenter/events/home_event.dart';
import 'package:your_store_app/features/home/widgets/add_to_cart_bottom_sheet.dart';
import 'package:your_store_app/features/home/widgets/categories_bottom_sheet.dart';
import 'package:your_store_app/shared/widgets/shimmer_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HomePresenter>().add(LoadCategories());
    context.read<HomePresenter>().add(LoadProducts());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final state = context.read<HomePresenter>().state;
        if (state is HomeLoaded && state.hasMore && !state.isLoadingMore) {
          context.read<HomePresenter>().add(LoadMoreProducts());
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Productos'),
        actions: [
          BlocBuilder<HomePresenter, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded && state.categories.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.category),
                  tooltip: 'Categorías',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => CategoriesBottomSheet(
                        categories: state.categories,
                        onCategorySelected: (slug) {
                          context.read<HomePresenter>().add(SetCategory(slug));
                          context.read<HomePresenter>().add(LoadProducts());
                        },
                      ),
                    );
                  },
                );
              }
              return const Text('No hay categorías');
            },
          ),
        ],
      ),
      body: BlocConsumer<HomePresenter, HomeState>(
        listener: (context, state) {
          if (state is HomeProductAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${state.product.title} x${state.quantity} agregado',
                ),
              ),
            );
          }
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const ShimmerGrid();
          }

          if (state is HomeLoaded) {
            return Stack(
              children: [
                GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return _buildProductCard(product);
                  },
                ),
                if (state.isLoadingMore)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildProductCard(product) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  product.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 2,
                ),
                child: Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                child: Text(
                  "\$${product.price}",
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () async {
                  final result = await showModalBottomSheet<CartProduct>(
                    context: context,
                    builder: (_) => AddToCartBottomSheet(product: product),
                  );

                  if (!mounted) return;

                  if (result != null) {
                    context.read<HomePresenter>().add(
                      AddProductToCart(product, result.quantity),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
