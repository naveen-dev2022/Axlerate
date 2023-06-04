class PaymentListModel {
  PaymentListModel({
    required this.data,
  });

  final Data? data;
  const PaymentListModel.unknown() : data = null;

  factory PaymentListModel.fromJson(Map<String, dynamic> json) {
    return PaymentListModel(
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

  final List<PaymentListModelDoc> docs;
  final int count;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      docs: json["docs"] == null
          ? []
          : List<PaymentListModelDoc>.from(json["docs"]!.map((x) => PaymentListModelDoc.fromJson(x))),
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        // ignore: unnecessary_null_comparison
        "docs": docs == null ? [] : List<dynamic>.from(docs.map((x) => x.toJson())),
        "count": count,
      };
}

class PaymentListModelDoc {
  PaymentListModelDoc({
    required this.id,
    required this.organizationEnrollmentId,
    required this.uuid,
    required this.date,
    required this.expiryDate,
    required this.status,
    required this.orderId,
    required this.currency,
    required this.amount,
    required this.paid,
    required this.due,
    required this.refunded,
    required this.customer,
    required this.orderInfo,
    required this.attempts,
    required this.testMode,
    required this.dropReason,
    required this.referenceId,
    required this.paymentLink,
    required this.maxAttempts,
    required this.surcharge,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String organizationEnrollmentId;
  final String uuid;
  final DateTime? date;
  final DateTime? expiryDate;
  final String status;
  final String orderId;
  final String currency;
  final int amount;
  final int paid;
  final int due;
  final int refunded;
  final Customer? customer;
  final String orderInfo;
  final int attempts;
  final bool testMode;
  final String dropReason;
  final String referenceId;
  final String paymentLink;
  final int maxAttempts;
  final bool surcharge;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory PaymentListModelDoc.fromJson(Map<String, dynamic> json) {
    return PaymentListModelDoc(
      id: json["_id"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      uuid: json["uuid"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      expiryDate: DateTime.tryParse(json["expiryDate"] ?? ""),
      status: json["status"] ?? "",
      orderId: json["orderId"] ?? "",
      currency: json["currency"] ?? "",
      amount: json["amount"] ?? 0,
      paid: json["paid"] ?? 0,
      due: json["due"] ?? 0,
      refunded: json["refunded"] ?? 0,
      customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      orderInfo: json["orderInfo"] ?? "",
      attempts: json["attempts"] ?? 0,
      testMode: json["testMode"] ?? false,
      dropReason: json["dropReason"] ?? "",
      referenceId: json["referenceId"] ?? "",
      paymentLink: json["paymentLink"] ?? "",
      maxAttempts: json["maxAttempts"] ?? 0,
      surcharge: json["surcharge"] ?? false,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "organizationEnrollmentId": organizationEnrollmentId,
        "uuid": uuid,
        "date": date?.toIso8601String(),
        "expiryDate": expiryDate?.toIso8601String(),
        "status": status,
        "orderId": orderId,
        "currency": currency,
        "amount": amount,
        "paid": paid,
        "due": due,
        "refunded": refunded,
        "customer": customer?.toJson(),
        "orderInfo": orderInfo,
        "attempts": attempts,
        "testMode": testMode,
        "dropReason": dropReason,
        "referenceId": referenceId,
        "paymentLink": paymentLink,
        "maxAttempts": maxAttempts,
        "surcharge": surcharge,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Customer {
  Customer({
    required this.name,
    required this.phone,
    required this.email,
    required this.uid,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    required this.id,
  });

  final String name;
  final String phone;
  final String email;
  final dynamic uid;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String country;
  final String id;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      uid: json["uid"],
      address: json["address"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      zip: json["zip"] ?? "",
      country: json["country"] ?? "",
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "uid": uid,
        "address": address,
        "city": city,
        "state": state,
        "zip": zip,
        "country": country,
        "id": id,
      };
}
