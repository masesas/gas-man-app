import 'package:flutter/material.dart';
import 'package:gas_man_app/src/theme/app_colors.dart';
import 'package:gas_man_app/src/ui/splash/splash_screen.dart';

class GasManApp extends StatelessWidget {
  const GasManApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Gas Man App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kTeal,
          primary: kTeal,
          secondary: kAmber,
          onPrimary: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F7F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: kTeal,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}