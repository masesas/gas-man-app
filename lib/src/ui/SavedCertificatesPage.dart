import 'package:flutter/material.dart';
import 'package:gas_man_app/src/data/models/land_lord_certificate.dart';
import 'package:gas_man_app/src/ui/CertificateFormPage.dart';
import 'package:hive_flutter/adapters.dart';

import '../theme/app_colors.dart';
import 'CertificatePreviewPage.dart';

class SavedCertificatesPage extends StatefulWidget {
  const SavedCertificatesPage({super.key});

  @override
  State<SavedCertificatesPage> createState() => _SavedCertificatesPageState();
}

class _SavedCertificatesPageState extends State<SavedCertificatesPage> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box<LandlordCertificate>('certificates');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Certificates"),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<LandlordCertificate> certBox, _) {
          if (certBox.values.isEmpty) {
            return const Center(
              child: Text("No saved certificates yet.",
                  style: TextStyle(color: Colors.black54)),
            );
          }

          return ListView.builder(
            itemCount: certBox.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, i) {
              final cert = certBox.getAt(i)!;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(cert.customerName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(cert.propertyAddress),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () async {
                      await cert.delete();
                      setState(() {});
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CertificatePreviewPage(cert: cert),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kAmber,
        label: const Text("New Certificate"),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const CertificateFormPage()));
        },
      ),
    );
  }
}