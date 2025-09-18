// auth_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServices {
  final String baseUrl = "https://frijo.noviindus.in/api/";

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 202) {
      print(response.body);
      print("statuscode: ${response.statusCode}");
      return json.decode(response.body);
    } else {
      throw Exception("Failed with status: ${response.statusCode}");
    }
  }
}
