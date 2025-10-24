import 'package:flutter/material.dart';
import 'package:gas_man_app/src/helper/shared_helper.dart';

enum HazardClassification { atRisk, immediatelyDangerous, ncs }

extension HazardClassificationLabel on HazardClassification {
  String get label {
    switch (this) {
      case HazardClassification.atRisk:
        return 'At Risk (AR)';
      case HazardClassification.immediatelyDangerous:
        return 'Immediately Dangerous (ID)';
      case HazardClassification.ncs:
        return 'Not to Current Standards (NCS)';
    }
  }
}

class WarningNotice {
  final String id;
  DateTime date;
  String customerName;
  String addressLine1;
  String city;
  String postcode;
  String appliance;
  String location;
  String faultDetails;
  HazardClassification classification;
  bool supplyIsolated;
  bool cappedOrSealed;
  bool warningLabelAffixed;
  bool customerInformed;
  String engineerName;
  String? customerSignatureName;

  WarningNotice({
    required this.id,
    required this.date,
    required this.customerName,
    required this.addressLine1,
    required this.city,
    required this.postcode,
    required this.appliance,
    required this.location,
    required this.faultDetails,
    required this.classification,
    required this.supplyIsolated,
    required this.cappedOrSealed,
    required this.warningLabelAffixed,
    required this.customerInformed,
    required this.engineerName,
    this.customerSignatureName,
  });
}

class WarningNoticeStore {
  WarningNoticeStore._();

  static final WarningNoticeStore I = WarningNoticeStore._();
  final List<WarningNotice> _items = [];

  List<WarningNotice> get items => List.unmodifiable(_items);

  void add(WarningNotice n) => _items.insert(0, n);
}

class WarningNoticeFormScreen extends StatefulWidget {
  const WarningNoticeFormScreen({super.key});

  @override
  State<WarningNoticeFormScreen> createState() =>
      _WarningNoticeFormScreenState();
}

class _WarningNoticeFormScreenState extends State<WarningNoticeFormScreen> {
  final _form = GlobalKey<FormState>();

  final _customer = TextEditingController();
  final _addr1 = TextEditingController();
  final _city = TextEditingController();
  final _postcode = TextEditingController();
  final _appliance = TextEditingController();
  final _location = TextEditingController();
  final _fault = TextEditingController();
  final _engineer = TextEditingController(text: 'Engineer');
  final _signatureName = TextEditingController();

  DateTime _date = DateTime.now();
  HazardClassification _class = HazardClassification.immediatelyDangerous;
  bool _isolated = true;
  bool _capped = true;
  bool _label = true;
  bool _informed = true;

  @override
  void dispose() {
    _customer.dispose();
    _addr1.dispose();
    _city.dispose();
    _postcode.dispose();
    _appliance.dispose();
    _location.dispose();
    _fault.dispose();
    _engineer.dispose();
    _signatureName.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    if (!_form.currentState!.validate()) return;

    final notice = WarningNotice(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      date: _date,
      customerName: _customer.text.trim(),
      addressLine1: _addr1.text.trim(),
      city: _city.text.trim(),
      postcode: _postcode.text.trim().toUpperCase(),
      appliance: _appliance.text.trim(),
      location: _location.text.trim(),
      faultDetails: _fault.text.trim(),
      classification: _class,
      supplyIsolated: _isolated,
      cappedOrSealed: _capped,
      warningLabelAffixed: _label,
      customerInformed: _informed,
      engineerName: _engineer.text.trim(),
      customerSignatureName: _signatureName.text.trim().isEmpty
          ? null
          : _signatureName.text.trim(),
    );

    WarningNoticeStore.I.add(notice);
    Navigator.pop(context);
    SharedHelper.toast(context, 'Warning Notice saved');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gas Warning Notice')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Date
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event),
              title: Text(
                'Date: ${_date.toLocal().toString().split(' ').first}',
              ),
              trailing: TextButton(
                onPressed: _pickDate,
                child: const Text('Change'),
              ),
            ),
            const SizedBox(height: 4),

            // Customer + Address
            TextFormField(
              controller: _customer,
              decoration: const InputDecoration(labelText: 'Customer name'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addr1,
              decoration: const InputDecoration(labelText: 'Address line 1'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _city,
                    decoration: const InputDecoration(labelText: 'Town/City'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _postcode,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(labelText: 'Postcode'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Appliance & Location
            TextFormField(
              controller: _appliance,
              decoration: const InputDecoration(
                labelText: 'Appliance (e.g. Boiler)',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _location,
              decoration: const InputDecoration(
                labelText: 'Location (e.g. Kitchen)',
              ),
            ),
            const SizedBox(height: 8),

            // Fault details
            TextFormField(
              controller: _fault,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Details of fault / unsafe situation',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),

            // Classification
            DropdownButtonFormField<HazardClassification>(
              value: _class,
              decoration: const InputDecoration(labelText: 'Classification'),
              items: HazardClassification.values
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.label)))
                  .toList(),
              onChanged: (v) => setState(() => _class = v ?? _class),
            ),
            const SizedBox(height: 12),

            // Actions taken
            const Text(
              'Actions taken',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _isolated,
              onChanged: (v) => setState(() => _isolated = v ?? false),
              title: const Text('Gas supply isolated'),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _capped,
              onChanged: (v) => setState(() => _capped = v ?? false),
              title: const Text('Capped / Sealed off'),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _label,
              onChanged: (v) => setState(() => _label = v ?? false),
              title: const Text('Warning label affixed'),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _informed,
              onChanged: (v) => setState(() => _informed = v ?? false),
              title: const Text('Customer/Responsible person informed'),
            ),
            const SizedBox(height: 12),

            // Engineer + signature
            TextFormField(
              controller: _engineer,
              decoration: const InputDecoration(labelText: 'Engineer name'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _signatureName,
              decoration: const InputDecoration(
                labelText: 'Customer signature name (optional)',
              ),
            ),
            const SizedBox(height: 16),

            // Save
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save Warning Notice'),
              onPressed: _save,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ===============================
// WARNING NOTICE — List & Detail
// ===============================
class WarningNoticeListScreen extends StatelessWidget {
  const WarningNoticeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = WarningNoticeStore.I.items;
    return Scaffold(
      appBar: AppBar(title: const Text('Warning Notices (Saved)')),
      body: items.isEmpty
          ? const Center(child: Text('No warning notices saved yet.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                final n = items[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                    ),
                    title: Text('${n.classification.label} — ${n.appliance}'),
                    subtitle: Text(
                      '${n.customerName} • ${n.postcode} • ${n.date.toLocal().toString().split(' ').first}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WarningNoticeDetailScreen(notice: n),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class WarningNoticeDetailScreen extends StatelessWidget {
  final WarningNotice notice;

  const WarningNoticeDetailScreen({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    Widget row(String label, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Warning Notice')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          row('Date', notice.date.toLocal().toString().split(' ').first),
          row('Customer', notice.customerName),
          row(
            'Address',
            '${notice.addressLine1}, ${notice.city}, ${notice.postcode}',
          ),
          row('Appliance', notice.appliance),
          row('Location', notice.location),
          row('Classification', notice.classification.label),
          row('Fault details', notice.faultDetails),
          const Divider(),
          row('Supply isolated', notice.supplyIsolated ? 'Yes' : 'No'),
          row('Capped / Sealed', notice.cappedOrSealed ? 'Yes' : 'No'),
          row('Warning label', notice.warningLabelAffixed ? 'Yes' : 'No'),
          row('Customer informed', notice.customerInformed ? 'Yes' : 'No'),
          const Divider(),
          row('Engineer', notice.engineerName),
          if (notice.customerSignatureName != null &&
              notice.customerSignatureName!.isNotEmpty)
            row('Customer signature (name)', notice.customerSignatureName!),
        ],
      ),
    );
  }
}
