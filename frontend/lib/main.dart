import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme/app_theme.dart';
import 'controllers/news_controller.dart';
import 'screens/home_screen.dart';
import 'screens/news_details_screen.dart';
import 'screens/favorites_screen.dart';
import 'models/news_model.dart';

void main() async {
  try {
    print('Initializing app...');
    WidgetsFlutterBinding.ensureInitialized();
    
    // Initialize Hive
    await Hive.initFlutter();
    Hive.registerAdapter(NewsArticleAdapter()); // Register the adapter
    await Hive.openBox<Map>('favorites');
    
    // Initialize NewsController
    Get.put(NewsController());
    
    runApp(const MyApp());
  } catch (e) {
    print('Error during initialization: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News Aggregator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(
          name: '/details',
          page: () => NewsDetailsScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(name: '/favorites', page: () => FavoritesScreen()),
      ],
    );
  }
}