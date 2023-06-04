import 'package:axlerate/src/features/home/payments/domain/request_invoice_input_model.dart';

class ListOrgUpdatedModel {
  ListOrgUpdatedModel({
    required this.data,
  });

  final Data? data;
  ListOrgUpdatedModel.unknown() : data = null;

  factory ListOrgUpdatedModel.fromJson(Map<String, dynamic> json) {
    return ListOrgUpdatedModel(
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

  final Message message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: Message.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.docs,
    required this.count,
  });

  final List<OrgDoc> docs;
  final int count;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      docs: json["docs"] == null ? [] : List<OrgDoc>.from(json["docs"]!.map((x) => OrgDoc.fromJson(x))),
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "docs": docs.map((x) => x.toJson()).toList(),
        "count": count,
      };
}

class OrgDoc {
  OrgDoc({
    required this.id,
    required this.enrollmentId,
    required this.orgCode,
    required this.status,
    required this.organizationType,
    required this.title,
    required this.panNumber,
    required this.firstName,
    required this.lastName,
    required this.natureOfBusiness,
    required this.email,
    required this.incorporateDate,
    required this.contactNumber,
    required this.addresses,
    required this.createdBy,
    required this.updatedBy,
    required this.createdByOrg,
    required this.updatedByOrg,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.organizationServices,
    required this.users,
    required this.vehicles,
    required this.ppiUsersPartnerOrg,
    required this.totalTagPartnerOrg,
    required this.organizationLogo,
  });

  get displayName {
    return '$firstName $lastName';
  }

  final String id;
  final String enrollmentId;
  final String orgCode;
  final String status;
  final String organizationType;
  final String title;
  final String panNumber;
  final String firstName;
  final String lastName;
  final String natureOfBusiness;
  final String email;
  final DateTime? incorporateDate;
  final String contactNumber;
  final Addresses? addresses;
  final String createdBy;
  final String updatedBy;
  final String createdByOrg;
  final String updatedByOrg;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final List<OrganizationService> organizationServices;
  final int users;
  final int vehicles;
  final int ppiUsersPartnerOrg;
  final int totalTagPartnerOrg;
  final String? organizationLogo;

  factory OrgDoc.fromJson(Map<String, dynamic> json) {
    return OrgDoc(
      id: json["_id"] ?? "",
      enrollmentId: json["enrollmentId"] ?? "",
      orgCode: json["orgCode"] ?? "",
      status: json["status"] ?? "",
      organizationType: json["organizationType"] ?? "",
      title: json["title"] ?? "",
      panNumber: json["panNumber"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      natureOfBusiness: json["natureOfBusiness"] ?? "",
      email: json["email"] ?? "",
      incorporateDate: DateTime.tryParse(json["incorporateDate"] ?? ""),
      contactNumber: json["contactNumber"] ?? "",
      addresses: json["addresses"] == null ? null : Addresses.fromJson(json["addresses"]),
      createdBy: json["createdBy"] ?? "",
      updatedBy: json["updatedBy"] ?? "",
      createdByOrg: json["createdByOrg"] ?? "",
      updatedByOrg: json["updatedByOrg"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
      organizationServices: json["organizationServices"] == null
          ? []
          : List<OrganizationService>.from(json["organizationServices"]!.map((x) => OrganizationService.fromJson(x))),
      users: json["users"] ?? 0,
      vehicles: json["vehicles"] ?? 0,
      ppiUsersPartnerOrg: json["ppiUsersPartnerOrg"] ?? 0,
      totalTagPartnerOrg: json["totalTagPartnerOrg"] ?? 0,
      organizationLogo: json['organizationLogo'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enrollmentId": enrollmentId,
        "orgCode": orgCode,
        "status": status,
        "organizationType": organizationType,
        "title": title,
        "panNumber": panNumber,
        "firstName": firstName,
        "lastName": lastName,
        "natureOfBusiness": natureOfBusiness,
        "email": email,
        "incorporateDate": incorporateDate?.toIso8601String(),
        "contactNumber": contactNumber,
        "addresses": addresses?.toJson(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdByOrg": createdByOrg,
        "updatedByOrg": updatedByOrg,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "organizationServices": organizationServices.map((x) => x.toJson()).toList(),
        "users": users,
        "vehicles": vehicles,
        "ppiUsersPartnerOrg": ppiUsersPartnerOrg,
        "totalTagPartnerOrg": totalTagPartnerOrg,
        'organizationLogo': organizationLogo,
      };
}

class Addresses {
  Addresses({
    required this.officeAddress,
    required this.communicationAddress,
  });

  final Address? officeAddress;
  final Address? communicationAddress;

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return Addresses(
      officeAddress: json["officeAddress"] == null ? null : Address.fromJson(json["officeAddress"]),
      communicationAddress:
          json["communicationAddress"] == null ? null : Address.fromJson(json["communicationAddress"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "officeAddress": officeAddress?.toJson(),
        "communicationAddress": communicationAddress?.toJson(),
      };
}

class Address {
  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.state,
    required this.zipCode,
  });

  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String state;
  final String zipCode;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json["addressLine1"] ?? "",
      addressLine2: json["addressLine2"] ?? "",
      city: json["city"] ?? "",
      country: json["country"] ?? "",
      state: json["state"] ?? "",
      zipCode: json["zipCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "country": country,
        "state": state,
        "zipCode": zipCode,
      };
}

class CommunicationAddress {
  CommunicationAddress({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.state,
    required this.zipCode,
  });

  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String state;
  final String zipCode;

  factory CommunicationAddress.fromJson(Map<String, dynamic> json) {
    return CommunicationAddress(
      addressLine1: json["addressLine1"] ?? "",
      addressLine2: json["addressLine2"] ?? "",
      city: json["city"] ?? "",
      country: json["country"] ?? "",
      state: json["state"] ?? "",
      zipCode: json["zipCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "country": country,
        "state": state,
        "zipCode": zipCode,
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
    required this.organizationEntityId,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.salutationCode,
    required this.addressInfo,
    required this.panNumber,
    this.gstinNumber,
    required this.dateOfBirth,
    required this.vendor,
    required this.accessToken,
    required this.businessConfig,
    required this.defaultLimitUpdated,
    required this.kycDocuments,
    required this.kycStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.partnerId,
    required this.partnerEnrollmentId,
    required this.kycType,
    this.status,
    this.rejectionReason,
    this.companyName,
    this.logo,
    this.registrationType,
    this.documents,
    this.mid,
    this.mcc,
    this.productionApiKey,
    this.productionKey,
    this.testApiKey,
    this.regCorporateException,
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
  final String organizationEntityId;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String salutationCode;
  final CommunicationAddress? addressInfo;
  final String panNumber;
  final String? gstinNumber;
  final DateTime? dateOfBirth;
  final String vendor;
  final String accessToken;
  final bool businessConfig;
  final bool defaultLimitUpdated;
  final KycDocuments? kycDocuments;
  final String kycStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final String partnerId;
  final String partnerEnrollmentId;
  final String kycType;
  final String? status;
  final String? rejectionReason;
  final String? companyName;
  final String? logo;
  final String? registrationType;
  final RequestInvoiceInputDocuments? documents;
  final String? mid;
  final String? mcc;
  final String? productionApiKey;
  final String? productionKey;
  final String? testApiKey;
  final RegCorporateException? regCorporateException;

  String get tabName {
    switch (serviceType) {
      case "TAG":
        if (issuerName == "YESBANK") {
          return "YBTAG";
        } else {
          return "LQTAG";
        }
      default:
        return serviceType;
    }
  }

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
      organizationEntityId: json["organizationEntityId"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      mobileNumber: json["mobileNumber"] ?? "",
      email: json["email"] ?? "",
      salutationCode: json["salutationCode"] ?? "",
      addressInfo: json["addressInfo"] == null ? null : CommunicationAddress.fromJson(json["addressInfo"]),
      panNumber: json["panNumber"] ?? "",
      gstinNumber: json["gstinNumber"] ?? "",
      dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.tryParse(json["dateOfBirth"] ?? ""),
      vendor: json["vendor"] ?? "",
      accessToken: json["accessToken"] ?? "",
      businessConfig: json["businessConfig"] ?? false,
      defaultLimitUpdated: json["defaultLimitUpdated"] ?? false,
      kycDocuments: json["kycDocuments"] == null ? null : KycDocuments.fromJson(json["kycDocuments"]),
      kycStatus: json["kycStatus"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
      partnerId: json["partnerId"] ?? "",
      partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
      kycType: json["kycType"] ?? "",
      status: json["status"] ?? "",
      rejectionReason: json["rejectionReason"] ?? "",
      companyName: json["companyName"] ?? "",
      logo: json["logo"] ?? "",
      registrationType: json["registrationType"] ?? "",
      documents: json["documents"] == null
          ? json["kycDocuments"] == null
              ? null
              : RequestInvoiceInputDocuments.fromJson(json["kycDocuments"])
          : RequestInvoiceInputDocuments.fromJson(json["documents"]),
      mid: json["mid"] ?? "",
      mcc: json["mcc"] ?? "",
      productionApiKey: json["productionApiKey"] ?? "",
      productionKey: json["productionKey"] ?? "",
      testApiKey: json["testApiKey"] ?? "",
      regCorporateException:
          json["regCorporateException"] == null ? null : RegCorporateException.fromJson(json["regCorporateException"]),
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
        "organizationEntityId": organizationEntityId,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber,
        "email": email,
        "salutationCode": salutationCode,
        "addressInfo": addressInfo?.toJson(),
        "panNumber": panNumber,
        "gstinNumber": gstinNumber,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "vendor": vendor,
        "accessToken": accessToken,
        "businessConfig": businessConfig,
        "defaultLimitUpdated": defaultLimitUpdated,
        "kycDocuments": kycDocuments?.toJson(),
        "kycStatus": kycStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "partnerId": partnerId,
        "partnerEnrollmentId": partnerEnrollmentId,
        "kycType": kycType,
        "regCorporateException": regCorporateException?.toJson(),
      };
}

class RegCorporateException {
  RegCorporateException({
    required this.displayMessage,
    required this.exception,
  });

  final String displayMessage;
  final RegException? exception;

  factory RegCorporateException.fromJson(Map<String, dynamic> json) {
    return RegCorporateException(
      displayMessage: json["displayMessage"] ?? "",
      exception: json["exception"] == null ? null : RegException.fromJson(json["exception"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "displayMessage": displayMessage,
        "exception": exception?.toJson(),
      };
}

class RegException {
  RegException({
    required this.cause,
    required this.errorCode,
    required this.message,
    required this.languageCode,
    required this.errors,
    required this.suppressed,
    required this.localizedMessage,
  });

  final dynamic cause;
  final String errorCode;
  final String message;
  final String languageCode;
  final dynamic errors;
  final List<dynamic> suppressed;
  final String localizedMessage;

  factory RegException.fromJson(Map<String, dynamic> json) {
    return RegException(
      cause: json["cause"],
      errorCode: json["errorCode"] ?? "",
      message: json["message"] ?? "",
      languageCode: json["languageCode"] ?? "",
      errors: json["errors"],
      suppressed: json["suppressed"] == null ? [] : List<dynamic>.from(json["suppressed"]!.map((x) => x)),
      localizedMessage: json["localizedMessage"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "cause": cause,
        "errorCode": errorCode,
        "message": message,
        "languageCode": languageCode,
        "errors": errors,
        "suppressed": suppressed.map((x) => x).toList(),
        "localizedMessage": localizedMessage,
      };
}

OrganizationService? getOrgService(
  OrgDoc? orgDoc,
  String serviceType, {
  String? issuerName,
}) {
  int index = 0;
  try {
    if (orgDoc == null || orgDoc.organizationServices.isEmpty) {
      return null;
    }
    if (issuerName != null) {
      index = orgDoc.organizationServices.indexWhere((element) {
        return element.issuerName == issuerName && element.serviceType == serviceType;
      });
    } else {
      index = orgDoc.organizationServices.indexWhere((element) {
        return element.serviceType == serviceType;
      });
    }

    if (index == -1) {
      return null;
    }
    return orgDoc.organizationServices[index];
  } catch (e) {
    return null;
  }
}

class KycDocuments {
  KycDocuments({
    required this.panProof,
    required this.gstinProof,
    required this.addressProof,
    required this.identityProof,
  });

  final Proof? panProof;
  final Proof? gstinProof;
  final Proof? addressProof;
  final Proof? identityProof;

  factory KycDocuments.fromJson(Map<String, dynamic> json) {
    return KycDocuments(
      panProof: json["PAN_PROOF"] == null ? null : Proof.fromJson(json["PAN_PROOF"]),
      gstinProof: json["GSTIN_PROOF"] == null ? null : Proof.fromJson(json["GSTIN_PROOF"]),
      addressProof: json["ADDRESS_PROOF"] == null ? null : Proof.fromJson(json["ADDRESS_PROOF"]),
      identityProof: json["IDENTITY_PROOF"] == null ? null : Proof.fromJson(json["IDENTITY_PROOF"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "PAN_PROOF": panProof?.toJson(),
        "GSTIN_PROOF": gstinProof?.toJson(),
        "ADDRESS_PROOF": addressProof?.toJson(),
        "IDENTITY_PROOF": identityProof?.toJson(),
      };
}

class Proof {
  Proof({
    required this.url,
    required this.docUploadStatus,
  });

  final String url;
  final String docUploadStatus;

  factory Proof.fromJson(Map<String, dynamic> json) {
    return Proof(
      url: json["url"] ?? "",
      docUploadStatus: json["docUploadStatus"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "docUploadStatus": docUploadStatus,
      };
}
