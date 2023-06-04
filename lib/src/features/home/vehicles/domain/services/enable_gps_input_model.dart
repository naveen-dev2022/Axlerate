class EnableGpsInputModel {
  EnableGpsInputModel({
    required this.organizationId,
    required this.vehicleRegNo,
    required this.imei,
    required this.kycDocuments,
  });

  final String organizationId;
  final String vehicleRegNo;
  final String imei;
  final Map<String, dynamic> kycDocuments;

  factory EnableGpsInputModel.fromJson(Map<String, dynamic> json) => EnableGpsInputModel(
        organizationId: json["organizationId"],
        vehicleRegNo: json["vehicleEntityId"],
        imei: json["imei"],
        kycDocuments: json['kycDocuments'],
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "vehicleRegistrationNumber": vehicleRegNo,
        "imei": imei,
        "kycDocuments": kycDocuments,
      };
}
