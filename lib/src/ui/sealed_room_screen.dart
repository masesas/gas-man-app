import 'package:flutter/material.dart';

class SealedRoomScreen extends StatefulWidget {
  const SealedRoomScreen({super.key});

  @override
  State<SealedRoomScreen> createState() => _SealedRoomScreenState();
}

class _SealedRoomScreenState extends State<SealedRoomScreen> {
  final TextEditingController kwInput = TextEditingController();
  final TextEditingController volumeInput = TextEditingController();
  final TextEditingController airChangesInput = TextEditingController();
  bool isGross = true;
  String result = '';

  void calculateVent() {
    final kw = double.tryParse(kwInput.text) ?? 0;
    final vol = double.tryParse(volumeInput.text) ?? 0;
    final ach = double.tryParse(airChangesInput.text) ?? 0;

    if (kw <= 0 || vol <= 0) {
      setState(() => result = 'Please enter valid input values.');
      return;
    }

    // Simplified sealed-room ventilation calculation (example basis):
    // Free area (cm²) = (kW × 2) + (room volume ÷ 20) + (air changes ÷ 5)
    double area = (kw * 2) + (vol / 20) + (ach / 5);
    if (isGross) area *= 1.05; // minor adjustment for gross input

    setState(() {
      result =
      'Required minimum free area: ${area.toStringAsFixed(1)} cm²\n'
          '(Based on appliance and room parameters)';
    });
  }

  void resetFields() {
    kwInput.clear();
    volumeInput.clear();
    airChangesInput.clear();
    setState(() => result = '');
  }

  void showHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF004D40),
        title: const Text('Help', style: TextStyle(color: Colors.white)),
        content: const Text(
          'This calculator estimates ventilation requirements for room-sealed appliances.\n\n'
              'Enter the appliance heat input, room volume, and estimated air changes per hour.\n'
              'The result shows the minimum required vent free area in cm².',
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
        title: const Text('Sealed Room Calculator'),
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
            _textField('Room Volume (m³)', volumeInput),
            _textField('Air Changes per Hour', airChangesInput),
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}