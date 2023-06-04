class States {
  States({
    required this.data,
  });

  final Data? data;

  States.empty() : data = Data(message: []);

  factory States.fromJson(Map<String, dynamic> json) {
    return States(
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

  final List<String> message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.map((x) => x).toList(),
      };
}
