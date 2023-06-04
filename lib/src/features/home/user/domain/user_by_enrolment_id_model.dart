import 'package:axlerate/src/features/home/user/domain/list_user_response_model.dart';

class UserByEnrolmentIdModel {
  UserByEnrolmentIdModel({
    required this.data,
  });

  final Data? data;
  const UserByEnrolmentIdModel.unknown() : data = null;

  factory UserByEnrolmentIdModel.fromJson(Map<String, dynamic> json) {
    return UserByEnrolmentIdModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.message,
  });

  final MessageUser? message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null ? null : MessageUser.fromJson(json["message"]),
    );
  }
}

class MessageUser {
  MessageUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.status,
    required this.organizations,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.lastLogin,
    required this.accountInformation,
    required this.enrollmentId,
    required this.isContactNumberVerified,
    required this.isEmailVerified,
    required this.profilePic,
    required this.contactNumber,
  });

  final String id;
  final String name;
  final String email;
  final String password;
  final String status;
  final List<Organization> organizations;
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

  factory MessageUser.fromJson(Map<String, dynamic> json) {
    return MessageUser(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      status: json["status"] ?? "",
      organizations: json["organizations"] == null
          ? []
          : List<Organization>.from(json["organizations"]!.map((x) => Organization.fromJson(x))),
      createdBy: json["createdBy"] ?? "",
      updatedBy: json["updatedBy"] ?? "",
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      v: json["__v"] ?? 0,
      lastLogin: json["lastLogin"] == null ? null : DateTime.parse(json["lastLogin"]),
      accountInformation:
          json["accountInformation"] == null ? [] : List<String>.from(json["accountInformation"]!.map((x) => x)),
      enrollmentId: json["enrollmentId"] ?? "",
      isContactNumberVerified: json["isContactNumberVerified"] ?? false,
      isEmailVerified: json["isEmailVerified"] ?? false,
      profilePic: json["profilePic"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
    );
  }
}

class Organization {
  Organization({
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.organizationType,
    required this.role,
    required this.dashboard,
    required this.isPpiRegistered,
    required this.isDeactivated,
    required this.dateInfo,
    required this.addressInfo,
    required this.communicationInfo,
    required this.userServices,
    required this.userEntityId,
    required this.contactNumber,
    required this.employmentIndustry,
    required this.employmentType,
    required this.firstName,
    required this.gender,
    required this.isDependant,
    required this.isMinor,
    required this.isNriCustomer,
    required this.kycStatus,
    required this.kycType,
    required this.lastName,
    required this.partnerEnrollmentId,
    required this.partnerOrganizationId,
    required this.title,
    required this.orgCode,
  });

  final String organizationId;
  final String organizationEnrollmentId;
  final String organizationType;
  final List<String> role;
  final List<String> dashboard;
  final bool isPpiRegistered;
  final bool isDeactivated;
  final List<DateInfo> dateInfo;
  final List<AddressInfo> addressInfo;
  final List<UserDoc> userServices;
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
  final String kycStatus;
  final String kycType;
  final String lastName;
  final String partnerEnrollmentId;
  final String partnerOrganizationId;
  final String title;
  final String orgCode;

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationType: json["organizationType"] ?? "",
      role: json["role"] == null ? [] : List<String>.from(json["role"]!.map((x) => x)),
      dashboard: json["dashboard"] == null ? [] : List<String>.from(json["dashboard"]!.map((x) => x)),
      isPpiRegistered: json["isPpiRegistered"] ?? false,
      isDeactivated: json["isDeactivated"] ?? false,
      dateInfo: json["dateInfo"] == null ? [] : List<DateInfo>.from(json["dateInfo"]!.map((x) => DateInfo.fromJson(x))),
      addressInfo: json["addressInfo"] == null
          ? []
          : List<AddressInfo>.from(json["addressInfo"]!.map((x) => AddressInfo.fromJson(x))),
      userServices: List<UserDoc>.from(json['userServices'].map((x) => UserDoc.fromJson(x))),
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
      kycStatus: json["kycStatus"] ?? "",
      kycType: json["kycType"] ?? "",
      lastName: json["lastName"] ?? "",
      partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
      partnerOrganizationId: json["partnerOrganizationId"] ?? "",
      title: json["title"] ?? "",
      orgCode: json["orgCode"] ?? "",
    );
  }
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
}

Organization? getUserOrganizationData(UserByEnrolmentIdModel userData, String orgEnrollId) {
  // log('Before Map');
  Organization? org;
  try {
    for (Organization e in userData.data?.message?.organizations ?? []) {
      // log('Running For loop');
      if (e.organizationEnrollmentId == orgEnrollId) {
        org = e;
        break;
      }
    }
  } catch (e) {
    return org;
  }
  // log('The Result Entity ID is -> $result');
  return org;
}
