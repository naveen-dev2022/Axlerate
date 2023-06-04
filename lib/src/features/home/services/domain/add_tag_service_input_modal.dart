class AddTagServiceInputModel {
  AddTagServiceInputModel({
    required this.organizationId,
    this.partnerOrgId,
    required this.serviceType,
    required this.issuerName,
    required this.kycDocuments,
    this.cashBackPercentage,
    this.thresholdLimit,
  });

  final String organizationId;
  String? partnerOrgId;
  final String serviceType;
  final String issuerName;
  final Map<String, dynamic> kycDocuments;
  int? cashBackPercentage;
  final int? thresholdLimit;

  factory AddTagServiceInputModel.fromJson(Map<String, dynamic> json) => AddTagServiceInputModel(
        organizationId: json["organizationId"],
        partnerOrgId: json["partnerOrgId"],
        serviceType: json["serviceType"],
        issuerName: json["issuerName "],
        kycDocuments: json['kycDocuments'],
        cashBackPercentage: json["cashBackPercentage"],
        thresholdLimit: json["thresholdLimit"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {
      "organizationId": organizationId,
      //"partnerOrgId": partnerOrgId,
      "serviceType": serviceType,
      "issuerName": issuerName,
      'kycDocuments': kycDocuments,
      //"cashBackPercentage": cashBackPercentage,
    };
    partnerOrgId != null ? params.addAll({'partnerOrgId': partnerOrgId}) : params;

    cashBackPercentage != null ? params.addAll({'cashBackPercentage': cashBackPercentage}) : params;

    thresholdLimit != null ? params.addAll({"thresholdLimit": thresholdLimit}) : params;
    return params;
  }
}
