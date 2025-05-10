import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../widgets/news_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Aggregator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.toNamed('/favorites'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => controller.searchNews(value),
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                'general',
                'business',
                'technology',
                'sports',
                'entertainment',
                'health',
                'science',
              ].map((category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(category.toUpperCase()),
                  onSelected: (selected) {
                    if (selected) {
                      controller.loadCategoryNews(category);
                    }
                  },
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.error.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.error.value,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => controller.loadHeadlines(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.articles.isEmpty) {
                return const Center(
                  child: Text('No articles found. Pull down to refresh.'),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.loadHeadlines(),
                child: ListView.builder(
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    return NewsCard(
                      article: article,
                      onTap: () => Get.toNamed('/details', arguments: article),
                      onFavorite: () => controller.toggleFavorite(article),
                      isFavorite: controller.isFavorite(article),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}