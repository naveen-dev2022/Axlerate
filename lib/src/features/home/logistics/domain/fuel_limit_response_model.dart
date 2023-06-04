class FuelLimitResponseModel {
  FuelLimitResponseModel({
    required this.data,
  });

  final Data? data;
  FuelLimitResponseModel.unknown() : data = null;

  factory FuelLimitResponseModel.fromJson(Map<String, dynamic> json) {
    return FuelLimitResponseModel(
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
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.organizationEntityId,
    required this.entityType,
    required this.status,
    required this.issuerName,
    required this.accountNumber,
    required this.ifsc,
    required this.fuelLimits,
    required this.walletLimit,
    required this.availableBalance,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.limitId,
  });

  final String id;
  final String organizationId;
  final String organizationEnrollmentId;
  final String organizationEntityId;
  final String entityType;
  final String status;
  final String issuerName;
  final String accountNumber;
  final String ifsc;
  final FuelLimits? fuelLimits;
  final FuelLimits? walletLimit;
  final int availableBalance;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final String limitId;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["_id"] ?? "",
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationEntityId: json["organizationEntityId"] ?? "",
      entityType: json["entityType"] ?? "",
      status: json["status"] ?? "",
      issuerName: json["issuerName"] ?? "",
      accountNumber: json["accountNumber"] ?? "",
      ifsc: json["IFSC"] ?? "",
      fuelLimits: json["fuelLimits"] == null ? null : FuelLimits.fromJson(json["fuelLimits"]),
      walletLimit: json["walletLimit"] == null ? null : FuelLimits.fromJson(json["walletLimit"]),
      availableBalance: json["availableBalance"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
      limitId: json["limitId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "entityType": entityType,
        "status": status,
        "issuerName": issuerName,
        "accountNumber": accountNumber,
        "IFSC": ifsc,
        "fuelLimits": fuelLimits?.toJson(),
        "walletLimit": walletLimit?.toJson(),
        "availableBalance": availableBalance,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "limitId": limitId,
      };
}

class FuelLimits {
  FuelLimits({
    required this.daily,
    required this.monthly,
    required this.quarterly,
    required this.halfYearly,
    required this.yearly,
    required this.dailyTransactionCount,
    required this.monthlyTransactionCount,
    required this.quarterlyTransactionCount,
    required this.halfYearlyTransactionCount,
    required this.baseLimit,
  });

  final int daily;
  final int monthly;
  final int quarterly;
  final int halfYearly;
  final int yearly;
  final int dailyTransactionCount;
  final int monthlyTransactionCount;
  final int quarterlyTransactionCount;
  final int halfYearlyTransactionCount;
  final int baseLimit;

  factory FuelLimits.fromJson(Map<String, dynamic> json) {
    return FuelLimits(
      daily: json["daily"] ?? 0,
      monthly: json["monthly"] ?? 0,
      quarterly: json["quarterly"] ?? 0,
      halfYearly: json["halfYearly"] ?? 0,
      yearly: json["yearly"] ?? 0,
      dailyTransactionCount: json["dailyTransactionCount"] ?? 0,
      monthlyTransactionCount: json["monthlyTransactionCount"] ?? 0,
      quarterlyTransactionCount: json["quarterlyTransactionCount"] ?? 0,
      halfYearlyTransactionCount: json["halfYearlyTransactionCount"] ?? 0,
      baseLimit: json["baseLimit"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "daily": daily,
        "monthly": monthly,
        "quarterly": quarterly,
        "halfYearly": halfYearly,
        "yearly": yearly,
        "dailyTransactionCount": dailyTransactionCount,
        "monthlyTransactionCount": monthlyTransactionCount,
        "quarterlyTransactionCount": quarterlyTransactionCount,
        "halfYearlyTransactionCount": halfYearlyTransactionCount,
        "baseLimit": baseLimit,
      };
}
