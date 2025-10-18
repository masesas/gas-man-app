import 'package:flutter/material.dart';
import 'package:gas_man_app/src/theme/app_colors.dart';

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
  final List<Widget> pages = const [
    Placeholder(), // Dashboard (Part 2)
    Placeholder(), // Records (Part 2)
    Placeholder(), // Invoices (Part 2)
    Placeholder(), // Jobs (Part 2)
    Placeholder(), // Customers (Part 2)
    Placeholder(), // Addresses (Part 2)
    Placeholder(), // Find Merchants (Part 4)
    Placeholder(), // Gas Rate (Part 3)
    Placeholder(), // Pipe Sizing (Part 3)
    Placeholder(), // Ventilation (Part 3)
    Placeholder(), // Settings (Part 4)
    Placeholder(), // Help (Part 4)
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
