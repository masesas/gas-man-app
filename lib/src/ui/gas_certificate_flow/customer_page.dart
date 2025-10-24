import 'package:flutter/material.dart';

import 'gas_certificate_flow.dart';
import 'job_address_page.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer'), backgroundColor: kTeal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Customer Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Title'),
                    items: const [
                      DropdownMenuItem(value: 'Mr', child: Text('Mr')),
                      DropdownMenuItem(value: 'Mrs', child: Text('Mrs')),
                      DropdownMenuItem(value: 'Ms', child: Text('Ms')),
                    ],
                    onChanged: (_) {},
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  flex: 2,
                  child: TextField(decoration: InputDecoration(labelText: 'First Name')),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Last Name')),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Company Name')),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: kAmber),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const JobAddressPage()));
              },
              icon: const Icon(Icons.navigate_next),
              label: const Text('Next: Job Address'),
            ),
          ],
        ),
      ),
    );
  }
}
