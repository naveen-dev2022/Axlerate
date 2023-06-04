class FuelServiceInputModel {
  final String serviceType;
  final String panNumber;
  final String? gstinNumber;
  final String email;
  final String contactNumber;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String? dateOfBirth;
  final String issuerName;
  final String organizationEnrollmentId;
  final KycDocumentsFuel? kycDocuments;

  FuelServiceInputModel({
    required this.serviceType,
    required this.panNumber,
    this.gstinNumber,
    required this.email,
    required this.contactNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.dateOfBirth,
    required this.issuerName,
    required this.organizationEnrollmentId,
    required this.kycDocuments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceType': serviceType,
      'panNumber': panNumber,
      if (gstinNumber != null && gstinNumber!.isNotEmpty) "gstinNumber": gstinNumber,
      'email': email,
      'contactNumber': contactNumber,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateOfBirth': dateOfBirth,
      'issuerName': issuerName,
      'organizationEnrollmentId': organizationEnrollmentId,
      'kycDocuments': kycDocuments?.toMap(),
    };
  }
}

class KycDocumentsFuel {
  KycDocumentsFuel({
    required this.panProof,
    this.gstProof,
  });

  final PanProof panProof;
  final GstProof? gstProof;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PAN_PROOF': panProof.toMap(),
      if (gstProof != null) 'GSTIN_PROOF': gstProof?.toMap(),
    };
  }
}

class PanProof {
  PanProof({
    required this.url,
  });

  final String url;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
    };
  }
}

class GstProof {
  GstProof({
    required this.url,
  });

  final String url;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
    };
  }
}
