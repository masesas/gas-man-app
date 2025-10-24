import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'dart:math' as math;

class GasPipeCalculatorScreen extends StatefulWidget {
  const GasPipeCalculatorScreen({super.key});

  @override
  State<GasPipeCalculatorScreen> createState() => _GasPipeCalculatorScreenState();
}

class _GasPipeCalculatorScreenState extends State<GasPipeCalculatorScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController kwInput = TextEditingController();
  final TextEditingController lengthInput = TextEditingController();
  final TextEditingController highLoss = TextEditingController();
  final TextEditingController lowLoss = TextEditingController();

  String gasType = 'Natural Gas';
  bool isGross = true;
  bool isMetric = true;
  String pipeMaterial = 'Copper';

  Map<int, double> dropResults = {};
  String result = '';
  double? pressureDrop;
  int? chosenSize;
  bool hasResult = false;

  List<Map<String, dynamic>> savedResults = [];

  void calculate() {
    final kw = double.tryParse(kwInput.text) ?? 0;
    final length = double.tryParse(lengthInput.text) ?? 0;
    final hi = double.tryParse(highLoss.text) ?? 0;
    final lo = double.tryParse(lowLoss.text) ?? 0;

    if (kw <= 0 || length <= 0) {
      setState(() {
        result = 'Please enter valid input values.';
        hasResult = false;
      });
      return;
    }

    double netKw = isGross ? kw * 0.9 : kw;
    if (gasType == 'LPG') netKw *= 0.7;
    double totalLength = length + (hi * 0.5) + (lo * 0.3);
    if (!isMetric) totalLength *= 0.3048;
    double flowRate = netKw / 10.5;

    final Map<int, double> pipeLoss = {15: 0.8, 22: 0.25, 28: 0.09, 35: 0.04};
    final Map<int, double> calcDrops = {};

    pipeLoss.forEach((size, factor) {
      calcDrops[size] = flowRate * flowRate * totalLength * factor;
    });

    int bestSize = 35;
    for (final size in [15, 22, 28, 35]) {
      if ((calcDrops[size] ?? 999) < 1.0) {
        bestSize = size;
        break;
      }
    }

    setState(() {
      dropResults = calcDrops;
      chosenSize = bestSize;
      pressureDrop = calcDrops[bestSize];
      hasResult = true;
      result =
      'Recommended pipe size: ${bestSize} mm\nPressure drop: ${pressureDrop!.toStringAsFixed(2)} mbar';
    });
  }

  void reset() {
    kwInput.clear();
    lengthInput.clear();
    highLoss.clear();
    lowLoss.clear();
    setState(() {
      gasType = 'Natural Gas';
      pipeMaterial = 'Copper';
      isGross = true;
      isMetric = true;
      hasResult = false;
      dropResults.clear();
      result = '';
    });
  }

  void saveResult() {
    if (!hasResult) return;
    setState(() {
      savedResults.add({
        'date': DateTime.now(),
        'result': result,
      });
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Result saved.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gas Pipe Sizing Calculator')),
      body: Container(
        color: const Color(0xFFBFD6F6),
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _dropdownField('Gas Type', gasType, ['Natural Gas', 'LPG'], (v) {
              setState(() => gasType = v!);
            }),
            _textField('Input (kW)', kwInput),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Gross'),
                    value: true,
                    groupValue: isGross,
                    onChanged: (v) => setState(() => isGross = v!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Net'),
                    value: false,
                    groupValue: isGross,
                    onChanged: (v) => setState(() => isGross = v!),
                  ),
                ),
              ],
            ),
            _textField('Pipe Length', lengthInput),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Metres'),
                    value: true,
                    groupValue: isMetric,
                    onChanged: (v) => setState(() => isMetric = v!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Feet'),
                    value: false,
                    groupValue: isMetric,
                    onChanged: (v) => setState(() => isMetric = v!),
                  ),
                ),
              ],
            ),
            _dropdownField('Pipe Material', pipeMaterial, ['Copper', 'Steel'], (v) {
              setState(() => pipeMaterial = v!);
            }),
            _textField('High-loss fittings', highLoss),
            _textField('Low-loss fittings', lowLoss),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: calculate,
                  child: const Text('CALCULATE'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: reset,
                  child: const Text('RESET'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (hasResult) ...[
              _resultCard(result),
              const SizedBox(height: 12),
              _buildChart(),
              const SizedBox(height: 12),
              _legend(),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: saveResult,
                icon: const Icon(Icons.save),
                label: const Text('Save Result'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade700),
              ),
            ],
            if (savedResults.isNotEmpty) ...[
              const Divider(thickness: 2),
              const Text('Saved Results:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              for (var entry in savedResults)
                ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(entry['result']),
                  subtitle: Text(entry['date'].toString()),
                ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _resultCard(String text) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildChart() {
    const maxDrop = 1.0;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pressure Drop by Pipe Size (mbar)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (final size in [15, 22, 28, 35])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: _bar(size, dropResults[size] ?? 0, maxDrop),
              ),
          ],
        ),
      ),
    );
  }

  Widget _bar(int size, double value, double max) {
    final percent = math.min(value / max, 1.0);
    final color = value <= 1.0 ? Colors.green : Colors.red;
    return Row(
      children: [
        SizedBox(width: 40, child: Text('${size}mm')),
        Expanded(
          child: Stack(
            children: [
              Container(height: 20, color: Colors.grey.shade300),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: 20,
                width: MediaQuery.of(context).size.width * percent * 0.6,
                color: color,
              ),
              Positioned.fill(
                child: Center(
                    child: Text('${value.toStringAsFixed(2)} mbar',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _legend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.square, color: Colors.green, size: 16),
        SizedBox(width: 4),
        Text('< 1.0 mbar OK'),
        SizedBox(width: 16),
        Icon(Icons.square, color: Colors.red, size: 16),
        SizedBox(width: 4),
        Text('> 1.0 mbar Too High'),
      ],
    );
  }

  Widget _textField(String label, TextEditingController c) {
    return TextField(
      controller: c,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label, filled: true, fillColor: Colors.white),
    );
  }

  Widget _dropdownField(
      String label, String value, List<String> items, Function(String?) onChanged) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text('$label:', style: const TextStyle(fontSize: 16))),
        Expanded(
          flex: 3,
          child: DropdownButtonFormField<String>(
            value: value,
            items: items.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(filled: true, fillColor: Colors.white),
          ),
        ),
      ],
    );
  }
}