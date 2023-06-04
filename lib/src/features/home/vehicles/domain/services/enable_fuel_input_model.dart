class VehicleFuelServiceInputModel {
  VehicleFuelServiceInputModel({
    required this.organizationEnrollmentId,
    required this.vehicleRegistrationNumber,
    required this.kycDocuments,
    required this.issuerName,
    required this.profileId,
    required this.vehicleMake,
    required this.axle,
  });

  final String organizationEnrollmentId;
  final String vehicleRegistrationNumber;
  final KycDocumentsVehicle? kycDocuments;
  final String issuerName;
  final String profileId;
  final String vehicleMake;
  final String axle;

  factory VehicleFuelServiceInputModel.fromJson(Map<String, dynamic> json) {
    return VehicleFuelServiceInputModel(
      organizationEnrollmentId: json["organizationId"] ?? "",
      vehicleRegistrationNumber: json["vehicleRegistrationNumber"] ?? "",
      kycDocuments: json["kycDocuments"] == null ? null : KycDocumentsVehicle.fromJson(json["kycDocuments"]),
      issuerName: json["issuerName"] ?? "",
      profileId: json["profileId"] ?? "",
      vehicleMake: json["vehicleMake"] ?? "",
      axle: json["axle"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "organizationEnrollmentId": organizationEnrollmentId,
        "vehicleRegistrationNumber": vehicleRegistrationNumber,
        "kycDocuments": kycDocuments?.toJson(),
        "issuerName": issuerName,
        "profileId": profileId,
        "vehicleMake": vehicleMake,
        "axle": axle,
      };
}

class KycDocumentsVehicle {
  KycDocumentsVehicle({
    required this.rcBook,
  });

  final RcBook? rcBook;

  factory KycDocumentsVehicle.fromJson(Map<String, dynamic> json) {
    return KycDocumentsVehicle(
      rcBook: json["RC_BOOK"] == null ? null : RcBook.fromJson(json["RC_BOOK"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "RC_BOOK": rcBook?.toJson(),
      };
}

class RcBook {
  RcBook({
    required this.url,
  });

  final String url;

  factory RcBook.fromJson(Map<String, dynamic> json) {
    return RcBook(
      url: json["url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
