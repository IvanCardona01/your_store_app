// app_pages.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:your_store_app/core/di/injection.dart';
import 'package:your_store_app/features/auth/injection.dart';
import 'package:your_store_app/features/auth/presenter/login_presenter.dart';
import 'package:your_store_app/features/auth/presenter/register_presenter.dart';
import 'package:your_store_app/features/home/injection.dart';
import 'package:your_store_app/features/home/presenter/home_presenter.dart';
import 'package:your_store_app/features/home/view/home_page.dart';
import 'package:your_store_app/features/profile/injection.dart';
import 'package:your_store_app/features/profile/presenter/profile_presenter.dart';
import 'package:your_store_app/features/profile/view/profile_page.dart';

import '../../../features/auth/view/login_page.dart';
import '../../../features/auth/view/register_page.dart';
import '../../../shared/widgets/main_layout.dart';
import 'app_routes.dart';

class AppPages {
  static const String initial = AppRoutes.login;

  static final GoRouter router = GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) {
          initAuth();
          return BlocProvider(
            create: (_) => sl<LoginPresenter>(),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.register,
        builder: (context, state) {
          initAuthRegister();
          return BlocProvider(
            create: (_) => sl<RegisterPresenter>(),
            child: const RegisterPage(),
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.home,
                builder: (context, state) {
                  initHome();
                  return BlocProvider(
                    create: (_) => sl<HomePresenter>(),
                    child: const HomePage(),
                  );
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cart,
                name: AppRoutes.cart,
                builder: (context, state) => const Scaffold(
                  body: Center(child: Text('Carrito')),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: AppRoutes.profile,
                builder: (context, state) {
                  initProfile();
                  return BlocProvider(
                    create: (_) => sl<ProfilePresenter>(),
                    child: const ProfilePage(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
