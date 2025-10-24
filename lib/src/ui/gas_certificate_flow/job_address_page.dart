import 'package:flutter/material.dart';

import 'gas_certificate_flow.dart';

class JobAddressPage extends StatelessWidget {
  const JobAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Address'), backgroundColor: kTeal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Building / House No.')),
            const TextField(decoration: InputDecoration(labelText: 'Street')),
            const TextField(decoration: InputDecoration(labelText: 'Town / City')),
            const TextField(decoration: InputDecoration(labelText: 'Region')),
            const TextField(decoration: InputDecoration(labelText: 'Postcode')),
            const SizedBox(height: 16),
            const Text('Contact Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: "Occupant's Name")),
            const TextField(decoration: InputDecoration(labelText: "Occupant's Phone")),
            const TextField(decoration: InputDecoration(labelText: "Occupant's Email")),
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
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: kAmber),
                    onPressed: () {
                      // Go next to appliance page (future implementation)
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Continue'),
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
