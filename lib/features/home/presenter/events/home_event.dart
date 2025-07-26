abstract class HomeEvent {
  const HomeEvent();
}

class LoadProducts extends HomeEvent {
  const LoadProducts();
}

class LoadMoreProducts extends HomeEvent {
  const LoadMoreProducts();
}

class RefreshProducts extends HomeEvent {
  const RefreshProducts();
}

class LoadCategories extends HomeEvent {
  const LoadCategories();
}

class SetCategory extends HomeEvent {
  final String slug;
  const SetCategory(this.slug);
}