import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:gas_man_app/src/data/models/land_lord_certificate.dart';
import 'package:gas_man_app/src/ui/SavedCertificatesPage.dart';
import 'package:hive_flutter/adapters.dart';

import '../theme/app_colors.dart';

class CertificateFormPage extends StatefulWidget {
  const CertificateFormPage({super.key});

  @override
  State<CertificateFormPage> createState() => _CertificateFormPageState();
}

class _CertificateFormPageState extends State<CertificateFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _customerController = TextEditingController();
  final _addressController = TextEditingController();
  final _applianceController = TextEditingController();
  final _engineerController =
  TextEditingController(text: "The Gas Man Ltd"); // pre-fill
  final _commentsController = TextEditingController();

  final _engineerSigKey = GlobalKey<SignatureState>();
  final _customerSigKey = GlobalKey<SignatureState>();

  bool _saving = false;

  Future<void> _saveCertificate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    // Convert drawn signatures to PNG bytes
    final engineerImage = await
    (await _engineerSigKey.currentState!.getData()).toByteData(format: ui.ImageByteFormat.png);
    final customerImage =
    await (await _customerSigKey.currentState!.getData()).toByteData(format: ui.ImageByteFormat.png);

    final engineerBytes = engineerImage?.buffer.asUint8List();
    final customerBytes = customerImage?.buffer.asUint8List();

    final cert = LandlordCertificate(
      customerName: _customerController.text,
      propertyAddress: _addressController.text,
      applianceDetails: _applianceController.text,
      engineerName: _engineerController.text,
      comments: _commentsController.text,
      date: DateTime.now().toString().substring(0, 16),
      engineerSignature: engineerBytes,
      customerSignature: customerBytes,
    );

    final box = Hive.box<LandlordCertificate>('certificates');
    await box.add(cert);

    setState(() => _saving = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Certificate saved successfully")),
    );

    // Navigate to saved list
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SavedCertificatesPage()),
    );
  }

  void _clearSignatures() {
    _engineerSigKey.currentState?.clear();
    _customerSigKey.currentState?.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Landlord Gas Safety Certificate"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_customerController, "Customer Name"),
              _buildTextField(_addressController, "Property Address", maxLines: 2),
              _buildTextField(_applianceController, "Appliance Details"),
              _buildTextField(_engineerController, "Engineer Name"),
              _buildTextField(_commentsController, "Comments / Notes", maxLines: 3),

              const SizedBox(height: 20),
              const Text("Engineer Signature",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 150,
                child: Signature(key: _engineerSigKey, color: kTeal, strokeWidth: 3),
              ),

              const SizedBox(height: 20),
              const Text("Customer Signature",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 150,
                child: Signature(key: _customerSigKey, color: Colors.amber, strokeWidth: 3),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: _clearSignatures,
                    icon: const Icon(Icons.refresh, color: kTeal),
                    label:
                    const Text("Clear Signatures", style: TextStyle(color: kTeal)),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saving ? null : _saveCertificate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAmber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.save),
                  label: Text(_saving ? "Saving…" : "Save Certificate",
                      style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          fillColor: Colors.white,
          filled: true,
        ),
        validator: (val) =>
        val == null || val.isEmpty ? "Please enter $label" : null,
      ),
    );
  }
}