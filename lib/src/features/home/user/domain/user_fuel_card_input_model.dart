class AddFuelServiceToUserInputModel {
  AddFuelServiceToUserInputModel({
    // required this.organizationId,
    required this.organizationEnrollmentId,
    // required this.organizationEntityId,
    required this.serviceType,
    // required this.userId,
    required this.userEnrollmentId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.salutationCode,
    required this.addressCategory,
    required this.addressLine1,
    required this.addressLine2,
    // required this.addressLine3,
    required this.city,
    required this.country,
    required this.state,
    required this.postalCode,
    required this.contactNumber,
    required this.email,
    required this.panNumber,
    // required this.kycDocuments,
  });

  // final String organizationId;
  final String organizationEnrollmentId;
  // final String organizationEntityId;
  final String serviceType;
  // final String userId;
  final String userEnrollmentId;
  final String firstName;
  final String lastName;
  final String? dateOfBirth;
  final String salutationCode;
  final String addressCategory;
  final String addressLine1;
  final String addressLine2;
  // final String addressLine3;
  final String city;
  final String country;
  final String state;
  final String postalCode;
  final String contactNumber;
  final String email;
  final String panNumber;
  // final AddFuelServiceToUserKycDocuments? kycDocuments;

  factory AddFuelServiceToUserInputModel.fromJson(Map<String, dynamic> json) {
    return AddFuelServiceToUserInputModel(
      // organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      // organizationEntityId: json["organizationEntityId"] ?? "",
      serviceType: json["serviceType"] ?? "",
      // userId: json["userId"] ?? "",
      userEnrollmentId: json["userEnrollmentId"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      dateOfBirth: json["dateOfBirth"] ?? "",
      salutationCode: json["salutationCode"] ?? "",
      addressCategory: json["addressCategory"] ?? "",
      addressLine1: json["addressLine1"] ?? "",
      addressLine2: json["addressLine2"] ?? "",
      // addressLine3: json["addressLine3"] ?? "",
      city: json["city"] ?? "",
      country: json["country"] ?? "",
      state: json["state"] ?? "",
      postalCode: json["postalCode"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      email: json["email"] ?? "",
      panNumber: json["panNumber"] ?? "",
      // kycDocuments:
      //     json["kycDocuments"] == null ? null : AddFuelServiceToUserKycDocuments.fromJson(json["kycDocuments"]),
    );
  }

  Map<String, dynamic> toJson() => {
        // "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        // "organizationEntityId": organizationEntityId,
        "serviceType": serviceType,
        // "userId": userId,
        "userEnrollmentId": userEnrollmentId,
        "firstName": firstName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "salutationCode": salutationCode,
        "addressCategory": addressCategory,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        // "addressLine3": addressLine3,
        "city": city,
        "country": country,
        "state": state,
        "postalCode": postalCode,
        "contactNumber": contactNumber,
        "email": email,
        "panNumber": panNumber,
        // "kycDocuments": kycDocuments?.toJson(),
      };
}

// class AddFuelServiceToUserKycDocuments {
//   AddFuelServiceToUserKycDocuments({
//     required this.panProof,
//   });

//   final AddFuelServiceToUser? panProof;

//   factory AddFuelServiceToUserKycDocuments.fromJson(Map<String, dynamic> json) {
//     return AddFuelServiceToUserKycDocuments(
//       panProof: json["PAN_PROOF"] == null ? null : AddFuelServiceToUser.fromJson(json["PAN_PROOF"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "PAN_PROOF": panProof?.toJson(),
//       };
// }

// class AddFuelServiceToUser {
//   AddFuelServiceToUser({
//     required this.url,
//   });

//   final String url;

//   factory AddFuelServiceToUser.fromJson(Map<String, dynamic> json) {
//     return AddFuelServiceToUser(
//       url: json["url"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "url": url,
//       };
// }
