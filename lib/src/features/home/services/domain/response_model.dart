class Mtopresponse {
  Mtopresponse({
    required this.data,
  });
  final Data? data;
  factory Mtopresponse.fromJson(Map<String, dynamic> json) {
    return Mtopresponse(
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
