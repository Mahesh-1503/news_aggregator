import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/news_model.dart';

class NewsService {
  final String apiKey = dotenv.env['NEWS_API_KEY'] ?? '07ef64cec4684d13ac9de33d01ebd515';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> getHeadlines() async {
    try {
      print('Fetching headlines...'); // Debug print
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
      );
      
      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['articles'] == null) {
          throw Exception('No articles found in response');
        }
        return (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      } else {
        throw Exception('Failed to load headlines: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getHeadlines: $e'); // Debug print
      rethrow;
    }
  }

  Future<List<NewsArticle>> getNewsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      } else {
        throw Exception('Failed to load category news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getNewsByCategory: $e'); // Debug print
      rethrow;
    }
  }

  Future<List<NewsArticle>> searchNews(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/everything?q=$query&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      } else {
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in searchNews: $e'); // Debug print
      rethrow;
    }
  }
}