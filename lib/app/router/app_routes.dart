class AppRoutes {
  // Main routes
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  
  // Products routes
  static const String products = '/products';
  static const String productDetail = '/products/:productId';
  
  // Cart and checkout routes
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderSuccess = '/order-success';
  
  // User profile routes
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String orderHistory = '/profile/orders';
  
}