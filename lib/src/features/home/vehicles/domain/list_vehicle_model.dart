// import 'dart:convert';

// import 'package:flutter/material.dart';

// class ListVehiclesModel {
//   ListVehiclesModel({
//     this.data,
//   });

//   final Data? data;

//   const ListVehiclesModel.unknown() : data = null;

//   Map<String, dynamic> toMap() {
//     return {
//       'data': data?.toMap(),
//     };
//   }

//   factory ListVehiclesModel.fromMap(Map<String, dynamic> map) {
//     return ListVehiclesModel(
//       data: map['data'] != null ? Data.fromMap(map['data']) : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ListVehiclesModel.fromJson(Map<String, dynamic> source) {
//     return ListVehiclesModel.fromMap(source);
//   }
// }

// class Data {
//   Data({
//     required this.message,
//   });

//   final Message message;

//   Map<String, dynamic> toMap() {
//     return {
//       'message': message.toMap(),
//     };
//   }

//   factory Data.fromMap(Map<String, dynamic> map) {
//     return Data(
//       message: Message.fromMap(map['message']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Data.fromJson(Map<String, dynamic> source) => Data.fromMap(source);
// }

// class Message {
//   Message({
//     required this.docs,
//     required this.count,
//   });

//   final List<VehicleDoc> docs;
//   final int count;

//   Map<String, dynamic> toMap() {
//     return {
//       'docs': docs.map((x) => x.toMap()).toList(),
//       'count': count,
//     };
//   }

//   factory Message.fromMap(Map<String, dynamic> map) {
//     return Message(
//       docs:
//           List<VehicleDoc>.from(map['docs']?.map((x) => VehicleDoc.fromMap(x))),
//       count: map['count'] ?? 0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Message.fromJson(Map<String, dynamic> source) =>
//       Message.fromMap(source);
// }

// class VehicleDoc {
//   final String id;
//   final String enrollmentId;
//   final String entityId;
//   final String organizationId;
//   final String organizationEnrollmentId;
//   final String organizationEntityId;
//   final String status;
//   final AccountInformation? accountInformation;
//   final String contactNumber;
//   final String registrationNumber;
//   final String registrationDate;
//   final String engineNumber;
//   final String chasisNumber;
//   final String fuelType;
//   final String insuranceExpiryDate;
//   final String fitnessUpto;
//   final String vehicleCategory;
//   final String createdBy;
//   final String updatedBy;
//   final String createdByOrg;
//   final String updatedByOrg;
//   final String createdAt;
//   final String updatedAt;
//   final int v;
//   final VehicleDocServices? services;
//   final OrganizationDetails? organizationDetails;
//   VehicleDoc({
//     required this.id,
//     required this.enrollmentId,
//     required this.entityId,
//     required this.organizationId,
//     required this.organizationEnrollmentId,
//     required this.organizationEntityId,
//     required this.status,
//     required this.accountInformation,
//     required this.contactNumber,
//     required this.registrationNumber,
//     required this.registrationDate,
//     required this.engineNumber,
//     required this.chasisNumber,
//     required this.fuelType,
//     required this.insuranceExpiryDate,
//     required this.fitnessUpto,
//     required this.vehicleCategory,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdByOrg,
//     required this.updatedByOrg,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.services,
//     required this.organizationDetails,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'enrollmentId': enrollmentId,
//       'entityId': entityId,
//       'organizationId': organizationId,
//       'organizationEnrollmentId': organizationEnrollmentId,
//       'organizationEntityId': organizationEntityId,
//       'status': status,
//       'accountInformation': accountInformation,
//       'contactNumber': contactNumber,
//       'registrationNumber': registrationNumber,
//       'registrationDate': registrationDate,
//       'engineNumber': engineNumber,
//       'chasisNumber': chasisNumber,
//       'fuelType': fuelType,
//       'insuranceExpiryDate': insuranceExpiryDate,
//       'fitnessUpto': fitnessUpto,
//       'vehicleCategory': vehicleCategory,
//       'createdBy': createdBy,
//       'updatedBy': updatedBy,
//       'createdByOrg': createdByOrg,
//       'updatedByOrg': updatedByOrg,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'v': v,
//       "services": services,
//       'organizationDetails': organizationDetails?.toMap(),
//     };
//   }

//   factory VehicleDoc.fromMap(Map<String, dynamic> map) {
//     return VehicleDoc(
//       id: map['_id'] ?? '',
//       enrollmentId: map['enrollmentId'] ?? '',
//       entityId: map['entityId'] ?? '',
//       organizationId: map['organizationId'] ?? '',
//       organizationEnrollmentId: map['organizationEnrollmentId'] ?? '',
//       organizationEntityId: map['organizationEntityId'] ?? '',
//       status: map['status'] ?? '',
//       accountInformation: map['accountInformation'] == null
//           ? null
//           : AccountInformation.fromJson(map['accountInformation']),
//       contactNumber: map['contactNumber'] ?? '',
//       registrationNumber: map['registrationNumber'] ?? '',
//       registrationDate: map['registrationDate'] ?? '',
//       engineNumber: map['engineNumber'] ?? '',
//       chasisNumber: map['chasisNumber'] ?? '',
//       fuelType: map['fuelType'] ?? '',
//       insuranceExpiryDate: map['insuranceExpiryDate'] ?? '',
//       fitnessUpto: map['fitnessUpto'] ?? '',
//       vehicleCategory: map['vehicleCategory'] ?? '',
//       createdBy: map['createdBy'] ?? '',
//       updatedBy: map['updatedBy'] ?? '',
//       createdByOrg: map['createdByOrg'] ?? '',
//       updatedByOrg: map['updatedByOrg'] ?? '',
//       createdAt: map['createdAt'] ?? '',
//       updatedAt: map['updatedAt'] ?? '',
//       v: 0,
//       services: map['services'] == null
//           ? null
//           : VehicleDocServices.fromJson(map["services"]),
//       organizationDetails: map['organizationDetails'] == null
//           ? null
//           : OrganizationDetails.fromMap(map['organizationDetails']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory VehicleDoc.fromJson(Map<String, dynamic> source) =>
//       VehicleDoc.fromMap(source);
// }

// class OrganizationDetails {
//   OrganizationDetails({
//     this.services,
//     required this.firstName,
//     required this.lastName,
//   });

//   final VehicleOrgServices? services;
//   final String firstName;
//   final String lastName;

//   Map<String, dynamic> toMap() {
//     return {
//       'services': services?.toMap(),
//       'firstName': firstName,
//       'lastName': lastName,
//     };
//   }

//   factory OrganizationDetails.fromMap(Map<String, dynamic> map) {
//     return OrganizationDetails(
//       services: map['services'] != null
//           ? VehicleOrgServices.fromMap(map['services'])
//           : null,
//       firstName: map['firstName'] ?? '',
//       lastName: map['lastName'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory OrganizationDetails.fromJson(Map<String, dynamic> source) =>
//       OrganizationDetails.fromMap(source);
// }

// class VehicleOrgServices {
//   VehicleOrgServices({
//     this.gps,
//     this.tag,
//   });

//   final Gps? gps;
//   final Tag? tag;

//   Map<String, dynamic> toMap() {
//     return {
//       'gps': gps?.toMap(),
//     };
//   }

//   factory VehicleOrgServices.fromMap(Map<String, dynamic> map) {
//     return VehicleOrgServices(
//       gps: map['gps'] != null ? Gps.fromMap(map['gps']) : null,
//       tag: map['tag'] != null ? Tag.fromMap(map['tag']) : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory VehicleOrgServices.fromJson(Map<String, dynamic> source) =>
//       VehicleOrgServices.fromMap(source);
// }

// class Gps {
//   final List<String> partnerOrganizationId;
//   final List<String> issuerName;
//   Gps({
//     required this.partnerOrganizationId,
//     required this.issuerName,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'partnerOrganizationId': partnerOrganizationId,
//       'issuerName': issuerName,
//     };
//   }

//   factory Gps.fromMap(Map<String, dynamic> map) {
//     return Gps(
//       partnerOrganizationId: map['partnerOrganizationId'] != null
//           ? List<String>.from(map['partnerOrganizationId'])
//           : [],
//       issuerName:
//           map['issuerName'] != null ? List<String>.from(map['issuerName']) : [],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Gps.fromJson(Map<String, dynamic> source) => Gps.fromMap(source);
// }

// class Tag {
//   Tag({
//     required this.issuer,
//     required this.partnerOrganization,
//   });

//   final List<Issuer> issuer;
//   final List<PartnerOrganization> partnerOrganization;

//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'issuer': issuer.map((x) => x.toMap()).toList(),
//   //     'partnerOrganization': partnerOrganization.map((x) => x.toMap()).toList(),
//   //   };
//   // }

//   factory Tag.fromMap(Map<String, dynamic> map) {
//     return Tag(
//       issuer: map['issuer'] != null
//           ? List<Issuer>.from(map['issuer']?.map((x) => Issuer.fromMap(x)))
//           : [],
//       partnerOrganization: map['partnerOrganization'] != null
//           ? List<PartnerOrganization>.from(map['partnerOrganization']
//               ?.map((x) => PartnerOrganization.fromMap(x)))
//           : [],
//     );
//   }

//   // String toJson() => json.encode(toMap());

//   factory Tag.fromJson(Map<String, dynamic> source) => Tag.fromMap(source);
// }

// class Issuer {
//   final String name;
//   final String kycStatus;
//   final VehicleKycDocuments kycDocuments;
//   final String kycType;

//   Issuer({
//     required this.name,
//     required this.kycStatus,
//     required this.kycDocuments,
//     required this.kycType,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'kycStatus': kycStatus,
//       'kycDocuments': kycDocuments.toJson(),
//       'kycType': kycType,
//     };
//   }

//   factory Issuer.fromMap(Map<String, dynamic> map) {
//     return Issuer(
//       name: map['name'] ?? '',
//       kycStatus: map['kycStatus'] ?? '',
//       kycDocuments: VehicleKycDocuments.fromJson(map['kycDocuments']),
//       kycType: map['kycType'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Issuer.fromJson(Map<String, dynamic> source) =>
//       Issuer.fromMap(source);
// }

// class VehicleKycDocuments {
//   VehicleKycDocuments({
//     required this.identityProof,
//     required this.addressProof,
//   });

//   final Proof identityProof;
//   final Proof addressProof;

//   factory VehicleKycDocuments.fromJson(Map<String, dynamic> json) =>
//       VehicleKycDocuments(
//         identityProof: Proof.fromJson(json["IDENTITY_PROOF"]),
//         addressProof: Proof.fromJson(json["ADDRESS_PROOF"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "IDENTITY_PROOF": identityProof.toJson(),
//         "ADDRESS_PROOF": addressProof.toJson(),
//       };
// }

// class Proof {
//   Proof({
//     required this.url,
//     required this.docUploadStatus,
//   });

//   final String url;
//   final String docUploadStatus;

//   Map<String, dynamic> toMap() {
//     return {
//       'url': url,
//       'docUploadStatus': docUploadStatus,
//     };
//   }

//   factory Proof.fromMap(Map<String, dynamic> map) {
//     return Proof(
//       url: map['url'] ?? '',
//       docUploadStatus: map['docUploadStatus'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Proof.fromJson(Map<String, dynamic> source) => Proof.fromMap(source);
// }

// class PartnerOrganization {
//   final String id;
//   final double cashBackPercentage;

//   PartnerOrganization({
//     required this.id,
//     required this.cashBackPercentage,
//   });

//   factory PartnerOrganization.fromMap(Map<String, dynamic> map) {
//     return PartnerOrganization(
//         id: map['_id'] ?? '',
//         cashBackPercentage: map['cashBackPercentage'] != null
//             ? double.parse(map['cashBackPercentage'].toString())
//             : 0.0);
//   }

//   factory PartnerOrganization.fromJson(Map<String, dynamic> source) =>
//       PartnerOrganization.fromMap(source);
// }

// class AccountInformation {
//   AccountInformation({
//     required this.id,
//     required this.accountInformationId,
//     required this.entityId,
//     required this.type,
//     required this.status,
//     required this.accountNumber,
//     required this.ifsc,
//     required this.upiId,
//     required this.thresholdLimit,
//     required this.availableBalance,
//     required this.organizationId,
//     required this.partnerOrganizationId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   final String id;
//   final String accountInformationId;
//   final String entityId;
//   final String type;
//   final String status;
//   final String accountNumber;
//   final String ifsc;
//   final String upiId;
//   final int thresholdLimit;
//   final int availableBalance;
//   final String organizationId;
//   final String partnerOrganizationId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int v;

//   factory AccountInformation.fromJson(Map<String, dynamic> json) =>
//       AccountInformation(
//         id: json["_id"] ?? "",
//         accountInformationId: json["id"] ?? '',
//         entityId: json["entityId"] ?? '',
//         type: json["type"] ?? '',
//         status: json["status"] ?? '',
//         accountNumber: json["accountNumber"] ?? '',
//         ifsc: json["IFSC"] ?? '',
//         upiId: json["upiId"] ?? '',
//         thresholdLimit: json["thresholdLimit"] ?? 0,
//         availableBalance: json["availableBalance"] ?? '',
//         organizationId: json["organizationId"] ?? '',
//         partnerOrganizationId: json["partnerOrganizationId"] ?? '',
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "id": accountInformationId,
//         "entityId": entityId,
//         "type": type,
//         "status": status,
//         "accountNumber": accountNumber,
//         "IFSC": ifsc,
//         "upiId": upiId,
//         "thresholdLimit": thresholdLimit,
//         "availableBalance": availableBalance,
//         "organizationId": organizationId,
//         "partnerOrganizationId": partnerOrganizationId,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class VehicleDocServices {
//   VehicleDocServices({
//     required this.gps,
//     required this.tag,
//   });

//   final Gps? gps;
//   final List<VehicleTag> tag;

//   factory VehicleDocServices.fromJson(Map<String, dynamic> json) {
//     return VehicleDocServices(
//       gps: json["gps"] == null ? null : Gps.fromJson(json["gps"]),
//       tag: json["tag"] == null
//           ? []
//           : List<VehicleTag>.from(
//               json["tag"]!.map((x) => VehicleTag.fromJson(x))),
//     );
//   }
// }

// class VehicleGps {
//   VehicleGps({
//     required this.imei,
//     required this.kycDocuments,
//     required this.status,
//   });

//   final String imei;
//   final GpsKycDocuments? kycDocuments;
//   final String status;

//   factory VehicleGps.fromJson(Map<String, dynamic> json) {
//     return VehicleGps(
//       imei: json["imei"] ?? "",
//       kycDocuments: json["kycDocuments"] == null
//           ? null
//           : GpsKycDocuments.fromJson(json["kycDocuments"]),
//       status: json["status"] ?? "",
//     );
//   }
// }

// class GpsKycDocuments {
//   GpsKycDocuments({
//     required this.rcBookImage,
//     required this.otherProof1,
//   });

//   final OtherProof1? rcBookImage;
//   final OtherProof1? otherProof1;

//   factory GpsKycDocuments.fromJson(Map<String, dynamic> json) {
//     return GpsKycDocuments(
//       rcBookImage: json["RC_BOOK_IMAGE"] == null
//           ? null
//           : OtherProof1.fromJson(json["RC_BOOK_IMAGE"]),
//       otherProof1: json["OTHER_PROOF1"] == null
//           ? null
//           : OtherProof1.fromJson(json["OTHER_PROOF1"]),
//     );
//   }
// }

// class OtherProof1 {
//   OtherProof1({
//     required this.documentNo,
//     required this.documentExpiry,
//     required this.url,
//     required this.docUploadStatus,
//   });

//   final String documentNo;
//   final DateTime? documentExpiry;
//   final String url;
//   final String docUploadStatus;

//   factory OtherProof1.fromJson(Map<String, dynamic> json) {
//     return OtherProof1(
//       documentNo: json["documentNo"] ?? "",
//       documentExpiry: json["documentExpiry"] == null
//           ? null
//           : DateTime.parse(json["documentExpiry"]),
//       url: json["url"] ?? "",
//       docUploadStatus: json["docUploadStatus"] ?? "",
//     );
//   }
// }

// class VehicleTag {
//   VehicleTag({
//     required this.partnerOrganizationId,
//     required this.partnerEnrollmentId,
//     required this.kycStatus,
//     required this.balanceType,
//     required this.kycDocuments,
//     required this.kycType,
//     required this.status,
//     required this.regTruckException,
//   });

//   final String partnerOrganizationId;
//   final String partnerEnrollmentId;
//   final String kycStatus;
//   final String balanceType;
//   final TagKycDocuments? kycDocuments;
//   final String kycType;
//   final String status;
//   final RegTruckException? regTruckException;

//   factory VehicleTag.fromJson(Map<String, dynamic> json) {
//     return VehicleTag(
//       partnerOrganizationId: json["partnerOrganizationId"] ?? "",
//       partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
//       kycStatus: json["kycStatus"] ?? "",
//       balanceType: json["balanceType"] ?? "",
//       kycDocuments: json["kycDocuments"] == null
//           ? null
//           : TagKycDocuments.fromJson(json["kycDocuments"]),
//       kycType: json["kycType"] ?? "",
//       status: json["status"] ?? "",
//       regTruckException: json["regTruckException"] == null
//           ? null
//           : RegTruckException.fromJson(json["regTruckException"]),
//     );
//   }
// }

// class TagKycDocuments {
//   TagKycDocuments({
//     required this.rcBookImage,
//     required this.identityProof,
//     required this.addressProof,
//   });

//   final AddressProof? rcBookImage;
//   final AddressProof? identityProof;
//   final AddressProof? addressProof;

//   factory TagKycDocuments.fromJson(Map<String, dynamic> json) {
//     return TagKycDocuments(
//       rcBookImage: json["RC_BOOK_IMAGE"] == null
//           ? null
//           : AddressProof.fromJson(json["RC_BOOK_IMAGE"]),
//       identityProof: json["IDENTITY_PROOF"] == null
//           ? null
//           : AddressProof.fromJson(json["IDENTITY_PROOF"]),
//       addressProof: json["ADDRESS_PROOF"] == null
//           ? null
//           : AddressProof.fromJson(json["ADDRESS_PROOF"]),
//     );
//   }
// }

// class AddressProof {
//   AddressProof({
//     required this.url,
//     required this.docUploadStatus,
//   });

//   final String url;
//   final String docUploadStatus;

//   factory AddressProof.fromJson(Map<String, dynamic> json) {
//     return AddressProof(
//       url: json["url"] ?? "",
//       docUploadStatus: json["docUploadStatus"] ?? "",
//     );
//   }
// }

// class RegTruckException {
//   RegTruckException({
//     required this.detailMessage,
//     required this.cause,
//     required this.shortMessage,
//     required this.languageCode,
//     required this.errorCode,
//     required this.fieldErrors,
//     required this.message,
//     required this.localizedMessage,
//     required this.suppressed,
//   });

//   final String detailMessage;
//   final dynamic cause;
//   final String shortMessage;
//   final String languageCode;
//   final String errorCode;
//   final dynamic fieldErrors;
//   final dynamic message;
//   final dynamic localizedMessage;
//   final List<dynamic> suppressed;

//   factory RegTruckException.fromJson(Map<String, dynamic> json) {
//     return RegTruckException(
//       detailMessage: json["detailMessage"] ?? "",
//       cause: json["cause"],
//       shortMessage: json["shortMessage"] ?? "",
//       languageCode: json["languageCode"] ?? "",
//       errorCode: json["errorCode"] ?? "",
//       fieldErrors: json["fieldErrors"],
//       message: json["message"],
//       localizedMessage: json["localizedMessage"],
//       suppressed: json["suppressed"] == null
//           ? []
//           : List<dynamic>.from(json["suppressed"]!.map((x) => x)),
//     );
//   }
// }
