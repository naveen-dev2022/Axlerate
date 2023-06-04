// class ListVehiclesModel {
//   ListVehiclesModel({
//     required this.data,
//   });

//   final Data? data;
//   const ListVehiclesModel.unknown() : data = null;

//   factory ListVehiclesModel.fromJson(Map<String, dynamic> json) {
//     return ListVehiclesModel(
//       data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     );
//   }
// }

// class Data {
//   Data({
//     required this.message,
//   });

//   final Message? message;

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       message:
//           json["message"] == null ? null : Message.fromJson(json["message"]),
//     );
//   }
// }

// class Message {
//   Message({
//     required this.docs,
//     required this.count,
//   });

//   final List<VehicleDoc> docs;
//   final int count;

//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       docs: json["docs"] == null
//           ? []
//           : List<VehicleDoc>.from(
//               json["docs"]!.map((x) => VehicleDoc.fromJson(x))),
//       count: json["count"] ?? 0,
//     );
//   }
// }

// class VehicleDoc {
//   VehicleDoc({
//     required this.id,
//     required this.enrollmentId,
//     required this.organizationId,
//     required this.organizationEnrollmentId,
//     required this.organizationEntityId,
//     required this.status,
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
//     required this.organizationDetails,
//     required this.entityId,
//     required this.contactNumber,
//     required this.accountInformation,
//     required this.vehicleImage,
//     required this.services,
//   });

//   final String id;
//   final String enrollmentId;
//   final String organizationId;
//   final String organizationEnrollmentId;
//   final String organizationEntityId;
//   final String status;
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
//   final OrganizationDetails? organizationDetails;
//   final String entityId;
//   final String contactNumber;
//   final AccountInformation? accountInformation;
//   final VehicleImage? vehicleImage;
//   final DocServices? services;

//   factory VehicleDoc.fromJson(Map<String, dynamic> json) {
//     return VehicleDoc(
//       id: json["_id"] ?? "",
//       enrollmentId: json["enrollmentId"] ?? "",
//       organizationId: json["organizationId"] ?? "",
//       organizationEnrollmentId: json["organizationEnrollmentId"] ?? "",
//       organizationEntityId: json["organizationEntityId"] ?? "",
//       status: json["status"] ?? "",
//       registrationNumber: json["registrationNumber"] ?? "",
//       registrationDate: json["registrationDate"] == null
//           ? null
//           : DateTime.parse(json["registrationDate"]),
//       engineNumber: json["engineNumber"] ?? "",
//       chasisNumber: json["chasisNumber"] ?? "",
//       fuelType: json["fuelType"] ?? "",
//       insuranceExpiryDate: json["insuranceExpiryDate"] == null
//           ? null
//           : DateTime.parse(json["insuranceExpiryDate"]),
//       fitnessUpto: json["fitnessUpto"] == null
//           ? null
//           : DateTime.parse(json["fitnessUpto"]),
//       vehicleType: json["vehicleType"] == null
//           ? null
//           : VehicleType.fromJson(json["vehicleType"]),
//       vehicleCategory: json["vehicleCategory"] ?? "",
//       createdBy: json["createdBy"] ?? "",
//       updatedBy: json["updatedBy"] ?? "",
//       createdByOrg: json["createdByOrg"] ?? "",
//       updatedByOrg: json["updatedByOrg"] ?? "",
//       createdAt:
//           json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//       updatedAt:
//           json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//       v: json["__v"] ?? 0,
//       organizationDetails: json["organizationDetails"] == null
//           ? null
//           : OrganizationDetails.fromJson(json["organizationDetails"]),
//       entityId: json["entityId"] ?? "",
//       contactNumber: json["contactNumber"] ?? "",
//       accountInformation: json["accountInformation"] == null
//           ? null
//           : AccountInformation.fromJson(json["accountInformation"]),
//       vehicleImage: json["vehicleImage"] == null
//           ? null
//           : VehicleImage.fromJson(json["vehicleImage"]),
//       services: json["services"] == null
//           ? null
//           : DocServices.fromJson(json["services"]),
//     );
//   }
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

//   factory AccountInformation.fromJson(Map<String, dynamic> json) {
//     return AccountInformation(
//       id: json["_id"] ?? "",
//       accountInformationId: json["id"] ?? "",
//       entityId: json["entityId"] ?? "",
//       type: json["type"] ?? "",
//       status: json["status"] ?? "",
//       accountNumber: json["accountNumber"] ?? "",
//       ifsc: json["IFSC"] ?? "",
//       upiId: json["upiId"] ?? "",
//       thresholdLimit: json["thresholdLimit"] ?? 0,
//       availableBalance: json["availableBalance"] ?? 0,
//       organizationId: json["organizationId"] ?? "",
//       partnerOrganizationId: json["partnerOrganizationId"] ?? "",
//       createdAt:
//           json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//       updatedAt:
//           json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//       v: json["__v"] ?? 0,
//     );
//   }
// }

// class OrganizationDetails {
//   OrganizationDetails({
//     required this.firstName,
//     required this.lastName,
//     required this.services,
//   });

//   final String firstName;
//   final String lastName;
//   final OrganizationDetailsServices? services;

//   factory OrganizationDetails.fromJson(Map<String, dynamic> json) {
//     return OrganizationDetails(
//       firstName: json["firstName"] ?? "",
//       lastName: json["lastName"] ?? "",
//       services: json["services"] == null
//           ? null
//           : OrganizationDetailsServices.fromJson(json["services"]),
//     );
//   }
// }

// class OrganizationDetailsServices {
//   OrganizationDetailsServices({
//     required this.tag,
//     required this.ppi,
//     required this.gps,
//   });

//   final Ppi? tag;
//   final Ppi? ppi;
//   final PurpleGps? gps;

//   factory OrganizationDetailsServices.fromJson(Map<String, dynamic> json) {
//     return OrganizationDetailsServices(
//       tag: json["tag"] == null ? null : Ppi.fromJson(json["tag"]),
//       ppi: json["ppi"] == null ? null : Ppi.fromJson(json["ppi"]),
//       gps: json["gps"] == null ? null : PurpleGps.fromJson(json["gps"]),
//     );
//   }
// }

// class PurpleGps {
//   PurpleGps({
//     required this.partnerOrganization,
//     required this.issuer,
//   });

//   final List<dynamic> partnerOrganization;
//   final List<String> issuer;

//   factory PurpleGps.fromJson(Map<String, dynamic> json) {
//     return PurpleGps(
//       partnerOrganization: json["partnerOrganization"] == null
//           ? []
//           : List<dynamic>.from(json["partnerOrganization"]!.map((x) => x)),
//       issuer: json["issuer"] == null
//           ? []
//           : List<String>.from(json["issuer"]!.map((x) => x)),
//     );
//   }
// }

// class Ppi {
//   Ppi({
//     required this.partnerOrganization,
//     required this.issuer,
//   });

//   final List<PartnerOrganization> partnerOrganization;
//   final List<Issuer> issuer;

//   factory Ppi.fromJson(Map<String, dynamic> json) {
//     return Ppi(
//       partnerOrganization: json["partnerOrganization"] == null
//           ? []
//           : List<PartnerOrganization>.from(json["partnerOrganization"]!
//               .map((x) => PartnerOrganization.fromJson(x))),
//       issuer: json["issuer"] == null
//           ? []
//           : List<Issuer>.from(json["issuer"]!.map((x) => Issuer.fromJson(x))),
//     );
//   }
// }

// class Issuer {
//   Issuer({
//     required this.name,
//     required this.kycStatus,
//     required this.kycDocuments,
//     required this.kycType,
//   });

//   final String name;
//   final String kycStatus;
//   final IssuerKycDocuments? kycDocuments;
//   final String kycType;

//   factory Issuer.fromJson(Map<String, dynamic> json) {
//     return Issuer(
//       name: json["name"] ?? "",
//       kycStatus: json["kycStatus"] ?? "",
//       kycDocuments: json["kycDocuments"] == null
//           ? null
//           : IssuerKycDocuments.fromJson(json["kycDocuments"]),
//       kycType: json["kycType"] ?? "",
//     );
//   }
// }

// class IssuerKycDocuments {
//   IssuerKycDocuments({
//     required this.identityProof,
//     required this.addressProof,
//   });

//   final AddressProof? identityProof;
//   final AddressProof? addressProof;

//   factory IssuerKycDocuments.fromJson(Map<String, dynamic> json) {
//     return IssuerKycDocuments(
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

// class PartnerOrganization {
//   PartnerOrganization({
//     required this.id,
//     required this.enrollmentId,
//     required this.cashBackPercentage,
//   });

//   final String id;
//   final String enrollmentId;
//   final int cashBackPercentage;

//   factory PartnerOrganization.fromJson(Map<String, dynamic> json) {
//     return PartnerOrganization(
//       id: json["id"] ?? "",
//       enrollmentId: json["enrollmentId"] ?? "",
//       cashBackPercentage: json["cashBackPercentage"] ?? 0,
//     );
//   }
// }

// class DocServices {
//   DocServices({
//     required this.tag,
//     required this.gps,
//   });

//   final List<Tag> tag;
//   final FluffyGps? gps;

//   factory DocServices.fromJson(Map<String, dynamic> json) {
//     return DocServices(
//       tag: json["tag"] == null
//           ? []
//           : List<Tag>.from(json["tag"]!.map((x) => Tag.fromJson(x))),
//       gps: json["gps"] == null ? null : FluffyGps.fromJson(json["gps"]),
//     );
//   }
// }

// class FluffyGps {
//   FluffyGps({
//     required this.imei,
//     required this.kycDocuments,
//     required this.status,
//   });

//   final String imei;
//   final GpsKycDocuments? kycDocuments;
//   final String status;

//   factory FluffyGps.fromJson(Map<String, dynamic> json) {
//     return FluffyGps(
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

//   factory Tag.fromJson(Map<String, dynamic> json) {
//     return Tag(
//       serialNumber: json["serialNumber"] ?? "",
//       kitNumber: json["kitNumber"] ?? "",
//       vehicleClass: json["vehicleClass"] == null
//           ? null
//           : VehicleClass.fromJson(json["vehicleClass"]),
//       partnerOrganizationId: json["partnerOrganizationId"] ?? "",
//       partnerEnrollmentId: json["partnerEnrollmentId"] ?? "",
//       kycStatus: json["kycStatus"] ?? "",
//       balanceType: json["balanceType"] ?? "",
//       kycDocuments: json["kycDocuments"] == null
//           ? null
//           : TagKycDocuments.fromJson(json["kycDocuments"]),
//       kycType: json["kycType"] ?? "",
//       status: json["status"] ?? "",
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
//       frontView:
//           json["FRONT_VIEW"] == null ? null : View.fromJson(json["FRONT_VIEW"]),
//       sideView:
//           json["SIDE_VIEW"] == null ? null : View.fromJson(json["SIDE_VIEW"]),
//     );
//   }
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
// }
