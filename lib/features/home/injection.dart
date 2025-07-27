import 'package:your_store_app/core/db/drift/app_database.dart';
import 'package:your_store_app/core/network/domain/network_service.dart';
import 'package:your_store_app/features/home/data/home_database_service_impl.dart';
import 'package:your_store_app/features/home/domain/home_database_service.dart';
import 'package:your_store_app/features/home/domain/home_repository.dart';
import 'package:your_store_app/features/home/interactor/add_product_to_cart_use_case.dart';
import 'package:your_store_app/features/home/interactor/get_categories_use_case.dart';
import 'package:your_store_app/features/home/interactor/get_product_use_case.dart';
import 'package:your_store_app/features/home/presenter/home_presenter.dart';

import '../../core/di/injection.dart';
import 'data/home_repository_impl.dart';


void initHome() {
  if (sl.isRegistered<HomePresenter>()) return;

  sl.registerLazySingleton<HomeDatabaseService>(() => HomeDatabaseServiceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl<NetworkService>(), sl<HomeDatabaseService>()));

  sl.registerLazySingleton<GetProductsUseCase>(() => GetProductsUseCase(sl<HomeRepository>()));
  sl.registerLazySingleton<GetCategoriesUseCase>(() => GetCategoriesUseCase(sl<HomeRepository>()));
  sl.registerLazySingleton<AddProductToCartUseCase>(() => AddProductToCartUseCase(sl<HomeRepository>()));

  sl.registerFactory<HomePresenter>(() => HomePresenter(sl<GetProductsUseCase>(), sl<GetCategoriesUseCase>(), sl<AddProductToCartUseCase>()));
}