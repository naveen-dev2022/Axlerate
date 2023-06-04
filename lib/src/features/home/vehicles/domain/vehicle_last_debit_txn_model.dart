class VehicleLastDebitTxnModel {
  Data? data;

  VehicleLastDebitTxnModel({this.data});

  VehicleLastDebitTxnModel.unknown() : data = null;

  VehicleLastDebitTxnModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  VehicleLastDebitTxnModelMessage? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null ? VehicleLastDebitTxnModelMessage.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class VehicleLastDebitTxnModelMessage {
  List<Docs>? docs;

  VehicleLastDebitTxnModelMessage({this.docs});

  VehicleLastDebitTxnModelMessage.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Docs {
  String? transactionTime;
  Metadata? metadata;
  String? tollPlazaName;
  VehicleInfo? vehicleInfo;
  int? amount;
  String? sId;
  double? balance;
  String? transactionType;
  String? type;
  String? organizationEnrollmentId;
  String? tollReaderTime;
  String? serialNumber;
  String? tagId;
  String? transactionReference;

  Docs(
      {this.transactionTime,
      this.metadata,
      this.tollPlazaName,
      this.vehicleInfo,
      this.amount,
      this.sId,
      this.balance,
      this.transactionType,
      this.type,
      this.organizationEnrollmentId,
      this.tollReaderTime,
      this.serialNumber,
      this.tagId,
      this.transactionReference});

  Docs.fromJson(Map<String, dynamic> json) {
    transactionTime = json['transactionTime'] ?? '';
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    tollPlazaName = json['tollPlazaName'] ?? '';
    vehicleInfo = json['vehicleInfo'] != null ? VehicleInfo.fromJson(json['vehicleInfo']) : null;
    amount = json['amount'] ?? 0;
    sId = json['_id'] ?? '';
    balance = json['balance'] != null ? double.parse(json['balance'].toString()) : 0.0;
    transactionType = json['transactionType'] ?? '';
    type = json['type'] ?? '';
    organizationEnrollmentId = json['organizationEnrollmentId'] ?? '';
    tollReaderTime = json['tollReaderTime'] ?? '';
    serialNumber = json['serialNumber'] ?? '';
    tagId = json['tagId'] ?? '';
    transactionReference = json['transactionReference'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transactionTime'] = transactionTime;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['tollPlazaName'] = tollPlazaName;
    if (vehicleInfo != null) {
      data['vehicleInfo'] = vehicleInfo!.toJson();
    }
    data['amount'] = amount;
    data['_id'] = sId;
    data['balance'] = balance;
    data['transactionType'] = transactionType;
    data['type'] = type;
    data['organizationEnrollmentId'] = organizationEnrollmentId;
    data['tollReaderTime'] = tollReaderTime;
    data['serialNumber'] = serialNumber;
    data['tagId'] = tagId;
    data['transactionReference'] = transactionReference;
    return data;
  }
}

class Metadata {
  String? organizationEnrollmentId;
  String? organizationId;
  String? partnerOrganizationEnrollmentId;
  String? partnerOrganizationId;
  String? type;
  String? vehicleEnrollmentId;
  String? vehicleId;

  Metadata(
      {this.organizationEnrollmentId,
      this.organizationId,
      this.partnerOrganizationEnrollmentId,
      this.partnerOrganizationId,
      this.type,
      this.vehicleEnrollmentId,
      this.vehicleId});

  Metadata.fromJson(Map<String, dynamic> json) {
    organizationEnrollmentId = json['organizationEnrollmentId'] ?? '';
    organizationId = json['organizationId'] ?? '';
    partnerOrganizationEnrollmentId = json['partnerOrganizationEnrollmentId'] ?? '';
    partnerOrganizationId = json['partnerOrganizationId'] ?? '';
    type = json['type'] ?? '';
    vehicleEnrollmentId = json['vehicleEnrollmentId'] ?? '';
    vehicleId = json['vehicleId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['organizationEnrollmentId'] = organizationEnrollmentId;
    data['organizationId'] = organizationId;
    data['partnerOrganizationEnrollmentId'] = partnerOrganizationEnrollmentId;
    data['partnerOrganizationId'] = partnerOrganizationId;
    data['type'] = type;
    data['vehicleEnrollmentId'] = vehicleEnrollmentId;
    data['vehicleId'] = vehicleId;
    return data;
  }
}

class VehicleInfo {
  String? vehicleId;
  String? vehicleEntityId;

  VehicleInfo({this.vehicleId, this.vehicleEntityId});

  VehicleInfo.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'] ?? '';
    vehicleEntityId = json['vehicleEntityId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicleId'] = vehicleId;
    data['vehicleEntityId'] = vehicleEntityId;
    return data;
  }
}
