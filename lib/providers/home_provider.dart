import 'package:flutter/material.dart';
import 'package:noviindusvideoapp/data/models/category_model.dart';
import 'package:noviindusvideoapp/data/models/feed_model.dart';
import 'package:noviindusvideoapp/data/repository/home_repository.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepository repository;

  HomeProvider(this.repository) {
    fetchCategories();
    fetchFeeds();
  }

 
  List<Category> categories = [];
  List<Feed> feeds = [];
  int selectedCategoryIndex = 0;
  int playingVideoIndex = -1;

  bool isLoadingCategories = true;
  bool isLoadingFeeds = true;



  void selectCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  void setPlayingVideo(int index) {
    playingVideoIndex = index;
    notifyListeners();
  }


  

  // Fetch categories
  Future<void> fetchCategories() async {
    try {
      categories = await repository.getCategories();
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      isLoadingCategories = false;
      notifyListeners();
    }
  }

  // Fetch feeds
  Future<void> fetchFeeds() async {
    try {
      feeds = await repository.getFeeds();
    } catch (e) {
      debugPrint("Error fetching feeds: $e");
    } finally {
      isLoadingFeeds = false;
      notifyListeners();
    }
  }
}
