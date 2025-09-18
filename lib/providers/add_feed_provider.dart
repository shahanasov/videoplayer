import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noviindusvideoapp/data/repository/add_feed_repository.dart';

class AddFeedProvider extends ChangeNotifier {
  final FeedRepository repository;
  final ImagePicker picker = ImagePicker();

  AddFeedProvider(this.repository);

  File? video;
  File? image;
  String desc = '';
  List<int> categories = [];
  bool isLoading = false;

  // Setters
  void setVideo(File file) {
    video = file;
    notifyListeners();
  }

  void setImage(File file) {
    image = file;
    notifyListeners();
  }

  void setDesc(String value) {
    desc = value;
  }

  void setCategories(List<int> selected) {
    categories = selected;
    notifyListeners();
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setImage(File(pickedFile.path));
    }
  }

  // Pick video from gallery
  Future<void> pickVideo() async {
    try {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        setVideo(File(pickedFile.path));
      }
    } catch (e) {
      debugPrint("Error picking video: $e");
    }
  }

  void reset() {
    video = null;
    image = null;
    desc = '';
    categories = [];
    isLoading = false;
    notifyListeners();
  }

  // Upload feed
  Future<void> uploadFeed(BuildContext context) async {
    if (video == null ||
        image == null ||
        desc.trim().isEmpty ||
        categories.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All fields are mandatory')));
      return;
    }

    try {
      isLoading = true; // Start loading
      notifyListeners();

      await repository.uploadFeed(
        video: video!,
        image: image!,
        desc: desc.trim(),
        categories: categories,
      );

      isLoading = false; // Stop loading
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feed uploaded successfully')),
      );
      reset();
      Navigator.pop(context);
    } catch (e) {
      isLoading = false; // Stop loading on error
      notifyListeners();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error uploading feed: $e')));
    }
  }
}
