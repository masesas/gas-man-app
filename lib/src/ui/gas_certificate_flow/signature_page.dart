import 'package:flutter/material.dart';

import '../certificate_preview_screen.dart';
import 'gas_certificate_flow.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  bool signed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Signature'), backgroundColor: kTeal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Customer Declaration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'I confirm that the details entered are correct and that I am satisfied '
              'with the gas safety inspection carried out.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text('Signature Pad Placeholder'),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: signed,
              onChanged: (v) => setState(() => signed = v!),
              title: const Text('Customer has signed'),
            ),
            const SizedBox(height: 12),
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
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: kAmber),
                    onPressed: signed
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const CertificatePreviewPage()),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Preview Certificate'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
