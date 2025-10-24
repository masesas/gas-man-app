import 'package:flutter/material.dart';
import 'package:gas_man_app/src/data/models/gas_safety_certificate.dart';
import 'package:gas_man_app/src/ui/customer_signature_screen.dart';

class PdfPreviewScreen extends StatelessWidget {
  final GasSafetyCertificate cert;
  const PdfPreviewScreen({super.key, required this.cert});

  @override
  Widget build(BuildContext context) {
    if (cert.customerSignature == null) {
      // If someone jumped here directly, push them back to signature screen
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CustomerSignatureScreen(cert: cert)),
        );
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // ... build the PDF preview + Email/Print buttons ...
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Preview')),
      // your existing preview UI
    );
  }
}