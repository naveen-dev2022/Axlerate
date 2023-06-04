class OrganizationResponseModel {
  OrganizationResponseModel({
    required this.data,
  });

  Data data;

  factory OrganizationResponseModel.fromJson(Map<String, dynamic> json) => OrganizationResponseModel(
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
  Message({
    required this.id,
    required this.enrollmentId,
    required this.orgCode,
    required this.status,
    required this.organizationType,
    required this.title,
    required this.panNumber,
    required this.firstName,
    required this.lastName,
    required this.natureOfBusiness,
    required this.email,
    required this.incorporateDate,
    required this.contactNumber,
    required this.addresses,
    required this.createdBy,
    required this.updatedBy,
    required this.createdByOrg,
    required this.updatedByOrg,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String enrollmentId;
  String orgCode;
  String status;
  String organizationType;
  String title;
  String panNumber;
  String firstName;
  String lastName;
  String natureOfBusiness;
  String email;
  DateTime incorporateDate;
  String contactNumber;
  Addresses addresses;
  String createdBy;
  String updatedBy;
  String createdByOrg;
  String updatedByOrg;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        enrollmentId: json["enrollmentId"],
        orgCode: json["orgCode"],
        status: json["status"],
        organizationType: json["organizationType"],
        title: json["title"],
        panNumber: json["panNumber"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        natureOfBusiness: json["natureOfBusiness"],
        email: json["email"],
        incorporateDate: DateTime.parse(json["incorporateDate"]),
        contactNumber: json["contactNumber"],
        addresses: Addresses.fromJson(json["addresses"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        createdByOrg: json["createdByOrg"],
        updatedByOrg: json["updatedByOrg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enrollmentId": enrollmentId,
        "orgCode": orgCode,
        "status": status,
        "organizationType": organizationType,
        "title": title,
        "panNumber": panNumber,
        "firstName": firstName,
        "lastName": lastName,
        "natureOfBusiness": natureOfBusiness,
        "email": email,
        "incorporateDate": incorporateDate.toIso8601String(),
        "contactNumber": contactNumber,
        "addresses": addresses.toJson(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdByOrg": createdByOrg,
        "updatedByOrg": updatedByOrg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Addresses {
  Addresses({
    required this.officeAddress,
    required this.communicationAddress,
  });

  Address officeAddress;
  Address communicationAddress;

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
        officeAddress: Address.fromJson(json["officeAddress"]),
        communicationAddress: Address.fromJson(json["communicationAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "officeAddress": officeAddress.toJson(),
        "communicationAddress": communicationAddress.toJson(),
      };
}

class Address {
  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.state,
  });

  String addressLine1;
  String addressLine2;
  String city;
  String country;
  String state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        country: json["country"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "country": country,
        "state": state,
      };
}
