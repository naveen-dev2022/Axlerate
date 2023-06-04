class LqTagAccountInfoResponse {
  LqTagAccountInfoResponse({
    required this.data,
  });

  final Data? data;
  LqTagAccountInfoResponse.unknown() : data = null;

  factory LqTagAccountInfoResponse.fromJson(Map<String, dynamic> json) {
    return LqTagAccountInfoResponse(
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

  final List<LqTagAccountInfoMessage> message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null
          ? []
          : List<LqTagAccountInfoMessage>.from(json["message"]!.map((x) => LqTagAccountInfoMessage.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.map((x) => x.toJson()).toList(),
      };
}

class LqTagAccountInfoMessage {
  LqTagAccountInfoMessage({
    required this.id,
    required this.userEnrollmentId,
    required this.userEntityId,
    required this.organizationEnrollmentId,
    required this.organizationEntityId,
    required this.partnerEnrollmentId,
    required this.type,
    required this.status,
    required this.kitNumber,
    required this.accountNumber,
    required this.ifsc,
    required this.upiId,
    required this.thresholdLimit,
    required this.availableBalance,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.vehicleEnrollmentId,
    required this.vehicleEntityId,
    required this.serialNumber,
  });

  final String id;
  final String userEnrollmentId;
  final String userEntityId;
  final String organizationEnrollmentId;
  final String organizationEntityId;
  final String partnerEnrollmentId;
  final String type;
  final String status;
  final String kitNumber;
  final String accountNumber;
  final String ifsc;
  final String upiId;
  final int thresholdLimit;
  final int availableBalance;
  final String token;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final String vehicleEnrollmentId;
  final String vehicleEntityId;
  final String serialNumber;

  factory LqTagAccountInfoMessage.fromJson(Map<String, dynamic> json) {
    return LqTagAccountInfoMessage(
      id: json["_id"] ?? "",
      userEnrollmentId: json["userEnrollmentId"] ?? "",
      userEntityId: json["userEntityId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationEntityId: json["organizationEntityId"] ?? "",
      partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      kitNumber: json["kitNumber"] ?? "",
      accountNumber: json["accountNumber"] ?? "",
      ifsc: json["IFSC"] ?? "",
      upiId: json["upiId"] ?? "",
      thresholdLimit: json["thresholdLimit"] ?? 0,
      availableBalance: json["availableBalance"] ?? 0,
      token: json["token"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
      vehicleEnrollmentId: json["vehicleEnrollmentId"] ?? "",
      vehicleEntityId: json["vehicleEntityId"] ?? "",
      serialNumber: json["serialNumber"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userEnrollmentId": userEnrollmentId,
        "userEntityId": userEntityId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "partnerEnrollmentId": partnerEnrollmentId,
        "type": type,
        "status": status,
        "kitNumber": kitNumber,
        "accountNumber": accountNumber,
        "IFSC": ifsc,
        "upiId": upiId,
        "thresholdLimit": thresholdLimit,
        "availableBalance": availableBalance,
        "token": token,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "vehicleEnrollmentId": vehicleEnrollmentId,
        "vehicleEntityId": vehicleEntityId,
        "serialNumber": serialNumber,
      };
}
