import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';

class LqUserAccInfoModel {
  LqUserAccInfoModel({
    required this.data,
  });

  final Data? data;
  bool? isLqEnabled;

  LqUserAccInfoModel.reqNotSent()
      : data = null,
        isLqEnabled = true;
  LqUserAccInfoModel.unknown() : data = null;

  factory LqUserAccInfoModel.fromJson(Map<String, dynamic> json) {
    return LqUserAccInfoModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };

  List<WalletDisplayModel> getWallets() {
    List<WalletDisplayModel> wallets = [];
    if (data != null && data!.message.isNotEmpty) {
      for (var wallet in data!.message) {
        wallets.add(WalletDisplayModel(
            id: wallet.id,
            kitNo: wallet.kitNumber,
            balance: wallet.availableBalance,
            upiId: wallet.upiId,
            accountNumber: wallet.accountNumber,
            ifscCode: wallet.ifsc,
            organizationEnrollmentId: wallet.organizationEnrollmentId,
            userEnrollmentId: wallet.userEnrollmentId,
            userEntityId: wallet.userEntityId,
            type: WalletType.values.byName((wallet.type).toString().toLowerCase()),
            walletName: wallet.name));
      }
    }

    return wallets;
  }
}

class Data {
  Data({
    required this.message,
  });

  final List<LqUserAccInfoModelMessage> message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null
          ? []
          : List<LqUserAccInfoModelMessage>.from(json["message"]!.map((x) => LqUserAccInfoModelMessage.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.map((x) => x.toJson()).toList(),
      };
}

class LqUserAccInfoModelMessage {
  LqUserAccInfoModelMessage(
      {required this.id,
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
      // required this.token,
      required this.createdAt,
      required this.updatedAt,
      // required this.v,
      required this.name});

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
  final double availableBalance;
  // final String token;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // final int v;
  final String name;

  factory LqUserAccInfoModelMessage.fromJson(Map<String, dynamic> json) {
    return LqUserAccInfoModelMessage(
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
      availableBalance: double.parse(json["availableBalance"].toString()),
      // token: json["token"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      // v: json["__v"] ?? 0,
      name: json["name"] ?? "Corporate Wallet",
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
        // "token": token,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        // "__v": v,
        "name": name
      };
}
