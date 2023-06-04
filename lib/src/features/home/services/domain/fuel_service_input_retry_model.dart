class FuelServiceRetryInputModel {
  FuelServiceRetryInputModel({
    required this.serviceType,
    required this.issuerName,
    required this.organizationEnrollmentId,
    // required this.organizationId,
    required this.panNumber,
    required this.contactNumber,
    required this.kycDocuments,
  });

  final String serviceType;
  final String issuerName;
  final String organizationEnrollmentId;
  // final String organizationId;
  final String panNumber;
  final String contactNumber;
  final RetryFuelKycDocuments? kycDocuments;

  factory FuelServiceRetryInputModel.fromJson(Map<String, dynamic> json) {
    return FuelServiceRetryInputModel(
      serviceType: json["serviceType"] ?? "",
      issuerName: json["issuerName"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      // organizationId: json["organizationId"] ?? "",
      panNumber: json["panNumber"] ?? "",
      contactNumber: json["contactNumber"] ?? '',
      kycDocuments: json["kycDocuments"] == null ? null : RetryFuelKycDocuments.fromJson(json["kycDocuments"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "serviceType": serviceType,
        "issuerName": issuerName,
        "organizationEnrollmentId": organizationEnrollmentId,
        // "organizationId": organizationId,
        "panNumber": panNumber,
        "contactNumber": contactNumber,
        "kycDocuments": kycDocuments?.toJson(),
      };
}

class RetryFuelKycDocuments {
  RetryFuelKycDocuments({
    required this.panProof,
    this.gstinProof,
  });

  final RetryProof? panProof;
  final RetryProof? gstinProof;

  factory RetryFuelKycDocuments.fromJson(Map<String, dynamic> json) {
    return RetryFuelKycDocuments(
      panProof: json["PAN_PROOF"] == null ? null : RetryProof.fromJson(json["PAN_PROOF"]),
      gstinProof: json["GSTIN_PROOF"] == null ? null : RetryProof.fromJson(json["GSTIN_PROOF"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "PAN_PROOF": panProof?.toJson(),
        if (gstinProof != null && gstinProof!.url.isNotEmpty) "GSTIN_PROOF": gstinProof?.toJson(),
      };
}

class RetryProof {
  RetryProof({
    required this.url,
  });

  final String url;

  factory RetryProof.fromJson(Map<String, dynamic> json) {
    return RetryProof(
      url: json["url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
