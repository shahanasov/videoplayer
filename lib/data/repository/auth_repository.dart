
import 'package:noviindusvideoapp/data/services/auth_services.dart';
import 'package:noviindusvideoapp/data/services/token_storage.dart';

class AuthRepository {
  final AuthServices authService;
  final TokenStorage tokenStorage;

  AuthRepository({
    required this.authService,
    required this.tokenStorage,
  });

  /// Verify OTP and save token in SharedPreferences
  Future<String> verifyOtp(String countryCode, String phone) async {
    final response = await authService.post("otp_verified", {
      "country_code": countryCode,
      "phone": phone,
    });

    if (response["status"] == true && response["token"] != null) {
      final accessToken = response["token"]["access"];
      // Save token to SharedPreferences
      await tokenStorage.saveToken(accessToken);
      return accessToken;
    } else {
      throw Exception(response["message"] ?? "OTP verification failed");
    }
  }


  Future<String?> getSavedToken() async {
    return await tokenStorage.readToken();
  }


}
