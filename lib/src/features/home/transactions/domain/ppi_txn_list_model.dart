class PpiTxnListModel {
  PpiTxnListModel({
    this.data,
  });

  final Data? data;

  const PpiTxnListModel.unknown() : data = null;

  factory PpiTxnListModel.fromJson(Map<String, dynamic> json) => PpiTxnListModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.message,
  });

  final Message? message;

  factory Data.fromJson(Map<String, dynamic> json) {
    // log('Data');
    return Data(
      message: Message.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class Message {
  Message({
    this.docs,
    this.count,
  });

  final List<Doc?>? docs;
  final int? count;

  factory Message.fromJson(Map<String, dynamic> json) {
    // log('Message');
    return Message(
      docs: json["docs"] == null ? [] : List<Doc?>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "docs": docs == null ? [] : List<dynamic>.from(docs!.map((x) => x!.toJson())),
        "count": count,
      };
}

class Doc {
  Doc({
    this.transactionTime,
    this.metadata,
    this.balance,
    this.organization,
    this.organizationEnrollmentId,
    this.transactionType,
    this.amount,
    this.type,
    this.partnerOrganization,
    this.id,
    this.user,
    this.transactionReference,
    this.from,
    this.to,
  });

  final DateTime? transactionTime;
  final Metadata? metadata;
  final double? balance;
  final Organization? organization;
  final String? organizationEnrollmentId;
  final String? transactionType;
  final double? amount;
  final String? type;
  final Organization? partnerOrganization;
  final String? id;
  final User? user;
  final String? transactionReference;
  final String? from;
  final String? to;

  String get description {
    if (transactionType != "B2C") {
      return to!;
    }

    // if (metadata!.accountInfoEntity ==
    //     metadata!.organizationEntityId) {
    if (type == "CREDIT") {
      return "Wallet Reload from Admin - ${organization!.firstName}";
    }
    return "Wallet Transfer to User - ${user!.name}";
    // }

    // if (metadata!.accountInfoEntity == metadata!.userEntityId) {
    //   if (type == "CREDIT") {
    //     return "Wallet Transfer from Org - ${organization!.firstName}";
    //   }
    //   return "Wallet Transfer to User - ${user!.name}";
    // }
  }

  factory Doc.fromJson(Map<String, dynamic> json) {
    // log('Doc');
    return Doc(
      transactionTime: json["transactionTime"] == null ? null : DateTime.parse(json["transactionTime"]),
      metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
      balance: json["balance"] != null ? double.parse(json["balance"].toString()) : 0.0,
      organization: json["organization"] == null ? null : Organization.fromJson(json["organization"]),
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? '',
      transactionType: json["transactionType"] ?? '',
      amount: json["amount"] != null ? double.parse(json["amount"].toString()) : 0.0,
      type: json["type"] ?? '',
      partnerOrganization: json["organization"] == null ? null : Organization.fromJson(json["partnerOrganization"]),
      id: json["_id"] ?? '',
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      transactionReference: json["transactionReference"] ?? '',
      from: json["from"] ?? '',
      to: json["to"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "transactionTime": transactionTime?.toIso8601String(),
        "metadata": metadata!.toJson(),
        "balance": balance,
        "organization": organization!.toJson(),
        "organizationEnrollmentId": organizationEnrollmentId,
        "transactionType": transactionType,
        "amount": amount,
        "type": type,
        "partnerOrganization": partnerOrganization!.toJson(),
        "_id": id,
        "user": user!.toJson(),
        "transactionReference": transactionReference,
        "from": from,
        "to": to,
      };
}

class Metadata {
  Metadata({
    this.accountInfoEntity,
    this.organizationEnrollmentId,
    this.organizationId,
    this.organizationEntityId,
    this.partnerOrganizationEnrollmentId,
    this.partnerOrganizationId,
    this.type,
    this.userEnrollmentId,
    this.userId,
    this.userEntityId,
  });

  final String? accountInfoEntity;
  final String? organizationEnrollmentId;
  final String? organizationId;
  final String? organizationEntityId;
  final String? partnerOrganizationEnrollmentId;
  final String? partnerOrganizationId;
  final String? type;
  final String? userEnrollmentId;
  final String? userId;
  final String? userEntityId;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    // log('Meta Data');
    return Metadata(
      accountInfoEntity: json["accountInfoEntity"],
      organizationEnrollmentId: json["organizationEnrollmentId"],
      organizationId: json["organizationId"],
      organizationEntityId: json["organizationEntityId"],
      partnerOrganizationEnrollmentId: json["partnerOrganizationEnrollmentId"],
      partnerOrganizationId: json["partnerOrganizationId"],
      type: json["type"],
      userEnrollmentId: json["userEnrollmentId"],
      userId: json["userId"],
      userEntityId: json["userEntityId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "accountInfoEntity": accountInfoEntity,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationId": organizationId,
        "organizationEntityId": organizationEntityId,
        "partnerOrganizationEnrollmentId": partnerOrganizationEnrollmentId,
        "partnerOrganizationId": partnerOrganizationId,
        "type": type,
        "userEnrollmentId": userEnrollmentId,
        "userId": userId,
        "userEntityId": userEntityId,
      };
}

class Organization {
  Organization({
    this.cashBack,
    this.id,
    this.firstName,
    this.lastName,
    this.natureOfBusiness,
    this.enrollmentId,
    this.contactNumber,
    this.cashBackPercentage,
  });

  final double? cashBack;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? natureOfBusiness;
  final String? enrollmentId;
  final String? contactNumber;
  final double? cashBackPercentage;

  factory Organization.fromJson(Map<String, dynamic> json) {
    // log('Organization');

    return Organization(
      cashBack: json["cashBack"] != null ? double.parse(json["cashBack"].toString()) : 0.0,
      id: json["_id"] ?? '',
      firstName: json["firstName"] ?? '',
      lastName: json["lastName"] ?? '',
      natureOfBusiness: json["natureOfBusiness"] ?? '',
      enrollmentId: json["enrollmentId"] ?? '',
      contactNumber: json["contactNumber"] ?? '',
      cashBackPercentage:
          json["cashBackPercentage"] != null ? double.parse(json["cashBackPercentage"].toString()) : 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        "cashBack": cashBack,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "natureOfBusiness": natureOfBusiness,
        "enrollmentId": enrollmentId,
        "contactNumber": contactNumber,
        "cashBackPercentage": cashBackPercentage,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.enrollmentId,
    this.contactNumber,
    this.email,
  });

  final String? id;
  final String? name;
  final String? enrollmentId;
  final String? contactNumber;
  final String? email;

  factory User.fromJson(Map<String, dynamic> json) {
    // log('User');

    return User(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      enrollmentId: json["enrollmentId"] ?? '',
      contactNumber: json["contactNumber"] ?? '',
      email: json["email"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "enrollmentId": enrollmentId,
        "contactNumber": contactNumber,
        "email": email,
      };
}
