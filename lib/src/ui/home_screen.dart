import 'package:flutter/material.dart';
import 'package:gas_man_app/src/ui/find_merchants_screen.dart';
import 'package:gas_man_app/src/ui/invoices_screen.dart';
import 'package:gas_man_app/src/ui/ventilation_screen.dart';
import 'package:gas_man_app/src/ui/address/address_screen.dart';
import 'package:gas_man_app/src/ui/customer/customer_screen.dart';
import 'package:gas_man_app/src/ui/gas_pipe_sizing/gas_pipe_sizing_screen.dart';
import 'package:gas_man_app/src/ui/gas_rate_calculator/gas_rate_calculator_screen.dart';
import 'package:gas_man_app/src/ui/help/help_screen.dart';
import 'package:gas_man_app/src/ui/record/record_screen.dart';
import 'package:gas_man_app/src/ui/settings/settings_screen.dart';
import 'package:gas_man_app/src/ui/warning_notice_screen.dart';

import 'job/job_screen.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      _ToolItem('Dashboard', Icons.dashboard, Colors.amber, () {}),
      _ToolItem('Records', Icons.note_add, Colors.tealAccent,
              () => _open(context, const RecordsScreen())),
      _ToolItem('Invoices', Icons.receipt_long, Colors.orangeAccent,
              () => _open(context, const InvoicesScreen())),
      _ToolItem('Jobs', Icons.work, Colors.greenAccent,
              () => _open(context, const JobsScreen())),
      _ToolItem('Customers', Icons.people, Colors.blueAccent,
              () => _open(context, const CustomersScreen())),
      _ToolItem('Addresses', Icons.location_on, Colors.purpleAccent,
              () => _open(context, const AddressesScreen())),
      _ToolItem('Find Merchants', Icons.store, Colors.cyanAccent,
              () => _open(context, const FindMerchantsScreen())),
      _ToolItem('Gas Rate', Icons.local_fire_department, Colors.redAccent,
              () => _open(context, const GasRateCalculatorScreen())),
      _ToolItem('Pipe Sizing', Icons.straighten, Colors.amberAccent,
              () => _open(context, const GasPipeSizingScreen())),
      _ToolItem('Ventilation', Icons.air, Colors.lightBlueAccent,
              () => _open(context, const VentilationScreen())),
      _ToolItem('Warning Notices', Icons.warning_amber_rounded, Colors.redAccent,
              () => _open(context, const WarningNoticeScreen())),
      _ToolItem('Settings', Icons.settings, Colors.grey,
              () => _open(context, const SettingsScreen())),
      _ToolItem('Help', Icons.help_outline, Colors.lightGreenAccent,
              () => _open(context, const HelpScreen())),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Gas Man App'),
        backgroundColor: const Color(0xFF0E827C),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF0E827C),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: tools
            .map((tool) => GestureDetector(
          onTap: tool.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tool.icon, size: 48, color: tool.color),
                const SizedBox(height: 8),
                Text(
                  tool.title,
                  style: const TextStyle(
                    color: Color(0xFF0E827C),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ))
            .toList(),
      ),
    );
  }

  static void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}

class _ToolItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _ToolItem(this.title, this.icon, this.color, this.onTap);
}