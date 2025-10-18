import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Welcome to The Gas Man App',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            _DashboardTile(
              icon: Icons.note_add,
              label: 'New Record',
              color: Colors.teal.shade400,
              onTap: () => _nav(context, 'Records'),
            ),
            _DashboardTile(
              icon: Icons.receipt_long,
              label: 'Invoices',
              color: Colors.amber.shade400,
              onTap: () => _nav(context, 'Invoices'),
            ),
            _DashboardTile(
              icon: Icons.person,
              label: 'Customers',
              color: Colors.teal.shade300,
              onTap: () => _nav(context, 'Customers'),
            ),
            _DashboardTile(
              icon: Icons.store_mall_directory,
              label: 'Merchants',
              color: Colors.amber.shade300,
              onTap: () => _nav(context, 'Find Merchants'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Upcoming Jobs',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text('No jobs currently scheduled.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _nav(BuildContext context, String title) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navigate to $title')));
  }
}

class _DashboardTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DashboardTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 36),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
