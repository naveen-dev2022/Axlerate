class DetailVehicleUpdatedModel {
  DetailVehicleUpdatedModel({
    required this.data,
  });

  final Data? data;
  const DetailVehicleUpdatedModel.unknown() : data = null;

  factory DetailVehicleUpdatedModel.fromJson(Map<String, dynamic> json) {
    return DetailVehicleUpdatedModel(
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

  final Vehicle? message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null ? null : Vehicle.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Vehicle {
  Vehicle({
    required this.id,
    required this.enrollmentId,
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.organizationEntityId,
    required this.status,
    required this.accountInformation,
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
    required this.services,
    required this.contactNumber,
    required this.vehicleImage,
    required this.entityId,
  });

  final String id;
  final String enrollmentId;
  final String organizationId;
  final String organizationEnrollmentId;
  final String organizationEntityId;
  final String status;
  final List<String> accountInformation;
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
  final List<Service> services;
  final String contactNumber;
  final VehicleImage? vehicleImage;
  final String entityId;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json["_id"] ?? "",
      enrollmentId: json["enrollmentId"] ?? "",
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationEntityId: json["organizationEntityId"] ?? "",
      status: json["status"] ?? "",
      accountInformation:
          json["accountInformation"] == null ? [] : List<String>.from(json["accountInformation"]!.map((x) => x)),
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
      services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
      // services: json["services"] == null ? null : Service.map((x) => x.toJson()).toList(),
      contactNumber: json["contactNumber"] ?? "",
      vehicleImage: json["vehicleImage"] == null ? null : VehicleImage.fromJson(json["vehicleImage"]),
      entityId: json["entityId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enrollmentId": enrollmentId,
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "status": status,
        "accountInformation": accountInformation.map((x) => x).toList(),
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
        "services": services.map((x) => x.toJson()).toList(),
        "contactNumber": contactNumber,
        "vehicleImage": vehicleImage?.toJson(),
        "entityId": entityId,
      };
}

class OwnerImageModel {
  OwnerImageModel({
    required this.url,
    required this.docUploadStatus,
  });

  final String url;
  final String docUploadStatus;

  factory OwnerImageModel.fromJson(Map<String, dynamic> json) {
    return OwnerImageModel(
      url: json["url"] ?? "",
      docUploadStatus: json["docUploadStatus"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "docUploadStatus": docUploadStatus,
      };
}

class RcBookImage {
  RcBookImage({
    required this.url,
    required this.docUploadStatus,
    required this.documentExpiry,
  });

  final String url;
  final String docUploadStatus;
  final DateTime? documentExpiry;

  factory RcBookImage.fromJson(Map<String, dynamic> json) {
    return RcBookImage(
      url: json["url"] ?? "",
      docUploadStatus: json["docUploadStatus"] ?? "",
      documentExpiry: DateTime.tryParse(json["documentExpiry"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "docUploadStatus": docUploadStatus,
      };
}

class Service {
  Service({
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
    required this.imei,
    required this.vehicleEntityId,
    required this.partnerId,
    required this.partnerEnrollmentId,
    required this.contactNumber,
    required this.kycType,
    required this.balanceType,
    required this.serialNumber,
    required this.kitNumber,
    required this.vehicleClass,
    required this.profileId,
    required this.vendor,
    required this.mapStatus,
    required this.rcNumber,
    required this.vehicleMake,
    required this.axle,
    required this.createdAt,
    required this.userEnrollmentId,
    required this.updatedAt,
    required this.v,
    required this.rejectionReason,
    required this.registrationDate,
    required this.userDetails,
    this.regTruckException,
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
  final String imei;
  final String vehicleEntityId;
  final String partnerId;
  final String partnerEnrollmentId;
  final String contactNumber;
  final String kycType;
  final String balanceType;
  final String userEnrollmentId;
  final String serialNumber;
  final String kitNumber;
  final VehicleClass? vehicleClass;
  final String profileId;
  final String vendor;
  final String mapStatus;
  final String rcNumber;
  final String vehicleMake;
  final String axle;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final String rejectionReason;
  final DateTime? registrationDate;
  final UserDetails? userDetails;
  final RegTruckException? regTruckException;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
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
      imei: json["imei"] ?? "",
      userEnrollmentId: json['userEnrollmentId'] ?? '',
      vehicleEntityId: json["vehicleEntityId"] ?? "",
      partnerId: json["partnerId"] ?? "",
      partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      kycType: json["kycType"] ?? "",
      balanceType: json["balanceType"] ?? "",
      serialNumber: json["serialNumber"] ?? "",
      kitNumber: json["kitNumber"] ?? "",
      vehicleClass: json["vehicleClass"] == null ? null : VehicleClass.fromJson(json["vehicleClass"]),
      profileId: json["profileId"] ?? "",
      vendor: json["vendor"] ?? "",
      mapStatus: json["mapStatus"] ?? "",
      rcNumber: json["rcNumber"] ?? "",
      vehicleMake: json["vehicleMake"] ?? "",
      rejectionReason: json["rejectionReason"] ?? "",
      registrationDate: DateTime.tryParse(json["registrationDate"] ?? ""),
      axle: json["axle"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
      userDetails: json["userDetails"] == null ? null : UserDetails.fromJson(json["userDetails"]),
      regTruckException:
          json["regTruckException"] == null ? null : RegTruckException.fromJson(json["regTruckException"]),
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
        "imei": imei,
        'userEnrollmentId': userEnrollmentId,
        "vehicleEntityId": vehicleEntityId,
        "partnerId": partnerId,
        "partnerEnrollmentId": partnerEnrollmentId,
        "contactNumber": contactNumber,
        "kycType": kycType,
        "balanceType": balanceType,
        "serialNumber": serialNumber,
        "kitNumber": kitNumber,
        "vehicleClass": vehicleClass?.toJson(),
        "profileId": profileId,
        "vendor": vendor,
        "mapStatus": mapStatus,
        "rcNumber": rcNumber,
        "vehicleMake": vehicleMake,
        "rejectionReason": rejectionReason,
        "registrationDate": registrationDate,
        "axle": axle,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "userDetails": userDetails?.toJson(),
        "regTruckException": regTruckException?.toJson(),
      };
}

class RegTruckException {
  RegTruckException({
    required this.displayMessage,
    required this.exception,
  });

  final String displayMessage;
  final Exception? exception;

  factory RegTruckException.fromJson(Map<String, dynamic> json) {
    return RegTruckException(
      displayMessage: json["displayMessage"] ?? "",
      exception: json["exception"] == null ? null : Exception.fromJson(json["exception"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "displayMessage": displayMessage,
        "exception": exception?.toJson(),
      };
}

class Exception {
  Exception({
    required this.detailMessage,
    required this.cause,
    required this.shortMessage,
    required this.languageCode,
    required this.errorCode,
    required this.fieldErrors,
    required this.message,
    required this.localizedMessage,
    required this.suppressed,
  });

  final String detailMessage;
  final dynamic cause;
  final String shortMessage;
  final String languageCode;
  final String errorCode;
  final List<String> fieldErrors;
  final dynamic message;
  final dynamic localizedMessage;
  final List<dynamic> suppressed;

  factory Exception.fromJson(Map<String, dynamic> json) {
    return Exception(
      detailMessage: json["detailMessage"] ?? "",
      cause: json["cause"],
      shortMessage: json["shortMessage"] ?? "",
      languageCode: json["languageCode"] ?? "",
      errorCode: json["errorCode"] ?? "",
      fieldErrors: json["fieldErrors"] == null ? [] : List<String>.from(json["fieldErrors"]!.map((x) => x)),
      message: json["message"],
      localizedMessage: json["localizedMessage"],
      suppressed: json["suppressed"] == null ? [] : List<dynamic>.from(json["suppressed"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "detailMessage": detailMessage,
        "cause": cause,
        "shortMessage": shortMessage,
        "languageCode": languageCode,
        "errorCode": errorCode,
        "fieldErrors": fieldErrors.map((x) => x).toList(),
        "message": message,
        "localizedMessage": localizedMessage,
        "suppressed": suppressed.map((x) => x).toList(),
      };
}

class UserDetails {
  UserDetails({
    required this.userName,
    required this.userEnrollmentId,
    required this.userContactNumber,
  });

  final String userName;
  final String userEnrollmentId;
  final String userContactNumber;

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userName: json["userName"] ?? "",
      userEnrollmentId: json["userEnrollmentId"] ?? "",
      userContactNumber: json["userContactNumber"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "userEnrollmentId": userEnrollmentId,
        "userContactNumber": userContactNumber,
      };
}

class VehicleServiceKycDocuments {
  VehicleServiceKycDocuments({
    required this.rcBookImage,
    required this.ownerImage,
    required this.rcBook,
  });

  final RcBookImage? rcBookImage;
  final OwnerImageModel? ownerImage;
  final RcBookUpload? rcBook;

  factory VehicleServiceKycDocuments.fromJson(Map<String, dynamic> json) {
    return VehicleServiceKycDocuments(
      rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : RcBookImage.fromJson(json["RC_BOOK_IMAGE"]),
      ownerImage: json["OWNER_IMAGE"] == null ? null : OwnerImageModel.fromJson(json["OWNER_IMAGE"]),
      rcBook: json["RC_BOOK"] == null ? null : RcBookUpload.fromJson(json["RC_BOOK"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "RC_BOOK_IMAGE": rcBookImage?.toJson(),
        "RC_BOOK": rcBook?.toJson(),
      };
}

class RcBookUpload {
  RcBookUpload({
    required this.url,
    required this.docUploadStatus,
  });

  final String url;
  final String docUploadStatus;

  factory RcBookUpload.fromJson(Map<String, dynamic> json) {
    return RcBookUpload(
      url: json["url"] ?? "",
      docUploadStatus: json["docUploadStatus"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "docUploadStatus": docUploadStatus,
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

class VehicleImage {
  VehicleImage({
    required this.frontView,
    required this.sideView,
  });

  final View? frontView;
  final View? sideView;

  factory VehicleImage.fromJson(Map<String, dynamic> json) {
    return VehicleImage(
      frontView: json["FRONT_VIEW"] == null ? null : View.fromJson(json["FRONT_VIEW"]),
      sideView: json["SIDE_VIEW"] == null ? null : View.fromJson(json["SIDE_VIEW"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "FRONT_VIEW": frontView?.toJson(),
        "SIDE_VIEW": sideView?.toJson(),
      };
}

class View {
  View({
    required this.url,
  });

  final String url;

  factory View.fromJson(Map<String, dynamic> json) {
    return View(
      url: json["url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
