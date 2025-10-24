import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gas_man_app/src/data/models/land_lord_certificate.dart';

import '../theme/app_colors.dart';

class CertificatePreviewPage extends StatelessWidget {
  final LandlordCertificate cert;
  const CertificatePreviewPage({super.key, required this.cert});

  Widget _buildInfoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 150,
            child: Text("$label:",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: kTeal))),
        Expanded(child: Text(value, style: const TextStyle(color: kText))),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Certificate Preview")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kTeal,
                      ),
                      child: const Icon(Icons.local_fire_department,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "The Gas Man Ltd",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  Text(cert.date,
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
              const Divider(thickness: 2, color: kAmber, height: 25),
              const Text("Landlord Gas Safety Certificate",
                  style: TextStyle(
                      fontSize: 18,
                      color: kTeal,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              _buildInfoRow("Customer Name", cert.customerName),
              _buildInfoRow("Property Address", cert.propertyAddress),
              _buildInfoRow("Appliance Details", cert.applianceDetails),
              _buildInfoRow("Engineer Name", cert.engineerName),
              _buildInfoRow("Comments", cert.comments),
              const SizedBox(height: 16),

              // Signatures
              const Text("Signatures",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kTeal)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _signatureBox(cert.engineerSignature, "Engineer Signature"),
                  _signatureBox(cert.customerSignature, "Customer Signature"),
                ],
              ),
              const SizedBox(height: 24),

              Center(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Back to List"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAmber,
                    foregroundColor: Colors.black,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signatureBox(Uint8List? sig, String label) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(6),
          ),
          child: sig != null
              ? Image.memory(sig, fit: BoxFit.contain)
              : const Center(child: Text("No Signature")),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}