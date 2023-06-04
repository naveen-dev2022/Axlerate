class UpdatedUserByEnrolmentIdModel {
  UpdatedUserByEnrolmentIdModel({
    required this.data,
  });

  final Data? data;
  const UpdatedUserByEnrolmentIdModel.unknown() : data = null;

  factory UpdatedUserByEnrolmentIdModel.fromJson(Map<String, dynamic> json) {
    return UpdatedUserByEnrolmentIdModel(
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

  final UpdatedMessageUser? message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null ? null : UpdatedMessageUser.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class UpdatedMessageUser {
  UpdatedMessageUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.status,
    required this.enrollmentId,
    required this.contactNumber,
    required this.organizations,
    required this.isEmailVerified,
    required this.isContactNumberVerified,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.currentLogin,
    required this.lastLogin,
    required this.accountInformation,
    required this.profilePic,
  });

  final String id;
  final String name;
  final String email;
  final String password;
  final String status;
  final List<OrganizationUpdated> organizations;
  final String createdBy;
  final String updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final DateTime? lastLogin;
  final List<String> accountInformation;
  final String enrollmentId;
  final bool isContactNumberVerified;
  final bool isEmailVerified;
  final String profilePic;
  final String contactNumber;
  final DateTime? currentLogin;

  factory UpdatedMessageUser.fromJson(Map<String, dynamic> json) {
    return UpdatedMessageUser(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      enrollmentId: json["enrollmentId"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      status: json["status"] ?? "",
      organizations: json["organizations"] == null
          ? []
          : List<OrganizationUpdated>.from(json["organizations"]!.map((x) => OrganizationUpdated.fromJson(x))),
      isEmailVerified: json["isEmailVerified"] ?? false,
      isContactNumberVerified: json["isContactNumberVerified"] ?? false,
      createdBy: json["createdBy"] ?? "",
      updatedBy: json["updatedBy"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
      currentLogin: DateTime.tryParse(json["currentLogin"] ?? ""),
      lastLogin: DateTime.tryParse(json["lastLogin"] ?? ""),
      accountInformation:
          json["accountInformation"] == null ? [] : List<String>.from(json["accountInformation"]!.map((x) => x)),
      profilePic: json["profilePic"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "enrollmentId": enrollmentId,
        "contactNumber": contactNumber,
        "status": status,
        "organizations": organizations.map((x) => x.toJson()).toList(),
        "accountInformation": accountInformation.map((x) => x).toList(),
        "isEmailVerified": isEmailVerified,
        "isContactNumberVerified": isContactNumberVerified,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "currentLogin": currentLogin?.toIso8601String(),
        "lastLogin": lastLogin?.toIso8601String(),
        "profilePic": profilePic,
      };
}

class OrganizationUpdated {
  OrganizationUpdated({
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.orgCode,
    required this.organizationType,
    required this.role,
    required this.dashboard,
    required this.isDeactivated,
    required this.userServices,
  });

  final String organizationId;
  final String organizationEnrollmentId;
  final String orgCode;
  final String organizationType;
  final List<String> role;
  final List<dynamic> dashboard;
  final bool isDeactivated;
  final List<UserService> userServices;

  factory OrganizationUpdated.fromJson(Map<String, dynamic> json) {
    return OrganizationUpdated(
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      orgCode: json["orgCode"] ?? "",
      organizationType: json["organizationType"] ?? "",
      role: json["role"] == null ? [] : List<String>.from(json["role"]!.map((x) => x)),
      dashboard: json["dashboard"] == null ? [] : List<dynamic>.from(json["dashboard"]!.map((x) => x)),
      isDeactivated: json["isDeactivated"] ?? false,
      userServices: json["userServices"] == null
          ? []
          : List<UserService>.from(json["userServices"]!.map((x) => UserService.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "orgCode": orgCode,
        "organizationType": organizationType,
        "role": role.map((x) => x).toList(),
        "dashboard": dashboard.map((x) => x).toList(),
        "isDeactivated": isDeactivated,
        "userServices": userServices.map((x) => x.toJson()).toList(),
      };
}

class UserService {
  UserService({
    required this.id,
    required this.issuerName,
    required this.organizationId,
    required this.partnerEnrollmentId,
    required this.serviceType,
    required this.userEnrollmentId,
    required this.v,
    required this.addressInfo,
    required this.communicationInfo,
    required this.contactNumber,
    required this.createdAt,
    required this.dateInfo,
    required this.kycInfo,
    required this.kycStatus,
    required this.kycType,
    required this.orgCode,
    required this.organizationEnrollmentId,
    required this.partnerId,
    required this.updatedAt,
    required this.userEntityId,
    required this.userId,
    required this.employmentIndustry,
    required this.employmentType,
    required this.firstName,
    required this.gender,
    required this.isDependant,
    required this.isMinor,
    required this.isNriCustomer,
    required this.lastName,
    required this.title,
    required this.email,
    required this.salutationCode,
    required this.panNumber,
    required this.dateOfBirth,
    required this.kycDocuments,
  });

  final String id;
  final String issuerName;
  final String organizationId;
  final String partnerEnrollmentId;
  final String serviceType;
  final String userEnrollmentId;
  final int v;
  final List<AddressInfo> addressInfo;
  final List<CommunicationInfo> communicationInfo;
  final String contactNumber;
  final DateTime? createdAt;
  final List<DateInfo> dateInfo;
  final List<KycInfo> kycInfo;
  final String kycStatus;
  final String kycType;
  final String orgCode;
  final String organizationEnrollmentId;
  final String partnerId;
  final DateTime? updatedAt;
  final String userEntityId;
  final String userId;
  final String employmentIndustry;
  final String employmentType;
  final String firstName;
  final String gender;
  final bool isDependant;
  final bool isMinor;
  final bool isNriCustomer;
  final String lastName;
  final String title;
  final String email;
  final String salutationCode;
  final String panNumber;
  final String dateOfBirth;
  final KycDocuments? kycDocuments;

  factory UserService.fromJson(Map<String, dynamic> json) {
    return UserService(
      id: json["_id"] ?? "",
      issuerName: json["issuerName"] ?? "",
      organizationId: json["organizationId"] ?? "",
      partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
      serviceType: json["serviceType"] ?? "",
      userEnrollmentId: json["userEnrollmentId"] ?? "",
      v: json["__v"] ?? 0,
      addressInfo: json["addressInfo"] == null
          ? []
          : List<AddressInfo>.from(json["addressInfo"]!.map((x) => AddressInfo.fromJson(x))),
      communicationInfo: json["communicationInfo"] == null
          ? []
          : List<CommunicationInfo>.from(json["communicationInfo"]!.map((x) => CommunicationInfo.fromJson(x))),
      contactNumber: json["contactNumber"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      dateInfo: json["dateInfo"] == null ? [] : List<DateInfo>.from(json["dateInfo"]!.map((x) => DateInfo.fromJson(x))),
      kycInfo: json["kycInfo"] == null ? [] : List<KycInfo>.from(json["kycInfo"]!.map((x) => KycInfo.fromJson(x))),
      kycStatus: json["kycStatus"] ?? "",
      kycType: json["kycType"] ?? "",
      orgCode: json["orgCode"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      partnerId: json["partnerId"] ?? "",
      userEntityId: json["userEntityId"] ?? "",
      userId: json["userId"] ?? "",
      employmentIndustry: json["employmentIndustry"] ?? "",
      employmentType: json["employmentType"] ?? "",
      firstName: json["firstName"] ?? "",
      gender: json["gender"] ?? "",
      isDependant: json["isDependant"] ?? false,
      isMinor: json["isMinor"] ?? false,
      isNriCustomer: json["isNRICustomer"] ?? false,
      lastName: json["lastName"] ?? "",
      title: json["title"] ?? "",
      email: json["email"] ?? "",
      salutationCode: json["salutationCode"] ?? "",
      panNumber: json["panNumber"] ?? "",
      dateOfBirth: json["dateOfBirth"] ?? "",
      updatedAt: json["updatedAt"] != null ? DateTime.tryParse(json["updatedAt"] ?? "") : json["updatedAt"] ?? "",
      kycDocuments: json["kycDocuments"] == null ? null : KycDocuments.fromJson(json["kycDocuments"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "issuerName": issuerName,
        "organizationId": organizationId,
        "partnerEnrollmentId": partnerEnrollmentId,
        "serviceType": serviceType,
        "userEnrollmentId": userEnrollmentId,
        "__v": v,
        "addressInfo": addressInfo.map((x) => x.toJson()).toList(),
        "communicationInfo": communicationInfo.map((x) => x.toJson()).toList(),
        "contactNumber": contactNumber,
        "createdAt": createdAt?.toIso8601String(),
        "dateInfo": dateInfo.map((x) => x.toJson()).toList(),
        "kycInfo": kycInfo.map((x) => x.toJson()).toList(),
        "kycStatus": kycStatus,
        "kycType": kycType,
        "orgCode": orgCode,
        "organizationEnrollmentId": organizationEnrollmentId,
        "partnerId": partnerId,
        "updatedAt": updatedAt?.toIso8601String(),
        "userEntityId": userEntityId,
        "userId": userId,
        "employmentIndustry": employmentIndustry,
        "employmentType": employmentType,
        "firstName": firstName,
        "gender": gender,
        "isDependant": isDependant,
        "isMinor": isMinor,
        "isNRICustomer": isNriCustomer,
        "lastName": lastName,
        "title": title,
        "email": email,
        "salutationCode": salutationCode,
        "panNumber": panNumber,
        "dateOfBirth": dateOfBirth,
        "kycDocuments": kycDocuments?.toJson(),
      };
}

class KycDocuments {
  KycDocuments({
    required this.addressProof,
  });

  final AddressProof? addressProof;

  factory KycDocuments.fromJson(Map<String, dynamic> json) {
    return KycDocuments(
      addressProof: json["addressProof"] == null ? null : AddressProof.fromJson(json["addressProof"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "addressProof": addressProof?.toJson(),
      };
}

class AddressProof {
  AddressProof({
    required this.url,
    required this.docUploadStatus,
  });

  final String url;
  final String docUploadStatus;

  factory AddressProof.fromJson(Map<String, dynamic> json) {
    return AddressProof(
      url: json["url"] ?? "",
      docUploadStatus: json["docUploadStatus"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "docUploadStatus": docUploadStatus,
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

class KycInfo {
  KycInfo({
    required this.documentNo,
    required this.documentType,
  });

  final String documentNo;
  final String documentType;

  factory KycInfo.fromJson(Map<String, dynamic> json) {
    return KycInfo(
      documentNo: json["documentNo"] ?? "",
      documentType: json["documentType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "documentNo": documentNo,
        "documentType": documentType,
      };
}

UserService? getOrgServiceFromUserEnrollId(
  OrganizationUpdated? organizationUpdated,
  String serviceType, {
  String? issuerName,
  String? organizationEnrollmentId,
}) {
  int index = 0;
  try {
    if (organizationUpdated == null || organizationUpdated.userServices.isEmpty) {
      return null;
    }
    if (organizationEnrollmentId != null) {
      index = organizationUpdated.userServices.indexWhere((element) {
        return organizationUpdated.organizationEnrollmentId == organizationEnrollmentId.toUpperCase() &&
            element.serviceType == serviceType &&
            element.issuerName == issuerName;
      });
    } else {
      if (issuerName != null) {
        index = organizationUpdated.userServices.indexWhere((element) {
          return element.issuerName == issuerName && element.serviceType == serviceType;
        });
      } else {
        index = organizationUpdated.userServices.indexWhere((element) {
          return element.serviceType == serviceType;
        });
      }
    }
    if (index == -1) {
      return null;
    }
    return organizationUpdated.userServices[index];
  } catch (e) {
    return null;
  }
}

UserService? getOrgServiceFromUserEnrollIdByOrgList(
  List<OrganizationUpdated>? listOrganizationUpdated,
  // String? currentOrgEnrollId,
  String serviceType, {
  String? issuerName,
}) {
  int index = 0;
  late OrganizationUpdated? organizationUpdated;
  try {
    if (listOrganizationUpdated == null || listOrganizationUpdated.isEmpty) {
      return null;
    }

    // listOrganizationUpdated.map((e) {
    //   // if (e.organizationEnrollmentId == currentOrgEnrollId) {
    //   return organizationUpdated = e;
    //   // }
    // });
    organizationUpdated = listOrganizationUpdated.map((e) => e) as OrganizationUpdated?;

    if (issuerName != null) {
      index = organizationUpdated!.userServices.indexWhere((element) {
        return element.issuerName == issuerName && element.serviceType == serviceType;
      });
    } else {
      index = organizationUpdated!.userServices.indexWhere((element) {
        return element.serviceType == serviceType;
      });
    }

    if (index == -1) {
      return null;
    }
    return organizationUpdated.userServices[index];
  } catch (e) {
    return null;
  }
}
