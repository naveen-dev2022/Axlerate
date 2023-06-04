class NewListUsersResponseModel {
  NewListUsersResponseModel({
    this.data,
  });

  final Data? data;

  const NewListUsersResponseModel.unknown() : data = null;

  factory NewListUsersResponseModel.fromJson(Map<String, dynamic> json) => NewListUsersResponseModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.message,
  });

  Message? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
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
        docs: json["docs"] == null ? [] : List<UserDoc>.from(json["docs"]!.map((x) => UserDoc.fromJson(x))),
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "count": count,
      };
}

class UserDoc {
  UserDoc({
    this.id,
    this.enrollmentId,
    this.email,
    this.status,
    required this.organizations,
    this.accountInformation,
    this.isEmailVerified,
    this.isContactNumberVerified,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.contactNumber,
    this.lastLogin,
    this.name,
    this.password,
  });

  String? id;
  String? enrollmentId;
  String? email;
  String? status;
  Organizations organizations;
  List<String?>? accountInformation;
  bool? isEmailVerified;
  bool? isContactNumberVerified;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? contactNumber;
  DateTime? lastLogin;
  String? name;
  String? password;

  factory UserDoc.fromJson(Map<String, dynamic> json) => UserDoc(
        id: json["_id"] ?? '',
        enrollmentId: json["enrollmentId"] ?? '',
        email: json["email"] ?? '',
        status: json["status"] ?? '',
        organizations: Organizations.fromJson(json["organizations"]),
        accountInformation: json["accountInformation"] == null
            ? []
            : json["accountInformation"] == []
                ? []
                : List<String?>.from(json["accountInformation"]!.map((x) => x)),
        isEmailVerified: json["isEmailVerified"] ?? false,
        isContactNumberVerified: json["isContactNumberVerified"] ?? false,
        createdBy: json["createdBy"] ?? '',
        updatedBy: json["updatedBy"] ?? '',
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? '',
        contactNumber: json["contactNumber"] ?? '',
        lastLogin: json["lastLogin"] == null ? null : DateTime.parse(json["lastLogin"]),
        name: json["name"] ?? '',
        password: json["password"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enrollmentId": enrollmentId,
        "email": email,
        "status": status,
        "organizations": organizations.toJson(),
        "accountInformation": accountInformation == null ? [] : List<dynamic>.from(accountInformation!.map((x) => x)),
        "isEmailVerified": isEmailVerified,
        "isContactNumberVerified": isContactNumberVerified,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "contactNumber": contactNumber,
        "lastLogin": lastLogin,
        "name": name,
        "password": password,
      };
}

class Organizations {
  Organizations({
    this.organizationId,
    this.organizationEnrollmentId,
    this.organizationEntityId,
    this.organizationType,
    this.role,
    this.dashboard,
    this.isPpiRegistered,
    this.isDeactivated,
    this.dateInfo,
    this.addressInfo,
    this.communicationInfo,
    this.organizationDetails,
    this.userEntityId,
    this.contactNumber,
    this.employmentIndustry,
    this.employmentType,
    this.firstName,
    this.gender,
    this.isDependant,
    this.isMinor,
    this.isNriCustomer,
    this.kycStatus,
    this.kycType,
    this.lastName,
    this.partnerOrganizationId,
    this.title,
  });

  String? organizationId;
  String? organizationEnrollmentId;
  String? organizationEntityId;
  String? organizationType;
  List<String?>? role;
  List<dynamic>? dashboard;
  bool? isPpiRegistered;
  bool? isDeactivated;
  List<DateInfo?>? dateInfo;
  List<dynamic>? addressInfo;
  List<CommunicationInfo?>? communicationInfo;
  OrganizationDetails? organizationDetails;
  String? userEntityId;
  String? contactNumber;
  String? employmentIndustry;
  String? employmentType;
  String? firstName;
  String? gender;
  bool? isDependant;
  bool? isMinor;
  bool? isNriCustomer;
  String? kycStatus;
  String? kycType;
  String? lastName;
  String? partnerOrganizationId;
  String? title;

  factory Organizations.fromJson(Map<String, dynamic> json) => Organizations(
        organizationId: json["organizationId"] ?? '',
        organizationEnrollmentId: json["organizationEnrollmentId"] ?? '',
        organizationEntityId: json["organizationEntityId"] ?? '',
        organizationType: json["organizationType"] ?? '',
        role: json["role"] == null
            ? []
            : json["role"] == []
                ? []
                : List<String?>.from(json["role"]!.map((x) => x)),
        dashboard: json["dashboard"] == null ? [] : List<dynamic>.from(json["dashboard"]!.map((x) => x)),
        isPpiRegistered: json["isPpiRegistered"] ?? false,
        isDeactivated: json["isDeactivated"] ?? false,
        dateInfo:
            json["dateInfo"] == null ? [] : List<DateInfo?>.from(json["dateInfo"]!.map((x) => DateInfo.fromJson(x))),
        addressInfo: json["addressInfo"] == null ? [] : List<dynamic>.from(json["addressInfo"]!.map((x) => x)),
        communicationInfo: json["communicationInfo"] == null
            ? []
            : List<CommunicationInfo?>.from(json["communicationInfo"]!.map((x) => CommunicationInfo.fromJson(x))),
        organizationDetails:
            json["organizationDetails"] == null ? null : OrganizationDetails.fromJson(json["organizationDetails"]),
        userEntityId: json["userEntityId"] ?? '',
        contactNumber: json["contactNumber"] ?? '',
        employmentIndustry: json["employmentIndustry"] ?? '',
        employmentType: json["employmentType"] ?? '',
        firstName: json["firstName"] ?? '',
        gender: json["gender"] ?? '',
        isDependant: json["isDependant"] ?? false,
        isMinor: json["isMinor"] ?? false,
        isNriCustomer: json["isNRICustomer"] ?? false,
        kycStatus: json["kycStatus"] ?? '',
        kycType: json["kycType"] ?? '',
        lastName: json["lastName"] ?? '',
        partnerOrganizationId: json["partnerOrganizationId"] ?? '',
        title: json["title"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "organizationType": organizationType,
        "role": role == null ? [] : List<dynamic>.from(role!.map((x) => x)),
        "dashboard": dashboard == null ? [] : List<dynamic>.from(dashboard!.map((x) => x)),
        "isPpiRegistered": isPpiRegistered,
        "isDeactivated": isDeactivated,
        "dateInfo": dateInfo == null ? [] : List<dynamic>.from(dateInfo!.map((x) => x!.toJson())),
        "addressInfo": addressInfo == null ? [] : List<dynamic>.from(addressInfo!.map((x) => x)),
        "communicationInfo":
            communicationInfo == null ? [] : List<dynamic>.from(communicationInfo!.map((x) => x!.toJson())),
        "organizationDetails": organizationDetails!.toJson(),
        "userEntityId": userEntityId,
        "contactNumber": contactNumber,
        "employmentIndustry": employmentIndustry,
        "employmentType": employmentType,
        "firstName": firstName,
        "gender": gender,
        "isDependant": isDependant,
        "isMinor": isMinor,
        "isNRICustomer": isNriCustomer,
        "kycStatus": kycStatus,
        "kycType": kycType,
        "lastName": lastName,
        "partnerOrganizationId": partnerOrganizationId,
        "title": title,
      };
}

class CommunicationInfo {
  CommunicationInfo({
    this.contactNo,
    this.contactNo2,
    this.notification,
    this.emailId,
  });

  String? contactNo;
  String? contactNo2;
  bool? notification;
  String? emailId;

  factory CommunicationInfo.fromJson(Map<String, dynamic> json) => CommunicationInfo(
        contactNo: json["contactNo"] ?? '',
        contactNo2: json["contactNo2"] ?? '',
        notification: json["notification"] ?? false,
        emailId: json["emailId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "contactNo": contactNo,
        "contactNo2": contactNo2,
        "notification": notification,
        "emailId": emailId,
      };
}

class DateInfo {
  DateInfo({
    this.dateType,
    this.date,
  });

  String? dateType;
  String? date;

  factory DateInfo.fromJson(Map<String, dynamic> json) => DateInfo(
        dateType: json["dateType"] ?? '',
        date: json["date"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "dateType": dateType,
        "date": date,
      };
}

class CommunicationInfoClass {
  CommunicationInfoClass({
    this.contactNo,
    this.contactNo2,
    this.notification,
    this.emailId,
  });

  String? contactNo;
  String? contactNo2;
  bool? notification;
  String? emailId;

  factory CommunicationInfoClass.fromJson(Map<String, dynamic> json) => CommunicationInfoClass(
        contactNo: json["contactNo"] ?? '',
        contactNo2: json["contactNo2"] ?? '',
        notification: json["notification"] ?? false,
        emailId: json["emailId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "contactNo": contactNo,
        "contactNo2": contactNo2,
        "notification": notification,
        "emailId": emailId,
      };
}

class DateInfoClass {
  DateInfoClass({
    this.dateType,
    this.date,
  });

  String? dateType;
  String? date;

  factory DateInfoClass.fromJson(Map<String, dynamic> json) => DateInfoClass(
        dateType: json["dateType"] ?? '',
        date: json["date"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "dateType": dateType,
        "date": date,
      };
}

class OrganizationDetails {
  OrganizationDetails({
    this.services,
    this.firstName,
    this.lastName,
  });

  Services? services;
  String? firstName;
  String? lastName;

  factory OrganizationDetails.fromJson(Map<String, dynamic> json) => OrganizationDetails(
        services: json["services"] == null ? null : Services.fromJson(json["services"]),
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "services": services!.toJson(),
        "firstName": firstName,
        "lastName": lastName,
      };
}

class Services {
  Services({
    this.tag,
    this.ppi,
    this.gps,
  });

  Ppi? tag;
  Ppi? ppi;
  Gps? gps;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        tag: json["tag"] == null ? null : Ppi.fromJson(json["tag"]),
        ppi: json["ppi"] == null ? null : Ppi.fromJson(json["ppi"]),
        gps: json["gps"] == null ? null : Gps.fromJson(json["gps"]),
      );

  Map<String, dynamic> toJson() => {
        "tag": tag!.toJson(),
        "ppi": ppi!.toJson(),
        "gps": gps!.toJson(),
      };
}

class Gps {
  Gps({
    this.partnerOrganization,
    this.issuer,
  });

  List<dynamic>? partnerOrganization;
  List<String?>? issuer;

  factory Gps.fromJson(Map<String, dynamic> json) => Gps(
        partnerOrganization:
            json["partnerOrganization"] == null ? [] : List<dynamic>.from(json["partnerOrganization"]!.map((x) => x)),
        issuer: json["issuer"] == null
            ? []
            : json["issuer"] == []
                ? []
                : List<String?>.from(json["issuer"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "partnerOrganization":
            partnerOrganization == null ? [] : List<dynamic>.from(partnerOrganization!.map((x) => x)),
        "issuer": issuer == null ? [] : List<dynamic>.from(issuer!.map((x) => x)),
      };
}

class Ppi {
  Ppi({
    this.partnerOrganization,
    this.issuer,
  });

  List<PartnerOrganization?>? partnerOrganization;
  List<Issuer?>? issuer;

  factory Ppi.fromJson(Map<String, dynamic> json) => Ppi(
        partnerOrganization: json["partnerOrganization"] == null
            ? []
            : List<PartnerOrganization?>.from(json["partnerOrganization"]!.map((x) => PartnerOrganization.fromJson(x))),
        issuer: json["issuer"] == null ? [] : List<Issuer?>.from(json["issuer"]!.map((x) => Issuer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partnerOrganization":
            partnerOrganization == null ? [] : List<dynamic>.from(partnerOrganization!.map((x) => x!.toJson())),
        "issuer": issuer == null ? [] : List<dynamic>.from(issuer!.map((x) => x!.toJson())),
      };
}

class Issuer {
  Issuer({
    this.name,
    this.kycStatus,
    this.kycType,
    this.kycDocuments,
  });

  String? name;
  String? kycStatus;
  String? kycType;
  KycDocuments? kycDocuments;

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        name: json["name"] ?? '',
        kycStatus: json["kycStatus"] ?? '',
        kycType: json["kycType"] ?? '',
        kycDocuments: json["kycDocuments"] == null ? null : KycDocuments.fromJson(json["kycDocuments"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "kycStatus": kycStatus,
        "kycType": kycType,
        "kycDocuments": kycDocuments,
      };
}

class KycDocuments {
  KycDocuments({
    this.identityProof,
    this.addressProof,
  });

  Proof? identityProof;
  Proof? addressProof;

  factory KycDocuments.fromJson(Map<String, dynamic> json) => KycDocuments(
        identityProof: json["IDENTITY_PROOF"] == null ? null : Proof.fromJson(json["IDENTITY_PROOF"]),
        addressProof: json["ADDRESS_PROOF"] == null ? null : Proof.fromJson(json["ADDRESS_PROOF"]),
      );

  Map<String, dynamic> toJson() => {
        "IDENTITY_PROOF": identityProof == null ? null : identityProof!.toJson(),
        "ADDRESS_PROOF": addressProof == null ? null : addressProof!.toJson(),
      };
}

class Proof {
  Proof({
    this.url,
    this.docUploadStatus,
  });

  String? url;
  String? docUploadStatus;

  factory Proof.fromJson(Map<String, dynamic> json) => Proof(
        url: json["url"] ?? '',
        docUploadStatus: json["docUploadStatus"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "docUploadStatus": docUploadStatus,
      };
}

class PartnerOrganization {
  PartnerOrganization({
    this.id,
    this.enrollmentId,
    this.cashBackPercentage,
  });

  String? id;
  String? enrollmentId;
  double? cashBackPercentage;

  factory PartnerOrganization.fromJson(Map<String, dynamic> json) => PartnerOrganization(
        id: json["id"] ?? '',
        enrollmentId: json["enrollmentId"] ?? '',
        cashBackPercentage: json["cashBackPercentage"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "enrollmentId": enrollmentId,
        "cashBackPercentage": cashBackPercentage,
      };
}
