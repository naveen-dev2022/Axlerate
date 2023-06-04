class ListInvoiceSavedCustomerModel {
  ListInvoiceSavedCustomerModel({
    required this.data,
  });

  final Data? data;
  const ListInvoiceSavedCustomerModel.unknown() : data = null;

  factory ListInvoiceSavedCustomerModel.fromJson(Map<String, dynamic> json) {
    return ListInvoiceSavedCustomerModel(
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

  final List<Doc> docs;
  final int count;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      docs: json["docs"] == null ? [] : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "docs": docs.map((x) => x.toJson()).toList(),
        "count": count,
      };
}

class Doc {
  Doc({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    required this.country,
    required this.state,
    required this.organizationEnrollmentId,
  });

  final String id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String country;
  final String state;
  final String organizationEnrollmentId;

  factory Doc.fromJson(Map<String, dynamic> json) {
    return Doc(
      id: json["_id"] ?? "",
      email: json["email"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      city: json["city"] ?? "",
      country: json["country"] ?? "",
      state: json["state"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "phone": phone,
        "address": address,
        "city": city,
        "country": country,
        "state": state,
        "organizationEnrollmentId": organizationEnrollmentId,
      };
}
