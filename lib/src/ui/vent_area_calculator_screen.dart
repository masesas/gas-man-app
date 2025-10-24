import 'package:flutter/material.dart';

class VentAreaCalculatorScreen extends StatefulWidget {
  const VentAreaCalculatorScreen({super.key});

  @override
  State<VentAreaCalculatorScreen> createState() => _VentAreaCalculatorScreenState();
}

class _VentAreaCalculatorScreenState extends State<VentAreaCalculatorScreen> {
  String shape = 'Rectangular';
  final TextEditingController widthCtrl = TextEditingController();
  final TextEditingController heightCtrl = TextEditingController();
  final TextEditingController diameterCtrl = TextEditingController();
  final List<double> ventAreas = [];
  String result = '';

  void calculateArea() {
    double area = 0.0;

    if (shape == 'Rectangular') {
      final w = double.tryParse(widthCtrl.text) ?? 0;
      final h = double.tryParse(heightCtrl.text) ?? 0;
      if (w <= 0 || h <= 0) {
        setState(() => result = 'Please enter valid width and height.');
        return;
      }
      area = w * h;
    } else {
      final d = double.tryParse(diameterCtrl.text) ?? 0;
      if (d <= 0) {
        setState(() => result = 'Please enter a valid diameter.');
        return;
      }
      area = 3.1416 * (d / 2) * (d / 2);
    }

    setState(() {
      ventAreas.add(area);
      final total = ventAreas.reduce((a, b) => a + b);
      result = 'Vent ${ventAreas.length}: ${area.toStringAsFixed(1)} cm²\n'
          'Total Free Area: ${total.toStringAsFixed(1)} cm²';
    });
  }

  void resetAll() {
    widthCtrl.clear();
    heightCtrl.clear();
    diameterCtrl.clear();
    ventAreas.clear();
    setState(() => result = '');
  }

  void showHelpDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF004D40),
        title: const Text('Vent Area Help', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Use this tool to calculate the free area of ventilation openings.\n\n'
              'Rectangular: Width × Height\n'
              'Circular: 3.142 × (Diameter ÷ 2)²\n\n'
              'Tap "Add Another Vent" to total multiple openings.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vent Area Calculator'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Container(
        color: const Color(0xFFBFD6F6),
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            const Text('Select Vent Shape', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              value: shape,
              items: const [
                DropdownMenuItem(value: 'Rectangular', child: Text('Rectangular')),
                DropdownMenuItem(value: 'Circular', child: Text('Circular')),
              ],
              onChanged: (v) => setState(() => shape = v ?? 'Rectangular'),
            ),
            const SizedBox(height: 12),
            if (shape == 'Rectangular') ...[
              _textField('Width (cm)', widthCtrl),
              _textField('Height (cm)', heightCtrl),
            ] else
              _textField('Diameter (cm)', diameterCtrl),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: calculateArea,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text('Add Vent'),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  onPressed: resetAll,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: showHelpDialog,
              icon: const Icon(Icons.help_outline, color: Colors.teal),
              label: const Text('Help...?'),
            ),
            const SizedBox(height: 20),
            if (result.isNotEmpty)
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}