import 'package:flutter/material.dart';
import 'package:gas_man_app/src/theme/app_colors.dart';

class WarningNoticeScreen extends StatefulWidget {
  const WarningNoticeScreen({super.key});

  @override
  State<WarningNoticeScreen> createState() => _WarningNoticeScreenState();
}

class _WarningNoticeScreenState extends State<WarningNoticeScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _applianceController = TextEditingController();
  final TextEditingController _defectsController = TextEditingController();
  final TextEditingController _actionTakenController = TextEditingController();
  final TextEditingController _recommendationsController = TextEditingController();
  
  String _selectedRiskCategory = 'At Risk';
  bool _turnedOff = false;
  bool _cappedOff = false;
  bool _labelAttached = false;
  
  final List<String> _riskCategories = [
    'Immediately Dangerous',
    'At Risk',
    'Not to Current Standards',
  ];

  @override
  void dispose() {
    _customerNameController.dispose();
    _addressController.dispose();
    _applianceController.dispose();
    _defectsController.dispose();
    _actionTakenController.dispose();
    _recommendationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warning/Advice Notice'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWarningHeader(),
              const SizedBox(height: 20),
              _buildSectionTitle('Customer Details'),
              const SizedBox(height: 12),
              _buildCustomerDetailsSection(),
              const SizedBox(height: 20),
              _buildSectionTitle('Appliance Information'),
              const SizedBox(height: 12),
              _buildApplianceSection(),
              const SizedBox(height: 20),
              _buildSectionTitle('Risk Category'),
              const SizedBox(height: 12),
              _buildRiskCategorySection(),
              const SizedBox(height: 20),
              _buildSectionTitle('Defects Identified'),
              const SizedBox(height: 12),
              _buildDefectsSection(),
              const SizedBox(height: 20),
              _buildSectionTitle('Action Taken'),
              const SizedBox(height: 12),
              _buildActionTakenSection(),
              const SizedBox(height: 20),
              _buildSectionTitle('Recommendations'),
              const SizedBox(height: 12),
              _buildRecommendationsSection(),
              const SizedBox(height: 30),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.red[700], size: 32),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'GAS SAFETY WARNING/ADVICE NOTICE\nThis notice must be issued when unsafe situations are identified',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.red[700],
      ),
    );
  }

  Widget _buildCustomerDetailsSection() {
    return Column(
      children: [
        TextFormField(
          controller: _customerNameController,
          decoration: InputDecoration(
            labelText: 'Customer Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter customer name';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _addressController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Property Address',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter property address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildApplianceSection() {
    return TextFormField(
      controller: _applianceController,
      decoration: InputDecoration(
        labelText: 'Appliance Type/Location',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter appliance information';
        }
        return null;
      },
    );
  }

  Widget _buildRiskCategorySection() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _selectedRiskCategory,
          decoration: InputDecoration(
            labelText: 'Risk Classification',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: _riskCategories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(
                category,
                style: TextStyle(
                  color: category == 'Immediately Dangerous'
                      ? Colors.red[700]
                      : category == 'At Risk'
                          ? Colors.orange[700]
                          : Colors.yellow[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedRiskCategory = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        if (_selectedRiskCategory == 'Immediately Dangerous')
          _buildImmediateDangerWarning(),
      ],
    );
  }

  Widget _buildImmediateDangerWarning() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.dangerous, color: Colors.red),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'IMMEDIATELY DANGEROUS - Appliance must be disconnected',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CheckboxListTile(
            title: const Text('Turned off and disconnected'),
            value: _turnedOff,
            onChanged: (value) {
              setState(() {
                _turnedOff = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Capped off at meter/isolation valve'),
            value: _cappedOff,
            onChanged: (value) {
              setState(() {
                _cappedOff = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Warning label attached'),
            value: _labelAttached,
            onChanged: (value) {
              setState(() {
                _labelAttached = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );
  }

  Widget _buildDefectsSection() {
    return TextFormField(
      controller: _defectsController,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Details of Defects/Faults',
        hintText: 'Describe all identified defects...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please describe the defects';
        }
        return null;
      },
    );
  }

  Widget _buildActionTakenSection() {
    return TextFormField(
      controller: _actionTakenController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Action Taken',
        hintText: 'Describe actions taken to make safe...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please describe actions taken';
        }
        return null;
      },
    );
  }

  Widget _buildRecommendationsSection() {
    return TextFormField(
      controller: _recommendationsController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Recommendations',
        hintText: 'Recommended remedial work...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _saveWarningNotice,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Save Notice',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _generatePDF,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Generate PDF',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _saveWarningNotice() {
    if (_formKey.currentState!.validate()) {
      // Validate ID actions for Immediately Dangerous
      if (_selectedRiskCategory == 'Immediately Dangerous') {
        if (!_turnedOff || !_labelAttached) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('For ID situations, appliance must be turned off and labeled'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Warning notice saved successfully'),
        ),
      );
    }
  }

  void _generatePDF() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Generating PDF...'),
        ),
      );
      // Navigate to PDF preview
    }
  }
}
