import 'package:get/get.dart';
import '../screens/home_screen.dart';
import '../screens/news_details_screen.dart';
import '../screens/favorites_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.details,
      page: () => NewsDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => FavoritesScreen(),
    ),
  ];
}