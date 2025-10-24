import 'package:flutter/material.dart';

import 'customer_page.dart';
import 'gas_certificate_flow.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jobs'), backgroundColor: kTeal),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          JobCard(
            jobName: 'Job 1',
            clientName: 'Mr John Example',
            address: '10 Example Street, Example Town, EX1 1XE',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomerPage()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kAmber,
        icon: const Icon(Icons.add),
        label: const Text('Add New Job'),
        onPressed: () {},
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String jobName;
  final String clientName;
  final String address;
  final VoidCallback onTap;
  const JobCard({
    super.key,
    required this.jobName,
    required this.clientName,
    required this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(jobName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$clientName\n$address'),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
