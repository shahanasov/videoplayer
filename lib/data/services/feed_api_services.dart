import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://frijo.noviindus.in/api/";

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 202) {
     
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception(
        'Failed to fetch $endpoint, statusCode: ${response.statusCode}',
      );
    }
  }

Future<dynamic> post(String endpoint, Map<String, dynamic> body, String token) async {
  final response = await http.post(
    Uri.parse('$baseUrl$endpoint'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",  
    },
    body: json.encode(body),
  );

  if (response.statusCode == 200 || response.statusCode == 202) {
    print(response.body);
    return json.decode(response.body);
  } else {
    throw Exception(
      'Failed to post $endpoint, statusCode: ${response.statusCode}, body: ${response.body}',
    );
  }
}

}
