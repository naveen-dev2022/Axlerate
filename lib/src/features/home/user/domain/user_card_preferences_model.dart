class UserCardPreferencesModel {
  UserCardPreferencesModel({
    required this.data,
  });

  final Data data;

  factory UserCardPreferencesModel.fromJson(Map<String, dynamic> json) => UserCardPreferencesModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.message,
  });

  final Message message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.atm,
    required this.pos,
    required this.ecom,
    required this.international,
    required this.dcc,
    required this.contactless,
  });

  final bool atm;
  final bool pos;
  final bool ecom;
  final bool international;
  final bool dcc;
  final bool contactless;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        atm: json["atm"] ?? false,
        pos: json["pos"] ?? false,
        ecom: json["ecom"] ?? false,
        international: json["international"] ?? false,
        dcc: json["dcc"] ?? false,
        contactless: json["contactless"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "atm": atm,
        "pos": pos,
        "ecom": ecom,
        "international": international,
        "dcc": dcc,
        "contactless": contactless,
      };
}
