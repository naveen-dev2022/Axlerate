class FetchFuelVehicleBalanceModel {
  FetchFuelVehicleBalanceModel({
    required this.data,
  });

  final Data? data;
  const FetchFuelVehicleBalanceModel.unknown() : data = null;

  factory FetchFuelVehicleBalanceModel.fromJson(Map<String, dynamic> json) {
    return FetchFuelVehicleBalanceModel(
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

  final List<Message> message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null ? [] : List<Message>.from(json["message"]!.map((x) => Message.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.map((x) => x.toJson()).toList(),
      };
}

class Message {
  Message({
    required this.entityId,
    required this.productId,
    required this.balance,
    required this.lienBalance,
  });

  final String entityId;
  final String productId;
  final String balance;
  final String lienBalance;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      entityId: json["entityId"] ?? "",
      productId: json["productId"] ?? "",
      balance: json["balance"] ?? "",
      lienBalance: json["lienBalance"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "entityId": entityId,
        "productId": productId,
        "balance": balance,
        "lienBalance": lienBalance,
      };
}
