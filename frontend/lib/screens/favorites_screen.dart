import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../widgets/news_card.dart';

class FavoritesScreen extends StatelessWidget {
  final NewsController controller = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Articles'),
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No favorite articles yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final article = controller.favorites[index];
            return NewsCard(
              article: article,
              onTap: () => Get.toNamed('/details', arguments: article),
              onFavorite: () => controller.toggleFavorite(article),
              isFavorite: true,
            );
          },
        );
      }),
    );
  }
}