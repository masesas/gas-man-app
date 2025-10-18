import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final List<Map<String, String>> jobs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: jobs.isEmpty
          ? const Center(child: Text('No jobs yet'))
          : ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (_, i) {
                final job = jobs[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: Text(job['title']!),
                    subtitle: Text(job['customer']!),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addJob,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addJob() async {
    final title = await SharedHelper.prompt(context, title: 'Job Title');
    if (title == null || title.isEmpty) {
      return;
    }

    String? customer;
    if (context.mounted) {
      customer = await SharedHelper.prompt(context, title: 'Customer Name');
    }

    if (customer == null || customer.isEmpty) {
      return;
    }

    setState(() => jobs.add({'title': title, 'customer': customer!}));
    if (context.mounted) {
      SharedHelper.toast(context, 'Job added');
    }
  }
}
