// ---------------------------- ENGINEER PROFILE SCREEN ------------------------
import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EngineerProfileScreen extends StatefulWidget {
  const EngineerProfileScreen({super.key});
  @override
  State<EngineerProfileScreen> createState() => _EngineerProfileScreenState();
}

class _EngineerProfileScreenState extends State<EngineerProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _engineerName = TextEditingController();
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _gasSafeNo = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _signatureName = TextEditingController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _engineerName.text = prefs.getString('eng_name') ?? '';
      _companyName.text = prefs.getString('eng_company') ?? '';
      _gasSafeNo.text = prefs.getString('eng_gassafe') ?? '';
      _email.text = prefs.getString('eng_email') ?? '';
      _signatureName.text = prefs.getString('eng_signature') ?? '';
      _loading = false;
    });
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('eng_name', _engineerName.text.trim());
    await prefs.setString('eng_company', _companyName.text.trim());
    await prefs.setString('eng_gassafe', _gasSafeNo.text.trim());
    await prefs.setString('eng_email', _email.text.trim());
    await prefs.setString('eng_signature', _signatureName.text.trim());

    if (mounted) SharedHelper.toast(context, 'Engineer profile saved ✅');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Engineer Profile')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Your Engineer Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _engineerName,
              decoration: const InputDecoration(labelText: 'Engineer Name'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Enter your name'
                  : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _companyName,
              decoration: const InputDecoration(labelText: 'Company Name'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Enter your company name'
                  : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _gasSafeNo,
              decoration:
              const InputDecoration(labelText: 'Gas Safe Registration No.'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Enter your Gas Safe number'
                  : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email Address'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Enter your email';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _signatureName,
              decoration: const InputDecoration(labelText: 'Signature (name)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save Profile'),
              onPressed: _saveProfile,
            ),
          ],
        ),
      ),
    );
  }
}