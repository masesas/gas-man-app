import 'package:flutter/material.dart';

import 'package:gas_man_app/src/theme/app_theme.dart';
import 'package:gas_man_app/src/ui/splash/splash_screen.dart';

class GasManApp extends StatelessWidget {
  const GasManApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Gas Man App',
      theme: AppTheme.buildTheme(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
