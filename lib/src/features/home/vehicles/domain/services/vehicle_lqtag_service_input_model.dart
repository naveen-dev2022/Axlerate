class VehicleLqTagInputModel {
  VehicleLqTagInputModel({
    required this.userEnrollmentId,
    required this.organizationEnrollmentId,
    required this.vehicleRegistrationNumber,
    required this.balanceType,
    required this.fastagInfo,
    required this.kycDocuments,
    required this.registrationDate,
  });

  final String userEnrollmentId;
  final String organizationEnrollmentId;
  final String vehicleRegistrationNumber;
  final String balanceType;
  final FastagInfoLq? fastagInfo;
  final KycDocumentsLqInput? kycDocuments;
  final String? registrationDate;

  factory VehicleLqTagInputModel.fromJson(Map<String, dynamic> json) {
    return VehicleLqTagInputModel(
      userEnrollmentId: json["userEnrollmentId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      vehicleRegistrationNumber: json["vehicleRegistrationNumber"] ?? "",
      balanceType: json["balanceType"] ?? "",
      fastagInfo: json["fastagInfo"] == null ? null : FastagInfoLq.fromJson(json["fastagInfo"]),
      kycDocuments: json["kycDocuments"] == null ? null : KycDocumentsLqInput.fromJson(json["kycDocuments"]),
      registrationDate: json["registrationDate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "userEnrollmentId": userEnrollmentId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "vehicleRegistrationNumber": vehicleRegistrationNumber,
        "balanceType": balanceType,
        "fastagInfo": fastagInfo?.toJson(),
        "kycDocuments": kycDocuments?.toJson(),
        "registrationDate": registrationDate,
      };
}

class FastagInfoLq {
  FastagInfoLq({
    required this.serialNumber,
  });

  final String serialNumber;

  factory FastagInfoLq.fromJson(Map<String, dynamic> json) {
    return FastagInfoLq(
      serialNumber: json["serialNumber"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "serialNumber": serialNumber,
      };
}

class KycDocumentsLqInput {
  KycDocumentsLqInput({
    required this.rcBookImage,
    required this.ownerImage,
  });

  final RcBookImageLqInput? rcBookImage;
  final OwnerImageLqInput? ownerImage;

  factory KycDocumentsLqInput.fromJson(Map<String, dynamic> json) {
    return KycDocumentsLqInput(
      rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : RcBookImageLqInput.fromJson(json["RC_BOOK_IMAGE"]),
      ownerImage: json["OWNER_IMAGE"] == null ? null : OwnerImageLqInput.fromJson(json["OWNER_IMAGE"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "RC_BOOK_IMAGE": rcBookImage?.toJson(),
        "OWNER_IMAGE": ownerImage?.toJson(),
      };
}

class OwnerImageLqInput {
  OwnerImageLqInput({
    required this.url,
  });

  final String url;

  factory OwnerImageLqInput.fromJson(Map<String, dynamic> json) {
    return OwnerImageLqInput(
      url: json["url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class RcBookImageLqInput {
  RcBookImageLqInput({
    required this.documentNo,
    required this.documentExpiry,
    required this.url,
  });

  final String documentNo;
  final String? documentExpiry;
  final String url;

  factory RcBookImageLqInput.fromJson(Map<String, dynamic> json) {
    return RcBookImageLqInput(
      documentNo: json["documentNo"] ?? "",
      documentExpiry: json["documentExpiry"] ?? "",
      url: json["url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "documentNo": documentNo,
        "documentExpiry": documentExpiry,
        "url": url,
      };
}
