class ListLqtagVehicles {
  ListLqtagVehicles({
    required this.data,
  });

  final Data? data;
  ListLqtagVehicles.unknown() : data = null;

  factory ListLqtagVehicles.fromJson(Map<String, dynamic> json) {
    return ListLqtagVehicles(
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
    required this.docs,
    required this.count,
  });

  final List<Doc> docs;
  final int count;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      docs: json["docs"] == null ? [] : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "docs": docs.map((x) => x.toJson()).toList(),
        "count": count,
      };
}

class Doc {
  Doc({
    required this.issuerName,
    required this.registrationNumber,
    required this.serviceType,
    required this.kycStatus,
    required this.organizationEnrollmentId,
    required this.partnerEnrollmentId,
    required this.vehicleEnrollmentId,
    required this.profileId,
    required this.lqtagaccountinformation,
  });

  final String issuerName;
  final String registrationNumber;
  final String serviceType;
  final String kycStatus;
  final String organizationEnrollmentId;
  final String partnerEnrollmentId;
  final String vehicleEnrollmentId;
  final String profileId;
  final Lqtagaccountinformation? lqtagaccountinformation;

  factory Doc.fromJson(Map<String, dynamic> json) {
    return Doc(
      issuerName: json["issuerName"] ?? "",
      registrationNumber: json["registrationNumber"] ?? "",
      serviceType: json["serviceType"] ?? "",
      kycStatus: json["kycStatus"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
      vehicleEnrollmentId: json["vehicleEnrollmentId"] ?? "",
      profileId: json["profileId"] ?? "",
      lqtagaccountinformation: json["lqtagaccountinformation"] == null
          ? null
          : Lqtagaccountinformation.fromJson(json["lqtagaccountinformation"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "issuerName": issuerName,
        "registrationNumber": registrationNumber,
        "serviceType": serviceType,
        "kycStatus": kycStatus,
        "organizationEnrollmentId": organizationEnrollmentId,
        "partnerEnrollmentId": partnerEnrollmentId,
        "vehicleEnrollmentId": vehicleEnrollmentId,
        "profileId": profileId,
        "lqtagaccountinformation": lqtagaccountinformation?.toJson(),
      };
}

class Lqtagaccountinformation {
  Lqtagaccountinformation({
    required this.type,
    required this.status,
    required this.serialNumber,
    required this.kitNumber,
    required this.accountNumber,
    required this.ifsc,
    required this.upiId,
    required this.thresholdLimit,
    required this.availableBalance,
  });

  final String type;
  final String status;
  final String serialNumber;
  final String kitNumber;
  final String accountNumber;
  final String ifsc;
  final String upiId;
  final int thresholdLimit;
  final int availableBalance;

  factory Lqtagaccountinformation.fromJson(Map<String, dynamic> json) {
    return Lqtagaccountinformation(
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      serialNumber: json["serialNumber"] ?? "",
      kitNumber: json["kitNumber"] ?? "",
      accountNumber: json["accountNumber"] ?? "",
      ifsc: json["IFSC"] ?? "",
      upiId: json["upiId"] ?? "",
      thresholdLimit: json["thresholdLimit"] ?? 0,
      availableBalance: json["availableBalance"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "status": status,
        "serialNumber": serialNumber,
        "kitNumber": kitNumber,
        "accountNumber": accountNumber,
        "IFSC": ifsc,
        "upiId": upiId,
        "thresholdLimit": thresholdLimit,
        "availableBalance": availableBalance,
      };
}
