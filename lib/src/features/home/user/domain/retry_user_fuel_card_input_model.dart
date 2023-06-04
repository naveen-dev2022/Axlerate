class RetryAddFuelServiceToUserInputModel {
  RetryAddFuelServiceToUserInputModel({
    required this.serviceType,
    required this.issuerName,
    required this.organizationEnrollmentId,
    // required this.organizationId,
    required this.userEnrollmentId,
    required this.panNumber,
    // required this.kycDocuments,
  });

  final String serviceType;
  final String issuerName;
  final String organizationEnrollmentId;
  // final String organizationId;
  final String userEnrollmentId;
  final String panNumber;
  // final RetryAddFuelServiceToUserKycDocuments? kycDocuments;

  factory RetryAddFuelServiceToUserInputModel.fromJson(Map<String, dynamic> json) {
    return RetryAddFuelServiceToUserInputModel(
      serviceType: json["serviceType"] ?? "",
      issuerName: json["issuerName"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      // organizationId: json["organizationId"] ?? "",
      userEnrollmentId: json["userEnrollmentId"] ?? "",
      panNumber: json["panNumber"] ?? "",
      // kycDocuments:
      //     json["kycDocuments"] == null ? null : RetryAddFuelServiceToUserKycDocuments.fromJson(json["kycDocuments"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "serviceType": serviceType,
        "issuerName": issuerName,
        "organizationEnrollmentId": organizationEnrollmentId,
        // "organizationId": organizationId,
        "userEnrollmentId": userEnrollmentId,
        "panNumber": panNumber,
        // "kycDocuments": kycDocuments?.toJson(),
      };
}

// class RetryAddFuelServiceToUserKycDocuments {
//   RetryAddFuelServiceToUserKycDocuments({
//     required this.panProof,
//   });

//   final RetryAddFuelServiceToUserPanProof? panProof;

//   factory RetryAddFuelServiceToUserKycDocuments.fromJson(Map<String, dynamic> json) {
//     return RetryAddFuelServiceToUserKycDocuments(
//       panProof: json["PAN_PROOF"] == null ? null : RetryAddFuelServiceToUserPanProof.fromJson(json["PAN_PROOF"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "PAN_PROOF": panProof?.toJson(),
//       };
// }

// class RetryAddFuelServiceToUserPanProof {
//   RetryAddFuelServiceToUserPanProof({
//     required this.url,
//   });

//   final String url;

//   factory RetryAddFuelServiceToUserPanProof.fromJson(Map<String, dynamic> json) {
//     return RetryAddFuelServiceToUserPanProof(
//       url: json["url"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "url": url,
//       };
// }
