class ListUserFuelMappingResponseModel {
  ListUserFuelMappingResponseModel({
    required this.data,
  });

  final Data? data;
  ListUserFuelMappingResponseModel.unknown() : data = null;

  factory ListUserFuelMappingResponseModel.fromJson(Map<String, dynamic> json) {
    return ListUserFuelMappingResponseModel(
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

  final List<MessageElement> message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null
          ? []
          : List<MessageElement>.from(json["message"]!.map((x) => MessageElement.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.map((x) => x.toJson()).toList(),
      };
}

class MessageElement {
  MessageElement({
    required this.kycInfo,
    required this.id,
    required this.userEnrollmentId,
    required this.userId,
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.organizationEntityId,
    required this.orgCode,
    required this.issuerName,
    required this.kycStatus,
    required this.serviceType,
    required this.userEntityId,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.addressInfo,
    required this.mapStatus,
    required this.email,
    required this.salutationCode,
    required this.panNumber,
    required this.dateOfBirth,
    required this.dateInfo,
    required this.communicationInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.kycType,
    required this.regCustomerException,
    required this.vehicleEnrollmentId,
    required this.vehicleEntityId,
    required this.vehicleRegistrationNumber,
  });

  final List<dynamic> kycInfo;
  final String id;
  final String userEnrollmentId;
  final String userId;
  final String organizationId;
  final String organizationEnrollmentId;
  final String organizationEntityId;
  final String orgCode;
  final String issuerName;
  final String kycStatus;
  final String serviceType;
  final String userEntityId;
  final String firstName;
  final String lastName;
  final String contactNumber;
  final List<AddressInfo> addressInfo;
  final String mapStatus;
  final String email;
  final String salutationCode;
  final String panNumber;
  final DateTime? dateOfBirth;
  final List<dynamic> dateInfo;
  final List<dynamic> communicationInfo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final String kycType;
  final RegCustomerException? regCustomerException;
  final String vehicleEnrollmentId;
  final String vehicleEntityId;
  final String vehicleRegistrationNumber;

  factory MessageElement.fromJson(Map<String, dynamic> json) {
    return MessageElement(
      kycInfo: json["kycInfo"] == null ? [] : List<dynamic>.from(json["kycInfo"]!.map((x) => x)),
      id: json["_id"] ?? "",
      userEnrollmentId: json["userEnrollmentId"] ?? "",
      userId: json["userId"] ?? "",
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationEntityId: json["organizationEntityId"] ?? "",
      orgCode: json["orgCode"] ?? "",
      issuerName: json["issuerName"] ?? "",
      kycStatus: json["kycStatus"] ?? "",
      serviceType: json["serviceType"] ?? "",
      userEntityId: json["userEntityId"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      addressInfo: json["addressInfo"] == null
          ? []
          : List<AddressInfo>.from(json["addressInfo"]!.map((x) => AddressInfo.fromJson(x))),
      mapStatus: json["mapStatus"] ?? "",
      email: json["email"] ?? "",
      salutationCode: json["salutationCode"] ?? "",
      panNumber: json["panNumber"] ?? "",
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      dateInfo: json["dateInfo"] == null ? [] : List<dynamic>.from(json["dateInfo"]!.map((x) => x)),
      communicationInfo:
          json["communicationInfo"] == null ? [] : List<dynamic>.from(json["communicationInfo"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
      kycType: json["kycType"] ?? "",
      regCustomerException:
          json["regCustomerException"] == null ? null : RegCustomerException.fromJson(json["regCustomerException"]),
      vehicleEnrollmentId: json["vehicleEnrollmentId"] ?? "",
      vehicleEntityId: json["vehicleEntityId"] ?? "",
      vehicleRegistrationNumber: json["vehicleRegistrationNumber"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "kycInfo": kycInfo.map((x) => x).toList(),
        "_id": id,
        "userEnrollmentId": userEnrollmentId,
        "userId": userId,
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "orgCode": orgCode,
        "issuerName": issuerName,
        "kycStatus": kycStatus,
        "serviceType": serviceType,
        "userEntityId": userEntityId,
        "firstName": firstName,
        "lastName": lastName,
        "contactNumber": contactNumber,
        "addressInfo": addressInfo.map((x) => x.toJson()).toList(),
        "mapStatus": mapStatus,
        "email": email,
        "salutationCode": salutationCode,
        "panNumber": panNumber,
        "dateOfBirth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "dateInfo": dateInfo.map((x) => x).toList(),
        "communicationInfo": communicationInfo.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "kycType": kycType,
        "regCustomerException": regCustomerException?.toJson(),
        "vehicleEnrollmentId": vehicleEnrollmentId,
        "vehicleEntityId": vehicleEntityId,
        "vehicleRegistrationNumber": vehicleRegistrationNumber,
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

class RegCustomerException {
  RegCustomerException({
    required this.displayMessage,
    required this.exception,
    required this.id,
  });

  final String displayMessage;
  final RegCustomerExceptionException? exception;
  final String id;

  factory RegCustomerException.fromJson(Map<String, dynamic> json) {
    return RegCustomerException(
      displayMessage: json["displayMessage"] ?? "",
      exception: json["exception"] == null ? null : RegCustomerExceptionException.fromJson(json["exception"]),
      id: json["_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "displayMessage": displayMessage,
        "exception": exception?.toJson(),
        "_id": id,
      };
}

class RegCustomerExceptionException {
  RegCustomerExceptionException({
    required this.message,
    required this.errorCode,
  });

  final dynamic message;
  final int errorCode;

  factory RegCustomerExceptionException.fromJson(Map<String, dynamic> json) {
    return RegCustomerExceptionException(
      message: json["message"],
      errorCode: json["errorCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "errorCode": errorCode,
      };
}

class MessageMessage {
  MessageMessage({
    required this.displayMessage,
    required this.exception,
  });

  final String displayMessage;
  final MessageException? exception;

  factory MessageMessage.fromJson(Map<String, dynamic> json) {
    return MessageMessage(
      displayMessage: json["displayMessage"] ?? "",
      exception: json["exception"] == null ? null : MessageException.fromJson(json["exception"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "displayMessage": displayMessage,
        "exception": exception?.toJson(),
      };
}

class MessageException {
  MessageException({
    required this.message,
    required this.errorCode,
  });

  final String message;
  final int errorCode;

  factory MessageException.fromJson(Map<String, dynamic> json) {
    return MessageException(
      message: json["message"] ?? "",
      errorCode: json["errorCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "errorCode": errorCode,
      };
}
