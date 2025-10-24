import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gas_man_app/src/data/models/installation_checklist.dart';

class SavedChecklistsScreen extends StatelessWidget {
  const SavedChecklistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<InstallationChecklist>('checklists');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Checklists'),
        backgroundColor: Colors.teal,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<InstallationChecklist> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No checklists saved yet.'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final item = box.getAt(index);
              if (item == null) return const SizedBox.shrink();
              
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('${item.type} - ${item.make} ${item.model}'),
                  subtitle: Text(
                    'Location: ${item.location}\nGas Rate: ${item.gasRate ?? "N/A"}',
                  ),
                  trailing: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.teal,
                  ),
                  onTap: () {
                    // Navigate to PDF preview for this saved record
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
