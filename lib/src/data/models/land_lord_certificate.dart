// --------------------------- MODEL CLASS -------------------------------
import 'dart:typed_data';

import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 0)
class LandlordCertificate extends HiveObject {
  @HiveField(0)
  String customerName;
  @HiveField(1)
  String propertyAddress;
  @HiveField(2)
  String applianceDetails;
  @HiveField(3)
  String engineerName;
  @HiveField(4)
  String comments;
  @HiveField(5)
  String date;
  @HiveField(6)
  Uint8List? engineerSignature;
  @HiveField(7)
  Uint8List? customerSignature;

  LandlordCertificate({
    required this.customerName,
    required this.propertyAddress,
    required this.applianceDetails,
    required this.engineerName,
    required this.comments,
    required this.date,
    this.engineerSignature,
    this.customerSignature,
  });
}

// --------------------------- HIVE ADAPTER -------------------------------
class LandlordCertificateAdapter extends TypeAdapter<LandlordCertificate> {
  @override
  final int typeId = 0;

  @override
  LandlordCertificate read(BinaryReader reader) {
    return LandlordCertificate(
      customerName: reader.readString(),
      propertyAddress: reader.readString(),
      applianceDetails: reader.readString(),
      engineerName: reader.readString(),
      comments: reader.readString(),
      date: reader.readString(),
      engineerSignature: reader.read(),
      customerSignature: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, LandlordCertificate obj) {
    writer.writeString(obj.customerName);
    writer.writeString(obj.propertyAddress);
    writer.writeString(obj.applianceDetails);
    writer.writeString(obj.engineerName);
    writer.writeString(obj.comments);
    writer.writeString(obj.date);
    writer.write(obj.engineerSignature);
    writer.write(obj.customerSignature);
  }
}