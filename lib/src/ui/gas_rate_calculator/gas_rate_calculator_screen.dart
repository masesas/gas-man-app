import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class GasRateCalculatorScreen extends StatefulWidget {
  const GasRateCalculatorScreen({super.key});

  @override
  State<GasRateCalculatorScreen> createState() => _GasRateCalculatorScreenState();
}

class _GasRateCalculatorScreenState extends State<GasRateCalculatorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Timer _timer;
  int _seconds = 120;
  bool _isRunning = false;
  bool _torchOn = false;

  final TextEditingController _initialCtrl = TextEditingController();
  final TextEditingController _finalCtrl = TextEditingController();

  String _gasType = 'Natural Gas';
  String _unitType = 'Metric (m³)';
  String _result = '';
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initHive();
  }

  Future<void> _initHive() async {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var box = await Hive.openBox('gas_rate_history');
    _history = List<Map<String, dynamic>>.from(box.get('items', defaultValue: []));
    setState(() {});
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
      _seconds = 120;
      _result = '';
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds == 0) {
        t.cancel();
        setState(() => _isRunning = false);
        _calculateGasRate();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
      _seconds = 120;
      _result = '';
      _initialCtrl.clear();
      _finalCtrl.clear();
    });
  }

  // --- UI BUILD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Rate Calculator'),
        backgroundColor: const Color(0xFF004D40),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Calculator'),
            Tab(text: 'History'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_torchOn ? Icons.flashlight_on : Icons.flashlight_off),
            onPressed: _toggleTorch,
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF002F2F),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildCalculatorTab(),
            _buildHistoryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorTab() {
    final minutes = (_seconds ~/ 60).toString().padLeft(1, '0');
    final secs = (_seconds % 60).toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _dropdown(
            'Gas Type',
            _gasType,
            ['Natural Gas', 'LPG'],
                (v) => setState(() => _gasType = v!),
          ),
          _dropdown(
            'Units',
            _unitType,
            ['Metric (m³)', 'Imperial (ft³)'],
                (v) => setState(() => _unitType = v!),
          ),
          _textField('Initial Reading', _initialCtrl),
          _textField('Final Reading', _finalCtrl),
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal.shade900,
                border: Border.all(color: Colors.amber.shade400, width: 4),
              ),
              alignment: Alignment.center,
              child: Text(
                "$minutes:$secs",
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _isRunning ? null : _startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Start'),
              ),
              ElevatedButton(
                onPressed: _resetTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_result.isNotEmpty)
            Card(
              color: Colors.teal.shade800,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _result,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    if (_history.isEmpty) {
      return const Center(
        child: Text(
          'No saved results yet.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      itemCount: _history.length,
      itemBuilder: (context, index) {
        final item = _history[index];
        return Card(
          color: Colors.teal.shade800,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(
              'Gas Rate: ${item['gasRate']} ${item['unit']}',
              style: const TextStyle(color: Colors.amber),
            ),
            subtitle: Text(
              'Gross: ${item['gross']} kW  |  Net: ${item['net']} kW\n${item['date']}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.copy, color: Colors.white70),
              onPressed: () => _copyToClipboard(item),
            ),
          ),
        );
      },
    );
  }

  void _calculateGasRate() {
    final init = double.tryParse(_initialCtrl.text) ?? 0;
    final fin = double.tryParse(_finalCtrl.text) ?? 0;
    final used = fin - init;
    if (used <= 0) {
      setState(() => _result = 'Please enter valid readings.');
      return;
    }

    double gasRate;
    double grossKw;
    double netKw;

    if (_unitType.contains('Metric')) {
      gasRate = used * (3600 / 120); // m³/hr for 2 mins
      grossKw = gasRate * (_gasType == 'Natural Gas' ? 10.76 : 26.5);
      netKw = gasRate * (_gasType == 'Natural Gas' ? 9.5 : 23.5);
    } else {
      gasRate = used * (2 * 1.02264 * 39.11 / 3.6); // ft³/hr simplified
      grossKw = gasRate * 0.01;
      netKw = gasRate * 0.009;
    }

    final formatted = '''
Gas Rate: ${gasRate.toStringAsFixed(2)} ${_unitType.contains('Metric') ? 'm³/hr' : 'ft³/hr'}
Gross Heat Input: ${grossKw.toStringAsFixed(1)} kW
Net Heat Input: ${netKw.toStringAsFixed(1)} kW
''';

    setState(() {
      _result = formatted;
      _saveHistory(gasRate, grossKw, netKw);
    });
  }

  Future<void> _saveHistory(double gasRate, double gross, double net) async {
    final now = DateTime.now();
    final item = {
      'gasRate': gasRate.toStringAsFixed(2),
      'gross': gross.toStringAsFixed(1),
      'net': net.toStringAsFixed(1),
      'unit': _unitType.contains('Metric') ? 'm³/hr' : 'ft³/hr',
      'date': now.toString().substring(0, 16),
    };

    setState(() => _history.insert(0, item));
    final box = await Hive.openBox('gas_rate_history');
    await box.put('items', _history);
  }

  void _copyToClipboard(Map<String, dynamic> item) {
    final text = 'Gas Rate: ${item['gasRate']} ${item['unit']}\n'
        'Gross: ${item['gross']} kW\nNet: ${item['net']} kW';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _shareResult() {
    if (_result.isEmpty) return;
    // Placeholder: integrate share_plus plugin later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share feature coming soon')),
    );
  }

  void _toggleTorch() {
    setState(() => _torchOn = !_torchOn);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_torchOn ? 'Torch ON (simulated)' : 'Torch OFF'),
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: items.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer.cancel();
    _initialCtrl.dispose();
    _finalCtrl.dispose();
    super.dispose();
  }
}
