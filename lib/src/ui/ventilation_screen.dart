import 'package:flutter/material.dart';
import 'package:gas_man_app/src/theme/app_colors.dart';

class VentilationScreen extends StatefulWidget {
  const VentilationScreen({super.key});

  @override
  State<VentilationScreen> createState() => _VentilationScreenState();
}

class _VentilationScreenState extends State<VentilationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Room dimensions controllers
  final TextEditingController _roomLengthController = TextEditingController();
  final TextEditingController _roomWidthController = TextEditingController();
  final TextEditingController _roomHeightController = TextEditingController();
  
  // Appliance controllers
  final TextEditingController _applianceTypeController = TextEditingController();
  final TextEditingController _applianceRatingController = TextEditingController();
  
  // Calculation results
  double? _roomVolume;
  double? _requiredVentilation;
  String? _ventilationType;
  
  String _selectedUnit = 'meters';
  String _selectedApplianceType = 'Boiler';
  
  final List<String> _applianceTypes = [
    'Boiler',
    'Water Heater',
    'Gas Fire',
    'Cooker',
    'Tumble Dryer',
  ];

  @override
  void dispose() {
    _roomLengthController.dispose();
    _roomWidthController.dispose();
    _roomHeightController.dispose();
    _applianceTypeController.dispose();
    _applianceRatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Room Dimensions'),
              const SizedBox(height: 12),
              _buildUnitSelector(),
              const SizedBox(height: 12),
              _buildDimensionInputs(),
              const SizedBox(height: 24),
              _buildSectionTitle('Appliance Details'),
              const SizedBox(height: 12),
              _buildApplianceInputs(),
              const SizedBox(height: 24),
              _buildCalculateButton(),
              if (_roomVolume != null) ...[
                const SizedBox(height: 24),
                _buildResultsSection(),
              ],
              const SizedBox(height: 24),
              _buildReferenceCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }

  Widget _buildUnitSelector() {
    return Row(
      children: [
        const Text('Unit: '),
        const SizedBox(width: 12),
        ChoiceChip(
          label: const Text('Meters'),
          selected: _selectedUnit == 'meters',
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _selectedUnit = 'meters';
              });
            }
          },
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text('Feet'),
          selected: _selectedUnit == 'feet',
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _selectedUnit = 'feet';
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildDimensionInputs() {
    final unit = _selectedUnit == 'meters' ? 'm' : 'ft';
    
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _roomLengthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Length ($unit)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (double.tryParse(value) == null) {
                return 'Invalid';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: _roomWidthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Width ($unit)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (double.tryParse(value) == null) {
                return 'Invalid';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: _roomHeightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Height ($unit)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (double.tryParse(value) == null) {
                return 'Invalid';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildApplianceInputs() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _selectedApplianceType,
          decoration: InputDecoration(
            labelText: 'Appliance Type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: _applianceTypes.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedApplianceType = value!;
            });
          },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _applianceRatingController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Heat Input (kW)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter heat input';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCalculateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _calculate,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Calculate Ventilation Requirements',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Calculation Results',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 12),
          _buildResultRow('Room Volume', '${_roomVolume!.toStringAsFixed(2)} m³'),
          _buildResultRow('Required Ventilation', '${_requiredVentilation!.toStringAsFixed(0)} cm²'),
          _buildResultRow('Ventilation Type', _ventilationType!),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _buildRecommendations(),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommendations:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (_requiredVentilation! > 0) ...[
          const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text('Install permanent ventilation grilles'),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text('Ensure adequate air circulation'),
              ),
            ],
          ),
        ] else ...[
          const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text('Room volume adequate for appliance'),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildReferenceCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Ventilation Standards',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildStandardItem('Room volume < 5m³', 'Not permitted'),
            _buildStandardItem('5m³ - 10m³', '100cm² permanent ventilation'),
            _buildStandardItem('10m³ - 20m³', '50cm² permanent ventilation'),
            _buildStandardItem('> 20m³', 'May not require additional ventilation'),
            const SizedBox(height: 8),
            const Text(
              'Note: Always consult BS 5440 and manufacturer guidelines',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardItem(String condition, String requirement) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: '$condition: ',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextSpan(text: requirement),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // Parse input values
        double length = double.parse(_roomLengthController.text);
        double width = double.parse(_roomWidthController.text);
        double height = double.parse(_roomHeightController.text);
        double heatInput = double.parse(_applianceRatingController.text);
        
        // Convert to meters if needed
        if (_selectedUnit == 'feet') {
          length = length * 0.3048;
          width = width * 0.3048;
          height = height * 0.3048;
        }
        
        // Calculate room volume
        _roomVolume = length * width * height;
        
        // Calculate required ventilation based on room volume and heat input
        if (_roomVolume! < 5) {
          _requiredVentilation = 200.0;
          _ventilationType = 'High-level and low-level ventilation required';
        } else if (_roomVolume! < 10) {
          _requiredVentilation = 100.0 + (heatInput > 7 ? (heatInput - 7) * 5 : 0);
          _ventilationType = 'Permanent ventilation required';
        } else if (_roomVolume! < 20) {
          _requiredVentilation = 50.0 + (heatInput > 7 ? (heatInput - 7) * 2.5 : 0);
          _ventilationType = 'Permanent ventilation recommended';
        } else {
          _requiredVentilation = heatInput > 7 ? (heatInput - 7) * 2.5 : 0;
          _ventilationType = _requiredVentilation! > 0 
              ? 'Additional ventilation recommended'
              : 'Adequate natural ventilation';
        }
      });
    }
  }
}
