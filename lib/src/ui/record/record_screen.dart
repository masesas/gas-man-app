import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = [
      'Homeowner Gas Safety Record',
      'Landlord Gas Safety Record',
      'Gas Service Record',
      'Gas Breakdown Record',
      'Commissioning Checklist',
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Gas Safety Records',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (var r in records)
          Card(
            child: ListTile(
              title: Text(r),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => SharedHelper.toast(context, 'Opening "$r"...'),
            ),
          ),
      ],
    );
  }
}
