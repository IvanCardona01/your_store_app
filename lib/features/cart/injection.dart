import 'package:your_store_app/core/db/drift/app_database.dart';
import 'package:your_store_app/core/di/injection.dart';
import 'package:your_store_app/features/cart/data/cart_database_service_impl.dart';
import 'package:your_store_app/features/cart/data/cart_repository_impl.dart';
import 'package:your_store_app/features/cart/domain/cart_database_service.dart';
import 'package:your_store_app/features/cart/domain/cart_repository.dart';
import 'package:your_store_app/features/cart/interactor/get_cart_products_use_case.dart';
import 'package:your_store_app/features/cart/interactor/remove_product_from_cart_use_case.dart';
import 'package:your_store_app/features/cart/presenter/cart_presenter.dart';

void initCart() {
  if (sl.isRegistered<CartPresenter>()) return;

  sl.registerLazySingleton<CartDatabaseService>(() => CartDatabaseServiceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl<CartDatabaseService>()));
  
  sl.registerLazySingleton<GetCartProductsUseCase>(() => GetCartProductsUseCase(sl<CartRepository>()));
  sl.registerLazySingleton<RemoveProductFromCartUseCase>(() => RemoveProductFromCartUseCase(sl<CartRepository>()));

  sl.registerFactory<CartPresenter>(() => CartPresenter(sl<GetCartProductsUseCase>(), sl<RemoveProductFromCartUseCase>()));
}