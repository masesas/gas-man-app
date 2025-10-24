import 'package:flutter/material.dart';

import 'gas_certificate_flow.dart';
import 'signature_page.dart';

class SafetyChecksPage extends StatefulWidget {
  const SafetyChecksPage({super.key});

  @override
  State<SafetyChecksPage> createState() => _SafetyChecksPageState();
}

class _SafetyChecksPageState extends State<SafetyChecksPage> {
  bool tightnessTest = false;
  bool ventilationOK = false;
  bool flueCheck = false;
  bool applianceSafe = false;
  final notesCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety Checks'), backgroundColor: kTeal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Checks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: tightnessTest,
              onChanged: (v) => setState(() => tightnessTest = v!),
              title: const Text('Tightness Test Passed'),
            ),
            CheckboxListTile(
              value: ventilationOK,
              onChanged: (v) => setState(() => ventilationOK = v!),
              title: const Text('Ventilation Adequate'),
            ),
            CheckboxListTile(
              value: flueCheck,
              onChanged: (v) => setState(() => flueCheck = v!),
              title: const Text('Flue Check Passed'),
            ),
            CheckboxListTile(
              value: applianceSafe,
              onChanged: (v) => setState(() => applianceSafe = v!),
              title: const Text('Appliance Safe to Use'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Engineer Notes',
                border: OutlineInputBorder(),
              ),
            ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SignaturePage()));
                    },
                    icon: const Icon(Icons.navigate_next),
                    label: const Text('Next: Signature'),
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
