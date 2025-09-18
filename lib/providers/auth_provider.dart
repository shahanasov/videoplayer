import 'package:flutter/material.dart';
import 'package:noviindusvideoapp/data/repository/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository authRepository;

  String? token;
  String? error;
  bool isLoading = false;

  AuthProvider({required this.authRepository}) {
    _loadToken(); 
  }

  Future<void> _loadToken() async {
    token = await authRepository.getSavedToken();
    notifyListeners();
  }

  Future<void> verifyOtp(String countryCode, String phone) async {
    isLoading = true;
    notifyListeners();

    try {
      token = await authRepository.verifyOtp(countryCode, phone);
      error = null;
    } catch (e) {
      error = e.toString();
      token = null;
    }

    isLoading = false;
    notifyListeners();
  }



  bool get isLoggedIn => token != null;
}
