import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gas_man_app/src/data/models/gas_safety_certificate.dart';
import 'package:gas_man_app/src/ui/pdf_preview_screen.dart';

class CustomerSignatureScreen extends StatefulWidget {
  final GasSafetyCertificate cert;

  const CustomerSignatureScreen({super.key, required this.cert});

  @override
  State<CustomerSignatureScreen> createState() =>
      _CustomerSignatureScreenState();
}

class _CustomerSignatureScreenState extends State<CustomerSignatureScreen> {
  // Assume you already have a signature controller/canvas
  Uint8List? signatureBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer's Signature")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ... your date fields / customer name / signature pad ...
          // signatureBytes = await signatureController.toPngBytes(); (example)
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    // validate you have a signature
                    if (signatureBytes == null || signatureBytes!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please capture a signature.'),
                        ),
                      );
                      return;
                    }
                    // attach to cert model
                    widget.cert.copyWith(
                      customerSignature: String.fromCharCodes(
                        signatureBytes ?? [],
                      ),
                    );

                    // now go to PDF preview
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PdfPreviewScreen(cert: widget.cert),
                      ),
                    );
                  },
                  child: const Text('Approve & Preview'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
