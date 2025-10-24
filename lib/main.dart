import 'package:flutter/material.dart';
import 'package:gas_man_app/src/app.dart';
import 'package:gas_man_app/src/data/models/installation_checklist.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(InstallationChecklistAdapter());
  await Hive.openBox<InstallationChecklist>('checklists');
  runApp(const GasManApp());
}

