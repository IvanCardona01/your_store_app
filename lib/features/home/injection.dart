import 'package:your_store_app/core/network/domain/network_service.dart';
import 'package:your_store_app/features/home/domain/home_repository.dart';
import 'package:your_store_app/features/home/interactor/get_categories_use_case.dart';
import 'package:your_store_app/features/home/interactor/get_product_use_case.dart';
import 'package:your_store_app/features/home/presenter/home_presenter.dart';

import '../../core/di/injection.dart';
import 'data/home_repository_impl.dart';


void initHome() {
  if (sl.isRegistered<HomePresenter>()) return;

  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl<NetworkService>()));

  sl.registerLazySingleton<GetProductsUseCase>(() => GetProductsUseCase(sl<HomeRepository>()));
  sl.registerLazySingleton<GetCategoriesUseCase>(() => GetCategoriesUseCase(sl<HomeRepository>()));

  sl.registerFactory<HomePresenter>(() => HomePresenter(sl<GetProductsUseCase>(), sl<GetCategoriesUseCase>()));
}