import 'package:flutter/material.dart';
import 'package:gas_man_app/src/theme/app_colors.dart';
import 'package:gas_man_app/src/ui/address/address_screen.dart';
import 'package:gas_man_app/src/ui/customer/customer_screen.dart';
import 'package:gas_man_app/src/ui/dashboard/dashboard_screen.dart';
import 'package:gas_man_app/src/ui/find_merchants_screen.dart';
import 'package:gas_man_app/src/ui/gas_pipe_sizing/gas_pipe_sizing_screen.dart';
import 'package:gas_man_app/src/ui/gas_rate_calculator/gas_rate_calculator_screen.dart';
import 'package:gas_man_app/src/ui/help/help_screen.dart';
import 'package:gas_man_app/src/ui/job/job_screen.dart';
import 'package:gas_man_app/src/ui/record/record_screen.dart';
import 'package:gas_man_app/src/ui/settings/settings_screen.dart';
import 'package:gas_man_app/src/ui/invoices_screen.dart';
import 'package:gas_man_app/src/ui/ventilation_screen.dart';

class NavigationShell extends StatefulWidget {
  const NavigationShell({super.key});

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  int index = 0;

  final List<String> titles = [
    'Dashboard',
    'Records',
    'Invoices',
    'Jobs',
    'Customers',
    'Addresses',
    'Find Merchants',
    'Gas Rate Calculator',
    'Pipe Sizing',
    'Ventilation',
    'Settings',
    'Help',
  ];
  final List<Widget> pages = [
    DashboardPage(), // Dashboard
    const RecordsScreen(), // Records
    const InvoicesScreen(), // Invoices
    const JobsScreen(), // Jobs
    const CustomersScreen(), // Customers
    const AddressesScreen(), // Addresses
    const FindMerchantsScreen(), // Find Merchants
    const GasRateCalculatorScreen(), // Gas Rate
    const GasPipeSizingScreen(), // Pipe Sizing
    const VentilationScreen(), // Ventilation
    const SettingsScreen(), // Settings
    const HelpScreen(), // Help
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[index])),
      drawer: _AppDrawer(
        index: index,
        onSelect: (i) {
          setState(() => index = i);
          Navigator.of(context).pop();
        },
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[index],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final int index;
  final ValueChanged<int> onSelect;

  const _AppDrawer({required this.index, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final List<String> labels = [
      'Dashboard',
      'Records',
      'Invoices',
      'Jobs',
      'Customers',
      'Addresses',
      'Find Merchants',
      'Gas Rate Calculator',
      'Pipe Sizing',
      'Ventilation',
      'Settings',
      'Help',
    ];

    final List<IconData> icons = [
      Icons.dashboard_outlined,
      Icons.note_add,
      Icons.receipt_long,
      Icons.work,
      Icons.person,
      Icons.location_on,
      Icons.store_mall_directory,
      Icons.calculate,
      Icons.linear_scale,
      Icons.air,
      Icons.settings,
      Icons.help_outline,
    ];

    return Drawer(
      child: SafeArea(
        child: ListView.builder(
          itemCount: labels.length,
          itemBuilder: (context, i) {
            final selected = i == index;
            return ListTile(
              leading: Icon(
                icons[i],
                color: selected ? AppColors.primary : Colors.black54,
              ),
              title: Text(
                labels[i],
                style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: selected,
              onTap: () => onSelect(i),
            );
          },
        ),
      ),
    );
  }
}
