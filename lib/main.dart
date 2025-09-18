import 'package:flutter/material.dart';
import 'package:noviindusvideoapp/core/theme/theme.dart';
import 'package:noviindusvideoapp/presentation/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noviindus',

      theme: AppTheme.darkTheme,
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
