import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final List<Map<String, String>> addresses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: addresses.isEmpty
          ? const Center(child: Text('No addresses added'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: addresses
                  .map(
                    (a) => Card(
                      child: ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(a['line1']!),
                        subtitle: Text('${a['city']!}, ${a['postcode']!}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAddress(context),
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }

  void _addAddress(BuildContext context) async {
    final line1 = await SharedHelper.prompt(context, title: 'Address line 1');
    if (line1 == null || line1.isEmpty) return;

    String? city;
    if (context.mounted) {
      city = await SharedHelper.prompt(context, title: 'City');
    }

    if (city == null || city.isEmpty) return;

    String? pc;
    if (context.mounted) {
      pc = await SharedHelper.prompt(context, title: 'Postcode');
    }

    if (pc == null || pc.isEmpty) return;
    setState(
      () => addresses.add({'line1': line1, 'city': city!, 'postcode': pc!}),
    );

    if (context.mounted) {
      SharedHelper.toast(context, 'Address added');
    }
  }
}
