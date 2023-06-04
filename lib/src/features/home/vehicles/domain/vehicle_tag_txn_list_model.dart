class VehicleTagTxnListModel {
  Data? data;

  VehicleTagTxnListModel({this.data});

  VehicleTagTxnListModel.unknown() : data = null;

  VehicleTagTxnListModel.fromJson(Map<String, dynamic> json) {
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
  Message? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  List<Docs>? docs;
  int? count;

  Message({this.docs, this.count});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Docs {
  String? transactionTime;
  Metadata? metadata;
  String? rrn;
  String? externalId;
  String? sId;
  int? balance;
  String? tollId;
  Organization? organization;
  String? tollReaderTime;
  Organization? partnerOrganization;
  String? transactionReference;
  int? amount;
  String? profileId;
  String? laneNo;
  String? tollPlazaName;
  String? serialNumber;
  String? tagId;
  VehicleInfo? vehicleInfo;
  String? type;
  String? organizationEnrollmentId;
  String? transactionType;
  String? laneDirection;

  Docs(
      {this.transactionTime,
      this.metadata,
      this.rrn,
      this.externalId,
      this.sId,
      this.balance,
      this.tollId,
      this.organization,
      this.tollReaderTime,
      this.partnerOrganization,
      this.transactionReference,
      this.amount,
      this.profileId,
      this.laneNo,
      this.tollPlazaName,
      this.serialNumber,
      this.tagId,
      this.vehicleInfo,
      this.type,
      this.organizationEnrollmentId,
      this.transactionType,
      this.laneDirection});

  Docs.fromJson(Map<String, dynamic> json) {
    transactionTime = json['transactionTime'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    rrn = json['rrn'];
    externalId = json['externalId'];
    sId = json['_id'];
    balance = json['balance'];
    tollId = json['tollId'];
    organization = json['organization'] != null ? Organization.fromJson(json['organization']) : null;
    tollReaderTime = json['tollReaderTime'];
    partnerOrganization =
        json['partnerOrganization'] != null ? Organization.fromJson(json['partnerOrganization']) : null;
    transactionReference = json['transactionReference'];
    amount = json['amount'];
    profileId = json['profileId'];
    laneNo = json['laneNo'];
    tollPlazaName = json['tollPlazaName'];
    serialNumber = json['serialNumber'];
    tagId = json['tagId'];
    vehicleInfo = json['vehicleInfo'] != null ? VehicleInfo.fromJson(json['vehicleInfo']) : null;
    type = json['type'];
    organizationEnrollmentId = json['organizationEnrollmentId'];
    transactionType = json['transactionType'];
    laneDirection = json['laneDirection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transactionTime'] = transactionTime;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['rrn'] = rrn;
    data['externalId'] = externalId;
    data['_id'] = sId;
    data['balance'] = balance;
    data['tollId'] = tollId;
    if (organization != null) {
      data['organization'] = organization!.toJson();
    }
    data['tollReaderTime'] = tollReaderTime;
    if (partnerOrganization != null) {
      data['partnerOrganization'] = partnerOrganization!.toJson();
    }
    data['transactionReference'] = transactionReference;
    data['amount'] = amount;
    data['profileId'] = profileId;
    data['laneNo'] = laneNo;
    data['tollPlazaName'] = tollPlazaName;
    data['serialNumber'] = serialNumber;
    data['tagId'] = tagId;
    if (vehicleInfo != null) {
      data['vehicleInfo'] = vehicleInfo!.toJson();
    }
    data['type'] = type;
    data['organizationEnrollmentId'] = organizationEnrollmentId;
    data['transactionType'] = transactionType;
    data['laneDirection'] = laneDirection;
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
    organizationEnrollmentId = json['organizationEnrollmentId'];
    organizationId = json['organizationId'];
    partnerOrganizationEnrollmentId = json['partnerOrganizationEnrollmentId'];
    partnerOrganizationId = json['partnerOrganizationId'];
    type = json['type'];
    vehicleEnrollmentId = json['vehicleEnrollmentId'];
    vehicleId = json['vehicleId'];
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

class Organization {
  String? sId;
  String? firstName;
  String? lastName;
  String? natureOfBusiness;
  String? enrollmentId;
  String? contactNumber;
  int? cashBackPercentage;

  Organization(
      {this.sId,
      this.firstName,
      this.lastName,
      this.natureOfBusiness,
      this.enrollmentId,
      this.contactNumber,
      this.cashBackPercentage});

  Organization.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    natureOfBusiness = json['natureOfBusiness'];
    enrollmentId = json['enrollmentId'];
    contactNumber = json['contactNumber'];
    cashBackPercentage = json['cashBackPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['natureOfBusiness'] = natureOfBusiness;
    data['enrollmentId'] = enrollmentId;
    data['contactNumber'] = contactNumber;
    data['cashBackPercentage'] = cashBackPercentage;
    return data;
  }
}

class VehicleInfo {
  String? vehicleId;
  String? vehicleEntityId;

  VehicleInfo({this.vehicleId, this.vehicleEntityId});

  VehicleInfo.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'];
    vehicleEntityId = json['vehicleEntityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicleId'] = vehicleId;
    data['vehicleEntityId'] = vehicleEntityId;
    return data;
  }
}
