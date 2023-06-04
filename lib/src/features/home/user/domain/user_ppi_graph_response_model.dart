class UserPpiGraphResponseModel {
  UserPpiGraphResponseModel({
    required this.data,
  });

  final Data? data;

  UserPpiGraphResponseModel.unknown() : data = null;

  factory UserPpiGraphResponseModel.fromJson(Map<String, dynamic> json) {
    return UserPpiGraphResponseModel(
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
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      label: json["label"] != null ? json["label"].toString() : "",
      value: json["value"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
