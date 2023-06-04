// class UserProfileModel {
//   UserProfileModel({
//     required this.data,
//   });

//   Data? data;

//   UserProfileModel.unknown() : data = null;

//   factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data!.toJson(),
//       };
// }

// class Data {
//   Data({
//     required this.message,
//   });

//   Message message;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         message: Message.fromJson(json["message"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message.toJson(),
//       };
// }

// class Message {
//   Message({
//     required this.id,
//     required this.name,
//     required this.enrollmentId,
//     required this.email,
//     required this.contactNumber,
//     required this.status,
//     required this.organizations,
//     required this.accountInformation,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.lastLogin,
//     required this.profilePic,
//     required this.isContactNumberVerified,
//     required this.isEmailVerified,
//   });

//   String id;
//   String name;
//   String enrollmentId;
//   String email;
//   String contactNumber;
//   String status;
//   List<Organization> organizations;
//   List<dynamic> accountInformation;
//   String createdBy;
//   String updatedBy;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;
//   DateTime lastLogin;
//   String profilePic;
//   bool isContactNumberVerified;
//   bool isEmailVerified;

//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//         id: json["_id"] ?? '',
//         name: json["name"] ?? '',
//         enrollmentId: json["enrollmentId"] ?? '',
//         email: json["email"] ?? '',
//         contactNumber: json["contactNumber"] ?? '',
//         status: json["status"] ?? '',
//         organizations: json["organizations"] != null
//             ? List<Organization>.from(json["organizations"].map((x) => Organization.fromJson(x)))
//             : [],
//         accountInformation:
//             json["accountInformation"] != null ? List<dynamic>.from(json["accountInformation"].map((x) => x)) : [],
//         createdBy: json["createdBy"] ?? '',
//         updatedBy: json["updatedBy"] ?? '',
//         createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
//         updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
//         v: json["__v"] ?? 0,
//         lastLogin: json["lastLogin"] != null ? DateTime.parse(json["lastLogin"]) : DateTime.now(),
//         profilePic: json["profilePic"] ?? '',
//         isContactNumberVerified: json["isContactNumberVerified"] ?? false,
//         isEmailVerified: json["isEmailVerified"] ?? false,
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "enrollmentId": enrollmentId,
//         "email": email,
//         "contactNumber": contactNumber,
//         "status": status,
//         "organizations": List<dynamic>.from(organizations.map((x) => x.toJson())),
//         "accountInformation": List<dynamic>.from(accountInformation.map((x) => x)),
//         "createdBy": createdBy,
//         "updatedBy": updatedBy,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "lastLogin": lastLogin.toIso8601String(),
//         "profilePic": profilePic,
//         "isContactNumberVerified": isContactNumberVerified,
//         "isEmailVerified": isEmailVerified,
//       };
// }

// class Organization {
//   Organization({
//     required this.organizationId,
//     required this.organizationEnrollmentId,
//     required this.organizationType,
//     required this.dashboard,
//     required this.role,
//     required this.kycDocuments,
//     required this.isDeactivated,
//     required this.dateInfo,
//     required this.addressInfo,
//     required this.communicationInfo,
//   });

//   String organizationId;
//   String organizationEnrollmentId;
//   String organizationType;
//   List<String> dashboard;
//   List<String> role;
//   List<dynamic> kycDocuments;
//   bool isDeactivated;
//   List<dynamic> dateInfo;
//   List<dynamic> addressInfo;
//   List<dynamic> communicationInfo;

//   factory Organization.fromJson(Map<String, dynamic> json) => Organization(
//         organizationId: json["organizationId"] ?? '',
//         organizationEnrollmentId: json["organizationEnrollmentId"] ?? '',
//         organizationType: json["organizationType"] ?? '',
//         dashboard: json["dashboard"] != null ? List<String>.from(json["dashboard"].map((x) => x)) : [],
//         role: json["role"] != null ? List<String>.from(json["role"].map((x) => x)) : [],
//         kycDocuments: json["kycDocuments"] != null ? List<dynamic>.from(json["kycDocuments"].map((x) => x)) : [],
//         isDeactivated: json["isDeactivated"] ?? false,
//         dateInfo: json["dateInfo"] != null ? List<dynamic>.from(json["dateInfo"].map((x) => x)) : [],
//         addressInfo: json["addressInfo"] != null ? List<dynamic>.from(json["addressInfo"].map((x) => x)) : [],
//         communicationInfo:
//             json["communicationInfo"] != null ? List<dynamic>.from(json["communicationInfo"].map((x) => x)) : [],
//       );

//   Map<String, dynamic> toJson() => {
//         "organizationId": organizationId,
//         "organizationEnrollmentId": organizationEnrollmentId,
//         "organizationType": organizationType,
//         "dashboard": List<dynamic>.from(dashboard.map((x) => x)),
//         "role": List<dynamic>.from(role.map((x) => x)),
//         "kycDocuments": List<dynamic>.from(kycDocuments.map((x) => x)),
//         "isDeactivated": isDeactivated,
//         "dateInfo": List<dynamic>.from(dateInfo.map((x) => x)),
//         "addressInfo": List<dynamic>.from(addressInfo.map((x) => x)),
//         "communicationInfo": List<dynamic>.from(communicationInfo.map((x) => x)),
//       };
// }

class UserProfileModel {
  UserProfileModel({
    required this.data,
  });

  final Data? data;

  UserProfileModel.unknown() : data = null;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
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
    required this.id,
    required this.name,
    required this.enrollmentId,
    required this.email,
    required this.contactNumber,
    required this.status,
    required this.organizations,
    required this.accountInformation,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.lastLogin,
    required this.profilePic,
    required this.isContactNumberVerified,
    required this.isEmailVerified,
  });

  final String id;
  final String name;
  final String enrollmentId;
  final String email;
  final String contactNumber;
  final String status;
  final List<Organization> organizations;
  final List<String> accountInformation;
  final String createdBy;
  final String updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final DateTime? lastLogin;
  final String profilePic;
  final bool isContactNumberVerified;
  final bool isEmailVerified;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      enrollmentId: json["enrollmentId"] ?? "",
      email: json["email"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      status: json["status"] ?? "",
      organizations: json["organizations"] == null
          ? []
          : List<Organization>.from(json["organizations"]!.map((x) => Organization.fromJson(x))),
      accountInformation:
          json["accountInformation"] == null ? [] : List<String>.from(json["accountInformation"]!.map((x) => x)),
      createdBy: json["createdBy"] ?? "",
      updatedBy: json["updatedBy"] ?? "",
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      v: json["__v"] ?? 0,
      lastLogin: json["lastLogin"] == null ? null : DateTime.parse(json["lastLogin"]),
      profilePic: json["profilePic"] ?? "",
      isContactNumberVerified: json["isContactNumberVerified"] ?? false,
      isEmailVerified: json["isEmailVerified"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "enrollmentId": enrollmentId,
        "email": email,
        "contactNumber": contactNumber,
        "status": status,
        "organizations": organizations.map((x) => x.toJson()).toList(),
        "accountInformation": accountInformation.map((x) => x).toList(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "lastLogin": lastLogin?.toIso8601String(),
        "profilePic": profilePic,
        "isContactNumberVerified": isContactNumberVerified,
        "isEmailVerified": isEmailVerified,
      };
}

class Organization {
  Organization({
    required this.isPpiRegistered,
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.organizationType,
    required this.dashboard,
    required this.role,
    required this.kycDocuments,
    required this.isDeactivated,
    required this.dateInfo,
    required this.addressInfo,
    required this.communicationInfo,
    required this.userEntityId,
    required this.contactNumber,
    required this.employmentIndustry,
    required this.employmentType,
    required this.firstName,
    required this.gender,
    required this.isDependant,
    required this.isMinor,
    required this.isNriCustomer,
    required this.lastName,
    required this.partnerOrganizationId,
    required this.title,
    required this.organizationEntityId,
    required this.kycStatus,
    required this.kycType,
    required this.partnerEnrollmentId,
  });

  final bool isPpiRegistered;
  final String organizationId;
  final String organizationEnrollmentId;
  final String organizationType;
  final List<String> dashboard;
  final List<String> role;
  final List<dynamic> kycDocuments;
  final bool isDeactivated;
  final List<DateInfo> dateInfo;
  final List<AddressInfo> addressInfo;
  final List<CommunicationInfo> communicationInfo;
  final String userEntityId;
  final String contactNumber;
  final String employmentIndustry;
  final String employmentType;
  final String firstName;
  final String gender;
  final bool isDependant;
  final bool isMinor;
  final bool isNriCustomer;
  final String lastName;
  final String partnerOrganizationId;
  final String title;
  final String organizationEntityId;
  final String kycStatus;
  final String kycType;
  final String partnerEnrollmentId;

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      isPpiRegistered: json["isPpiRegistered"] ?? false,
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationType: json["organizationType"] ?? "",
      dashboard: json["dashboard"] == null ? [] : List<String>.from(json["dashboard"]!.map((x) => x)),
      role: json["role"] == null ? [] : List<String>.from(json["role"]!.map((x) => x)),
      kycDocuments: json["kycDocuments"] == null ? [] : List<dynamic>.from(json["kycDocuments"]!.map((x) => x)),
      isDeactivated: json["isDeactivated"] ?? false,
      dateInfo: json["dateInfo"] == null ? [] : List<DateInfo>.from(json["dateInfo"]!.map((x) => DateInfo.fromJson(x))),
      addressInfo: json["addressInfo"] == null
          ? []
          : List<AddressInfo>.from(json["addressInfo"]!.map((x) => AddressInfo.fromJson(x))),
      communicationInfo: json["communicationInfo"] == null
          ? []
          : List<CommunicationInfo>.from(json["communicationInfo"]!.map((x) => CommunicationInfo.fromJson(x))),
      userEntityId: json["userEntityId"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      employmentIndustry: json["employmentIndustry"] ?? "",
      employmentType: json["employmentType"] ?? "",
      firstName: json["firstName"] ?? "",
      gender: json["gender"] ?? "",
      isDependant: json["isDependant"] ?? false,
      isMinor: json["isMinor"] ?? false,
      isNriCustomer: json["isNRICustomer"] ?? false,
      lastName: json["lastName"] ?? "",
      partnerOrganizationId: json["partnerOrganizationId"] ?? "",
      title: json["title"] ?? "",
      organizationEntityId: json["organizationEntityId"] ?? "",
      kycStatus: json["kycStatus"] ?? "",
      kycType: json["kycType"] ?? "",
      partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "isPpiRegistered": isPpiRegistered,
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationType": organizationType,
        "dashboard": dashboard.map((x) => x).toList(),
        "role": role.map((x) => x).toList(),
        "kycDocuments": kycDocuments.map((x) => x).toList(),
        "isDeactivated": isDeactivated,
        "dateInfo": dateInfo.map((x) => x.toJson()).toList(),
        "addressInfo": addressInfo.map((x) => x.toJson()).toList(),
        "communicationInfo": communicationInfo.map((x) => x.toJson()).toList(),
        "userEntityId": userEntityId,
        "contactNumber": contactNumber,
        "employmentIndustry": employmentIndustry,
        "employmentType": employmentType,
        "firstName": firstName,
        "gender": gender,
        "isDependant": isDependant,
        "isMinor": isMinor,
        "isNRICustomer": isNriCustomer,
        "lastName": lastName,
        "partnerOrganizationId": partnerOrganizationId,
        "title": title,
        "organizationEntityId": organizationEntityId,
        "kycStatus": kycStatus,
        "kycType": kycType,
        "partnerEnrollmentId": partnerEnrollmentId,
      };
}

class AddressInfo {
  AddressInfo({
    required this.addressCategory,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
  });

  final String addressCategory;
  final String address1;
  final String address2;
  final String address3;
  final String city;
  final String state;
  final String country;
  final String pinCode;

  factory AddressInfo.fromJson(Map<String, dynamic> json) {
    return AddressInfo(
      addressCategory: json["addressCategory"] ?? "",
      address1: json["address1"] ?? "",
      address2: json["address2"] ?? "",
      address3: json["address3"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      country: json["country"] ?? "",
      pinCode: json["pinCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "addressCategory": addressCategory,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "city": city,
        "state": state,
        "country": country,
        "pinCode": pinCode,
      };
}

class CommunicationInfo {
  CommunicationInfo({
    required this.contactNo,
    required this.contactNo2,
    required this.notification,
    required this.emailId,
  });

  final String contactNo;
  final String contactNo2;
  final bool notification;
  final String emailId;

  factory CommunicationInfo.fromJson(Map<String, dynamic> json) {
    return CommunicationInfo(
      contactNo: json["contactNo"] ?? "",
      contactNo2: json["contactNo2"] ?? "",
      notification: json["notification"] ?? false,
      emailId: json["emailId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "contactNo": contactNo,
        "contactNo2": contactNo2,
        "notification": notification,
        "emailId": emailId,
      };
}

class DateInfo {
  DateInfo({
    required this.dateType,
    required this.date,
  });

  final String dateType;
  final String date;

  factory DateInfo.fromJson(Map<String, dynamic> json) {
    return DateInfo(
      dateType: json["dateType"] ?? "",
      date: json["date"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "dateType": dateType,
        "date": date,
      };
}
