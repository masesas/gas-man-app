import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Help & Support',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text(
          'If you need help using The Gas Man App, please reach out via email.\n\n'
          '📧 contact@gasmanapp.co.uk\n\n'
          'We aim to respond within 24 hours on business days.',
          style: TextStyle(fontSize: 15, height: 1.4),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.email_outlined),
            label: const Text('Email Support'),
            onPressed: () =>
                SharedHelper.toast(context, 'Opening email app...'),
          ),
        ),
      ],
    );
  }
}
