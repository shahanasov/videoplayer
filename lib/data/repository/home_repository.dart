import 'package:noviindusvideoapp/data/models/category_model.dart';
import 'package:noviindusvideoapp/data/models/feed_model.dart';
import 'package:noviindusvideoapp/data/services/feed_api_services.dart';

class HomeRepository {
  final ApiService apiService;

  HomeRepository(this.apiService);

  /// Fetch categories from API
  Future<List<Category>> getCategories() async {
    final data = await apiService.get('category_list');

    final categoriesData = data['categories'] ?? [];

    return (categoriesData as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  /// Fetch feeds from API
  Future<List<Feed>> getFeeds() async {
    final data = await apiService.get('home');
    final feedsData = data['results'] ?? [];
    return (feedsData as List).map((json) => Feed.fromJson(json)).toList();
  }
}
