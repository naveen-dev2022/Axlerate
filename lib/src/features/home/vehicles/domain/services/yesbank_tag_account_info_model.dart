class YesBankTagAccountInfoModel {
  YesBankTagAccountInfoModel({
    required this.data,
  });

  final Data? data;
  const YesBankTagAccountInfoModel.unknown() : data = null;

  factory YesBankTagAccountInfoModel.fromJson(Map<String, dynamic> json) {
    return YesBankTagAccountInfoModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
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
}

class Message {
  Message({
    required this.id,
    required this.messageId,
    required this.entityId,
    required this.type,
    required this.status,
    required this.accountNumber,
    required this.ifsc,
    required this.upiId,
    required this.thresholdLimit,
    required this.availableBalance,
    required this.organizationId,
    required this.partnerOrganizationId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String messageId;
  final String entityId;
  final String type;
  final String status;
  final String accountNumber;
  final String ifsc;
  final String upiId;
  final int thresholdLimit;
  final int availableBalance;
  final String organizationId;
  final String partnerOrganizationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["_id"] ?? "",
      messageId: json["id"] ?? "",
      entityId: json["entityId"] ?? "",
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      accountNumber: json["accountNumber"] ?? "",
      ifsc: json["IFSC"] ?? "",
      upiId: json["upiId"] ?? "",
      thresholdLimit: json["thresholdLimit"] ?? 0,
      availableBalance: json["availableBalance"] ?? 0,
      organizationId: json["organizationId"] ?? "",
      partnerOrganizationId: json["partnerOrganizationId"] ?? "",
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      v: json["__v"] ?? 0,
    );
  }
}
