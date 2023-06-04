class FuelServiceUpdateInputModel {
  FuelServiceUpdateInputModel({
    required this.organizationEnrollmentId,
    // required this.organizationId,
    required this.serviceType,
    required this.issuerName,
    required this.firstName,
    required this.lastName,
    required this.panNumber,
    this.gstinNumber,
    required this.email,
    required this.contactNumber,
    this.addressCategory,
    required this.addressLine1,
    required this.addressLine2,
    this.addressLine3,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.dateOfBirth,
    required this.salutationCode,
    required this.kycDocuments,
  });

  final String organizationEnrollmentId;
  // final String organizationId;
  final String serviceType;
  final String issuerName;
  final String firstName;
  final String lastName;
  final String panNumber;
  final String? gstinNumber;
  final String email;
  final String contactNumber;
  final String? addressCategory;
  final String addressLine1;
  final String addressLine2;
  final String? addressLine3;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String? dateOfBirth;
  final String salutationCode;
  final FuelServiceUpdateKycDocuments? kycDocuments;

  factory FuelServiceUpdateInputModel.fromJson(Map<String, dynamic> json) {
    return FuelServiceUpdateInputModel(
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      // organizationId: json["organizationId"] ?? "",
      serviceType: json["serviceType"] ?? "",
      issuerName: json["issuerName"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      panNumber: json["panNumber"] ?? "",
      gstinNumber: json["gstinNumber"] ?? "",
      email: json["email"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      // addressCategory: json["addressCategory"] ?? "",
      addressLine1: json["addressLine1"] ?? "",
      addressLine2: json["addressLine2"] ?? "",
      // addressLine3: json["addressLine3"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      postalCode: json["postalCode"] ?? "",
      country: json["country"] ?? "",
      dateOfBirth: (json["dateOfBirth"] ?? ""),
      salutationCode: json["salutationCode"] ?? "",
      kycDocuments: json["kycDocuments"] == null ? null : FuelServiceUpdateKycDocuments.fromJson(json["kycDocuments"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "organizationEnrollmentId": organizationEnrollmentId,
        // "organizationId": organizationId,
        "serviceType": serviceType,
        "issuerName": issuerName,
        "firstName": firstName,
        "lastName": lastName,
        "panNumber": panNumber,
        if (gstinNumber != null && gstinNumber!.isNotEmpty) "gstinNumber": gstinNumber,
        "email": email,
        "contactNumber": contactNumber,
        // "addressCategory": addressCategory,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        // "addressLine3": addressLine3,
        "city": city,
        "state": state,
        "postalCode": postalCode,
        "country": country,
        "dateOfBirth": dateOfBirth,
        "salutationCode": salutationCode,
        "kycDocuments": kycDocuments?.toJson(),
      };
}

class FuelServiceUpdateKycDocuments {
  FuelServiceUpdateKycDocuments({
    required this.panProof,
    this.gstinProof,
  });

  final UpdateProof? panProof;
  final UpdateProof? gstinProof;

  factory FuelServiceUpdateKycDocuments.fromJson(Map<String, dynamic> json) {
    return FuelServiceUpdateKycDocuments(
      panProof: json["PAN_PROOF"] == null ? null : UpdateProof.fromJson(json["PAN_PROOF"]),
      gstinProof: json["GSTIN_PROOF"] == null ? null : UpdateProof.fromJson(json["GSTIN_PROOF"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "PAN_PROOF": panProof?.toJson(),
        if (gstinProof != null) "GSTIN_PROOF": gstinProof?.toJson(),
      };
}

class UpdateProof {
  UpdateProof({
    required this.url,
  });

  final String url;

  factory UpdateProof.fromJson(Map<String, dynamic> json) {
    return UpdateProof(
      url: json["url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
