class SimpleVehicleListModel {
  SimpleVehicleListModel({
    required this.data,
  });

  final Data? data;
  const SimpleVehicleListModel.unknown() : data = null;

  factory SimpleVehicleListModel.fromJson(Map<String, dynamic> json) {
    return SimpleVehicleListModel(
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

  final Message? message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  Message({
    required this.docs,
    required this.count,
  });

  final List<DocVehicleList> docs;
  final int count;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      docs: json["docs"] == null ? [] : List<DocVehicleList>.from(json["docs"]!.map((x) => DocVehicleList.fromJson(x))),
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "docs": docs.map((x) => x.toJson()).toList(),
        "count": count,
      };
}

class DocVehicleList {
  DocVehicleList({
    required this.enrollmentId,
    required this.registrationNumber,
  });

  final String enrollmentId;
  final String registrationNumber;

  factory DocVehicleList.fromJson(Map<String, dynamic> json) {
    return DocVehicleList(
      enrollmentId: json["enrollmentId"] ?? "",
      registrationNumber: json["registrationNumber"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "enrollmentId": enrollmentId,
        "registrationNumber": registrationNumber,
      };
}
