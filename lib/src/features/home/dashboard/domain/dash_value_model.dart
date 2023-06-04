class DashboardValueModel {
  DashboardValueModel({
    required this.data,
  });

  Data? data;

  factory DashboardValueModel.fromJson(Map<String, dynamic> json) => DashboardValueModel(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.message,
  });

  Message? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"] != null ? Message.fromJson(json["message"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class Message {
  Message({
    required this.value,
  });

  double value;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        value: json["value"] != null ? double.parse(json['value'].toString()) : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}
