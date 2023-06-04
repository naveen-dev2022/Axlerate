class VerifyOrgKycInputModel {
  VerifyOrgKycInputModel({
    // required this.organizationId,
    required this.organizationEnrollmentId,
    required this.kycStatus,
    required this.kycComments,
  });

  // final String organizationId;
  final String organizationEnrollmentId;
  final String kycStatus;
  final String kycComments;

  factory VerifyOrgKycInputModel.fromJson(Map<String, dynamic> json) {
    return VerifyOrgKycInputModel(
      // organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      kycStatus: json["kycStatus"] ?? "",
      kycComments: json["kycComments"] ?? "",
    );
  }

  Map<String, dynamic> toMap() => {
        // "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "kycStatus": kycStatus,
        "kycComments": kycComments,
      };
}
