import 'package:flutter/material.dart';

import 'jobs_page.dart';

const kTeal = Color(0xFF00796B);
const kAmber = Color(0xFFFFB300);

class GasCertificateFlow extends StatelessWidget {
  const GasCertificateFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gas Safety Certificate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kTeal)
            .copyWith(primary: kTeal, secondary: kAmber),
        useMaterial3: true,
      ),
      home: const JobsPage(),
    );
  }
}
