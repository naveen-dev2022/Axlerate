class TagTxnListModel {
  TagTxnListModel({
    required this.data,
  });

  final Data? data;

  TagTxnListModel.unknown() : data = null;

  factory TagTxnListModel.fromJson(Map<String, dynamic> json) {
    return TagTxnListModel(
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
      message:
          json["message"] == null ? null : Message.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  Message({
    required this.docs,
    required this.count,
  });

  final List<TagTxnDoc> docs;
  final int count;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      docs: json["docs"] == null
          ? []
          : List<TagTxnDoc>.from(
              json["docs"]!.map((x) => TagTxnDoc.fromJson(x))),
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "docs": docs.map((x) => x.toJson()).toList(),
        "count": count,
      };
}

class TagTxnDoc {
  TagTxnDoc(
      {required this.transactionTime,
      required this.metadata,
      required this.rrn,
      required this.externalId,
      required this.id,
      required this.balance,
      required this.tollId,
      required this.organization,
      required this.tollReaderTime,
      required this.partnerOrganization,
      required this.transactionReference,
      required this.amount,
      required this.profileId,
      required this.laneNo,
      required this.tollPlazaName,
      required this.serialNumber,
      required this.tagId,
      required this.vehicleInfo,
      required this.type,
      required this.organizationEnrollmentId,
      required this.transactionType,
      required this.laneDirection,
      required this.from,
      required this.to});

  final DateTime? transactionTime;
  final Metadata? metadata;
  final String rrn;
  final String externalId;
  final String id;
  final int balance;
  final String tollId;
  final Organization? organization;
  final DateTime? tollReaderTime;
  final Organization? partnerOrganization;
  final String transactionReference;
  final int amount;
  final String profileId;
  final String laneNo;
  final String tollPlazaName;
  final String serialNumber;
  final String tagId;
  final VehicleInfo? vehicleInfo;
  final String type;
  final String organizationEnrollmentId;
  final String transactionType;
  final String laneDirection;
  final String from;
  final String to;

  factory TagTxnDoc.fromJson(Map<String, dynamic> json) {
    return TagTxnDoc(
      transactionTime: json["transactionTime"] == null
          ? null
          : DateTime.parse(json["transactionTime"]),
      metadata:
          json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
      rrn: json["rrn"] ?? "",
      externalId: json["externalId"] ?? "",
      id: json["_id"] ?? "",
      balance: json["balance"] ?? 0,
      tollId: json["tollId"] ?? "",
      organization: json["organization"] == null
          ? null
          : Organization.fromJson(json["organization"]),
      tollReaderTime: json["tollReaderTime"] == null
          ? null
          : DateTime.parse(json["tollReaderTime"]),
      partnerOrganization: json["partnerOrganization"] == null
          ? null
          : Organization.fromJson(json["partnerOrganization"]),
      transactionReference: json["transactionReference"] ?? "",
      amount: json["amount"] ?? 0,
      profileId: json["profileId"] ?? "",
      laneNo: json["laneNo"] ?? "",
      tollPlazaName: json["tollPlazaName"] ?? "",
      serialNumber: json["serialNumber"] ?? "",
      tagId: json["tagId"] ?? "",
      vehicleInfo: json["vehicleInfo"] == null
          ? null
          : VehicleInfo.fromJson(json["vehicleInfo"]),
      type: json["type"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      transactionType: json["transactionType"] ?? "",
      laneDirection: json["laneDirection"] ?? "",
      from: json["from"] ?? "",
      to: json["to"] ?? "",
    );
  }

  String get description {
    if (type == "CREDIT") {
      if (transactionType == "VIRUAL_ACCOUNT_CREDIT") {
        return 'Wallet Recharge by $tollPlazaName';
      }
      return "Wallet Reload by Admin";
    }
    if (transactionType == "C2C") {
      return 'Debited to Vehicle Wallet - $to';
    }
    return tollPlazaName;
  }

  Map<String, dynamic> toJson() => {
        "transactionTime": transactionTime?.toIso8601String(),
        "metadata": metadata?.toJson(),
        "rrn": rrn,
        "externalId": externalId,
        "_id": id,
        "balance": balance,
        "tollId": tollId,
        "organization": organization?.toJson(),
        "tollReaderTime": tollReaderTime?.toIso8601String(),
        "partnerOrganization": partnerOrganization?.toJson(),
        "transactionReference": transactionReference,
        "amount": amount,
        "profileId": profileId,
        "laneNo": laneNo,
        "tollPlazaName": tollPlazaName,
        "serialNumber": serialNumber,
        "tagId": tagId,
        "vehicleInfo": vehicleInfo?.toJson(),
        "type": type,
        "organizationEnrollmentId": organizationEnrollmentId,
        "transactionType": transactionType,
        "laneDirection": laneDirection,
        "from": from,
        "to": to,
      };
}

class Metadata {
  Metadata({
    required this.organizationEnrollmentId,
    required this.organizationId,
    required this.partnerOrganizationEnrollmentId,
    required this.partnerOrganizationId,
    required this.type,
    required this.vehicleEnrollmentId,
    required this.vehicleId,
  });

  final String organizationEnrollmentId;
  final String organizationId;
  final String partnerOrganizationEnrollmentId;
  final String partnerOrganizationId;
  final String type;
  final String vehicleEnrollmentId;
  final String vehicleId;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationId: json["organizationId"] ?? "",
      partnerOrganizationEnrollmentId:
          json["partnerOrganizationEnrollmentId"] ?? "",
      partnerOrganizationId: json["partnerOrganizationId"] ?? "",
      type: json["type"] ?? "",
      vehicleEnrollmentId: json["vehicleEnrollmentId"] ?? "",
      vehicleId: json["vehicleId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationId": organizationId,
        "partnerOrganizationEnrollmentId": partnerOrganizationEnrollmentId,
        "partnerOrganizationId": partnerOrganizationId,
        "type": type,
        "vehicleEnrollmentId": vehicleEnrollmentId,
        "vehicleId": vehicleId,
      };
}

class Organization {
  Organization({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.natureOfBusiness,
    required this.enrollmentId,
    required this.contactNumber,
    required this.cashBackPercentage,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String natureOfBusiness;
  final String enrollmentId;
  final String contactNumber;
  final int cashBackPercentage;

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json["_id"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      natureOfBusiness: json["natureOfBusiness"] ?? "",
      enrollmentId: json["enrollmentId"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      cashBackPercentage: json["cashBackPercentage"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "natureOfBusiness": natureOfBusiness,
        "enrollmentId": enrollmentId,
        "contactNumber": contactNumber,
        "cashBackPercentage": cashBackPercentage,
      };
}

class VehicleInfo {
  VehicleInfo({
    required this.vehicleId,
    required this.vehicleEntityId,
  });

  final String vehicleId;
  final String vehicleEntityId;

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      vehicleId: json["vehicleId"] ?? "",
      vehicleEntityId: json["vehicleEntityId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "vehicleId": vehicleId,
        "vehicleEntityId": vehicleEntityId,
      };
}
