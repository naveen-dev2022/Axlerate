class VerifyVehicleKycInputModel {
  VerifyVehicleKycInputModel({
    required this.organizationEnrollmentId,
    required this.kycStatus,
    required this.kycComments,
    required this.issuerName,
  });

  final String organizationEnrollmentId;
  final String kycStatus;
  final String kycComments;
  final String issuerName;

  factory VerifyVehicleKycInputModel.fromJson(Map<String, dynamic> json) {
    return VerifyVehicleKycInputModel(
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      kycStatus: json["kycStatus"] ?? "",
      kycComments: json["kycComments"] ?? "",
      issuerName: json["issuerName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "organizationEnrollmentId": organizationEnrollmentId,
        "kycStatus": kycStatus,
        "kycComments": kycComments,
        "issuerName": issuerName,
      };
}
