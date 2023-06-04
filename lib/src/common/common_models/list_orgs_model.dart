// // ignore_for_file: prefer_null_aware_operators

// class ListOrgsModel {
//   ListOrgsModel({
//     this.data,
//   });

//   Data? data;

//   ListOrgsModel.unknown() : data = null;

//   factory ListOrgsModel.fromJson(Map<String, dynamic> json) => ListOrgsModel(
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data!.toJson(),
//       };
// }

// class Data {
//   Data({
//     required this.message,
//   });

//   Message message;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         message: Message.fromJson(json["message"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message.toJson(),
//       };
// }

// class Message {
//   Message({
//     required this.docs,
//     required this.count,
//   });

//   List<OrgDoc> docs;
//   int count;

//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//         docs: List<OrgDoc>.from(json["docs"].map((x) {
//           return OrgDoc.fromJson(x);
//         })),
//         count: json["count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
//         "count": count,
//       };
// }

// class OrgDoc {
//   OrgDoc({
//     required this.id,
//     required this.enrollmentId,
//     required this.orgCode,
//     required this.status,
//     required this.organizationType,
//     required this.services,
//     required this.accountInformation,
//     required this.title,
//     required this.panNumber,
//     required this.firstName,
//     required this.lastName,
//     required this.natureOfBusiness,
//     required this.email,
//     required this.incorporateDate,
//     required this.contactNumber,
//     required this.addresses,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdByOrg,
//     required this.updatedByOrg,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.users,
//     required this.vehicles,
//     required this.ppiUsersPartnerOrg,
//     required this.totalTagPartnerOrg,
//     // required this.addressLine1,
//     // required this.addressLine2,
//     // required this.city,
//     // required this.country,
//     // required this.state,
//     // required this.zipCode,
//     required this.thresholdLimit,
//   });

//   get displayName {
//     return '$firstName $lastName';
//   }

//   String id;
//   String enrollmentId;
//   String orgCode;
//   String status;
//   String organizationType;
//   Services? services;
//   List<String> accountInformation;
//   String title;
//   String panNumber;
//   String firstName;
//   String lastName;
//   String natureOfBusiness;
//   String email;
//   DateTime incorporateDate;
//   String contactNumber;
//   Addresses? addresses;
//   String createdBy;
//   String updatedBy;
//   String createdByOrg;
//   String updatedByOrg;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;
//   int users;
//   int vehicles;
//   int ppiUsersPartnerOrg;
//   int totalTagPartnerOrg;
//   // String addressLine1;
//   // String addressLine2;
//   // String city;
//   // String country;
//   // String state;
//   // String zipCode;
//   int thresholdLimit;

//   factory OrgDoc.fromJson(Map<String, dynamic> json) => OrgDoc(
//         id: json["_id"] ?? "",
//         enrollmentId: json["enrollmentId"] ?? "",
//         orgCode: json['orgCode'] ?? '',
//         status: json["status"] ?? "",
//         organizationType: json["organizationType"] ?? "",
//         services: json["services"] != null ? Services.fromJson(json["services"]) : null,
//         accountInformation:
//             json["accountInformation"] != null ? List<String>.from(json["accountInformation"].map((x) => x)) : [],
//         title: json["title"] ?? "",
//         panNumber: json["panNumber"] ?? "",
//         firstName: json["firstName"] ?? "",
//         lastName: json["lastName"] ?? "",
//         natureOfBusiness: json["natureOfBusiness"] ?? "",
//         email: json["email"] ?? "",
//         incorporateDate: json["incorporateDate"] != null ? DateTime.parse(json["incorporateDate"]) : DateTime.now(),
//         contactNumber: json["contactNumber"] ?? "",
//         addresses: json["addresses"] == null ? null : Addresses.fromJson(json["addresses"]),
//         createdBy: json["createdBy"] ?? "",
//         updatedBy: json["updatedBy"] ?? "",
//         createdByOrg: json["createdByOrg"] ?? "",
//         updatedByOrg: json["updatedByOrg"] ?? "",
//         createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
//         updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
//         v: json["__v"] ?? 0,
//         users: json["users"] ?? 0,
//         vehicles: json["vehicles"] ?? 0,
//         ppiUsersPartnerOrg: json["ppiUsersPartnerOrg"] ?? 0,
//         totalTagPartnerOrg: json["totalTagPartnerOrg"] ?? 0,
//         // addressLine1: json["addressLine1"] ?? "",
//         // addressLine2: json["addressLine2"] ?? "",
//         // city: json["city"] ?? "",
//         // country: json["country"] ?? "",
//         // state: json["state"] ?? "",
//         // zipCode: json["zipCode"] ?? "",
//         thresholdLimit: json["thresholdLimit"] ?? 0,
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "enrollmentId": enrollmentId,
//         'orgCode': orgCode,
//         "status": status,
//         "organizationType": organizationType,
//         "services": services?.toJson(),
//         "accountInformation": List<dynamic>.from(accountInformation.map((x) => x)),
//         "title": title,
//         "panNumber": panNumber,
//         "firstName": firstName,
//         "lastName": lastName,
//         "natureOfBusiness": natureOfBusiness,
//         "email": email,
//         "incorporateDate": incorporateDate.toIso8601String(),
//         "contactNumber": contactNumber,
//         "addresses": addresses,
//         "createdBy": createdBy,
//         "updatedBy": updatedBy,
//         "createdByOrg": createdByOrg,
//         "updatedByOrg": updatedByOrg,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "users": users,
//         "vehicles": vehicles,
//         "ppiUsersPartnerOrg": ppiUsersPartnerOrg,
//         "totalTagPartnerOrg": totalTagPartnerOrg,
//         // "addressLine1": addressLine1,
//         // "addressLine2": addressLine2,
//         // "city": city,
//         // "country": country,
//         // "state": state,
//         // "zipCode": zipCode,
//         "thresholdLimit": thresholdLimit,
//       };
// }

// class Addresses {
//   Addresses({
//     required this.officeAddress,
//     required this.communicationAddress,
//   });

//   Address? officeAddress;
//   Address? communicationAddress;

//   factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
//         officeAddress: json["officeAddress"] != null ? Address.fromJson(json["officeAddress"]) : null,
//         communicationAddress:
//             json["communicationAddress"] != null ? Address.fromJson(json["communicationAddress"]) : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "officeAddress": officeAddress!.toJson(),
//         "communicationAddress": communicationAddress!.toJson(),
//       };
// }

// class Address {
//   Address({
//     required this.addressLine1,
//     required this.addressLine2,
//     required this.city,
//     required this.country,
//     required this.state,
//     required this.zipCode,
//   });

//   String? addressLine1;
//   String? addressLine2;
//   String? city;
//   String? country;
//   String? state;
//   String? zipCode;

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         addressLine1: json["addressLine1"] ?? "",
//         addressLine2: json["addressLine2"] ?? "",
//         city: json["city"] ?? "",
//         country: json["country"] ?? "",
//         state: json["state"] ?? "",
//         zipCode: json["zipCode"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "addressLine1": addressLine1,
//         "addressLine2": addressLine2,
//         "city": city,
//         "country": country,
//         "state": state,
//         "zipCode": zipCode,
//       };
// }

// class Services {
//   Services({
//     required this.gps,
//     required this.tag,
//     required this.ppi,
//     required this.fuel,
//   });

//   Gps? gps;
//   Tag? tag;
//   Ppi? ppi;
//   Fuel? fuel;

//   factory Services.fromJson(Map<String, dynamic> json) => Services(
//         gps: json["gps"] != null ? Gps.fromJson(json["gps"]) : null,
//         tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
//         ppi: json["ppi"] == null ? null : Ppi.fromJson(json["ppi"]),
//         fuel: json["fuel"] == null ? null : Fuel.fromJson(json["fuel"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "gps": gps == null ? null : gps?.toJson(),
//         "tag": tag == null ? null : tag?.toJson(),
//         "ppi": ppi == null ? null : ppi?.toJson(),
//         "fuel": fuel == null ? null : fuel?.toJson(),
//       };
// }

// class Gps {
//   Gps({
//     required this.partnerOrganizationId,
//     required this.issuerName,
//   });

//   List<String> partnerOrganizationId;
//   List<String> issuerName;

//   factory Gps.fromJson(Map<String, dynamic> json) => Gps(
//         partnerOrganizationId:
//             json["partnerOrganization"] != null ? List<String>.from(json["partnerOrganization"].map((x) => x)) : [],
//         issuerName: json["issuer"] != null ? List<String>.from(json["issuer"].map((x) => x)) : [],
//       );

//   Map<String, dynamic> toJson() => {
//         "partnerOrganizationId": List<dynamic>.from(partnerOrganizationId.map((x) => x)),
//         "issuerName": List<dynamic>.from(issuerName.map((x) => x)),
//       };
// }

// class Ppi {
//   Ppi({
//     required this.issuer,
//     required this.partnerOrganization,
//   });

//   List<Issuer>? issuer;
//   List<PartnerOrganization>? partnerOrganization;

//   factory Ppi.fromJson(Map<String, dynamic> json) => Ppi(
//         issuer: json["issuer"] != null ? List<Issuer>.from(json["issuer"].map((x) => Issuer.fromJson(x))) : null,
//         partnerOrganization: json["partnerOrganization"] != null
//             ? List<PartnerOrganization>.from(json["partnerOrganization"].map((x) => PartnerOrganization.fromJson(x)))
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "issuer": List<dynamic>.from(issuer!.map((x) => x.toJson())),
//         "partnerOrganization": List<dynamic>.from(partnerOrganization!.map((x) => x.toJson())),
//       };
// }

// class Issuer {
//   Issuer({
//     required this.name,
//     required this.kycStatus,
//     required this.entityId,
//     required this.kycDocuments,
//     required this.kycType,
//   });

//   String name;
//   String kycStatus;
//   String entityId;
//   KycDocuments? kycDocuments;
//   String kycType;

//   factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
//         name: json["name"] ?? "",
//         entityId: json["entityId"] ?? "",
//         kycStatus: json["kycStatus"] ?? "",
//         kycDocuments: json["kycDocuments"] == null ? null : KycDocuments.fromJson(json["kycDocuments"]),
//         kycType: json["kycType"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "entityId": entityId,
//         "kycStatus": kycStatus,
//         "kycDocuments": kycDocuments == null ? null : kycDocuments?.toJson(),
//         "kycType": kycType,
//       };
// }

// class KycDocuments {
//   KycDocuments({
//     required this.identityProof,
//     required this.addressProof,
//   });

//   Proof? identityProof;
//   Proof? addressProof;

//   factory KycDocuments.fromJson(Map<String, dynamic> json) => KycDocuments(
//         identityProof: json["IDENTITY_PROOF"] != null ? Proof.fromJson(json["IDENTITY_PROOF"]) : null,
//         addressProof: json["ADDRESS_PROOF"] != null ? Proof.fromJson(json["ADDRESS_PROOF"]) : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "IDENTITY_PROOF": identityProof!.toJson(),
//         "ADDRESS_PROOF": addressProof!.toJson(),
//       };
// }

// class Proof {
//   Proof({
//     required this.url,
//     required this.docUploadStatus,
//   });

//   String url;
//   String docUploadStatus;

//   factory Proof.fromJson(Map<String, dynamic> json) => Proof(
//         url: json["url"] ?? "",
//         docUploadStatus: json["docUploadStatus"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "docUploadStatus": docUploadStatus,
//       };
// }

// class PartnerOrganization {
//   PartnerOrganization({
//     required this.id,
//     required this.enrollmentId,
//     required this.cashBackPercentage,
//   });

//   String id;
//   String enrollmentId;
//   double cashBackPercentage;

//   factory PartnerOrganization.fromJson(Map<String, dynamic> json) => PartnerOrganization(
//         id: json["id"] ?? "",
//         enrollmentId: json["enrollmentId"] ?? "",
//         cashBackPercentage:
//             json["cashBackPercentage"] != null ? double.parse(json["cashBackPercentage"].toString()) : 0.0,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "cashBackPercentage": cashBackPercentage,
//       };
// }

// class Tag {
//   Tag({
//     required this.issuer,
//     required this.partnerOrganization,
//   });

//   List<Issuer>? issuer;
//   List<PartnerOrganization>? partnerOrganization;

//   factory Tag.fromJson(Map<String, dynamic> json) => Tag(
//         issuer: json["issuer"] != null ? List<Issuer>.from(json["issuer"].map((x) => Issuer.fromJson(x))) : null,
//         partnerOrganization: json["partnerOrganization"] != null
//             ? List<PartnerOrganization>.from(json["partnerOrganization"].map((x) => PartnerOrganization.fromJson(x)))
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "issuer": List<dynamic>.from(issuer!.map((x) => x.toJson())),
//         "partnerOrganization": List<dynamic>.from(partnerOrganization!.map((x) => x.toJson())),
//       };
// }

// class Fuel {
//   Fuel({
//     required this.hpcl,
//   });

//   final List<Hpcl> hpcl;

//   factory Fuel.fromJson(Map<String, dynamic> json) {
//     return Fuel(
//       hpcl: json["hpcl"] == null ? [] : List<Hpcl>.from(json["hpcl"]!.map((x) => Hpcl.fromJson(x))),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "hpcl": hpcl.map((x) => x.toJson()).toList(),
//       };
// }

// class Hpcl {
//   Hpcl({
//     required this.firstName,
//     required this.lastName,
//     required this.mobileNumber,
//     required this.email,
//     required this.salutationCode,
//     required this.addressInfo,
//     required this.panNumber,
//     required this.dateOfBirth,
//     required this.vendor,
//     required this.entityId,
//     required this.accessToken,
//     required this.kycStatus,
//     required this.kycDocuments,
//   });

//   final String firstName;
//   final String lastName;
//   final String mobileNumber;
//   final String email;
//   final String salutationCode;
//   final AddressInfo? addressInfo;
//   final String panNumber;
//   final DateTime? dateOfBirth;
//   final String vendor;
//   final String entityId;
//   final String accessToken;
//   final String kycStatus;
//   final KycDocumentsPanAndGst? kycDocuments;

//   factory Hpcl.fromJson(Map<String, dynamic> json) {
//     return Hpcl(
//       firstName: json["firstName"] ?? "",
//       lastName: json["lastName"] ?? "",
//       mobileNumber: json["mobileNumber"] ?? "",
//       email: json["email"] ?? "",
//       salutationCode: json["salutationCode"] ?? "",
//       addressInfo: json["addressInfo"] == null ? null : AddressInfo.fromJson(json["addressInfo"]),
//       panNumber: json["panNumber"] ?? "",
//       dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
//       vendor: json["vendor"] ?? "",
//       entityId: json["entityId"] ?? "",
//       accessToken: json["accessToken"] ?? "",
//       kycStatus: json["kycStatus"] ?? "",
//       kycDocuments: json["kycDocuments"] == null ? null : KycDocumentsPanAndGst.fromJson(json["kycDocuments"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "firstName": firstName,
//         "lastName": lastName,
//         "mobileNumber": mobileNumber,
//         "email": email,
//         "salutationCode": salutationCode,
//         "addressInfo": addressInfo?.toJson(),
//         "panNumber": panNumber,
//         "dateOfBirth": dateOfBirth?.toIso8601String(),
//         "vendor": vendor,
//         "entityId": entityId,
//         "accessToken": accessToken,
//         "kycStatus": kycStatus,
//         "kycDocuments": kycDocuments?.toJson(),
//       };
// }

// class AddressInfo {
//   AddressInfo({
//     required this.addressLine1,
//     required this.addressLine2,
//     required this.city,
//     required this.country,
//     required this.state,
//     required this.postalCode,
//   });

//   final String addressLine1;
//   final String addressLine2;
//   final String city;
//   final String country;
//   final String state;
//   final String postalCode;

//   factory AddressInfo.fromJson(Map<String, dynamic> json) {
//     return AddressInfo(
//       addressLine1: json["addressLine1"] ?? "",
//       addressLine2: json["addressLine2"] ?? "",
//       city: json["city"] ?? "",
//       country: json["country"] ?? "",
//       state: json["state"] ?? "",
//       postalCode: json["postalCode"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "addressLine1": addressLine1,
//         "addressLine2": addressLine2,
//         "city": city,
//         "country": country,
//         "state": state,
//         "postalCode": postalCode,
//       };
// }

// class KycDocumentsPanAndGst {
//   KycDocumentsPanAndGst({
//     required this.panProof,
//     this.gstProof,
//   });

//   final PanProofClassOrg? panProof;
//   final GstProofClassOrg? gstProof;

//   factory KycDocumentsPanAndGst.fromJson(Map<String, dynamic> json) {
//     return KycDocumentsPanAndGst(
//       panProof: json["PAN_PROOF"] == null ? null : PanProofClassOrg.fromJson(json["PAN_PROOF"]),
//       gstProof: json["GSTIN_PROOF"] == null ? null : GstProofClassOrg.fromJson(json["GSTIN_PROOF"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "PAN_PROOF": panProof?.toJson(),
//         "GSTIN_PROOF": gstProof?.toJson(),
//       };
// }

// class PanProofClassOrg {
//   PanProofClassOrg({
//     required this.url,
//     required this.docUploadStatus,
//   });

//   final String url;
//   final String docUploadStatus;

//   factory PanProofClassOrg.fromJson(Map<String, dynamic> json) {
//     return PanProofClassOrg(
//       url: json["url"] ?? "",
//       docUploadStatus: json["docUploadStatus"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "docUploadStatus": docUploadStatus,
//       };
// }

// class GstProofClassOrg {
//   GstProofClassOrg({
//     required this.url,
//     required this.docUploadStatus,
//   });

//   final String url;
//   final String docUploadStatus;

//   factory GstProofClassOrg.fromJson(Map<String, dynamic> json) {
//     return GstProofClassOrg(
//       url: json["url"] ?? "",
//       docUploadStatus: json["docUploadStatus"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "docUploadStatus": docUploadStatus,
//       };
// }

// // class TagPartnerOrganization {
// //   TagPartnerOrganization({
// //     required this.id,
// //     required this.cashBackPercentage,
// //   });

// //   String id;
// //   double cashBackPercentage;

// //   factory TagPartnerOrganization.fromJson(Map<String, dynamic> json) =>
// //       TagPartnerOrganization(
// //         id: json["id"] ?? "",
// //         cashBackPercentage: json["cashBackPercentage"] != null
// //             ? double.parse(json["cashBackPercentage"].toString())
// //             : 0.0,
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "cashBackPercentage": cashBackPercentage,
// //       };
// // }
