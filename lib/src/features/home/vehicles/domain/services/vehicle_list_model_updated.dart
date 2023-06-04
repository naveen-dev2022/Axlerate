class ListVehicleUpdatedModel {
  ListVehicleUpdatedModel({
    required this.data,
  });

  final Data? data;
  const ListVehicleUpdatedModel.unknown() : data = null;

  factory ListVehicleUpdatedModel.fromJson(Map<String, dynamic> json) {
    return ListVehicleUpdatedModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.message,
  });

  final Message? message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  Message({
    required this.docs,
    required this.count,
  });

  final List<VehicleDoc> docs;
  final int count;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      docs: json["docs"] == null ? [] : List<VehicleDoc>.from(json["docs"]!.map((x) => VehicleDoc.fromJson(x))),
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "docs": docs.map((x) => x.toJson()).toList(),
        "count": count,
      };
}

class VehicleDoc {
  VehicleDoc({
    required this.id,
    required this.enrollmentId,
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.status,
    required this.registrationNumber,
    required this.registrationDate,
    required this.engineNumber,
    required this.chasisNumber,
    required this.fuelType,
    required this.insuranceExpiryDate,
    required this.fitnessUpto,
    required this.vehicleType,
    required this.vehicleCategory,
    required this.createdBy,
    required this.updatedBy,
    required this.createdByOrg,
    required this.updatedByOrg,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.organizationEntityId,
    required this.vehicleServices,
    required this.organizationDetails,
    required this.accountInformation,
    required this.lqtagaccountinformation,
  });

  final String id;
  final String enrollmentId;
  final String organizationId;
  final String organizationEnrollmentId;
  final String status;
  final String registrationNumber;
  final DateTime? registrationDate;
  final String engineNumber;
  final String chasisNumber;
  final String fuelType;
  final DateTime? insuranceExpiryDate;
  final DateTime? fitnessUpto;
  final VehicleType? vehicleType;
  final String vehicleCategory;
  final String createdBy;
  final String updatedBy;
  final String createdByOrg;
  final String updatedByOrg;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final String organizationEntityId;
  final List<VehicleService> vehicleServices;
  final OrganizationDetails? organizationDetails;
  final AccountInformation? accountInformation;
  final Lqtagaccountinformation? lqtagaccountinformation;

  factory VehicleDoc.fromJson(Map<String, dynamic> json) {
    return VehicleDoc(
      id: json["_id"] ?? "",
      enrollmentId: json["enrollmentId"] ?? "",
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      status: json["status"] ?? "",
      registrationNumber: json["registrationNumber"] ?? "",
      registrationDate: DateTime.tryParse(json["registrationDate"] ?? ""),
      engineNumber: json["engineNumber"] ?? "",
      chasisNumber: json["chasisNumber"] ?? "",
      fuelType: json["fuelType"] ?? "",
      insuranceExpiryDate: DateTime.tryParse(json["insuranceExpiryDate"] ?? ""),
      fitnessUpto: DateTime.tryParse(json["fitnessUpto"] ?? ""),
      vehicleType: json["vehicleType"] == null ? null : VehicleType.fromJson(json["vehicleType"]),
      vehicleCategory: json["vehicleCategory"] ?? "",
      createdBy: json["createdBy"] ?? "",
      updatedBy: json["updatedBy"] ?? "",
      createdByOrg: json["createdByOrg"] ?? "",
      updatedByOrg: json["updatedByOrg"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
      organizationEntityId: json["organizationEntityId"] ?? "",
      vehicleServices: json["vehicleServices"] == null
          ? []
          : List<VehicleService>.from(json["vehicleServices"]!.map((x) => VehicleService.fromJson(x))),
      organizationDetails:
          json["organizationDetails"] == null ? null : OrganizationDetails.fromJson(json["organizationDetails"]),
      lqtagaccountinformation: json["lqtagaccountinformation"] == null
          ? null
          : Lqtagaccountinformation.fromJson(json["lqtagaccountinformation"]),
      accountInformation:
          json["accountInformation"] == null ? null : AccountInformation.fromJson(json["accountInformation"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enrollmentId": enrollmentId,
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "status": status,
        "registrationNumber": registrationNumber,
        "registrationDate": registrationDate?.toIso8601String(),
        "engineNumber": engineNumber,
        "chasisNumber": chasisNumber,
        "fuelType": fuelType,
        "insuranceExpiryDate": insuranceExpiryDate?.toIso8601String(),
        "fitnessUpto": fitnessUpto?.toIso8601String(),
        "vehicleType": vehicleType?.toJson(),
        "vehicleCategory": vehicleCategory,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdByOrg": createdByOrg,
        "updatedByOrg": updatedByOrg,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "organizationEntityId": organizationEntityId,
        "vehicleServices": vehicleServices.map((x) => x.toJson()).toList(),
        "organizationDetails": organizationDetails?.toJson(),
        "accountInformation": accountInformation?.toJson(),
        "lqtagaccountinformation": lqtagaccountinformation?.toJson(),
      };
}

class AccountInformation {
  AccountInformation({
    required this.id,
    required this.accountInformationId,
    required this.entityId,
    required this.type,
    required this.status,
    required this.accountNumber,
    required this.ifsc,
    required this.upiId,
    required this.thresholdLimit,
    required this.availableBalance,
    required this.organizationId,
    required this.partnerOrganizationId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String accountInformationId;
  final String entityId;
  final String type;
  final String status;
  final String accountNumber;
  final String ifsc;
  final String upiId;
  final dynamic thresholdLimit;
  final int availableBalance;
  final String organizationId;
  final String partnerOrganizationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory AccountInformation.fromJson(Map<String, dynamic> json) {
    return AccountInformation(
      id: json["_id"] ?? "",
      accountInformationId: json["id"] ?? "",
      entityId: json["entityId"] ?? "",
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      accountNumber: json["accountNumber"] ?? "",
      ifsc: json["IFSC"] ?? "",
      upiId: json["upiId"] ?? "",
      thresholdLimit: json["thresholdLimit"],
      availableBalance: json["availableBalance"] ?? 0,
      organizationId: json["organizationId"] ?? "",
      partnerOrganizationId: json["partnerOrganizationId"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": accountInformationId,
        "entityId": entityId,
        "type": type,
        "status": status,
        "accountNumber": accountNumber,
        "IFSC": ifsc,
        "upiId": upiId,
        "thresholdLimit": thresholdLimit,
        "availableBalance": availableBalance,
        "organizationId": organizationId,
        "partnerOrganizationId": partnerOrganizationId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Lqtagaccountinformation {
  Lqtagaccountinformation({
    required this.type,
    required this.status,
    required this.serialNumber,
    required this.kitNumber,
    required this.accountNumber,
    required this.ifsc,
    required this.upiId,
    required this.thresholdLimit,
    required this.availableBalance,
  });

  final String type;
  final String status;
  final String serialNumber;
  final String kitNumber;
  final String accountNumber;
  final String ifsc;
  final String upiId;
  final int thresholdLimit;
  final int availableBalance;

  factory Lqtagaccountinformation.fromJson(Map<String, dynamic> json) {
    return Lqtagaccountinformation(
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      serialNumber: json["serialNumber"] ?? "",
      kitNumber: json["kitNumber"] ?? "",
      accountNumber: json["accountNumber"] ?? "",
      ifsc: json["IFSC"] ?? "",
      upiId: json["upiId"] ?? "",
      thresholdLimit: json["thresholdLimit"] ?? 0,
      availableBalance: json["availableBalance"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "status": status,
        "serialNumber": serialNumber,
        "kitNumber": kitNumber,
        "accountNumber": accountNumber,
        "IFSC": ifsc,
        "upiId": upiId,
        "thresholdLimit": thresholdLimit,
        "availableBalance": availableBalance,
      };
}

class OrganizationDetails {
  OrganizationDetails({
    required this.firstName,
    required this.lastName,
    required this.organizationServices,
  });

  final String firstName;
  final String lastName;
  final List<OrganizationService> organizationServices;

  factory OrganizationDetails.fromJson(Map<String, dynamic> json) {
    return OrganizationDetails(
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      organizationServices: json["organizationServices"] == null
          ? []
          : List<OrganizationService>.from(json["organizationServices"]!.map((x) => OrganizationService.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "organizationServices": organizationServices.map((x) => x.toJson()).toList(),
      };
}

class OrganizationService {
  OrganizationService({
    required this.id,
    required this.organizationEnrollmentId,
    required this.orgCode,
    required this.organizationType,
    required this.serviceType,
    required this.issuerName,
    required this.createdBy,
    required this.updatedBy,
    required this.createdByOrg,
    required this.updatedByOrg,
    required this.cashBackPercentage,
    required this.businessConfig,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.partnerId,
    required this.partnerEnrollmentId,
    required this.organizationEntityId,
    required this.kycDocuments,
    required this.kycType,
    required this.kycStatus,
  });

  final String id;
  final String organizationEnrollmentId;
  final String orgCode;
  final String organizationType;
  final String serviceType;
  final String issuerName;
  final String createdBy;
  final String updatedBy;
  final String createdByOrg;
  final String updatedByOrg;
  final int cashBackPercentage;
  final bool businessConfig;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final String partnerId;
  final String partnerEnrollmentId;
  final String organizationEntityId;
  final OrganizationServiceKycDocuments? kycDocuments;
  final String kycType;
  final String kycStatus;

  factory OrganizationService.fromJson(Map<String, dynamic> json) {
    return OrganizationService(
      id: json["_id"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      orgCode: json["orgCode"] ?? "",
      organizationType: json["organizationType"] ?? "",
      serviceType: json["serviceType"] ?? "",
      issuerName: json["issuerName"] ?? "",
      createdBy: json["createdBy"] ?? "",
      updatedBy: json["updatedBy"] ?? "",
      createdByOrg: json["createdByOrg"] ?? "",
      updatedByOrg: json["updatedByOrg"] ?? "",
      cashBackPercentage: json["cashBackPercentage"] ?? 0,
      businessConfig: json["businessConfig"] ?? false,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
      partnerId: json["partnerId"] ?? "",
      partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
      organizationEntityId: json["organizationEntityId"] ?? "",
      kycDocuments:
          json["kycDocuments"] == null ? null : OrganizationServiceKycDocuments.fromJson(json["kycDocuments"]),
      kycType: json["kycType"] ?? "",
      kycStatus: json["kycStatus"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "organizationEnrollmentId": organizationEnrollmentId,
        "orgCode": orgCode,
        "organizationType": organizationType,
        "serviceType": serviceType,
        "issuerName": issuerName,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdByOrg": createdByOrg,
        "updatedByOrg": updatedByOrg,
        "cashBackPercentage": cashBackPercentage,
        "businessConfig": businessConfig,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "partnerId": partnerId,
        "partnerEnrollmentId": partnerEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "kycDocuments": kycDocuments?.toJson(),
        "kycType": kycType,
        "kycStatus": kycStatus,
      };
}

class OrganizationServiceKycDocuments {
  OrganizationServiceKycDocuments({
    required this.addressProof,
  });

  final RcBookImage? addressProof;

  factory OrganizationServiceKycDocuments.fromJson(Map<String, dynamic> json) {
    return OrganizationServiceKycDocuments(
      addressProof: json["ADDRESS_PROOF"] == null ? null : RcBookImage.fromJson(json["ADDRESS_PROOF"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "ADDRESS_PROOF": addressProof?.toJson(),
      };
}

class RcBookImage {
  RcBookImage({
    required this.url,
    required this.docUploadStatus,
  });

  final String url;
  final String docUploadStatus;

  factory RcBookImage.fromJson(Map<String, dynamic> json) {
    return RcBookImage(
      url: json["url"] ?? "",
      docUploadStatus: json["docUploadStatus"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "docUploadStatus": docUploadStatus,
      };
}

class VehicleService {
  VehicleService({
    required this.id,
    required this.vehicleEnrollmentId,
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.organizationEntityId,
    required this.registrationNumber,
    required this.createdBy,
    required this.updatedBy,
    required this.createdByOrg,
    required this.updatedByOrg,
    required this.serviceType,
    required this.issuerName,
    required this.kycDocuments,
    required this.kycStatus,
    required this.vehicleEntityId,
    required this.partnerId,
    required this.partnerEnrollmentId,
    required this.contactNumber,
    required this.kycType,
    required this.balanceType,
    required this.serialNumber,
    required this.kitNumber,
    required this.vehicleClass,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String vehicleEnrollmentId;
  final String organizationId;
  final String organizationEnrollmentId;
  final String organizationEntityId;
  final String registrationNumber;
  final String createdBy;
  final String updatedBy;
  final String createdByOrg;
  final String updatedByOrg;
  final String serviceType;
  final String issuerName;
  final VehicleServiceKycDocuments? kycDocuments;
  final String kycStatus;
  final String vehicleEntityId;
  final String partnerId;
  final String partnerEnrollmentId;
  final String contactNumber;
  final String kycType;
  final String balanceType;
  final String serialNumber;
  final String kitNumber;
  final VehicleClass? vehicleClass;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory VehicleService.fromJson(Map<String, dynamic> json) {
    return VehicleService(
      id: json["_id"] ?? "",
      vehicleEnrollmentId: json["vehicleEnrollmentId"] ?? "",
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationEntityId: json["organizationEntityId"] ?? "",
      registrationNumber: json["registrationNumber"] ?? "",
      createdBy: json["createdBy"] ?? "",
      updatedBy: json["updatedBy"] ?? "",
      createdByOrg: json["createdByOrg"] ?? "",
      updatedByOrg: json["updatedByOrg"] ?? "",
      serviceType: json["serviceType"] ?? "",
      issuerName: json["issuerName"] ?? "",
      kycDocuments: json["kycDocuments"] == null ? null : VehicleServiceKycDocuments.fromJson(json["kycDocuments"]),
      kycStatus: json["kycStatus"] ?? "",
      vehicleEntityId: json["vehicleEntityId"] ?? "",
      partnerId: json["partnerId"] ?? "",
      partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      kycType: json["kycType"] ?? "",
      balanceType: json["balanceType"] ?? "",
      serialNumber: json["serialNumber"] ?? "",
      kitNumber: json["kitNumber"] ?? "",
      vehicleClass: json["vehicleClass"] == null ? null : VehicleClass.fromJson(json["vehicleClass"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vehicleEnrollmentId": vehicleEnrollmentId,
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "registrationNumber": registrationNumber,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdByOrg": createdByOrg,
        "updatedByOrg": updatedByOrg,
        "serviceType": serviceType,
        "issuerName": issuerName,
        "kycDocuments": kycDocuments?.toJson(),
        "kycStatus": kycStatus,
        "vehicleEntityId": vehicleEntityId,
        "partnerId": partnerId,
        "partnerEnrollmentId": partnerEnrollmentId,
        "contactNumber": contactNumber,
        "kycType": kycType,
        "balanceType": balanceType,
        "serialNumber": serialNumber,
        "kitNumber": kitNumber,
        "vehicleClass": vehicleClass?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class VehicleServiceKycDocuments {
  VehicleServiceKycDocuments({
    required this.rcBookImage,
  });

  final RcBookImage? rcBookImage;

  factory VehicleServiceKycDocuments.fromJson(Map<String, dynamic> json) {
    return VehicleServiceKycDocuments(
      rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : RcBookImage.fromJson(json["RC_BOOK_IMAGE"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "RC_BOOK_IMAGE": rcBookImage?.toJson(),
      };
}

class VehicleClass {
  VehicleClass({
    required this.tagClass,
    required this.axleCount,
    required this.mapperClass,
  });

  final String tagClass;
  final int axleCount;
  final String mapperClass;

  factory VehicleClass.fromJson(Map<String, dynamic> json) {
    return VehicleClass(
      tagClass: json["tagClass"] ?? "",
      axleCount: json["axleCount"] ?? 0,
      mapperClass: json["mapperClass"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "tagClass": tagClass,
        "axleCount": axleCount,
        "mapperClass": mapperClass,
      };
}

class VehicleType {
  VehicleType({
    required this.maker,
    required this.emissionNorm,
    required this.financierName,
    required this.isCommercial,
  });

  final String maker;
  final String emissionNorm;
  final String financierName;
  final String isCommercial;

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
      maker: json["maker"] ?? "",
      emissionNorm: json["emissionNorm"] ?? "",
      financierName: json["financierName"] ?? "",
      isCommercial: json["isCommercial"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "maker": maker,
        "emissionNorm": emissionNorm,
        "financierName": financierName,
        "isCommercial": isCommercial,
      };
}
