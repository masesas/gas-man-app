import 'package:flutter/material.dart';
import 'package:gas_man_app/src/ui/installation_checklist_pdf.dart';
import 'package:printing/printing.dart';
import 'package:signature/signature.dart';

class InstallationCommissioningChecklistPage extends StatefulWidget {
  const InstallationCommissioningChecklistPage({super.key});
  
  @override
  State<InstallationCommissioningChecklistPage> createState() =>
      InstallationCommissioningChecklistPageState();
}

class InstallationCommissioningChecklistPageState
    extends State<InstallationCommissioningChecklistPage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final typeController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final locationController = TextEditingController();
  final serialController = TextEditingController();
  final gcnController = TextEditingController();
  final notesController = TextEditingController();
  final combustionHighRatio = TextEditingController();
  final combustionLowRatio = TextEditingController();
  final coHigh = TextEditingController();
  final coLow = TextEditingController();
  final co2High = TextEditingController();
  final co2Low = TextEditingController();
  final heatInput = TextEditingController();
  final runTemp = TextEditingController();
  final gasRate = TextEditingController();
  final meterPressure = TextEditingController();
  final appliancePressure = TextEditingController();
  final engineerComments = TextEditingController();

  bool? landlordAppliance = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Installation / Commissioning Checklist"),
        backgroundColor: const Color(0xFF006D6F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("Appliance Details"),
              buildTextField("Type", typeController),
              buildTextField("Make", makeController),
              buildTextField("Model", modelController),
              buildTextField("Location", locationController),
              buildTextField("Serial No", serialController),
              buildTextField("GC Number", gcnController),
              const SizedBox(height: 10),
              sectionTitle("Safety Checks"),
              buildTextField("Heat Input (kW/h)", heatInput),
              buildTextField("Running Set Point Temp (°C)", runTemp),
              buildYesNoNA("Safety device(s) correct operation"),
              buildYesNoNA("Ventilation as per manufacturer recommendation"),
              const SizedBox(height: 10),
              sectionTitle("Gas Checks"),
              buildTextField("Gas Rate (m³/h)", gasRate),
              buildYesNoNA("Gas Tightness Satisfactory"),
              buildYesNoNA("Equipotential earth bonding"),
              buildTextField(
                "Standing pressure at meter (mbar)",
                meterPressure,
              ),
              buildTextField(
                "Standing pressure at appliance inlet (mbar)",
                appliancePressure,
              ),
              const SizedBox(height: 10),
              sectionTitle("Combustion Readings"),
              buildTextField("High CO (ppm)", coHigh),
              buildTextField("High CO₂ (%)", co2High),
              buildTextField("High CO/CO₂ Ratio", combustionHighRatio),
              buildTextField("Low CO (ppm)", coLow),
              buildTextField("Low CO₂ (%)", co2Low),
              buildTextField("Low CO/CO₂ Ratio", combustionLowRatio),
              const SizedBox(height: 10),
              sectionTitle("Engineer Comments"),
              buildTextField("Comments", engineerComments, maxLines: 5),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton("Home", Colors.teal, () {}),
                  buildButton("Save", Colors.green, () {}),
                  buildButton("Next", Colors.amber, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PDFPreviewPage()),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget buildYesNoNA(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        Row(
          children: [
            buildRadioOption("Yes"),
            buildRadioOption("No"),
            buildRadioOption("N/A"),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget buildRadioOption(String text) {
    return Expanded(
      child: Row(
        children: [
          Radio(value: text, groupValue: "", onChanged: (_) {}),
          Text(text),
        ],
      ),
    );
  }

  Widget buildButton(String label, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// PDF PREVIEW PAGE (before signature)
class PDFPreviewPage extends StatelessWidget {
  const PDFPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Preview"), backgroundColor: Colors.teal),
      body: PdfPreview(
        build: (format) => InstallationChecklistPDF.generate(
          type: "Boiler",
          make: "Baxi",
          model: "100 HE",
          location: "Airing Cupboard",
          serial: "BCP051100298ZX",
          gcn: "41-116-06",
          heatInput: "24",
          runTemp: "70",
          gasRate: "2.1",
          comments: "All safety checks satisfactory.",
        ),
        canChangePageFormat: false,
        canChangeOrientation: false,
        pdfFileName: "Installation_Checklist.pdf",
      ),
    );
  }
}

// SIGNATURE PAGE (after PDF)
class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});
  
  @override
  State<SignaturePage> createState() => SignaturePageState();
}

class SignaturePageState extends State<SignaturePage> {
  final SignatureController _controller = SignatureController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Customer Signature"), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Date of Issue"),
            ),
            TextFormField(
              decoration:
              const InputDecoration(labelText: "Next Service Due Date"),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Customer Name"),
            ),
            const SizedBox(height: 20),
            const Text("Customer Signature",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              height: 150,
              child: Signature(
                controller: _controller,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                buildButton("Home", Colors.teal, () {}),
                buildButton("Save", Colors.green, () {}),
                buildButton("Approve", Colors.amber, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String label, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 14)),
          onPressed: onPressed,
          child: Text(label,
              style: const TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }
}
