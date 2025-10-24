import 'package:flutter/material.dart';

import 'gas_certificate_flow.dart';
import 'safety_checks_page.dart';

class AppliancePage extends StatefulWidget {
  const AppliancePage({super.key});

  @override
  State<AppliancePage> createState() => _AppliancePageState();
}

class _AppliancePageState extends State<AppliancePage> {
  final TextEditingController applianceCtrl = TextEditingController();
  final TextEditingController modelCtrl = TextEditingController();
  final TextEditingController serialCtrl = TextEditingController();
  final TextEditingController flueCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appliance Details'), backgroundColor: kTeal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Appliance Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(controller: applianceCtrl, decoration: const InputDecoration(labelText: 'Appliance Type')),
            TextField(controller: modelCtrl, decoration: const InputDecoration(labelText: 'Make / Model')),
            TextField(controller: serialCtrl, decoration: const InputDecoration(labelText: 'Serial Number')),
            TextField(controller: flueCtrl, decoration: const InputDecoration(labelText: 'Flue Type')),
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SafetyChecksPage()));
                    },
                    icon: const Icon(Icons.navigate_next),
                    label: const Text('Next: Safety Checks'),
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
