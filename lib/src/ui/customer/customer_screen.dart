import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final List<String> customers = ['John Smith', 'Emma Brown'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Customers',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (var c in customers)
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(c),
              ),
            ),
          const SizedBox(height: 60),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCustomer,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addCustomer() async {
    final name = await SharedHelper.prompt(
      context,
      title: 'Enter new customer name',
    );
    if (name == null || name.isEmpty) return;

    setState(() => customers.add(name));
    if (context.mounted) {
      SharedHelper.toast(context, 'Customer added');
    }
  }
}
