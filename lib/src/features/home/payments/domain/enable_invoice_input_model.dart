class EnableInvoiceInputModel {
  EnableInvoiceInputModel({
    required this.organizationEnrollmentId,
    this.status,
    this.companyName,
    this.registrationType,
    this.mid,
    this.mcc,
    this.productionKey,
    this.productionApiKey,
    this.testApiKey,
    this.documents,
  });

  final String organizationEnrollmentId;
  final String? status;
  final String? companyName;
  final String? registrationType;
  final String? mid;
  final String? mcc;
  final String? productionKey;
  final String? productionApiKey;
  final String? testApiKey;
  final Map<String, dynamic>? documents;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {'organizationEnrollmentId': organizationEnrollmentId};

    status != null && status!.isNotEmpty ? params.addAll({'status': status}) : params;
    companyName != null && companyName!.isNotEmpty ? params.addAll({'companyName': companyName}) : params;
    registrationType != null && registrationType!.isNotEmpty
        ? params.addAll({'registrationType': registrationType})
        : params;
    mid != null && mid!.isNotEmpty ? params.addAll({'mid': mid}) : params;
    mcc != null && mcc!.isNotEmpty ? params.addAll({'mcc': mcc}) : params;
    productionKey != null && productionKey!.isNotEmpty ? params.addAll({'productionKey': productionKey}) : params;
    productionApiKey != null && productionApiKey!.isNotEmpty
        ? params.addAll({'productionApiKey': productionApiKey})
        : params;
    testApiKey != null && testApiKey!.isNotEmpty ? params.addAll({'testApiKey': testApiKey}) : params;
    documents != null && documents!.isNotEmpty ? params.addAll(documents!) : params;

    return params;
  }
}
