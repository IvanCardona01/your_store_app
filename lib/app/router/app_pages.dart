import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/view/login_page.dart';
import '../../../features/auth/view/register_page.dart';
import '../../../features/home/view/home_page.dart';
import '../../../features/products/view/products_page.dart';
import '../../../features/products/view/product_detail_page.dart';
import '../../../features/cart/view/cart_page.dart';
import '../../../features/cart/view/checkout_page.dart';
import '../../../features/cart/view/order_success_page.dart';
import '../../../features/profile/view/profile_page.dart';
import '../../../features/profile/view/edit_profile_page.dart';
import '../../../features/profile/view/order_history_page.dart';
import '../../../shared/widgets/main_layout.dart';
import 'app_routes.dart';

class AppPages {
  static const String initial = AppRoutes.home;

  static final GoRouter router = GoRouter(
    initialLocation: initial,
    routes: [
      // GoRoute(
      //   path: AppRoutes.login,
      //   name: 'login',
      //   builder: (context, state) => const LoginPage(),
      // ),
      // GoRoute(
      //   path: AppRoutes.register,
      //   name: 'register',
      //   builder: (context, state) => const RegisterPage(),
      // ),
      
      // ShellRoute(
      //   builder: (context, state, child) => MainLayout(child: child),
      //   routes: [
      //     // Home
      //     GoRoute(
      //       path: AppRoutes.home,
      //       name: 'home',
      //       builder: (context, state) => const HomePage(),
      //     ),
          
      //     // Productos
      //     GoRoute(
      //       path: AppRoutes.products,
      //       name: 'products',
      //       builder: (context, state) => const ProductsPage(),
      //       routes: [
      //         // Detalle del producto (ruta anidada)
      //         GoRoute(
      //           path: '/:productId',
      //           name: 'productDetail',
      //           builder: (context, state) => ProductDetailPage(
      //             productId: state.pathParameters['productId']!,
      //           ),
      //         ),
      //       ],
      //     ),
          
      //     // Carrito y compras
      //     GoRoute(
      //       path: AppRoutes.cart,
      //       name: 'cart',
      //       builder: (context, state) => const CartPage(),
      //     ),
      //     GoRoute(
      //       path: AppRoutes.checkout,
      //       name: 'checkout',
      //       builder: (context, state) => const CheckoutPage(),
      //     ),
      //     GoRoute(
      //       path: AppRoutes.orderSuccess,
      //       name: 'orderSuccess',
      //       builder: (context, state) => const OrderSuccessPage(),
      //     ),
          
      //     // Perfil de usuario
      //     GoRoute(
      //       path: AppRoutes.profile,
      //       name: 'profile',
      //       builder: (context, state) => const ProfilePage(),
      //       routes: [
      //         GoRoute(
      //           path: '/edit',
      //           name: 'editProfile',
      //           builder: (context, state) => const EditProfilePage(),
      //         ),
      //         GoRoute(
      //           path: '/orders',
      //           name: 'orderHistory',
      //           builder: (context, state) => const OrderHistoryPage(),
      //         ),
      //       ],
      //     ),
        // ],
      // ),
    ]
  );
}