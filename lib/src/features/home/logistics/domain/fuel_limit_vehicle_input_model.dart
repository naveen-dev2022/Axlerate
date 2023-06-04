class SetVehicleFuelInputModel {
  SetVehicleFuelInputModel({
    required this.organizationEnrollmentId,
    required this.issuerName,
    required this.fuelLimit,
    // required this.walletLimit,
  });

  final String organizationEnrollmentId;
  final String issuerName;
  final VehicleLimit? fuelLimit;
  // final VehicleLimit? walletLimit;

  factory SetVehicleFuelInputModel.fromJson(Map<String, dynamic> json) {
    return SetVehicleFuelInputModel(
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      issuerName: json["issuerName"] ?? "",
      fuelLimit: json["fuelLimit"] == null ? null : VehicleLimit.fromJson(json["fuelLimit"]),
      // walletLimit: json["walletLimit"] == null ? null : VehicleLimit.fromJson(json["walletLimit"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "organizationEnrollmentId": organizationEnrollmentId,
        "issuerName": issuerName,
        "fuelLimit": fuelLimit?.toJson(),
        // if (walletLimit != null) "walletLimit": walletLimit?.toJson(),
      };
}

class VehicleLimit {
  VehicleLimit({
    required this.daily,
    // required this.monthly,
    // required this.quarterly,
    // required this.halfYearly,
    // required this.yearly,
    // required this.dailyTransactionCount,
    // required this.monthlyTransactionCount,
    // required this.quarterlyTransactionCount,
    // required this.halfYearlyTransactionCount,
    // this.baseLimit,
  });

  final int daily;
  // final int monthly;
  // final int quarterly;
  // final int halfYearly;
  // final int yearly;
  // final int dailyTransactionCount;
  // final int monthlyTransactionCount;
  // final int quarterlyTransactionCount;
  // final int halfYearlyTransactionCount;
  // final int? baseLimit;

  factory VehicleLimit.fromJson(Map<String, dynamic> json) {
    return VehicleLimit(
      daily: json["daily"] ?? 0,
      // monthly: json["monthly"] ?? 0,
      // quarterly: json["quarterly"] ?? 0,
      // halfYearly: json["halfYearly"] ?? 0,
      // yearly: json["yearly"] ?? 0,
      // dailyTransactionCount: json["dailyTransactionCount"] ?? 0,
      // monthlyTransactionCount: json["monthlyTransactionCount"] ?? 0,
      // quarterlyTransactionCount: json["quarterlyTransactionCount"] ?? 0,
      // halfYearlyTransactionCount: json["halfYearlyTransactionCount"] ?? 0,
      // baseLimit: json["baseLimit"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "daily": daily,
        // "monthly": monthly,
        // "quarterly": quarterly,
        // "halfYearly": halfYearly,
        // "yearly": yearly,
        // "dailyTransactionCount": dailyTransactionCount,
        // "monthlyTransactionCount": monthlyTransactionCount,
        // "quarterlyTransactionCount": quarterlyTransactionCount,
        // "halfYearlyTransactionCount": halfYearlyTransactionCount,
        // if (baseLimit != null) "baseLimit": baseLimit,
      };
}
