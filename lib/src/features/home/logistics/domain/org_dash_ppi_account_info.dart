class OrgDashPpiAccountInfo {
  OrgDashPpiAccountInfo({
    this.data,
  });

  Data? data;
  bool? ppiNotenabled;

  OrgDashPpiAccountInfo.unknown() : data = null;

  OrgDashPpiAccountInfo.reqNotSent()
      : data = null,
        ppiNotenabled = true;

  factory OrgDashPpiAccountInfo.fromJson(Map<String, dynamic> json) => OrgDashPpiAccountInfo(
        data: json["data"] != null ? Data.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}

class Data {
  Data({
    this.message,
  });

  PpiAccountInfoMessage? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"] != null ? PpiAccountInfoMessage.fromJson(json['message']) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}

class PpiAccountInfoMessage {
  PpiAccountInfoMessage({
    this.id,
    this.organizationId,
    this.partnerOrganizationId,
    this.entityId,
    this.type,
    this.status,
    required this.accountNumber,
    required this.ifsc,
    required this.upiId,
    this.thresholdLimit,
    this.availableBalance,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? organizationId;
  String? partnerOrganizationId;
  String? entityId;
  String? type;
  String? status;
  String accountNumber;
  String ifsc;
  String upiId;
  int? thresholdLimit;
  int? availableBalance;
  String? createdAt;
  String? updatedAt;
  int? v;

  factory PpiAccountInfoMessage.fromJson(Map<String, dynamic> json) => PpiAccountInfoMessage(
        id: json["_id"],
        organizationId: json["organizationId"],
        partnerOrganizationId: json["partnerOrganizationId"],
        entityId: json["entityId"],
        type: json["type"],
        status: json["status"],
        accountNumber: json["accountNumber"],
        ifsc: json["IFSC"],
        upiId: json["upiId"],
        thresholdLimit: json["thresholdLimit"],
        availableBalance: json["availableBalance"],
        createdAt: json["createdAt"]?.toString(),
        updatedAt: json["updatedAt"]?.toString(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "organizationId": organizationId,
        "partnerOrganizationId": partnerOrganizationId,
        "entityId": entityId,
        "type": type,
        "status": status,
        "accountNumber": accountNumber,
        "IFSC": ifsc,
        "upiId": upiId,
        "thresholdLimit": thresholdLimit,
        "availableBalance": availableBalance,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
