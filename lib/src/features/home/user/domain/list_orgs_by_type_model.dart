class ListOrgsByTypeModel {
  ListOrgsByTypeModel({
    required this.data,
  });

  final Data data;

  factory ListOrgsByTypeModel.fromJson(Map<String, dynamic> json) => ListOrgsByTypeModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.message,
  });

  final Message message;

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

  final List<ListOrgByTypeDoc> docs;
  final int count;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        docs: List<ListOrgByTypeDoc>.from(json["docs"].map((x) => ListOrgByTypeDoc.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "count": count,
      };
}

class ListOrgByTypeDoc {
  ListOrgByTypeDoc({
    required this.id,
    required this.enrollmentId,
    required this.entityId,
    required this.status,
    required this.organizationType,
    required this.services,
    required this.accountInformation,
    required this.title,
    required this.panNumber,
    required this.firstName,
    required this.lastName,
    required this.natureOfBusiness,
    required this.email,
    required this.incorporateDate,
    required this.contactNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.state,
    required this.zipCode,
    required this.thresholdLimit,
    required this.createdBy,
    required this.updatedBy,
    required this.createdByOrg,
    required this.updatedByOrg,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.organizationLogo,
  });

  final String id;
  final String enrollmentId;
  final String entityId;
  final String status;
  final String organizationType;
  final Services? services;
  final List<dynamic> accountInformation;
  final String title;
  final String panNumber;
  final String firstName;
  final String lastName;
  final String natureOfBusiness;
  final String email;
  final DateTime incorporateDate;
  final String contactNumber;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String state;
  final String zipCode;
  final int thresholdLimit;
  final String createdBy;
  final String updatedBy;
  final String createdByOrg;
  final String updatedByOrg;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String organizationLogo;

  factory ListOrgByTypeDoc.fromJson(Map<String, dynamic> json) => ListOrgByTypeDoc(
        id: json["_id"] ?? '',
        enrollmentId: json["enrollmentId"] ?? '',
        entityId: json["entityId"] ?? '',
        status: json["status"] ?? '',
        organizationType: json["organizationType"] ?? '',
        services: json["services"] != null ? Services.fromJson(json["services"]) : null,
        accountInformation:
            json["accountInformation"] != null ? List<dynamic>.from(json["accountInformation"].map((x) => x)) : [],
        title: json["title"] ?? '',
        panNumber: json["panNumber"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        natureOfBusiness: json["natureOfBusiness"] ?? '',
        email: json["email"] ?? '',
        incorporateDate: json["incorporateDate"] != null ? DateTime.parse(json["incorporateDate"]) : DateTime.now(),
        contactNumber: json["contactNumber"] ?? '',
        addressLine1: json["addressLine1"] ?? '',
        addressLine2: json["addressLine2"] ?? '',
        city: json["city"] ?? '',
        country: json["country"] ?? '',
        state: json["state"] ?? '',
        zipCode: json["zipCode"] ?? '',
        thresholdLimit: json["thresholdLimit"] ?? 0,
        createdBy: json["createdBy"] ?? '',
        updatedBy: json["updatedBy"] ?? '',
        createdByOrg: json["createdByOrg"] ?? '',
        updatedByOrg: json["updatedByOrg"] ?? '',
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
        v: json["__v"] ?? 0,
        organizationLogo: json["organizationLogo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enrollmentId": enrollmentId,
        "entityId": entityId,
        "status": status,
        "organizationType": organizationType,
        "services": services!.toJson(),
        "accountInformation": List<dynamic>.from(accountInformation.map((x) => x)),
        "title": title,
        "panNumber": panNumber,
        "firstName": firstName,
        "lastName": lastName,
        "natureOfBusiness": natureOfBusiness,
        "email": email,
        "incorporateDate": incorporateDate.toIso8601String(),
        "contactNumber": contactNumber,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "country": country,
        "state": state,
        "zipCode": zipCode,
        "thresholdLimit": thresholdLimit,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdByOrg": createdByOrg,
        "updatedByOrg": updatedByOrg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "organizationLogo": organizationLogo,
      };
}

class Services {
  Services({
    required this.gps,
  });

  final Gps? gps;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        gps: json["gps"] != null ? Gps.fromJson(json["gps"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "gps": gps!.toJson(),
      };
}

class Gps {
  Gps({
    required this.partnerOrganizationId,
    required this.issuerName,
  });

  final List<String> partnerOrganizationId;
  final List<String> issuerName;

  factory Gps.fromJson(Map<String, dynamic> json) => Gps(
        partnerOrganizationId: List<String>.from(json["partnerOrganizationId"].map((x) => x)),
        issuerName: List<String>.from(json["issuerName"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "partnerOrganizationId": List<dynamic>.from(partnerOrganizationId.map((x) => x)),
        "issuerName": List<dynamic>.from(issuerName.map((x) => x)),
      };
}
