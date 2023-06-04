class UserModel {
  UserModel({
    required this.data,
  });

  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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

  Message message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message(
      {required this.id,
      required this.enrollmentId,
      required this.contactNumber,
      required this.status,
      required this.organizations,
      required this.accountInformation,
      required this.createdBy,
      required this.updatedBy,
      required this.dateInfo,
      required this.addressInfo,
      required this.communicationInfo,
      required this.createdAt,
      required this.updatedAt,
      required this.v,
      required this.lastLogin,
      required this.name,
      this.profilePic});

  String id;
  String enrollmentId;
  String contactNumber;
  String status;
  List<Organization> organizations;
  List<dynamic> accountInformation;
  String createdBy;
  String updatedBy;
  List<dynamic> dateInfo;
  List<dynamic> addressInfo;
  List<dynamic> communicationInfo;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  DateTime lastLogin;
  String name;
  String? profilePic;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json["_id"] ?? '',
      enrollmentId: json["enrollmentId"] ?? '',
      contactNumber: json["contactNumber"],
      status: json["status"] ?? '',
      organizations: json["organizations"] != null
          ? List<Organization>.from(json["organizations"].map((x) => Organization.fromJson(x)))
          : [],
      accountInformation:
          json["accountInformation"] != null ? List<dynamic>.from(json["accountInformation"].map((x) => x)) : [],
      createdBy: json["createdBy"] ?? '',
      updatedBy: json["updatedBy"] ?? '',
      dateInfo: json["dateInfo"] != null ? List<dynamic>.from(json["dateInfo"].map((x) => x)) : [],
      addressInfo: json["addressInfo"] != null ? List<dynamic>.from(json["addressInfo"].map((x) => x)) : [],
      communicationInfo:
          json["communicationInfo"] != null ? List<dynamic>.from(json["communicationInfo"].map((x) => x)) : [],
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
      v: json["__v"] ?? 0,
      lastLogin: json["lastLogin"] != null ? DateTime.parse(json["lastLogin"]) : DateTime.now(),
      name: json["name"] ?? '',
      profilePic: json['profilePic'] ?? '');

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enrollmentId": enrollmentId,
        "contactNumber": contactNumber,
        "status": status,
        "organizations": List<dynamic>.from(organizations.map((x) => x.toJson())),
        "accountInformation": List<dynamic>.from(accountInformation.map((x) => x)),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "dateInfo": List<dynamic>.from(dateInfo.map((x) => x)),
        "addressInfo": List<dynamic>.from(addressInfo.map((x) => x)),
        "communicationInfo": List<dynamic>.from(communicationInfo.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "lastLogin": lastLogin.toIso8601String(),
        "name": name,
        "profilePic": profilePic
      };
}

class Organization {
  Organization({
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.organizationType,
    required this.role,
    required this.partnerOrganizationId,
    required this.dashboard,
    required this.kycDocuments,
    required this.displayName,
  });

  String organizationId;
  String organizationEnrollmentId;
  String organizationType;
  List<String> role;
  String partnerOrganizationId;
  List<String> dashboard;
  List<dynamic> kycDocuments;
  String displayName;

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        organizationId: json["organizationId"] ?? '',
        organizationEnrollmentId: json["organizationEnrollmentId"] ?? '',
        organizationType: json["organizationType"] ?? '',
        role: json["role"] != null ? List<String>.from(json["role"].map((x) => x)) : [],
        partnerOrganizationId: json["partnerOrganizationId"] ?? '',
        dashboard: json["dashboard"] != null ? List<String>.from(json["dashboard"].map((x) => x)) : [],
        kycDocuments: json["kycDocuments"] != null ? List<dynamic>.from(json["kycDocuments"].map((x) => x)) : [],
        displayName: json["displayName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationType": organizationType,
        "role": List<dynamic>.from(role.map((x) => x)),
        "partnerOrganizationId": partnerOrganizationId,
        "dashboard": List<dynamic>.from(dashboard.map((x) => x)),
        "kycDocuments": List<dynamic>.from(kycDocuments.map((x) => x)),
        "displayName": displayName,
      };
}
