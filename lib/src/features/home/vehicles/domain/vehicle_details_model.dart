// class VehicleDetailsModel {
//   VehicleDetailsModel({
//     this.data,
//   });

//   Data? data;

//   factory VehicleDetailsModel.fromJson(Map<String, dynamic> json) => VehicleDetailsModel(
//         data: Data.fromJson(json["data"]),
//       );
//   VehicleDetailsModel.unknown() : data = null;

//   Map<String, dynamic> toJson() => {
//         "data": data!.toJson(),
//       };
// }

// class Data {
//   Data({
//     required this.message,
//   });

//   Vehicle? message;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         message: json["message"] == null ? null : Vehicle.fromJson(json["message"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message?.toJson(),
//       };
// }

// class Vehicle {
//   Vehicle({
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
//     required this.vehicleType,
//     required this.vehicleCategory,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdByOrg,
//     required this.updatedByOrg,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.vehicleImage,
//     required this.services,
//   });

//   final String id;
//   final String enrollmentId;
//   final String entityId;
//   final String organizationId;
//   final String organizationEnrollmentId;
//   final String organizationEntityId;
//   final String status;
//   final List<String> accountInformation;
//   final String contactNumber;
//   final String registrationNumber;
//   final DateTime? registrationDate;
//   final String engineNumber;
//   final String chasisNumber;
//   final String fuelType;
//   final DateTime? insuranceExpiryDate;
//   final DateTime? fitnessUpto;
//   final VehicleType? vehicleType;
//   final String vehicleCategory;
//   final String createdBy;
//   final String updatedBy;
//   final String createdByOrg;
//   final String updatedByOrg;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int v;
//   final VehicleImage? vehicleImage;
//   final Services? services;

//   factory Vehicle.fromJson(Map<String, dynamic> json) {
//     return Vehicle(
//       id: json["_id"] ?? "",
//       enrollmentId: json["enrollmentId"] ?? "",
//       entityId: json["entityId"] ?? "",
//       organizationId: json["organizationId"] ?? "",
//       organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
//       organizationEntityId: json["organizationEntityId"] ?? "",
//       status: json["status"] ?? "",
//       accountInformation:
//           json["accountInformation"] == null ? [] : List<String>.from(json["accountInformation"]!.map((x) => x)),
//       contactNumber: json["contactNumber"] ?? "",
//       registrationNumber: json["registrationNumber"] ?? "",
//       registrationDate: json["registrationDate"] == null ? null : DateTime.parse(json["registrationDate"]),
//       engineNumber: json["engineNumber"] ?? "",
//       chasisNumber: json["chasisNumber"] ?? "",
//       fuelType: json["fuelType"] ?? "",
//       insuranceExpiryDate: json["insuranceExpiryDate"] == null ? null : DateTime.parse(json["insuranceExpiryDate"]),
//       fitnessUpto: json["fitnessUpto"] == null ? null : DateTime.parse(json["fitnessUpto"]),
//       vehicleType: json["vehicleType"] == null ? null : VehicleType.fromJson(json["vehicleType"]),
//       vehicleCategory: json["vehicleCategory"] ?? "",
//       createdBy: json["createdBy"] ?? "",
//       updatedBy: json["updatedBy"] ?? "",
//       createdByOrg: json["createdByOrg"] ?? "",
//       updatedByOrg: json["updatedByOrg"] ?? "",
//       createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//       updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//       v: json["__v"] ?? 0,
//       vehicleImage: json["vehicleImage"] == null ? null : VehicleImage.fromJson(json["vehicleImage"]),
//       services: json["services"] == null ? null : Services.fromJson(json["services"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "enrollmentId": enrollmentId,
//         "entityId": entityId,
//         "organizationId": organizationId,
//         "organizationEnrollmentId": organizationEnrollmentId,
//         "organizationEntityId": organizationEntityId,
//         "status": status,
//         "accountInformation": accountInformation.map((x) => x).toList(),
//         "contactNumber": contactNumber,
//         "registrationNumber": registrationNumber,
//         "registrationDate": registrationDate?.toIso8601String(),
//         "engineNumber": engineNumber,
//         "chasisNumber": chasisNumber,
//         "fuelType": fuelType,
//         "insuranceExpiryDate": insuranceExpiryDate?.toIso8601String(),
//         "fitnessUpto": fitnessUpto?.toIso8601String(),
//         "vehicleType": vehicleType?.toJson(),
//         "vehicleCategory": vehicleCategory,
//         "createdBy": createdBy,
//         "updatedBy": updatedBy,
//         "createdByOrg": createdByOrg,
//         "updatedByOrg": updatedByOrg,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//         "vehicleImage": vehicleImage?.toJson(),
//         "services": services?.toJson(),
//       };
// }

// class Services {
//   Services({
//     required this.fuel,
//     required this.gps,
//     required this.tag,
//   });

//   final List<dynamic> fuel;
//   final Gps? gps;
//   final List<Tag> tag;

//   factory Services.fromJson(Map<String, dynamic> json) {
//     return Services(
//       fuel: json["fuel"] == null ? [] : List<dynamic>.from(json["fuel"]!.map((x) => x)),
//       gps: json["gps"] == null ? null : Gps.fromJson(json["gps"]),
//       tag: json["tag"] == null ? [] : List<Tag>.from(json["tag"]!.map((x) => Tag.fromJson(x))),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "fuel": fuel.map((x) => x).toList(),
//         "gps": gps?.toJson(),
//         "tag": tag.map((x) => x.toJson()).toList(),
//       };
// }

// class Gps {
//   Gps({
//     required this.imei,
//     required this.kycDocuments,
//     required this.status,
//   });

//   final String imei;
//   final GpsKycDocuments? kycDocuments;
//   final String status;

//   factory Gps.fromJson(Map<String, dynamic> json) {
//     return Gps(
//       imei: json["imei"] ?? "",
//       kycDocuments: json["kycDocuments"] == null ? null : GpsKycDocuments.fromJson(json["kycDocuments"]),
//       status: json["status"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "imei": imei,
//         "kycDocuments": kycDocuments?.toJson(),
//         "status": status,
//       };
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
//       rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : OtherProof1.fromJson(json["RC_BOOK_IMAGE"]),
//       otherProof1: json["OTHER_PROOF1"] == null ? null : OtherProof1.fromJson(json["OTHER_PROOF1"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "RC_BOOK_IMAGE": rcBookImage?.toJson(),
//         "OTHER_PROOF1": otherProof1?.toJson(),
//       };
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
//       documentExpiry: json["documentExpiry"] == null ? null : DateTime.parse(json["documentExpiry"]),
//       url: json["url"] ?? "",
//       docUploadStatus: json["docUploadStatus"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "documentNo": documentNo,
//         "documentExpiry": documentExpiry?.toIso8601String(),
//         "url": url,
//         "docUploadStatus": docUploadStatus,
//       };
// }

// class Tag {
//   Tag({
//     required this.serialNumber,
//     required this.kitNumber,
//     required this.vehicleClass,
//     required this.partnerOrganizationId,
//     required this.partnerEnrollmentId,
//     required this.kycStatus,
//     required this.balanceType,
//     required this.kycDocuments,
//     required this.kycType,
//     required this.status,
//     // required this.uploadKycException,
//     // required this.regTruckException,
//   });

//   final String serialNumber;
//   final String kitNumber;
//   final VehicleClass? vehicleClass;
//   final String partnerOrganizationId;
//   final String partnerEnrollmentId;
//   final String kycStatus;
//   final String balanceType;
//   final TagKycDocuments? kycDocuments;
//   final String kycType;
//   final String status;
//   // final String uploadKycException;
//   // final String regTruckException;

//   factory Tag.fromJson(Map<String, dynamic> json) {
//     return Tag(
//       serialNumber: json["serialNumber"] ?? "",
//       kitNumber: json["kitNumber"] ?? "",
//       vehicleClass: json["vehicleClass"] == null ? null : VehicleClass.fromJson(json["vehicleClass"]),
//       partnerOrganizationId: json["partnerOrganizationId"] ?? "",
//       partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
//       kycStatus: json["kycStatus"] ?? "",
//       balanceType: json["balanceType"] ?? "",
//       kycDocuments: json["kycDocuments"] == null ? null : TagKycDocuments.fromJson(json["kycDocuments"]),
//       kycType: json["kycType"] ?? "",
//       status: json["status"] ?? "",
//       // uploadKycException: json["uploadKycException"] ?? "",
//       // regTruckException: json["regTruckException"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "serialNumber": serialNumber,
//         "kitNumber": kitNumber,
//         "vehicleClass": vehicleClass?.toJson(),
//         "partnerOrganizationId": partnerOrganizationId,
//         "partnerEnrollmentId": partnerEnrollmentId,
//         "kycStatus": kycStatus,
//         "balanceType": balanceType,
//         "kycDocuments": kycDocuments?.toJson(),
//         "kycType": kycType,
//         "status": status,
//         // "uploadKycException": uploadKycException,
//         // "regTruckException": regTruckException,
//       };
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
//       rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : AddressProof.fromJson(json["RC_BOOK_IMAGE"]),
//       identityProof: json["IDENTITY_PROOF"] == null ? null : AddressProof.fromJson(json["IDENTITY_PROOF"]),
//       addressProof: json["ADDRESS_PROOF"] == null ? null : AddressProof.fromJson(json["ADDRESS_PROOF"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "RC_BOOK_IMAGE": rcBookImage?.toJson(),
//         "IDENTITY_PROOF": identityProof?.toJson(),
//         "ADDRESS_PROOF": addressProof?.toJson(),
//       };
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

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "docUploadStatus": docUploadStatus,
//       };
// }

// class VehicleClass {
//   VehicleClass({
//     required this.tagClass,
//     required this.axleCount,
//     required this.mapperClass,
//   });

//   final String tagClass;
//   final int axleCount;
//   final String mapperClass;

//   factory VehicleClass.fromJson(Map<String, dynamic> json) {
//     return VehicleClass(
//       tagClass: json["tagClass"] ?? "",
//       axleCount: json["axleCount"] ?? 0,
//       mapperClass: json["mapperClass"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "tagClass": tagClass,
//         "axleCount": axleCount,
//         "mapperClass": mapperClass,
//       };
// }

// class VehicleImage {
//   VehicleImage({
//     required this.frontView,
//     required this.sideView,
//   });

//   final View? frontView;
//   final View? sideView;

//   factory VehicleImage.fromJson(Map<String, dynamic> json) {
//     return VehicleImage(
//       frontView: json["FRONT_VIEW"] == null ? null : View.fromJson(json["FRONT_VIEW"]),
//       sideView: json["SIDE_VIEW"] == null ? null : View.fromJson(json["SIDE_VIEW"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "FRONT_VIEW": frontView?.toJson(),
//         "SIDE_VIEW": sideView?.toJson(),
//       };
// }

// class View {
//   View({
//     required this.url,
//   });

//   final String url;

//   factory View.fromJson(Map<String, dynamic> json) {
//     return View(
//       url: json["url"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "url": url,
//       };
// }

// class VehicleType {
//   VehicleType({
//     required this.maker,
//     required this.emissionNorm,
//     required this.financierName,
//     required this.isCommercial,
//   });

//   final String maker;
//   final String emissionNorm;
//   final String financierName;
//   final String isCommercial;

//   factory VehicleType.fromJson(Map<String, dynamic> json) {
//     return VehicleType(
//       maker: json["maker"] ?? "",
//       emissionNorm: json["emissionNorm"] ?? "",
//       financierName: json["financierName"] ?? "",
//       isCommercial: json["isCommercial"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "maker": maker,
//         "emissionNorm": emissionNorm,
//         "financierName": financierName,
//         "isCommercial": isCommercial,
//       };
// }


// // class Vehicle {
// //   Vehicle({
// //     required this.id,
// //     required this.enrollmentId,
// //     required this.organizationId,
// //     required this.organizationEnrollmentId,
// //     required this.organizationEntityId,
// //     required this.status,
// //     required this.accountInformation,
// //     required this.registrationNumber,
// //     required this.registrationDate,
// //     required this.engineNumber,
// //     required this.chasisNumber,
// //     required this.fuelType,
// //     required this.insuranceExpiryDate,
// //     required this.fitnessUpto,
// //     required this.vehicleType,
// //     required this.vehicleCategory,
// //     required this.createdBy,
// //     required this.updatedBy,
// //     required this.createdByOrg,
// //     required this.updatedByOrg,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.v,
// //     required this.services,
// //     required this.contactNumber,
// //     required this.entityId,
// //   });

// //   final String id;
// //   final String enrollmentId;
// //   final String organizationId;
// //   final String organizationEnrollmentId;
// //   final String organizationEntityId;
// //   final String status;
// //   final List<String> accountInformation;
// //   final String registrationNumber;
// //   final DateTime? registrationDate;
// //   final String engineNumber;
// //   final String chasisNumber;
// //   final String fuelType;
// //   final DateTime? insuranceExpiryDate;
// //   final DateTime? fitnessUpto;
// //   final VehicleType? vehicleType;
// //   final String vehicleCategory;
// //   final String createdBy;
// //   final String updatedBy;
// //   final String createdByOrg;
// //   final String updatedByOrg;
// //   final DateTime? createdAt;
// //   final DateTime? updatedAt;
// //   final int v;
// //   final Services? services;
// //   final String contactNumber;
// //   final String entityId;

// //   factory Vehicle.fromJson(Map<String, dynamic> json) {
// //     return Vehicle(
// //       id: json["_id"] ?? "",
// //       enrollmentId: json["enrollmentId"] ?? "",
// //       organizationId: json["organizationId"] ?? "",
// //       organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
// //       organizationEntityId: json["organizationEntityId"] ?? "",
// //       status: json["status"] ?? "",
// //       accountInformation:
// //           json["accountInformation"] == null ? [] : List<String>.from(json["accountInformation"]!.map((x) => x)),
// //       registrationNumber: json["registrationNumber"] ?? "",
// //       registrationDate: json["registrationDate"] == null ? null : DateTime.parse(json["registrationDate"]),
// //       engineNumber: json["engineNumber"] ?? "",
// //       chasisNumber: json["chasisNumber"] ?? "",
// //       fuelType: json["fuelType"] ?? "",
// //       insuranceExpiryDate: json["insuranceExpiryDate"] == null ? null : DateTime.parse(json["insuranceExpiryDate"]),
// //       fitnessUpto: json["fitnessUpto"] == null ? null : DateTime.parse(json["fitnessUpto"]),
// //       vehicleType: json["vehicleType"] == null ? null : VehicleType.fromJson(json["vehicleType"]),
// //       vehicleCategory: json["vehicleCategory"] ?? "",
// //       createdBy: json["createdBy"] ?? "",
// //       updatedBy: json["updatedBy"] ?? "",
// //       createdByOrg: json["createdByOrg"] ?? "",
// //       updatedByOrg: json["updatedByOrg"] ?? "",
// //       createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
// //       updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
// //       v: json["__v"] ?? 0,
// //       services: json["services"] == null ? null : Services.fromJson(json["services"]),
// //       contactNumber: json["contactNumber"] ?? "",
// //       entityId: json["entityId"] ?? "",
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "_id": id,
// //         "enrollmentId": enrollmentId,
// //         "organizationId": organizationId,
// //         "organizationEnrollmentId": organizationEnrollmentId,
// //         "organizationEntityId": organizationEntityId,
// //         "status": status,
// //         "accountInformation": accountInformation.map((x) => x).toList(),
// //         "registrationNumber": registrationNumber,
// //         "registrationDate": registrationDate?.toIso8601String(),
// //         "engineNumber": engineNumber,
// //         "chasisNumber": chasisNumber,
// //         "fuelType": fuelType,
// //         "insuranceExpiryDate": insuranceExpiryDate?.toIso8601String(),
// //         "fitnessUpto": fitnessUpto?.toIso8601String(),
// //         "vehicleType": vehicleType?.toJson(),
// //         "vehicleCategory": vehicleCategory,
// //         "createdBy": createdBy,
// //         "updatedBy": updatedBy,
// //         "createdByOrg": createdByOrg,
// //         "updatedByOrg": updatedByOrg,
// //         "createdAt": createdAt?.toIso8601String(),
// //         "updatedAt": updatedAt?.toIso8601String(),
// //         "__v": v,
// //         "services": services?.toJson(),
// //         "contactNumber": contactNumber,
// //         "entityId": entityId,
// //       };
// // }

// // class Services {
// //   Services({
// //     required this.fuel,
// //     required this.tag,
// //     required this.gps,
// //   });

// //   final List<dynamic> fuel;
// //   final List<Tag> tag;
// //   final Gps? gps;

// //   factory Services.fromJson(Map<String, dynamic> json) {
// //     return Services(
// //       fuel: json["fuel"] == null ? [] : List<dynamic>.from(json["fuel"]!.map((x) => x)),
// //       tag: json["tag"] == null ? [] : List<Tag>.from(json["tag"]!.map((x) => Tag.fromJson(x))),
// //       gps: json["gps"] == null ? null : Gps.fromJson(json["gps"]),
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "fuel": fuel.map((x) => x).toList(),
// //         "tag": tag.map((x) => x.toJson()).toList(),
// //         "gps": gps?.toJson(),
// //       };
// // }

// // class Gps {
// //   Gps({
// //     required this.imei,
// //     required this.kycDocuments,
// //     required this.status,
// //   });

// //   final String imei;
// //   final GpsKycDocuments? kycDocuments;
// //   final String status;

// //   factory Gps.fromJson(Map<String, dynamic> json) {
// //     return Gps(
// //       imei: json["imei"] ?? "",
// //       kycDocuments: json["kycDocuments"] == null ? null : GpsKycDocuments.fromJson(json["kycDocuments"]),
// //       status: json["status"] ?? "",
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "imei": imei,
// //         "kycDocuments": kycDocuments?.toJson(),
// //         "status": status,
// //       };
// // }

// // class GpsKycDocuments {
// //   GpsKycDocuments({
// //     required this.rcBookImage,
// //     required this.otherProof1,
// //   });

// //   final OtherProof1? rcBookImage;
// //   final OtherProof1? otherProof1;

// //   factory GpsKycDocuments.fromJson(Map<String, dynamic> json) {
// //     return GpsKycDocuments(
// //       rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : OtherProof1.fromJson(json["RC_BOOK_IMAGE"]),
// //       otherProof1: json["OTHER_PROOF1"] == null ? null : OtherProof1.fromJson(json["OTHER_PROOF1"]),
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "RC_BOOK_IMAGE": rcBookImage?.toJson(),
// //         "OTHER_PROOF1": otherProof1?.toJson(),
// //       };
// // }

// // class OtherProof1 {
// //   OtherProof1({
// //     required this.documentNo,
// //     required this.documentExpiry,
// //     required this.url,
// //     required this.docUploadStatus,
// //   });

// //   final String documentNo;
// //   final DateTime? documentExpiry;
// //   final String url;
// //   final String docUploadStatus;

// //   factory OtherProof1.fromJson(Map<String, dynamic> json) {
// //     return OtherProof1(
// //       documentNo: json["documentNo"] ?? "",
// //       documentExpiry: json["documentExpiry"] == null ? null : DateTime.parse(json["documentExpiry"]),
// //       url: json["url"] ?? "",
// //       docUploadStatus: json["docUploadStatus"] ?? "",
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "documentNo": documentNo,
// //         "documentExpiry": documentExpiry?.toIso8601String(),
// //         "url": url,
// //         "docUploadStatus": docUploadStatus,
// //       };
// // }

// // class Tag {
// //   Tag({
// //     required this.serialNumber,
// //     required this.kitNumber,
// //     required this.vehicleClass,
// //     required this.partnerOrganizationId,
// //     required this.partnerEnrollmentId,
// //     required this.kycStatus,
// //     required this.balanceType,
// //     required this.kycDocuments,
// //     required this.kycType,
// //     required this.status,
// //   });

// //   final String serialNumber;
// //   final String kitNumber;
// //   final VehicleClass? vehicleClass;
// //   final String partnerOrganizationId;
// //   final String partnerEnrollmentId;
// //   final String kycStatus;
// //   final String balanceType;
// //   final TagKycDocuments? kycDocuments;
// //   final String kycType;
// //   final String status;

// //   factory Tag.fromJson(Map<String, dynamic> json) {
// //     return Tag(
// //       serialNumber: json["serialNumber"] ?? "",
// //       kitNumber: json["kitNumber"] ?? "",
// //       vehicleClass: json["vehicleClass"] == null ? null : VehicleClass.fromJson(json["vehicleClass"]),
// //       partnerOrganizationId: json["partnerOrganizationId"] ?? "",
// //       partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
// //       kycStatus: json["kycStatus"] ?? "",
// //       balanceType: json["balanceType"] ?? "",
// //       kycDocuments: json["kycDocuments"] == null ? null : TagKycDocuments.fromJson(json["kycDocuments"]),
// //       kycType: json["kycType"] ?? "",
// //       status: json["status"] ?? "",
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "serialNumber": serialNumber,
// //         "kitNumber": kitNumber,
// //         "vehicleClass": vehicleClass?.toJson(),
// //         "partnerOrganizationId": partnerOrganizationId,
// //         "partnerEnrollmentId": partnerEnrollmentId,
// //         "kycStatus": kycStatus,
// //         "balanceType": balanceType,
// //         "kycDocuments": kycDocuments?.toJson(),
// //         "kycType": kycType,
// //         "status": status,
// //       };
// // }

// // class TagKycDocuments {
// //   TagKycDocuments({
// //     required this.rcBookImage,
// //     required this.identityProof,
// //     required this.addressProof,
// //   });

// //   final AddressProof? rcBookImage;
// //   final AddressProof? identityProof;
// //   final AddressProof? addressProof;

// //   factory TagKycDocuments.fromJson(Map<String, dynamic> json) {
// //     return TagKycDocuments(
// //       rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : AddressProof.fromJson(json["RC_BOOK_IMAGE"]),
// //       identityProof: json["IDENTITY_PROOF"] == null ? null : AddressProof.fromJson(json["IDENTITY_PROOF"]),
// //       addressProof: json["ADDRESS_PROOF"] == null ? null : AddressProof.fromJson(json["ADDRESS_PROOF"]),
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "RC_BOOK_IMAGE": rcBookImage?.toJson(),
// //         "IDENTITY_PROOF": identityProof?.toJson(),
// //         "ADDRESS_PROOF": addressProof?.toJson(),
// //       };
// // }

// // class AddressProof {
// //   AddressProof({
// //     required this.url,
// //     required this.docUploadStatus,
// //   });

// //   final String url;
// //   final String docUploadStatus;

// //   factory AddressProof.fromJson(Map<String, dynamic> json) {
// //     return AddressProof(
// //       url: json["url"] ?? "",
// //       docUploadStatus: json["docUploadStatus"] ?? "",
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "url": url,
// //         "docUploadStatus": docUploadStatus,
// //       };
// // }

// // class VehicleClass {
// //   VehicleClass({
// //     required this.tagClass,
// //     required this.axleCount,
// //     required this.mapperClass,
// //   });

// //   final String tagClass;
// //   final int axleCount;
// //   final String mapperClass;

// //   factory VehicleClass.fromJson(Map<String, dynamic> json) {
// //     return VehicleClass(
// //       tagClass: json["tagClass"] ?? "",
// //       axleCount: json["axleCount"] ?? 0,
// //       mapperClass: json["mapperClass"] ?? "",
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "tagClass": tagClass,
// //         "axleCount": axleCount,
// //         "mapperClass": mapperClass,
// //       };
// // }

// // class VehicleType {
// //   VehicleType({
// //     required this.maker,
// //     required this.emissionNorm,
// //     required this.financierName,
// //     required this.isCommercial,
// //   });

// //   final String maker;
// //   final String emissionNorm;
// //   final String financierName;
// //   final String isCommercial;

// //   factory VehicleType.fromJson(Map<String, dynamic> json) {
// //     return VehicleType(
// //       maker: json["maker"] ?? "",
// //       emissionNorm: json["emissionNorm"] ?? "",
// //       financierName: json["financierName"] ?? "",
// //       isCommercial: json["isCommercial"] ?? "",
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         "maker": maker,
// //         "emissionNorm": emissionNorm,
// //         "financierName": financierName,
// //         "isCommercial": isCommercial,
// //       };
// // }


// // class Vehicle {
// //   Vehicle({
// //     this.id,
// //     this.enrollmentId,
// //     this.organizationId,
// //     this.organizationEnrollmentId,
// //     this.organizationEntityId,
// //     this.status,
// //     this.accountInformation,
// //     this.contactNumber,
// //     this.registrationNumber,
// //     this.registrationDate,
// //     this.engineNumber,
// //     this.chasisNumber,
// //     this.fuelType,
// //     this.insuranceExpiryDate,
// //     this.fitnessUpto,
// //     this.vehicleType,
// //     this.vehicleCategory,
// //     this.createdBy,
// //     this.updatedBy,
// //     this.createdByOrg,
// //     this.updatedByOrg,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.v,
// //     this.services,
// //     this.entityId,
// //   });

// //   String? id;
// //   String? enrollmentId;
// //   String? organizationId;
// //   String? organizationEnrollmentId;
// //   String? organizationEntityId;
// //   String? status;
// //   List<String?>? accountInformation;
// //   String? contactNumber;
// //   String? registrationNumber;
// //   DateTime? registrationDate;
// //   String? engineNumber;
// //   String? chasisNumber;
// //   String? fuelType;
// //   DateTime? insuranceExpiryDate;
// //   DateTime? fitnessUpto;
// //   VehicleType? vehicleType;
// //   String? vehicleCategory;
// //   String? createdBy;
// //   String? updatedBy;
// //   String? createdByOrg;
// //   String? updatedByOrg;
// //   DateTime? createdAt;
// //   DateTime? updatedAt;
// //   int? v;
// //   Services? services;
// //   String? entityId;

// //   factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
// //         id: json["_id"] ?? '',
// //         enrollmentId: json["enrollmentId"] ?? '',
// //         organizationId: json["organizationId"] ?? '',
// //         organizationEnrollmentId: json["organizationEnrollmentId"] ?? '',
// //         organizationEntityId: json["organizationEntityId"] ?? '',
// //         status: json["status"] ?? [],
// //         accountInformation:
// //             json["accountInformation"] == null ? [] : List<String?>.from(json["accountInformation"]!.map((x) => x)),
// //         contactNumber: json["contactNumber"] ?? '',
// //         registrationNumber: json["registrationNumber"] ?? '',
// //         registrationDate: json["registrationDate"] == null ? null : DateTime.parse(json["registrationDate"]),
// //         engineNumber: json["engineNumber"] ?? '',
// //         chasisNumber: json["chasisNumber"] ?? '',
// //         fuelType: json["fuelType"] ?? '',
// //         insuranceExpiryDate: json["insuranceExpiryDate"] == null ? null : DateTime.parse(json["insuranceExpiryDate"]),
// //         fitnessUpto: json["fitnessUpto"] == null ? null : DateTime.parse(json["fitnessUpto"]),
// //         vehicleType: json["vehicleType"] == null ? null : VehicleType.fromJson(json["vehicleType"]),
// //         vehicleCategory: json["vehicleCategory"],
// //         createdBy: json["createdBy"] ?? '',
// //         updatedBy: json["updatedBy"] ?? '',
// //         createdByOrg: json["createdByOrg"] ?? '',
// //         updatedByOrg: json["updatedByOrg"] ?? '',
// //         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
// //         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
// //         v: json["__v"] ?? '',
// //         services: json["services"] == null ? null : Services.fromJson(json["services"]),
// //         entityId: json["entityId"] ?? '',
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "_id": id,
// //         "enrollmentId": enrollmentId,
// //         "organizationId": organizationId,
// //         "organizationEnrollmentId": organizationEnrollmentId,
// //         "organizationEntityId": organizationEntityId,
// //         "status": status,
// //         "accountInformation": accountInformation == null ? [] : List<dynamic>.from(accountInformation!.map((x) => x)),
// //         "contactNumber": contactNumber,
// //         "registrationNumber": registrationNumber,
// //         "registrationDate": registrationDate?.toIso8601String(),
// //         "engineNumber": engineNumber,
// //         "chasisNumber": chasisNumber,
// //         "fuelType": fuelType,
// //         "insuranceExpiryDate": insuranceExpiryDate?.toIso8601String(),
// //         "fitnessUpto": fitnessUpto?.toIso8601String(),
// //         "vehicleType": vehicleType!.toJson(),
// //         "vehicleCategory": vehicleCategory,
// //         "createdBy": createdBy,
// //         "updatedBy": updatedBy,
// //         "createdByOrg": createdByOrg,
// //         "updatedByOrg": updatedByOrg,
// //         "createdAt": createdAt?.toIso8601String(),
// //         "updatedAt": updatedAt?.toIso8601String(),
// //         "__v": v,
// //         "services": services!.toJson(),
// //         "entityId": entityId,
// //       };
// // }

// // class Services {
// //   Services({
// //     this.tag,
// //     this.fuel,
// //     this.gps,
// //   });

// //   List<Tag?>? tag;
// //   List<Tag?>? fuel;
// //   Gps? gps;

// //   factory Services.fromJson(Map<String, dynamic> json) => Services(
// //         tag: json["tag"] == null ? [] : List<Tag?>.from(json["tag"]!.map((x) => Tag.fromJson(x))),
// //         fuel: json["fuel"] == null ? [] : List<Tag>.from(json["fuel"]!.map((x) => x)),
// //         gps: json["gps"] == null ? null : Gps.fromJson(json["gps"]),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "tag": tag == null ? [] : List<dynamic>.from(tag!.map((x) => x!.toJson())),
// //         "fuel": fuel == null ? [] : List<dynamic>.from(fuel!.map((x) => x)),
// //         "gps": gps?.toJson(),
// //       };
// // }

// // class Gps {
// //   Gps({
// //     this.imei,
// //     this.kycDocuments,
// //     this.status,
// //   });

// //   String? imei;
// //   GpsKycDocuments? kycDocuments;
// //   String? status;

// //   factory Gps.fromJson(Map<String, dynamic> json) => Gps(
// //         imei: json["imei"] ?? '',
// //         kycDocuments: json["kycDocuments"] == null ? null : GpsKycDocuments.fromJson(json["kycDocuments"]),
// //         status: json["status"] ?? '',
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "imei": imei,
// //         "kycDocuments": kycDocuments?.toJson(),
// //         "status": status,
// //       };
// // }

// // class GpsKycDocuments {
// //   GpsKycDocuments({
// //     this.rcBookImage,
// //     this.otherProof1,
// //   });

// //   OtherProof1? rcBookImage;
// //   OtherProof1? otherProof1;

// //   factory GpsKycDocuments.fromJson(Map<String, dynamic> json) => GpsKycDocuments(
// //         rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : OtherProof1.fromJson(json["RC_BOOK_IMAGE"]),
// //         otherProof1: json["OTHER_PROOF1"] == null ? null : OtherProof1.fromJson(json["OTHER_PROOF1"]),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "RC_BOOK_IMAGE": rcBookImage?.toJson(),
// //         "OTHER_PROOF1": otherProof1?.toJson(),
// //       };
// // }

// // class OtherProof1 {
// //   OtherProof1({
// //     this.documentNo,
// //     this.documentExpiry,
// //     this.url,
// //     this.docUploadStatus,
// //   });

// //   String? documentNo;
// //   DateTime? documentExpiry;
// //   String? url;
// //   String? docUploadStatus;

// //   factory OtherProof1.fromJson(Map<String, dynamic> json) => OtherProof1(
// //         documentNo: json["documentNo"] ?? '',
// //         documentExpiry: json["documentExpiry"] == null ? null : DateTime.parse(json["documentExpiry"]),
// //         url: json["url"] ?? '',
// //         docUploadStatus: json["docUploadStatus"] ?? '',
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "documentNo": documentNo,
// //         "documentExpiry": documentExpiry,
// //         "url": url,
// //         "docUploadStatus": docUploadStatus,
// //       };
// // }

// // class Tag {
// //   Tag({
// //     this.serialNumber,
// //     this.kitNumber,
// //     this.vehicleClass,
// //     this.partnerOrganizationId,
// //     this.partnerEnrollmentId,
// //     this.kycStatus,
// //     this.balanceType,
// //     this.kycDocuments,
// //     this.kycType,
// //     this.status,
// //   });

// //   String? serialNumber;
// //   String? kitNumber;
// //   VehicleClass? vehicleClass;
// //   String? partnerOrganizationId;
// //   String? partnerEnrollmentId;
// //   String? kycStatus;
// //   String? balanceType;
// //   TagKycDocuments? kycDocuments;
// //   String? kycType;
// //   String? status;

// //   factory Tag.fromJson(Map<String, dynamic> json) => Tag(
// //         serialNumber: json["serialNumber"] ?? '',
// //         kitNumber: json["kitNumber"] ?? '',
// //         vehicleClass: json["vehicleClass"] == null ? null : VehicleClass.fromJson(json["vehicleClass"]),
// //         partnerOrganizationId: json["partnerOrganizationId"] ?? '',
// //         partnerEnrollmentId: json["partnerEnrollmentId"] ?? '',
// //         kycStatus: json["kycStatus"] ?? '',
// //         balanceType: json["balanceType"] ?? '',
// //         kycDocuments: json["kycDocuments"] == null ? null : TagKycDocuments.fromJson(json["kycDocuments"]),
// //         kycType: json["kycType"] ?? '',
// //         status: json["status"] ?? '',
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "serialNumber": serialNumber,
// //         "kitNumber": kitNumber,
// //         "vehicleClass": vehicleClass!.toJson(),
// //         "partnerOrganizationId": partnerOrganizationId,
// //         "partnerEnrollmentId": partnerEnrollmentId,
// //         "kycStatus": kycStatus,
// //         "balanceType": balanceType,
// //         "kycDocuments": kycDocuments!.toJson(),
// //         "kycType": kycType,
// //         "status": status,
// //       };
// // }

// // class TagKycDocuments {
// //   TagKycDocuments({
// //     this.rcBookImage,
// //     this.identityProof,
// //     this.addressProof,
// //   });

// //   AddressProof? rcBookImage;
// //   AddressProof? identityProof;
// //   AddressProof? addressProof;

// //   factory TagKycDocuments.fromJson(Map<String, dynamic> json) => TagKycDocuments(
// //         rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : AddressProof.fromJson(json["RC_BOOK_IMAGE"]),
// //         identityProof: json["IDENTITY_PROOF"] == null ? null : AddressProof.fromJson(json["IDENTITY_PROOF"]),
// //         addressProof: json["ADDRESS_PROOF"] == null ? null : AddressProof.fromJson(json["ADDRESS_PROOF"]),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "RC_BOOK_IMAGE": rcBookImage?.toJson(),
// //         "IDENTITY_PROOF": identityProof?.toJson(),
// //         "ADDRESS_PROOF": addressProof?.toJson(),
// //       };
// // }

// // class AddressProof {
// //   AddressProof({
// //     this.url,
// //     this.docUploadStatus,
// //   });

// //   String? url;
// //   String? docUploadStatus;

// //   factory AddressProof.fromJson(Map<String, dynamic> json) => AddressProof(
// //         url: json["url"] ?? '',
// //         docUploadStatus: json["docUploadStatus"] ?? '',
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "url": url,
// //         "docUploadStatus": docUploadStatus,
// //       };
// // }

// // class VehicleClass {
// //   VehicleClass({
// //     this.tagClass,
// //     this.axleCount,
// //     this.mapperClass,
// //     this.id,
// //   });

// //   String? tagClass;
// //   int? axleCount;
// //   String? mapperClass;
// //   String? id;

// //   factory VehicleClass.fromJson(Map<String, dynamic> json) => VehicleClass(
// //         tagClass: json["tagClass"] ?? '',
// //         axleCount: json["axleCount"] ?? 0,
// //         mapperClass: json["mapperClass"] ?? '',
// //         id: json["_id"] ?? '',
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "tagClass": tagClass,
// //         "axleCount": axleCount,
// //         "mapperClass": mapperClass,
// //         "_id": id,
// //       };
// // }

// // class VehicleType {
// //   VehicleType({
// //     this.maker,
// //     this.emissionNorm,
// //     this.financierName,
// //     this.isCommercial,
// //   });

// //   String? maker;
// //   String? emissionNorm;
// //   String? financierName;
// //   String? isCommercial;

// //   factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
// //         maker: json["maker"] ?? '',
// //         emissionNorm: json["emissionNorm"] ?? '',
// //         financierName: json["financierName"] ?? '',
// //         isCommercial: json["isCommercial"] ?? '',
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "maker": maker,
// //         "emissionNorm": emissionNorm,
// //         "financierName": financierName,
// //         "isCommercial": isCommercial,
// //       };
// // }
