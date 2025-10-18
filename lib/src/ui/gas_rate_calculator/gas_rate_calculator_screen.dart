import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';

class GasRateCalculatorScreen extends StatefulWidget {
  const GasRateCalculatorScreen({super.key});

  @override
  State<GasRateCalculatorScreen> createState() =>
      _GasRateCalculatorScreenState();
}

class _GasRateCalculatorScreenState extends State<GasRateCalculatorScreen> {
  String meterType = 'Metric (m³)';
  final TextEditingController volume = TextEditingController();
  final TextEditingController seconds = TextEditingController();
  double? result;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Gas Rate Calculator',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Meter Type'),
          value: meterType,
          items: const [
            DropdownMenuItem(value: 'Metric (m³)', child: Text('Metric (m³)')),
            DropdownMenuItem(
              value: 'Imperial (ft³)',
              child: Text('Imperial (ft³)'),
            ),
          ],
          onChanged: (v) => setState(() => meterType = v ?? meterType),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: volume,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Gas Volume Measured'),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: seconds,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Time (seconds)'),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.calculate),
          label: const Text('Calculate'),
          onPressed: _calculate,
        ),
        const SizedBox(height: 16),
        if (result != null)
          Card(
            color: Colors.teal.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Result: ${result!.toStringAsFixed(2)} ${meterType.contains("Metric") ? "m³/h" : "ft³/h"}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }

  void _calculate() {
    final v = double.tryParse(volume.text) ?? 0;
    final s = double.tryParse(seconds.text) ?? 0;
    if (v <= 0 || s <= 0) {
      SharedHelper.toast(context, 'Enter valid values');
      return;
    }
    setState(() => result = (v / s) * 3600);
  }
}
