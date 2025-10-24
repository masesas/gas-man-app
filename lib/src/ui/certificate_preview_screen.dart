import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'gas_certificate_flow_screen.dart';

class CertificatePreviewPage extends StatelessWidget {
  const CertificatePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Safety Certificate Preview'),
        backgroundColor: kTeal,
      ),
      body: PdfPreview(
        build: (format) => _generateCertificatePdf(format),
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        pdfFileName: 'gas_safety_certificate.pdf',
      ),
    );
  }
}

Future<Uint8List> _generateCertificatePdf(final PdfPageFormat format) async {
  final pdf = pw.Document();

  final titleStyle = pw.TextStyle(
    color: PdfColor.fromHex('#00796B'),
    fontSize: 18,
    fontWeight: pw.FontWeight.bold,
  );

  final headerStyle = pw.TextStyle(
    color: PdfColor.fromHex('#00796B'),
    fontSize: 12,
    fontWeight: pw.FontWeight.bold,
  );

  final cellStyle = pw.TextStyle(fontSize: 11);

  pdf.addPage(
    pw.MultiPage(
      pageFormat: format,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) => [
        pw.Center(child: pw.Text('GAS SAFETY CERTIFICATE', style: titleStyle)),
        pw.SizedBox(height: 12),
        pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColor.fromHex('#00796B')),
          ),
          padding: const pw.EdgeInsets.all(8),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Engineer Information', style: headerStyle),
              pw.SizedBox(height: 4),
              pw.Text('Engineer: John Example', style: cellStyle),
              pw.Text('Company: The Gas Man App Ltd', style: cellStyle),
              pw.Text('Gas Safe Reg: 1234567', style: cellStyle),
              pw.SizedBox(height: 8),
              pw.Text('Customer Information', style: headerStyle),
              pw.SizedBox(height: 4),
              pw.Text('Customer: Mr John Smith', style: cellStyle),
              pw.Text(
                'Address: 10 Example Street, Example Town, EX1 1EX',
                style: cellStyle,
              ),
              pw.SizedBox(height: 8),
              pw.Text('Appliance Details', style: headerStyle),
              pw.SizedBox(height: 4),
              pw.Table.fromTextArray(
                headers: ['Type', 'Make / Model', 'Flue Type', 'Safe?'],
                data: [
                  ['Boiler', 'Vaillant EcoTec', 'Balanced', 'Yes'],
                  ['Hob', 'Bosch 600', 'N/A', 'Yes'],
                ],
                headerStyle: pw.TextStyle(
                  color: PdfColor.fromHex('#FFFFFF'),
                  fontWeight: pw.FontWeight.bold,
                ),
                headerDecoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#00796B'),
                ),
                cellStyle: cellStyle,
                border: pw.TableBorder.all(color: PdfColor.fromHex('#CCCCCC')),
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerLeft,
                  3: pw.Alignment.center,
                },
              ),
              pw.SizedBox(height: 8),
              pw.Text('Safety Checks Summary', style: headerStyle),
              pw.Bullet(text: 'Tightness Test Passed'),
              pw.Bullet(text: 'Ventilation Adequate'),
              pw.Bullet(text: 'Flue Check Passed'),
              pw.Bullet(text: 'Appliance Safe to Use'),
              pw.SizedBox(height: 8),
              pw.Text('Engineer Notes', style: headerStyle),
              pw.Text('All appliances tested and found safe to use.'),
              pw.SizedBox(height: 12),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Engineer Signature:', style: headerStyle),
                      pw.SizedBox(height: 24),
                      pw.Text('___________'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Customer Signature:', style: headerStyle),
                      pw.SizedBox(height: 24),
                      pw.Text('___________'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Center(
                child: pw.Text(
                  'Generated by The Gas Man App',
                  style: pw.TextStyle(
                    color: PdfColor.fromHex('#FFB300'),
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  return pdf.save();
}
