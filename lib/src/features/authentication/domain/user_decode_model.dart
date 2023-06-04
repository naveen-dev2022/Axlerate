import 'dart:convert';

class UserDecodedModel {
  final String id;
  final String enrollmentId;
  final String status;
  final String email;
  final String contactNumber;
  final String tokenType;
  final List<UserDecodedOrganization?>? organizations;
  final String iat;
  final String exp;

  UserDecodedModel({
    required this.id,
    required this.enrollmentId,
    required this.status,
    required this.email,
    required this.contactNumber,
    required this.tokenType,
    required this.organizations,
    required this.iat,
    required this.exp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'enrollmentId': enrollmentId,
      'status': status,
      'email': email,
      'contactNumber': contactNumber,
      'tokenType': tokenType,
      'organizations': organizations?.map((x) => x!.toMap()).toList(),
      'iat': iat,
      'exp': exp,
    };
  }

  factory UserDecodedModel.fromMap(Map<String, dynamic> map) {
    return UserDecodedModel(
      id: map['id'] ?? '',
      enrollmentId: map['enrollmentId'] ?? '',
      status: map["status"] ?? '',
      email: map['email'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      tokenType: map['tokenType'] ?? '',
      organizations:
          List<UserDecodedOrganization>.from(map['organizations']?.map((x) => UserDecodedOrganization.fromMap(x))),
      iat: map['iat'] != null ? map['iat'].toString() : '',
      exp: map['exp'] != null ? map['exp'].toString() : '',
    );
  }

  factory UserDecodedModel.fromJson(Map<String, dynamic> source) => UserDecodedModel.fromMap(source);
}

class UserDecodedOrganization {
  final String organizationId;
  final String organizationEnrollmentId;
  final String? organizationEntityId;
  final String organizationType;
  final List<String> role;
  final String? userEntityId;
  final bool isDeactivated;
  // final List<dynamic> dateInfo;
  // final List<dynamic> addressInfo;
  // final List<dynamic> communicationInfo;
  final String status;
  //final bool isPpiRegistered;
  final String displayName;
  final String? logo;
  final String orgCode;

  UserDecodedOrganization(
      {required this.organizationId,
      required this.organizationEnrollmentId,
      required this.organizationEntityId,
      required this.organizationType,
      required this.role,
      required this.userEntityId,
      required this.isDeactivated,
      //required this.isPpiRegistered,
      required this.status,
      // required this.dateInfo,
      // required this.addressInfo,
      // required this.communicationInfo,
      required this.displayName,
      required this.logo,
      required this.orgCode});

  Map<String, dynamic> toMap() {
    return {
      'organizationId': organizationId,
      'organizationEnrollmentId': organizationEnrollmentId,
      'organizationEntityId': organizationEntityId,
      'organizationType': organizationType,
      'role': role,
      'userEntityId': userEntityId,
      'isDeactivated': isDeactivated,
      'status': status,
      // 'dateInfo': dateInfo,
      // 'addressInfo': addressInfo,
      // 'communicationInfo': communicationInfo,
      'displayName': displayName,
      'logo': logo,
      'orgCode': orgCode,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserDecodedOrganization.fromMap(Map<String, dynamic> map) {
    return UserDecodedOrganization(
      organizationId: map['organizationId'] ?? '',
      organizationEnrollmentId: map['organizationEnrollmentId'] ?? '',
      organizationEntityId: map["organizationEntityId"] ?? '',
      organizationType: map['organizationType'] ?? '',
      role: map['role'] == null ? [] : List<String>.from(map['role']),
      userEntityId: map["userEntityId"] ?? '',
      isDeactivated: map['isDeactivated'] ?? false,
      //isPpiRegistered: map['isPpiRegistered'] ?? false,
      // dateInfo: map['dateInfo'] == null ? [] : List<dynamic>.from(map['dateInfo']),
      // addressInfo: map['addressInfo'] == null ? [] : List<dynamic>.from(map['addressInfo']),
      // communicationInfo: map['communicationInfo'] == null ? [] : List<dynamic>.from(map['communicationInfo']),
      displayName: map['displayName'] ?? '',
      status: map['status'] ?? '',
      logo: map['logo'] ?? '',
      orgCode: map['orgCode'] ?? '',
    );
  }

  factory UserDecodedOrganization.fromJson(String source) => UserDecodedOrganization.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDecodedOrganization(organizationId: $organizationId, organizationEnrollmentId: $organizationEnrollmentId, organizationEntityId: $organizationEntityId, organizationType: $organizationType, role: $role, userEntityId: $userEntityId, isDeactivated: $isDeactivated, status: $status,displayName: $displayName, logo: $logo, orgCode: $orgCode)';
  }
}
