// class RequestInvoiceInputModel {
//   RequestInvoiceInputModel({
//     required this.organizationEnrollmentId,
//     this.companyName,
//     this.logo,
//     this.registrationType,
//     this.documents,
//   });

//   final String organizationEnrollmentId;
//   final String? companyName;
//   final String? logo;
//   final String? registrationType;
//   final Map<String, dynamic>? documents;

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> params = {'organizationEnrollmentId': organizationEnrollmentId};

//     companyName != null && companyName!.isNotEmpty ? params.addAll({'companyName': companyName}) : params;
//     logo != null && logo!.isNotEmpty ? params.addAll({'logo': logo}) : params;
//     registrationType != null && registrationType!.isNotEmpty
//         ? params.addAll({'registrationType': registrationType})
//         : params;
//     documents != null && documents!.isNotEmpty ? params.addAll({'documents': documents}) : params;

//     return params;
//   }
// }

class RequestInvoiceInputModel {
  RequestInvoiceInputModel({
    required this.organizationEnrollmentId,
    this.status,
    this.rejectionReason,
    this.companyName,
    this.logo,
    this.registrationType,
    this.documents,
    this.mid,
    this.mcc,
    this.productionApiKey,
    this.productionKey,
    this.testApiKey,
  });

  final String organizationEnrollmentId;
  final String? status;
  final String? rejectionReason;
  final String? companyName;
  final String? logo;
  final String? registrationType;
  final RequestInvoiceInputDocuments? documents;
  final String? mid;
  final String? mcc;
  final String? productionApiKey;
  final String? productionKey;
  final String? testApiKey;

  factory RequestInvoiceInputModel.fromJson(Map<String, dynamic> json) {
    return RequestInvoiceInputModel(
      organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
      status: json["status"] ?? "",
      rejectionReason: json["rejectionReason"] ?? "",
      companyName: json["companyName"] ?? "",
      logo: json["logo"] ?? "",
      registrationType: json["registrationType"] ?? "",
      documents: json["documents"] == null ? null : RequestInvoiceInputDocuments.fromJson(json["documents"]),
      mid: json["mid"] ?? "",
      mcc: json["mcc"] ?? "",
      productionApiKey: json["productionApiKey"] ?? "",
      productionKey: json["productionKey"] ?? "",
      testApiKey: json["testApiKey"] ?? "",
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "organizationEnrollmentId": organizationEnrollmentId,
  //       "companyName": companyName,
  //       "logo": logo,
  //       "registrationType": registrationType,
  //       "documents": documents?.toJson(),
  //     };

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {'organizationEnrollmentId': organizationEnrollmentId};

    status != null ? params.addAll({'status': status}) : params;
    rejectionReason != null ? params.addAll({'rejectionReason': rejectionReason}) : params;
    companyName != null && companyName!.isNotEmpty ? params.addAll({'companyName': companyName}) : params;
    logo != null && logo!.isNotEmpty ? params.addAll({'logo': logo}) : params;
    registrationType != null && registrationType!.isNotEmpty
        ? params.addAll({'registrationType': registrationType})
        : params;
    documents != null ? params.addAll({'documents': documents}) : params;
    mid != null ? params.addAll({'mid': mid}) : params;
    mcc != null ? params.addAll({'mcc': mcc}) : params;
    productionApiKey != null ? params.addAll({'productionApiKey': productionApiKey}) : params;
    productionKey != null ? params.addAll({'productionKey': productionKey}) : params;
    testApiKey != null ? params.addAll({'testApiKey': testApiKey}) : params;
    documents != null
        ? params.addAll({
            'documents': documents!.toJson()
            // documents!.boardResolution!.url.isNotEmpty
            //     ? 'ARTICLES_OF_ASSOCIATION'
            //     : {'url': documents!.articlesOfAssociation!.url},
          })
        : params;
    return params;
  }
}

class RequestInvoiceInputDocuments {
  RequestInvoiceInputDocuments({
    this.boardResolution,
    this.listOfDirectors,
    this.undertaking,
    this.merchantApplication,
    this.merchantOnboarding,
    this.articlesOfAssociation,
    this.memorandumOfAssociation,
    this.listOfDirectorsPartners,
    this.incorporationCertificate,
    this.partnershipDeed,
    this.establishmentCertificate,
    this.registrationCertificate,
    this.companyPan,
    this.gstRegistrationCertificate,
    this.productServicesUndertaking,
    this.companyAddressProof,
    this.kycDirectorsPartners,
    this.serviceAgreement,
    this.cancellationCheque,
    this.legalOpinionDocument,
    this.bankStatement,
    this.commencentOfBusinessCertificate,
    this.others,
  });

  final UploadDocuments? boardResolution;
  final UploadDocuments? listOfDirectors;
  final UploadDocuments? undertaking;
  final UploadDocuments? merchantApplication;
  final UploadDocuments? merchantOnboarding;
  final UploadDocuments? articlesOfAssociation;
  final UploadDocuments? memorandumOfAssociation;
  final UploadDocuments? listOfDirectorsPartners;
  final UploadDocuments? incorporationCertificate;
  final UploadDocuments? partnershipDeed;
  final UploadDocuments? establishmentCertificate;
  final UploadDocuments? registrationCertificate;
  final UploadDocuments? companyPan;
  final UploadDocuments? gstRegistrationCertificate;
  final UploadDocuments? productServicesUndertaking;
  final UploadDocuments? companyAddressProof;
  final UploadDocuments? kycDirectorsPartners;
  final UploadDocuments? serviceAgreement;
  final UploadDocuments? cancellationCheque;
  final UploadDocuments? legalOpinionDocument;
  final UploadDocuments? bankStatement;
  final UploadDocuments? commencentOfBusinessCertificate;
  final UploadDocuments? others;

  factory RequestInvoiceInputDocuments.fromJson(Map<String, dynamic> json) {
    return RequestInvoiceInputDocuments(
      boardResolution: json["BOARD_RESOLUTION"] == null ? null : UploadDocuments.fromJson(json["BOARD_RESOLUTION"]),
      listOfDirectors: json["LIST_OF_DIRECTORS"] == null ? null : UploadDocuments.fromJson(json["LIST_OF_DIRECTORS"]),
      undertaking: json["UNDERTAKING"] == null ? null : UploadDocuments.fromJson(json["UNDERTAKING"]),
      merchantApplication:
          json["MERCHANT_APPLICATION"] == null ? null : UploadDocuments.fromJson(json["MERCHANT_APPLICATION"]),
      merchantOnboarding:
          json["MERCHANT_ONBOARDING"] == null ? null : UploadDocuments.fromJson(json["MERCHANT_ONBOARDING"]),
      articlesOfAssociation:
          json["ARTICLES_OF_ASSOCIATION"] == null ? null : UploadDocuments.fromJson(json["ARTICLES_OF_ASSOCIATION"]),
      memorandumOfAssociation: json["MEMORANDUM_OF_ASSOCIATION"] == null
          ? null
          : UploadDocuments.fromJson(json["MEMORANDUM_OF_ASSOCIATION"]),
      listOfDirectorsPartners: json["LIST_OF_DIRECTORS_PARTNERS"] == null
          ? null
          : UploadDocuments.fromJson(json["LIST_OF_DIRECTORS_PARTNERS"]),
      incorporationCertificate: json["INCORPORATION_CERTIFICATE"] == null
          ? null
          : UploadDocuments.fromJson(json["INCORPORATION_CERTIFICATE"]),
      partnershipDeed: json["PARTNERSHIP_DEED"] == null ? null : UploadDocuments.fromJson(json["PARTNERSHIP_DEED"]),
      establishmentCertificate: json["ESTABLISHMENT_CERTIFICATE"] == null
          ? null
          : UploadDocuments.fromJson(json["ESTABLISHMENT_CERTIFICATE"]),
      registrationCertificate:
          json["REGISTRATION_CERTIFICATE"] == null ? null : UploadDocuments.fromJson(json["REGISTRATION_CERTIFICATE"]),
      companyPan: json["COMPANY_PAN"] == null ? null : UploadDocuments.fromJson(json["COMPANY_PAN"]),
      gstRegistrationCertificate: json["GST_REGISTRATION_CERTIFICATE"] == null
          ? null
          : UploadDocuments.fromJson(json["GST_REGISTRATION_CERTIFICATE"]),
      productServicesUndertaking: json["PRODUCT_SERVICES_UNDERTAKING"] == null
          ? null
          : UploadDocuments.fromJson(json["PRODUCT_SERVICES_UNDERTAKING"]),
      companyAddressProof:
          json["COMPANY_ADDRESS_PROOF"] == null ? null : UploadDocuments.fromJson(json["COMPANY_ADDRESS_PROOF"]),
      kycDirectorsPartners:
          json["KYC_DIRECTORS_PARTNERS"] == null ? null : UploadDocuments.fromJson(json["KYC_DIRECTORS_PARTNERS"]),
      serviceAgreement: json["SERVICE_AGREEMENT"] == null ? null : UploadDocuments.fromJson(json["SERVICE_AGREEMENT"]),
      cancellationCheque:
          json["CANCELLATION_CHEQUE"] == null ? null : UploadDocuments.fromJson(json["CANCELLATION_CHEQUE"]),
      legalOpinionDocument:
          json["LEGAL_OPINION_DOCUMENT"] == null ? null : UploadDocuments.fromJson(json["LEGAL_OPINION_DOCUMENT"]),
      bankStatement: json["BANK_STATEMENT"] == null ? null : UploadDocuments.fromJson(json["BANK_STATEMENT"]),
      commencentOfBusinessCertificate: json["COMMENCENT_OF_BUSINESS_CERTIFICATE"] == null
          ? null
          : UploadDocuments.fromJson(json["COMMENCENT_OF_BUSINESS_CERTIFICATE"]),
      others: json["OTHERS"] == null ? null : UploadDocuments.fromJson(json["OTHERS"]),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {};

    boardResolution != null ? params.addAll({"BOARD_RESOLUTION": boardResolution}) : params;
    listOfDirectors != null ? params.addAll({"LIST_OF_DIRECTORS": listOfDirectors}) : params;
    undertaking != null ? params.addAll({"UNDERTAKING": undertaking}) : params;
    merchantApplication != null ? params.addAll({"MERCHANT_APPLICATION": merchantApplication}) : params;
    merchantOnboarding != null ? params.addAll({"MERCHANT_ONBOARDING": merchantOnboarding}) : params;
    articlesOfAssociation != null ? params.addAll({"ARTICLES_OF_ASSOCIATION": articlesOfAssociation}) : params;
    memorandumOfAssociation != null ? params.addAll({"MEMORANDUM_OF_ASSOCIATION": memorandumOfAssociation}) : params;
    listOfDirectorsPartners != null ? params.addAll({"LIST_OF_DIRECTORS_PARTNERS": listOfDirectorsPartners}) : params;
    incorporationCertificate != null ? params.addAll({"INCORPORATION_CERTIFICATE": incorporationCertificate}) : params;
    partnershipDeed != null ? params.addAll({"PARTNERSHIP_DEED": partnershipDeed}) : params;
    establishmentCertificate != null ? params.addAll({"ESTABLISHMENT_CERTIFICATE": establishmentCertificate}) : params;
    registrationCertificate != null ? params.addAll({"REGISTRATION_CERTIFICATE": registrationCertificate}) : params;
    companyPan != null ? params.addAll({"COMPANY_PAN": companyPan}) : params;
    gstRegistrationCertificate != null
        ? params.addAll({"GST_REGISTRATION_CERTIFICATE": gstRegistrationCertificate})
        : params;
    productServicesUndertaking != null
        ? params.addAll({"PRODUCT_SERVICES_UNDERTAKING": productServicesUndertaking})
        : params;
    companyAddressProof != null ? params.addAll({"COMPANY_ADDRESS_PROOF": companyAddressProof}) : params;
    kycDirectorsPartners != null ? params.addAll({"KYC_DIRECTORS_PARTNERS": kycDirectorsPartners}) : params;
    serviceAgreement != null ? params.addAll({"SERVICE_AGREEMENT": serviceAgreement}) : params;
    cancellationCheque != null ? params.addAll({"CANCELLATION_CHEQUE": cancellationCheque}) : params;
    legalOpinionDocument != null ? params.addAll({"LEGAL_OPINION_DOCUMENT": legalOpinionDocument}) : params;
    bankStatement != null ? params.addAll({"BANK_STATEMENT": bankStatement}) : params;
    commencentOfBusinessCertificate != null
        ? params.addAll({"COMMENCENT_OF_BUSINESS_CERTIFICATE": commencentOfBusinessCertificate})
        : params;
    others != null ? params.addAll({"OTHERS": others}) : params;

    return params;
  }
}

class UploadDocuments {
  UploadDocuments({
    required this.url,
    this.documentNo,
    this.documentExpiry,
  });

  final String url;
  final String? documentNo;
  final DateTime? documentExpiry;

  factory UploadDocuments.fromJson(Map<String, dynamic> json) {
    return UploadDocuments(
      url: json["url"] ?? "",
      documentNo: json["documentNo"] ?? "",
      documentExpiry: json["documentExpiry"] == null ? null : DateTime.tryParse(json["documentExpiry"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        // "documentNo": documentNo ?? '',
        // "documentExpiry": documentExpiry?.toIso8601String(),
      };
}
