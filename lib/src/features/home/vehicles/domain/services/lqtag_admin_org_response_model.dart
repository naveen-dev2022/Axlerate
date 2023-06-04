class LqTagAdminOrgResponseModel {
  LqTagAdminOrgResponseModel({
    required this.data,
  });

  final Data? data;
  const LqTagAdminOrgResponseModel.unknown() : data = null;

  factory LqTagAdminOrgResponseModel.fromJson(Map<String, dynamic> json) {
    return LqTagAdminOrgResponseModel(
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

  final List<MessageLqAdmin> message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null
          ? []
          : List<MessageLqAdmin>.from(json["message"]!.map((x) => MessageLqAdmin.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.map((x) => x.toJson()).toList(),
      };
}

class MessageLqAdmin {
  MessageLqAdmin({
    required this.id,
    required this.issuerName,
    required this.serviceType,
    required this.userEnrollmentId,
    required this.organizationEnrollmentId,
    required this.userEntityId,
    required this.firstName,
    required this.lastName,
    required this.kycStatus,
    required this.contactNumber,
  });

  final String id;
  final String issuerName;
  final String serviceType;
  final String userEnrollmentId;
  final String organizationEnrollmentId;
  final String kycStatus;
  final String userEntityId;
  final String firstName;
  final String lastName;
  final String contactNumber;

  factory MessageLqAdmin.fromJson(Map<String, dynamic> json) {
    return MessageLqAdmin(
      id: json["_id"] ?? "",
      issuerName: json["issuerName"] ?? "",
      serviceType: json["serviceType"] ?? "",
      userEnrollmentId: json["userEnrollmentId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      kycStatus: json['kycStatus'],
      userEntityId: json["userEntityId"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      contactNumber: json['contactNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "issuerName": issuerName,
        "serviceType": serviceType,
        "userEnrollmentId": userEnrollmentId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "userEntityId": userEntityId,
        "firstName": firstName,
        "lastName": lastName,
        'contactNumber': contactNumber,
      };
}
