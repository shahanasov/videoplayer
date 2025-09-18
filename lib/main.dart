import 'package:flutter/material.dart';
import 'package:noviindusvideoapp/core/theme/theme.dart';
import 'package:noviindusvideoapp/data/repository/auth_repository.dart';
import 'package:noviindusvideoapp/data/services/auth_services.dart';
import 'package:noviindusvideoapp/data/services/token_storage.dart';
import 'package:noviindusvideoapp/presentation/auth/login.dart';
import 'package:noviindusvideoapp/presentation/home/home.dart';
import 'package:noviindusvideoapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthServices();
    final tokenStorage = TokenStorage();

    final authRepository = AuthRepository(
      authService: authService,
      tokenStorage: tokenStorage,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authRepository: authRepository),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            title: 'Noviindus',
            theme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            home: authProvider.isLoggedIn
                ? const HomeScreen()
                :  LoginScreen(),
          );
        },
      ),
    );
  }
}
