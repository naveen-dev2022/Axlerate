class OrgAccountInfoModel {
  OrgAccountInfoModel({
    required this.data,
  });

  final Data? data;

  OrgAccountInfoModel.unknown() : data = null;

  factory OrgAccountInfoModel.fromJson(Map<String, dynamic> json) {
    return OrgAccountInfoModel(
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
    required this.id,
    required this.userId,
    required this.organizationId,
    required this.partnerOrganizationId,
    required this.entityId,
    required this.type,
    required this.status,
    required this.kitNumber,
    required this.accountNumber,
    required this.ifsc,
    required this.upiId,
    required this.thresholdLimit,
    required this.availableBalance,
    required this.token,
    required this.cardPreference,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String userId;
  final String organizationId;
  final String partnerOrganizationId;
  final String entityId;
  final String type;
  final String status;
  final String kitNumber;
  final String accountNumber;
  final String ifsc;
  final String upiId;
  final int thresholdLimit;
  final int availableBalance;
  final String token;
  final CardPreference? cardPreference;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["_id"] ?? "",
      userId: json["userId"] ?? "",
      organizationId: json["organizationId"] ?? "",
      partnerOrganizationId: json["partnerOrganizationId"] ?? "",
      entityId: json["entityId"] ?? "",
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      kitNumber: json["kitNumber"] ?? "",
      accountNumber: json["accountNumber"] ?? "",
      ifsc: json["IFSC"] ?? "",
      upiId: json["upiId"] ?? "",
      thresholdLimit: json["thresholdLimit"] ?? 0,
      availableBalance: json["availableBalance"] ?? 0,
      token: json["token"] ?? "",
      cardPreference: json["cardPreference"] == null ? null : CardPreference.fromJson(json["cardPreference"]),
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "organizationId": organizationId,
        "partnerOrganizationId": partnerOrganizationId,
        "entityId": entityId,
        "type": type,
        "status": status,
        "kitNumber": kitNumber,
        "accountNumber": accountNumber,
        "IFSC": ifsc,
        "upiId": upiId,
        "thresholdLimit": thresholdLimit,
        "availableBalance": availableBalance,
        "token": token,
        "cardPreference": cardPreference?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class CardPreference {
  CardPreference({
    required this.atm,
    required this.pos,
    required this.ecom,
    required this.international,
    required this.dcc,
    required this.contactless,
    required this.limitConfig,
    required this.categoryLimitConfig,
  });

  final bool atm;
  final bool pos;
  final bool ecom;
  final bool international;
  final bool dcc;
  final bool contactless;
  final LimitConfig? limitConfig;
  final List<dynamic> categoryLimitConfig;

  factory CardPreference.fromJson(Map<String, dynamic> json) {
    return CardPreference(
      atm: json["atm"] ?? false,
      pos: json["pos"] ?? false,
      ecom: json["ecom"] ?? false,
      international: json["international"] ?? false,
      dcc: json["dcc"] ?? false,
      contactless: json["contactless"] ?? false,
      limitConfig: json["limitConfig"] == null ? null : LimitConfig.fromJson(json["limitConfig"]),
      categoryLimitConfig:
          json["categoryLimitConfig"] == null ? [] : List<dynamic>.from(json["categoryLimitConfig"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "atm": atm,
        "pos": pos,
        "ecom": ecom,
        "international": international,
        "dcc": dcc,
        "contactless": contactless,
        "limitConfig": limitConfig?.toJson(),
        "categoryLimitConfig": categoryLimitConfig.map((x) => x).toList(),
      };
}

class LimitConfig {
  LimitConfig({
    required this.atm,
    required this.pos,
    required this.ecom,
  });

  final String atm;
  final String pos;
  final String ecom;

  factory LimitConfig.fromJson(Map<String, dynamic> json) {
    return LimitConfig(
      atm: json["ATM"] ?? "",
      pos: json["POS"] ?? "",
      ecom: json["ECOM"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "ATM": atm,
        "POS": pos,
        "ECOM": ecom,
      };
}
