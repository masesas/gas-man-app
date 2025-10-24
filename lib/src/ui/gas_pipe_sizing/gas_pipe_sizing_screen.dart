import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';

class GasPipeSizingScreen extends StatefulWidget {
  const GasPipeSizingScreen({super.key});

  @override
  State<GasPipeSizingScreen> createState() => _GasPipeSizingScreenState();
}

class _GasPipeSizingScreenState extends State<GasPipeSizingScreen> {
  final TextEditingController lengthController = TextEditingController();
  int elbows = 0;
  int tees = 0;
  String pipeSize = '15 mm';
  double? pressureDrop;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Gas Pipe Sizing (UK)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: lengthController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Total Length (m)'),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Pipe Diameter'),
          value: pipeSize,
          items: const [
            DropdownMenuItem(value: '15 mm', child: Text('15 mm')),
            DropdownMenuItem(value: '22 mm', child: Text('22 mm')),
            DropdownMenuItem(value: '28 mm', child: Text('28 mm')),
            DropdownMenuItem(value: '35 mm', child: Text('35 mm')),
          ],
          onChanged: (v) => setState(() => pipeSize = v ?? pipeSize),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text('Elbows'),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: elbows > 0
                        ? () => setState(() => elbows--)
                        : null,
                  ),
                  Text('$elbows', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => elbows++),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text('Tees'),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: tees > 0 ? () => setState(() => tees--) : null,
                  ),
                  Text('$tees', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => tees++),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          icon: const Icon(Icons.calculate),
          label: const Text('Calculate Pressure Drop'),
          onPressed: _calculateDrop,
        ),
        const SizedBox(height: 16),
        if (pressureDrop != null)
          Card(
            color: Colors.teal.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Estimated Pressure Drop: ${pressureDrop!.toStringAsFixed(2)} mbar',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }

  void _calculateDrop() {
    final length = double.tryParse(lengthController.text) ?? 0;
    if (length <= 0) {
      SharedHelper.toast(context, 'Enter valid pipe length');
      return;
    }

    double baseFactor;
    switch (pipeSize) {
      case '15 mm':
        baseFactor = 0.25;
        break;
      case '22 mm':
        baseFactor = 0.10;
        break;
      case '28 mm':
        baseFactor = 0.07;
        break;
      case '35 mm':
        baseFactor = 0.05;
        break;
      default:
        baseFactor = 0.2;
    }

    final fittingsFactor = elbows * 0.5 + tees * 0.75;
    final drop = (length * baseFactor) + fittingsFactor;
    setState(() => pressureDrop = drop);
  }
}

// ---------------------------- VENTILATION CALCULATOR ------------------------
class VentilationCalculatorScreen extends StatefulWidget {
  const VentilationCalculatorScreen({super.key});

  @override
  State<VentilationCalculatorScreen> createState() =>
      _VentilationCalculatorScreenState();
}

class _VentilationCalculatorScreenState
    extends State<VentilationCalculatorScreen> {
  final TextEditingController kwController = TextEditingController();
  String applianceType = 'Room-Sealed';
  double? requiredArea;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Ventilation Calculator',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Appliance Type'),
          value: applianceType,
          items: const [
            DropdownMenuItem(value: 'Room-Sealed', child: Text('Room-Sealed')),
            DropdownMenuItem(value: 'Open Flue', child: Text('Open Flue')),
            DropdownMenuItem(value: 'Flueless', child: Text('Flueless')),
          ],
          onChanged: (v) => setState(() => applianceType = v ?? applianceType),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: kwController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Input Rating (kW)'),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.calculate),
          label: const Text('Calculate Required Vent Area'),
          onPressed: _calculate,
        ),
        const SizedBox(height: 16),
        if (requiredArea != null)
          Card(
            color: Colors.teal.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Minimum Free Ventilation Area: ${requiredArea!.toStringAsFixed(1)} cm²',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }

  void _calculate() {
    final kw = double.tryParse(kwController.text) ?? 0;
    if (kw <= 0) {
      SharedHelper.toast(context, 'Enter valid kW input');
      return;
    }

    double factor;
    switch (applianceType) {
      case 'Open Flue':
        factor = 5; // cm² per kW (example)
        break;
      case 'Flueless':
        factor = 10;
        break;
      default:
        factor = 0;
    }

    setState(() => requiredArea = kw * factor);
  }
}


