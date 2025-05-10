import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_model.dart';
import '../controllers/news_controller.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsController controller = Get.find<NewsController>();
  final NewsArticle article = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'news_image_${article.url}',
                child: article.imageUrl.isNotEmpty
                    ? Image.network(
                        article.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 50),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      ),
              ),
            ),
            actions: [
              Obx(() => IconButton(
                    icon: Icon(
                      controller.isFavorite(article)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: controller.isFavorite(article) ? Colors.red : null,
                    ),
                    onPressed: () => controller.toggleFavorite(article),
                  )),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        article.source,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article.publishedAt,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(article.url);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          Get.snackbar(
                            'Error',
                            'Could not open the article',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      icon: const Icon(Icons.launch),
                      label: const Text('Read Full Article'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}