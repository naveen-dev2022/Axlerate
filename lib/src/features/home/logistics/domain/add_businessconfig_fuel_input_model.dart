class AddBusinessConfigWithFuelInputModel {
  AddBusinessConfigWithFuelInputModel({
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.kycStatus,
    required this.kycComments,
  });

  final String organizationId;
  final String organizationEnrollmentId;
  final String kycStatus;
  final String kycComments;

  factory AddBusinessConfigWithFuelInputModel.fromJson(Map<String, dynamic> json) {
    return AddBusinessConfigWithFuelInputModel(
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      kycStatus: json["kycStatus"] ?? "",
      kycComments: json["kycComments"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "kycStatus": kycStatus,
        "kycComments": kycComments,
      };
}
