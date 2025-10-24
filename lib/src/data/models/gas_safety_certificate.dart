class GasSafetyCertificate {
  final String id;
  final String customerName;
  final String address;
  final String engineerName;
  final String engineerGasSafeNumber;
  final DateTime inspectionDate;
  final DateTime nextInspectionDate;
  final List<ApplianceCheck> applianceChecks;
  final String? additionalNotes;
  final String? customerSignature;
  final String? engineerSignature;
  final CertificateType certificateType;

  GasSafetyCertificate({
    required this.id,
    required this.customerName,
    required this.address,
    required this.engineerName,
    required this.engineerGasSafeNumber,
    required this.inspectionDate,
    required this.nextInspectionDate,
    required this.applianceChecks,
    this.additionalNotes,
    this.customerSignature,
    this.engineerSignature,
    required this.certificateType,
  });

  GasSafetyCertificate copyWith({
    String? id,
    String? customerName,
    String? address,
    String? engineerName,
    String? engineerGasSafeNumber,
    DateTime? inspectionDate,
    DateTime? nextInspectionDate,
    List<ApplianceCheck>? applianceChecks,
    String? additionalNotes,
    String? customerSignature,
    String? engineerSignature,
    CertificateType? certificateType,
  }) {
    return GasSafetyCertificate(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      engineerName: engineerName ?? this.engineerName,
      engineerGasSafeNumber: engineerGasSafeNumber ?? this.engineerGasSafeNumber,
      inspectionDate: inspectionDate ?? this.inspectionDate,
      nextInspectionDate: nextInspectionDate ?? this.nextInspectionDate,
      applianceChecks: applianceChecks ?? this.applianceChecks,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      customerSignature: customerSignature ?? this.customerSignature,
      engineerSignature: engineerSignature ?? this.engineerSignature,
      certificateType: certificateType ?? this.certificateType,
    );
  }
}

class ApplianceCheck {
  final String applianceType;
  final String make;
  final String model;
  final String location;
  final String flueType;
  final bool operatingPressureOk;
  final bool safetyDevicesOk;
  final bool ventilationOk;
  final bool visualInspectionOk;
  final bool flueFlowTestOk;
  final bool spillageTestOk;
  final ApplianceStatus status;
  final String? defects;
  final String? remedialAction;

  ApplianceCheck({
    required this.applianceType,
    required this.make,
    required this.model,
    required this.location,
    required this.flueType,
    required this.operatingPressureOk,
    required this.safetyDevicesOk,
    required this.ventilationOk,
    required this.visualInspectionOk,
    required this.flueFlowTestOk,
    required this.spillageTestOk,
    required this.status,
    this.defects,
    this.remedialAction,
  });
}

enum ApplianceStatus {
  safe,
  atRisk,
  immediatelyDangerous,
  notToCurrentStandards,
}

enum CertificateType {
  landlord,
  homeowner,
  serviceRecord,
  breakdown,
}
