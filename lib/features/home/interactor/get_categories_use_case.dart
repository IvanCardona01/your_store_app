import 'package:your_store_app/features/home/models/category_model.dart';
import 'package:your_store_app/features/home/domain/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryModel>> call() async {
    return await repository.getCategories();
  }
}
