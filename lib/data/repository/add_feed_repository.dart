import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:noviindusvideoapp/data/services/token_storage.dart';

class FeedRepository {
  FeedRepository();

  Future<void> uploadFeed({
    required File video,
    required File image,
    required String desc,
    required List<int> categories,
  }) async {
    final token = await TokenStorage().readToken();
    final baseUrl = "https://frijo.noviindus.in/api";
    var uri = Uri.parse('$baseUrl/my_feed');

    var request = http.MultipartRequest('POST', uri);
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    print("token: ${token}");
    request.files.add(await http.MultipartFile.fromPath('video', video.path));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    request.fields['desc'] = desc;
    request.fields['categories'] = categories.join(',');

    var response = await request.send();
    var responseData = await http.Response.fromStream(response);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      print("Upload success: ${responseData.body}");
    } else {
      throw Exception(
        'Failed to upload feed, statusCode: ${response.statusCode}, body: ${responseData.body}',
      );
    }
  }
}
