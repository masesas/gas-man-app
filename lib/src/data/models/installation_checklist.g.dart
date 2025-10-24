// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installation_checklist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InstallationChecklistAdapter extends TypeAdapter<InstallationChecklist> {
  @override
  final int typeId = 0;

  @override
  InstallationChecklist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InstallationChecklist(
      type: fields[0] as String,
      make: fields[1] as String,
      model: fields[2] as String,
      location: fields[3] as String,
      serialNumber: fields[4] as String?,
      gcNumber: fields[5] as String?,
      heatInput: fields[6] as String?,
      runningTemp: fields[7] as String?,
      gasRate: fields[8] as String?,
      meterPressure: fields[9] as String?,
      appliancePressure: fields[10] as String?,
      coHigh: fields[11] as String?,
      co2High: fields[12] as String?,
      combustionHighRatio: fields[13] as String?,
      coLow: fields[14] as String?,
      co2Low: fields[15] as String?,
      combustionLowRatio: fields[16] as String?,
      engineerComments: fields[17] as String?,
      createdAt: fields[18] as DateTime,
      completedAt: fields[19] as DateTime?,
      safetyDevicesOk: fields[20] as bool?,
      ventilationOk: fields[21] as bool?,
      gasTightnessOk: fields[22] as bool?,
      earthBondingOk: fields[23] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, InstallationChecklist obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.make)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.serialNumber)
      ..writeByte(5)
      ..write(obj.gcNumber)
      ..writeByte(6)
      ..write(obj.heatInput)
      ..writeByte(7)
      ..write(obj.runningTemp)
      ..writeByte(8)
      ..write(obj.gasRate)
      ..writeByte(9)
      ..write(obj.meterPressure)
      ..writeByte(10)
      ..write(obj.appliancePressure)
      ..writeByte(11)
      ..write(obj.coHigh)
      ..writeByte(12)
      ..write(obj.co2High)
      ..writeByte(13)
      ..write(obj.combustionHighRatio)
      ..writeByte(14)
      ..write(obj.coLow)
      ..writeByte(15)
      ..write(obj.co2Low)
      ..writeByte(16)
      ..write(obj.combustionLowRatio)
      ..writeByte(17)
      ..write(obj.engineerComments)
      ..writeByte(18)
      ..write(obj.createdAt)
      ..writeByte(19)
      ..write(obj.completedAt)
      ..writeByte(20)
      ..write(obj.safetyDevicesOk)
      ..writeByte(21)
      ..write(obj.ventilationOk)
      ..writeByte(22)
      ..write(obj.gasTightnessOk)
      ..writeByte(23)
      ..write(obj.earthBondingOk);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstallationChecklistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
