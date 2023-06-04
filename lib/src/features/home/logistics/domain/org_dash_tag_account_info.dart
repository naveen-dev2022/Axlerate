class OrgDashTagAccountInfo {
  OrgDashTagAccountInfo({
    this.data,
  });

  Data? data;
  bool? tagNotEnabled;

  OrgDashTagAccountInfo.unknown() : data = null;

  OrgDashTagAccountInfo.reqNotSent()
      : data = null,
        tagNotEnabled = true;

  factory OrgDashTagAccountInfo.fromJson(Map<String, dynamic> json) =>
      OrgDashTagAccountInfo(data: json["data"] != null ? Data.fromJson(json['data']) : null);

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}

class Data {
  Data({
    this.message,
  });

  YbTagAccountInfo? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"] != null ? YbTagAccountInfo.fromJson(json['message']) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}

class YbTagAccountInfo {
  YbTagAccountInfo({
    this.id,
    this.messageId,
    this.entityId,
    this.type,
    this.status,
    this.accountNumber,
    this.ifsc,
    required this.upiId,
    this.thresholdLimit,
    this.availableBalance,
    this.partnerOrganizationId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? messageId;
  String? entityId;
  String? type;
  String? status;
  String? accountNumber;
  String? ifsc;
  String upiId;
  int? thresholdLimit;
  int? availableBalance;
  String? partnerOrganizationId;
  String? createdAt;
  String? updatedAt;
  int? v;

  factory YbTagAccountInfo.fromJson(Map<String, dynamic> json) => YbTagAccountInfo(
        id: json["_id"],
        messageId: json["id"],
        entityId: json["entityId"],
        type: json["type"],
        status: json["status"],
        accountNumber: json["accountNumber"],
        ifsc: json["IFSC"],
        upiId: json["upiId"],
        thresholdLimit: json["thresholdLimit"],
        availableBalance: json["availableBalance"],
        partnerOrganizationId: json["partnerOrganizationId"],
        createdAt: json["createdAt"]?.toString(),
        updatedAt: json["updatedAt"]?.toString(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": messageId,
        "entityId": entityId,
        "type": type,
        "status": status,
        "accountNumber": accountNumber,
        "IFSC": ifsc,
        "upiId": upiId,
        "thresholdLimit": thresholdLimit,
        "availableBalance": availableBalance,
        "partnerOrganizationId": partnerOrganizationId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
