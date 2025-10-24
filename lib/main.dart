import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:gas_man_app/src/app.dart';
import 'package:gas_man_app/src/data/models/installation_checklist.dart';
import 'package:gas_man_app/src/data/models/land_lord_certificate.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

// --------------------------- MAIN APP ENTRY -----------------------------
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(LandlordCertificateAdapter());
  await Hive.openBox<LandlordCertificate>('certificates');
  runApp(const GasManApp());
}



