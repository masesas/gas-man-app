import 'package:flutter/material.dart';

class OpenFlueScreen extends StatefulWidget {
  const OpenFlueScreen({super.key});

  @override
  State<OpenFlueScreen> createState() => _OpenFlueScreenState();
}

class _OpenFlueScreenState extends State<OpenFlueScreen> {
  final TextEditingController kwInput = TextEditingController();
  bool isGross = true;
  final TextEditingController ventFreeArea = TextEditingController();
  final TextEditingController highVent = TextEditingController();
  final TextEditingController lowVent = TextEditingController();

  String result = '';

  void calculateVent() {
    final kw = double.tryParse(kwInput.text) ?? 0;
    if (kw <= 0) {
      setState(() => result = 'Please enter a valid kW value.');
      return;
    }

    // Simplified example formula for open-flued appliance ventilation:
    // Total free area (cm²) = (kW × 5) + 100 (safety factor)
    double area = (kw * 5) + 100;
    if (isGross) area *= 1.1; // Slight increase for gross

    setState(() {
      result =
      'Required free area: ${area.toStringAsFixed(1)} cm²\n\nDivide equally between high & low vents.';
    });
  }

  void resetFields() {
    kwInput.clear();
    ventFreeArea.clear();
    highVent.clear();
    lowVent.clear();
    setState(() => result = '');
  }

  void showHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF004D40),
        title: const Text('Help', style: TextStyle(color: Colors.white)),
        content: const Text(
          'This calculator estimates the required ventilation area for open flued gas appliances.\n\n'
              'Enter the appliance heat input (kW) and choose Net or Gross.\n'
              'Results give the minimum free area in cm² required.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.amber)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Flued Calculator'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Container(
        color: const Color(0xFFBFD6F6),
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            _textField('Appliance Heat Input (kW)', kwInput),
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
            const SizedBox(height: 8),
            _textField('Existing Free Area (cm²)', ventFreeArea),
            _textField('High Vent (cm²)', highVent),
            _textField('Low Vent (cm²)', lowVent),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calculateVent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('CALCULATE'),
                ),
                ElevatedButton(
                  onPressed: resetFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('RESET'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () => showHelp(context),
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
                        fontSize: 16, fontWeight: FontWeight.w600),
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
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}