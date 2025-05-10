import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';

class NewsController extends GetxController {
  final String apiKey = '07ef64cec4684d13ac9de33d01ebd515';
  final String baseUrl = 'https://newsapi.org/v2';
  
  final RxList<NewsArticle> articles = <NewsArticle>[].obs;
  final RxList<NewsArticle> favorites = <NewsArticle>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString selectedCategory = 'general'.obs;
  final RxString searchQuery = ''.obs;
  final RxString error = ''.obs;

  int _page = 1;
  bool _hasMore = true;
  String? _lastArticleDate;

  late Box<Map> _favoritesBox;

  @override
  void onInit() {
    super.onInit();
    print('NewsController initialized'); // Debug print
    _initHive();
    loadHeadlines();
  }

  Future<void> _initHive() async {
    _favoritesBox = await Hive.openBox<Map>('favorites');
    loadFavorites();
  }

  Future<void> loadHeadlines() async {
    try {
      print('Loading headlines...'); // Debug print
      isLoading.value = true;
      error.value = '';
      
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        articles.value = (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article))
            .toList();
        print('Headlines loaded: ${articles.length} articles'); // Debug print
      } else {
        throw Exception('Failed to load headlines');
      }
    } catch (e) {
      print('Error loading headlines: $e'); // Debug print
      error.value = 'Failed to load headlines: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCategoryNews(String category) async {
    try {
      isLoading.value = true;
      error.value = '';
      selectedCategory.value = category;
      
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        articles.value = (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      } else {
        throw Exception('Failed to load category news');
      }
    } catch (e) {
      error.value = 'Failed to load category news: $e';
      print('Error loading category news: $e'); // Debug print
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) {
      loadHeadlines();
      return;
    }
    
    try {
      isLoading.value = true;
      error.value = '';
      searchQuery.value = query;
      
      final response = await http.get(
        Uri.parse('$baseUrl/everything?q=$query&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        articles.value = (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      } else {
        throw Exception('Failed to search news');
      }
    } catch (e) {
      error.value = 'Failed to search news: $e';
      print('Error searching news: $e'); // Debug print
    } finally {
      isLoading.value = false;
    }
  }

  void loadFavorites() {
    try {
      favorites.value = _favoritesBox.values
          .map((item) => NewsArticle.fromJson(Map<String, dynamic>.from(item)))
          .toList();
      // Force UI update for all articles
      articles.refresh();
    } catch (e) {
      print('Error loading favorites: $e');
      favorites.value = [];
    }
  }

  void saveFavorites() {
    try {
      _favoritesBox.clear();
      for (var article in favorites) {
        _favoritesBox.add(article.toJson());
      }
      // Force UI update for all articles
      articles.refresh();
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  void toggleFavorite(NewsArticle article) {
    if (isFavorite(article)) {
      favorites.removeWhere((fav) => fav.url == article.url);
    } else {
      favorites.add(article);
    }
    saveFavorites();
    // Force UI update for all articles
    articles.refresh();
  }

  bool isFavorite(NewsArticle article) {
    return favorites.any((fav) => fav.url == article.url);
  }
}