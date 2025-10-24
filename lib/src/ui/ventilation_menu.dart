import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'open_flue_screen.dart';
import 'sealed_room_screen.dart';
import 'vent_area_calculator_screen.dart';

class VentilationMenuScreen extends StatelessWidget {
  const VentilationMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      _VentMenuItem(
        title: 'Open Flued Appliances',
        icon: Icons.fireplace,
        color: Colors.teal.shade700,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OpenFlueScreen()),
        ),
      ),
      _VentMenuItem(
        title: 'Sealed Room Appliances',
        icon: Icons.house_rounded,
        color: Colors.teal.shade600,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SealedRoomScreen()),
        ),
      ),
      _VentMenuItem(
        title: 'Vent Area Calculator',
        icon: Icons.wind_power,
        color: Colors.teal.shade500,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VentAreaCalculatorScreen()),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventilation Calculators'),
        backgroundColor: const Color(0xFF00796B),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelp(context),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF6F7F8),
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: cards,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.dashboard),
        label: const Text('Back to Dashboard'),
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.black87,
      ),
    );
  }

  void _showHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ventilation Help'),
        content: const Text(
          'Choose the correct calculator for your situation:\n\n'
              '🔥 Open Flued Appliances — calculate required vent sizes for open flue systems.\n\n'
              '🏠 Sealed Room Appliances — calculate ventilation based on room volume and air changes.\n\n'
              '🌬 Vent Area Calculator — find the free area of circular or rectangular vents.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }
}

class _VentMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _VentMenuItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.amber.shade300),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}