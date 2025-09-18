import 'category_model.dart';

class Feed {
  int id;
  String description;
  String image;
  String video;
  List<int> likes;
  List<dynamic> dislikes;
  List<dynamic> bookmarks;
  List<int> hide;
  DateTime createdAt;
  bool follow;
  int userId;
  String userName;
  dynamic userImage;
  List<dynamic> banners;
  List<Category> categories;
  bool status;
  bool next;

  Feed({
    required this.id,
    required this.description,
    required this.image,
    required this.video,
    required this.likes,
    required this.dislikes,
    required this.bookmarks,
    required this.hide,
    required this.createdAt,
    required this.follow,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.banners,
    required this.categories,
    required this.status,
    required this.next,
  });

  static Feed fromJson(Map<String, dynamic> json) {
    final user = (json['user'] != null && json['user'] is Map<String, dynamic>)
        ? json['user']
        : {};

    final categoryList =
        (json['category_dict'] as List<dynamic>?)
            ?.map(
              (e) => Category(
                id: e['id'] is int
                    ? e['id']
                    : int.tryParse(e['id'].toString()) ?? 0,
                title: e['title'] ?? '',
                image: e['title'] ?? '',
              ),
            )
            .toList() ??
        [];

    return Feed(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      likes: List<int>.from(json['likes'] ?? []),
      dislikes: List<int>.from(json['dislikes'] ?? []),
      bookmarks: List<int>.from(json['bookmarks'] ?? []),
      hide: List<int>.from(json['hide'] ?? []),
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      follow: json['follow'] ?? false,
      userId: user['id'] ?? 0,
      userName: user['name'] ?? '',
      userImage: user['image'],
      banners: json['banners'] ?? [],
      categories: categoryList,
      status: json['status'] ?? false,
      next: json['next'] ?? false,
    );
  }
}
