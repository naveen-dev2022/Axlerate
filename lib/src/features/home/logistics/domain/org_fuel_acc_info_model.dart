class OrgFuelAccInfo {
  OrgFuelAccInfo({
    required this.data,
  });

  final Data? data;
  OrgFuelAccInfo.unknown() : data = null;

  factory OrgFuelAccInfo.fromJson(Map<String, dynamic> json) {
    return OrgFuelAccInfo(
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

  final OrgFuelAccInfoMessage? message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null ? null : OrgFuelAccInfoMessage.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class OrgFuelAccInfoMessage {
  OrgFuelAccInfoMessage({
    required this.id,
    required this.organizationId,
    required this.organizationEnrollmentId,
    required this.organizationEntityId,
    required this.entityType,
    required this.status,
    required this.mapStatus,
    required this.issuerName,
    required this.accountNumber,
    required this.ifsc,
    required this.fuelLimits,
    required this.walletLimit,
    required this.availableBalance,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.vehicleEntityId,
  });

  final String id;
  final String organizationId;
  final String organizationEnrollmentId;
  final String organizationEntityId;
  final String vehicleEntityId;
  final String entityType;
  final String status;
  final String mapStatus;
  final String issuerName;
  final String accountNumber;
  final String ifsc;
  final FuelLimits? fuelLimits;
  final FuelLimits? walletLimit;
  final int availableBalance;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory OrgFuelAccInfoMessage.fromJson(Map<String, dynamic> json) {
    return OrgFuelAccInfoMessage(
      id: json["_id"] ?? "",
      organizationId: json["organizationId"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationEntityId: json["organizationEntityId"] ?? "",
      vehicleEntityId: json["vehicleEntityId"] ?? "",
      entityType: json["entityType"] ?? "",
      status: json["status"] ?? "",
      mapStatus: json["mapStatus"] ?? "",
      issuerName: json["issuerName"] ?? "",
      accountNumber: json["accountNumber"] ?? "",
      ifsc: json["IFSC"] ?? "",
      fuelLimits: json["fuelLimits"] == null ? null : FuelLimits.fromJson(json["fuelLimits"]),
      walletLimit: json["walletLimit"] == null ? null : FuelLimits.fromJson(json["walletLimit"]),
      availableBalance: json["availableBalance"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "organizationId": organizationId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "vehicleEntityId": vehicleEntityId,
        "entityType": entityType,
        "status": status,
        "mapStatus": mapStatus,
        "issuerName": issuerName,
        "accountNumber": accountNumber,
        "IFSC": ifsc,
        "fuelLimits": fuelLimits?.toJson(),
        "walletLimit": walletLimit?.toJson(),
        "availableBalance": availableBalance,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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
    required this.issuerName,
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
  final String issuerName;
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
      issuerName: json["issuerName"] ?? "",
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
        "issuerName": issuerName,
        "baseLimit": baseLimit,
      };
}
