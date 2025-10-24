import 'package:hive_flutter/hive_flutter.dart';

part 'installation_checklist.g.dart';

@HiveType(typeId: 0)
class InstallationChecklist extends HiveObject {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String make;

  @HiveField(2)
  final String model;

  @HiveField(3)
  final String location;

  @HiveField(4)
  final String? serialNumber;

  @HiveField(5)
  final String? gcNumber;

  @HiveField(6)
  final String? heatInput;

  @HiveField(7)
  final String? runningTemp;

  @HiveField(8)
  final String? gasRate;

  @HiveField(9)
  final String? meterPressure;

  @HiveField(10)
  final String? appliancePressure;

  @HiveField(11)
  final String? coHigh;

  @HiveField(12)
  final String? co2High;

  @HiveField(13)
  final String? combustionHighRatio;

  @HiveField(14)
  final String? coLow;

  @HiveField(15)
  final String? co2Low;

  @HiveField(16)
  final String? combustionLowRatio;

  @HiveField(17)
  final String? engineerComments;

  @HiveField(18)
  final DateTime createdAt;

  @HiveField(19)
  final DateTime? completedAt;

  @HiveField(20)
  final bool? safetyDevicesOk;

  @HiveField(21)
  final bool? ventilationOk;

  @HiveField(22)
  final bool? gasTightnessOk;

  @HiveField(23)
  final bool? earthBondingOk;

  InstallationChecklist({
    required this.type,
    required this.make,
    required this.model,
    required this.location,
    this.serialNumber,
    this.gcNumber,
    this.heatInput,
    this.runningTemp,
    this.gasRate,
    this.meterPressure,
    this.appliancePressure,
    this.coHigh,
    this.co2High,
    this.combustionHighRatio,
    this.coLow,
    this.co2Low,
    this.combustionLowRatio,
    this.engineerComments,
    DateTime? createdAt,
    this.completedAt,
    this.safetyDevicesOk,
    this.ventilationOk,
    this.gasTightnessOk,
    this.earthBondingOk,
  }) : createdAt = createdAt ?? DateTime.now();

  InstallationChecklist copyWith({
    String? type,
    String? make,
    String? model,
    String? location,
    String? serialNumber,
    String? gcNumber,
    String? heatInput,
    String? runningTemp,
    String? gasRate,
    String? meterPressure,
    String? appliancePressure,
    String? coHigh,
    String? co2High,
    String? combustionHighRatio,
    String? coLow,
    String? co2Low,
    String? combustionLowRatio,
    String? engineerComments,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? safetyDevicesOk,
    bool? ventilationOk,
    bool? gasTightnessOk,
    bool? earthBondingOk,
  }) {
    return InstallationChecklist(
      type: type ?? this.type,
      make: make ?? this.make,
      model: model ?? this.model,
      location: location ?? this.location,
      serialNumber: serialNumber ?? this.serialNumber,
      gcNumber: gcNumber ?? this.gcNumber,
      heatInput: heatInput ?? this.heatInput,
      runningTemp: runningTemp ?? this.runningTemp,
      gasRate: gasRate ?? this.gasRate,
      meterPressure: meterPressure ?? this.meterPressure,
      appliancePressure: appliancePressure ?? this.appliancePressure,
      coHigh: coHigh ?? this.coHigh,
      co2High: co2High ?? this.co2High,
      combustionHighRatio: combustionHighRatio ?? this.combustionHighRatio,
      coLow: coLow ?? this.coLow,
      co2Low: co2Low ?? this.co2Low,
      combustionLowRatio: combustionLowRatio ?? this.combustionLowRatio,
      engineerComments: engineerComments ?? this.engineerComments,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      safetyDevicesOk: safetyDevicesOk ?? this.safetyDevicesOk,
      ventilationOk: ventilationOk ?? this.ventilationOk,
      gasTightnessOk: gasTightnessOk ?? this.gasTightnessOk,
      earthBondingOk: earthBondingOk ?? this.earthBondingOk,
    );
  }
}
