class ListUserResponseModel {
  ListUserResponseModel({
    this.data,
  });

  Data? data;

  ListUserResponseModel.unknown() : data = null;

  factory ListUserResponseModel.fromJson(Map<String, dynamic> json) => ListUserResponseModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.message,
  });

  Message message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.docs,
    required this.count,
  });

  List<UserDoc> docs;
  int count;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        docs: List<UserDoc>.from(json["docs"].map((x) => UserDoc.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "count": count,
      };
}

class UserDoc {
  UserDoc({
    required this.id,
    required this.enrollmentId,
    required this.contactNumber,
    required this.status,
    required this.organizations,
    required this.isEmailVerified,
    required this.isContactNumberVerified,
    required this.lastLogin,
    required this.name,
  });

  String id;
  String enrollmentId;
  String contactNumber;
  String status;
  Organizations? organizations;
  bool isEmailVerified;
  bool isContactNumberVerified;
  DateTime? lastLogin;
  String name;

  factory UserDoc.fromJson(Map<String, dynamic> json) => UserDoc(
        id: json["_id"] ?? '',
        enrollmentId: json["enrollmentId"] ?? '',
        contactNumber: json["contactNumber"] ?? '',
        status: json["status"] ?? '',
        organizations: json["organizations"] == null ? null : Organizations.fromJson(json["organizations"]),
        isEmailVerified: json["isEmailVerified"] ?? false,
        isContactNumberVerified: json["isContactNumberVerified"] ?? false,
        lastLogin: json["lastLogin"] == null ? null : DateTime.parse(json["lastLogin"]),
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enrollmentId": enrollmentId,
        "contactNumber": contactNumber,
        "status": status,
        "organizations": organizations!.toJson(),
        "isEmailVerified": isEmailVerified,
        "isContactNumberVerified": isContactNumberVerified,
        "lastLogin": lastLogin!.toIso8601String(),
        "name": name,
      };
}

class Organizations {
  Organizations({
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.orgCode,
    required this.organizationType,
    required this.role,
    required this.dashboard,
    required this.isDeactivated,
    required this.organizationDetails,
    required this.userServices,
  });

  String organizationId;
  String organizationEnrollmentId;
  String orgCode;
  String organizationType;
  List<String> role;
  List<dynamic> dashboard;
  bool isDeactivated;
  OrganizationDetails? organizationDetails;
  List<UserService> userServices;

  factory Organizations.fromJson(Map<String, dynamic> json) => Organizations(
        organizationId: json["organizationId"] ?? '',
        organizationEnrollmentId: json["organizationEnrollmentId"] ?? '',
        orgCode: json["orgCode"] ?? '',
        organizationType: json["organizationType"] ?? '',
        role: json["role"] == null ? [] : List<String>.from(json["role"].map((x) => x)),
        dashboard: json["dashboard"] == null ? [] : List<dynamic>.from(json["dashboard"].map((x) => x)),
        isDeactivated: json["isDeactivated"] ?? false,
        organizationDetails:
            json["organizationDetails"] == null ? null : OrganizationDetails.fromJson(json["organizationDetails"]),
        userServices: json["userServices"] == null
            ? []
            : List<UserService>.from(json["userServices"].map((x) => UserService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "orgCode": orgCode,
        "organizationType": organizationType,
        "role": List<dynamic>.from(role.map((x) => x)),
        "dashboard": List<dynamic>.from(dashboard.map((x) => x)),
        "isDeactivated": isDeactivated,
        "organizationDetails": organizationDetails!.toJson(),
        "userServices": List<dynamic>.from(userServices.map((x) => x)),
      };
}

class UserService {
  UserService({
    required this.issuerName,
    required this.partnerEnrollmentId,
    required this.serviceType,
    required this.kycStatus,
    required this.partnerId,
    required this.userEntityId,
    this.kycType,
  });

  String issuerName;
  String partnerEnrollmentId;
  String serviceType;
  String kycStatus;
  String partnerId;
  String userEntityId;
  String? kycType;

  String get svgPath {
    switch (serviceType) {
      case "PPI":
        return "assets/new_assets/icons/card_icon.svg";
      case "FUEL":
        return "assets/new_assets/icons/fuel_icon.svg";
      // case "GPS":
      //   return "assets/new_assets/icons/card_icon.svg";
      case "TAG":
        return "assets/icons/lq_fastag_icon.svg";

      default:
        return "";
    }
  }

  factory UserService.fromJson(Map<String, dynamic> json) => UserService(
        issuerName: json["issuerName"] ?? '',
        partnerEnrollmentId: json["partnerEnrollmentId"] ?? '',
        serviceType: json["serviceType"] ?? '',
        kycStatus: json["kycStatus"] ?? '',
        partnerId: json["partnerId"] ?? '',
        userEntityId: json["userEntityId"] ?? '',
        kycType: json["kycType"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "issuerName": issuerName,
        "partnerEnrollmentId": partnerEnrollmentId,
        "serviceType": serviceType,
        "kycStatus": kycStatus,
        "partnerId": partnerId,
        "userEntityId": userEntityId,
        "kycType": kycType,
      };
}

class OrganizationDetails {
  OrganizationDetails({
    required this.firstName,
    required this.lastName,
    required this.services,
  });

  String firstName;
  String lastName;
  List<Service>? services;

  factory OrganizationDetails.fromJson(Map<String, dynamic> json) => OrganizationDetails(
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        services:
            json["services"] == null ? null : List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "services": List<Service>.from(services!.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    required this.serviceType,
    required this.issuerName,
    this.partnerId,
    this.partnerEnrollmentId,
    this.organizationEntityId,
    this.kycType,
    this.kycStatus,
    this.companyName,
    this.registrationType,
    this.mcc,
    this.mid,
    this.productionKey,
    this.productionApiKey,
    this.testApiKey,
    // this.regCorporateException,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.salutationCode,
    this.addressInfo,
    this.panNumber,
    this.dateOfBirth,
    this.vendor,
    this.accessToken,
  });

  String serviceType;
  String issuerName;
  String? partnerId;
  String? partnerEnrollmentId;
  String? organizationEntityId;
  String? kycType;
  String? kycStatus;
  String? companyName;
  String? registrationType;
  String? mcc;
  String? mid;
  String? productionKey;
  String? productionApiKey;
  String? testApiKey;
  // RegCorporateException? regCorporateException;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? salutationCode;
  AddressInfo? addressInfo;
  String? panNumber;
  DateTime? dateOfBirth;
  String? vendor;
  String? accessToken;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceType: json["serviceType"] ?? '',
        issuerName: json["issuerName"] ?? '',
        partnerId: json["partnerId"] ?? '',
        partnerEnrollmentId: json["partnerEnrollmentId"] ?? '',
        organizationEntityId: json["organizationEntityId"] ?? '',
        kycType: json["kycType"] ?? '',
        kycStatus: json["kycStatus"] ?? '',
        companyName: json["companyName"] ?? '',
        registrationType: json["registrationType"] ?? '',
        mcc: json["mcc"] ?? '',
        mid: json["mid"] ?? '',
        productionKey: json["productionKey"] ?? '',
        productionApiKey: json["productionApiKey"] ?? '',
        testApiKey: json["testApiKey"] ?? '',
        // regCorporateException: json["regCorporateException"] == null
        //     ? null
        //     : RegCorporateException.fromJson(json["regCorporateException"]),
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        mobileNumber: json["mobileNumber"] ?? '',
        email: json["email"] ?? '',
        salutationCode: json["salutationCode"] ?? '',
        addressInfo: json["addressInfo"] == null ? null : AddressInfo.fromJson(json["addressInfo"]),
        panNumber: json["panNumber"] ?? '',
        dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
        vendor: json["vendor"] ?? '',
        accessToken: json["accessToken"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "serviceType": serviceType,
        "issuerName": issuerName,
        "partnerId": partnerId,
        "partnerEnrollmentId": partnerEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "kycType": kycType,
        "kycStatus": kycStatus,
        "companyName": companyName,
        "registrationType": registrationType,
        "mcc": mcc,
        "mid": mid,
        "productionKey": productionKey,
        "productionApiKey": productionApiKey,
        "testApiKey": testApiKey,
        // "regCorporateException": regCorporateException?.toJson(),
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber,
        "email": email,
        "salutationCode": salutationCode,
        "addressInfo": addressInfo?.toJson(),
        "panNumber": panNumber,
        "dateOfBirth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "vendor": vendor,
        "accessToken": accessToken,
      };
}

class AddressInfo {
  AddressInfo({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.state,
    required this.zipCode,
  });

  String addressLine1;
  String addressLine2;
  String city;
  String country;
  String state;
  String zipCode;

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        addressLine1: json["addressLine1"] ?? '',
        addressLine2: json["addressLine2"] ?? '',
        city: json["city"] ?? '',
        country: json["country"] ?? '',
        state: json["state"] ?? '',
        zipCode: json["zipCode"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "country": country,
        "state": state,
        "zipCode": zipCode,
      };
}

class RegCorporateException {
  RegCorporateException({
    required this.detailMessage,
    this.cause,
    required this.shortMessage,
    required this.languageCode,
    required this.errorCode,
    this.fieldErrors,
    this.message,
    this.localizedMessage,
    required this.suppressed,
  });

  String detailMessage;
  dynamic cause;
  String shortMessage;
  String languageCode;
  String errorCode;
  dynamic fieldErrors;
  dynamic message;
  dynamic localizedMessage;
  List<dynamic>? suppressed;

  factory RegCorporateException.fromJson(Map<String, dynamic> json) => RegCorporateException(
        detailMessage: json["detailMessage"] ?? '',
        cause: json["cause"] ?? '',
        shortMessage: json["shortMessage"] ?? '',
        languageCode: json["languageCode"] ?? '',
        errorCode: json["errorCode"] ?? '',
        fieldErrors: json["fieldErrors"] ?? '',
        message: json["message"] ?? '',
        localizedMessage: json["localizedMessage"] ?? '',
        suppressed: json["suppressed"] == null ? null : List<dynamic>.from(json["suppressed"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "detailMessage": detailMessage,
        "cause": cause,
        "shortMessage": shortMessage,
        "languageCode": languageCode,
        "errorCode": errorCode,
        "fieldErrors": fieldErrors,
        "message": message,
        "localizedMessage": localizedMessage,
        "suppressed": List<dynamic>.from(suppressed!.map((x) => x)),
      };
}
