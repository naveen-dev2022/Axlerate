class FuelTxnListModel {
  FuelTxnListModel({
    required this.data,
  });

  final Data? data;
  const FuelTxnListModel.unknown() : data = null;

  factory FuelTxnListModel.fromJson(Map<String, dynamic> json) {
    return FuelTxnListModel(
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

  final FuelTxnListModelMessage? message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null ? null : FuelTxnListModelMessage.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class FuelTxnListModelMessage {
  FuelTxnListModelMessage({
    required this.docs,
    required this.count,
  });

  final List<DocFuel> docs;
  final int count;

  factory FuelTxnListModelMessage.fromJson(Map<String, dynamic> json) {
    return FuelTxnListModelMessage(
      docs: json["docs"] == null ? [] : List<DocFuel>.from(json["docs"]!.map((x) => DocFuel.fromJson(x))),
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "docs": docs.map((x) => x.toJson()).toList(),
        "count": count,
      };
}

class DocFuel {
  DocFuel({
    required this.transactionTime,
    required this.metadata,
    required this.transactionReference,
    required this.initiatedBy,
    required this.amount,
    required this.id,
    required this.organization,
    required this.transactionStatus,
    required this.transactionType,
    required this.description,
    required this.status,
    required this.from,
    required this.to,
    required this.type,
    required this.balance,
  });

  final DateTime? transactionTime;
  final Metadata? metadata;
  final String transactionReference;
  final String initiatedBy;
  final int amount;
  final String id;
  final Organization? organization;
  final String transactionStatus;
  final String transactionType;
  final String description;
  final String status;
  final String from;
  final String to;
  final String type;
  final int balance;

  factory DocFuel.fromJson(Map<String, dynamic> json) {
    return DocFuel(
      transactionTime: DateTime.tryParse(json["transactionTime"] ?? ""),
      metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
      transactionReference: json["transactionReference"] ?? "",
      initiatedBy: json["initiatedBy"] ?? "",
      amount: json["amount"] ?? 0,
      id: json["_id"] ?? "",
      organization: json["organization"] == null ? null : Organization.fromJson(json["organization"]),
      transactionStatus: json["transactionStatus"] ?? "",
      transactionType: json["transactionType"] ?? "",
      description: json["description"] ?? "",
      status: json["status"] ?? "",
      from: json["from"] ?? "",
      to: json["to"] ?? "",
      type: json["type"] ?? "",
      balance: json["balance"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "transactionTime": transactionTime?.toIso8601String(),
        "metadata": metadata?.toJson(),
        "transactionReference": transactionReference,
        "initiatedBy": initiatedBy,
        "amount": amount,
        "_id": id,
        "organization": organization?.toJson(),
        "transactionStatus": transactionStatus,
        "transactionType": transactionType,
        "description": description,
        "status": status,
        "from": from,
        "to": to,
        "type": type,
        "balance": balance,
      };
}

class Metadata {
  Metadata({
    required this.accountInfoEntity,
    required this.organizationEnrollmentId,
    required this.organizationEntityId,
    required this.organizationId,
    required this.type,
    required this.vehicleEnrollmentId,
    required this.vehicleEntityId,
    required this.vehicleId,
  });

  final String accountInfoEntity;
  final String organizationEnrollmentId;
  final String organizationEntityId;
  final String organizationId;
  final String type;
  final String vehicleEnrollmentId;
  final String vehicleEntityId;
  final String vehicleId;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      accountInfoEntity: json["accountInfoEntity"] ?? "",
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      organizationEntityId: json["organizationEntityId"] ?? "",
      organizationId: json["organizationId"] ?? "",
      type: json["type"] ?? "",
      vehicleEnrollmentId: json["vehicleEnrollmentId"] ?? "",
      vehicleEntityId: json["vehicleEntityId"] ?? "",
      vehicleId: json["vehicleId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "accountInfoEntity": accountInfoEntity,
        "organizationEnrollmentId": organizationEnrollmentId,
        "organizationEntityId": organizationEntityId,
        "organizationId": organizationId,
        "type": type,
        "vehicleEnrollmentId": vehicleEnrollmentId,
        "vehicleEntityId": vehicleEntityId,
        "vehicleId": vehicleId,
      };
}

class Organization {
  Organization({
    required this.natureOfBusiness,
  });

  final String natureOfBusiness;

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      natureOfBusiness: json["natureOfBusiness"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "natureOfBusiness": natureOfBusiness,
      };
}
