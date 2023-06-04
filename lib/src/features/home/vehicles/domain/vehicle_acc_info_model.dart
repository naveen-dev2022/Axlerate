class VehicleAccInfoModel {
  Data? data;

  VehicleAccInfoModel({this.data});

  VehicleAccInfoModel.unknown() : data = null;

  VehicleAccInfoModel.fromJson(Map<String, dynamic> json) {
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
  Messagee? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null ? Messagee.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Messagee {
  String? sId;
  String? id;
  String? entityId;
  String? type;
  String? status;
  String? accountNumber;
  String? iFSC;
  String? upiId;
  int? thresholdLimit;
  int? availableBalance;
  String? organizationId;
  String? partnerOrganizationId;
  String? createdAt;
  String? updatedAt;
  String? issuerName;
  int? iV;

  Messagee(
      {this.sId,
      this.id,
      this.entityId,
      this.type,
      this.status,
      this.accountNumber,
      this.iFSC,
      this.upiId,
      this.thresholdLimit,
      this.availableBalance,
      this.organizationId,
      this.partnerOrganizationId,
      this.createdAt,
      this.updatedAt,
      this.issuerName,
      this.iV});

  Messagee.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    entityId = json['entityId'];
    type = json['type'];
    status = json['status'];
    accountNumber = json['accountNumber'];
    iFSC = json['IFSC'];
    upiId = json['upiId'];
    thresholdLimit = json['thresholdLimit'];
    availableBalance = json['availableBalance'];
    organizationId = json['organizationId'];
    partnerOrganizationId = json['partnerOrganizationId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    issuerName = json["issuerName"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['entityId'] = entityId;
    data['type'] = type;
    data['status'] = status;
    data['accountNumber'] = accountNumber;
    data['IFSC'] = iFSC;
    data['upiId'] = upiId;
    data['thresholdLimit'] = thresholdLimit;
    data['availableBalance'] = availableBalance;
    data['organizationId'] = organizationId;
    data['partnerOrganizationId'] = partnerOrganizationId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
