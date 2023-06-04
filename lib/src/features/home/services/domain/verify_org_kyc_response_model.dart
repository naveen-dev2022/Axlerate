class VerifyOrgKycresponseModel {
  VerifyOrgKycresponseModel({
    required this.data,
  });

  final Data? data;

  factory VerifyOrgKycresponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOrgKycresponseModel(
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

  final String message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
