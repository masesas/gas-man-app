import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';
import 'package:gas_man_app/src/ui/warning_notice.dart';

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
      'Gas Warning Notice', // ✅ added
      'Warning Notices (Saved)', // ✅ list saved notices
    ];

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Gas Safety Records',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          for (var r in records)
            Card(
              child: ListTile(
                title: Text(r),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  if (r == 'Gas Warning Notice') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WarningNoticeFormScreen()),
                    );
                  } else if (r == 'Warning Notices (Saved)') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WarningNoticeListScreen()),
                    );
                  } else {
                    SharedHelper.toast(context, 'Opening "$r"...');
                  }
                },
              ),
            )
        ],
      ),
    );
  }
}
