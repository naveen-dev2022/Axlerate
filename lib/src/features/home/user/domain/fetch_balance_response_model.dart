class FetchBalanceResponseModel {
  FetchBalanceResponseModel({
    required this.data,
  });

  final Data? data;

  FetchBalanceResponseModel.unknown() : data = null;

  factory FetchBalanceResponseModel.fromJson(Map<String, dynamic> json) => FetchBalanceResponseModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.message,
  });

  final FetchUSerBalanceMessage message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: FetchUSerBalanceMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class FetchUSerBalanceMessage {
  FetchUSerBalanceMessage({
    required this.result,
    this.exception,
    this.pagination,
  });

  final List<Result> result;
  final dynamic exception;
  final dynamic pagination;

  factory FetchUSerBalanceMessage.fromJson(Map<String, dynamic> json) => FetchUSerBalanceMessage(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        exception: json["exception"],
        pagination: json["pagination"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "exception": exception,
        "pagination": pagination,
      };
}

class Result {
  Result({
    required this.entityId,
    required this.productId,
    required this.balance,
    required this.lienBalance,
  });

  final String entityId;
  final String productId;
  final String balance;
  final String lienBalance;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        entityId: json["entityId"] ?? '',
        productId: json["productId"] ?? '',
        balance: json["balance"] ?? '',
        lienBalance: json["lienBalance"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "entityId": entityId,
        "productId": productId,
        "balance": balance,
        "lienBalance": lienBalance,
      };
}
