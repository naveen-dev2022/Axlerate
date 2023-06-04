import 'dart:convert';

class VehicleFastTagServiceInputModel {
  VehicleFastTagServiceInputModel({
    required this.organizationId,
    required this.vehicleRegistrationNumber,
    required this.balanceType,
    required this.fastagInfo,
    required this.kycDocuments,
    this.vehicleImages,
    required this.thresholdLimit,
    required this.contactNumber,
  });

  final String organizationId;
  final String vehicleRegistrationNumber;
  final String balanceType;
  final FastagInfo fastagInfo;
  final Map<String, dynamic> kycDocuments;
  final int thresholdLimit;
  final Map<String, dynamic>? vehicleImages;
  final String contactNumber;

  VehicleFastTagServiceInputModel copyWith({
    String? organizationId,
    String? vehicleRegistrationNumber,
    String? balanceType,
    FastagInfo? fastagInfo,
    Map<String, dynamic>? kycDocuments,
    Map<String, dynamic>? vehicleImages,
    String? contactNumber,
    int? thresholdLimit,
  }) {
    return VehicleFastTagServiceInputModel(
      organizationId: organizationId ?? this.organizationId,
      vehicleRegistrationNumber: vehicleRegistrationNumber ?? this.vehicleRegistrationNumber,
      balanceType: balanceType ?? this.balanceType,
      fastagInfo: fastagInfo ?? this.fastagInfo,
      kycDocuments: kycDocuments ?? this.kycDocuments,
      vehicleImages: vehicleImages ?? this.vehicleImages,
      contactNumber: contactNumber ?? this.contactNumber,
      thresholdLimit: thresholdLimit ?? this.thresholdLimit,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {
      'organizationId': organizationId,
      'vehicleRegistrationNumber': vehicleRegistrationNumber,
      'balanceType': balanceType,
      'fastagInfo': fastagInfo.toJson(),
      'contactNumber': contactNumber,
      'kycDocuments': kycDocuments,
      'thresholdLimit': thresholdLimit,
    };

    if (vehicleImages != null) {
      vehicleImages!['FRONT_VIEW']['url'].isEmpty ? vehicleImages!.remove('FRONT_VIEW') : vehicleImages;
      vehicleImages!['SIDE_VIEW']['url'].isEmpty ? vehicleImages!.remove('SIDE_VIEW') : vehicleImages;
      params.addAll({'vehicleImages': vehicleImages});
    }

    return params;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'VehicleFastTagServiceInputModel(organizationId: $organizationId, vehicleRegistrationNumber: $vehicleRegistrationNumber, balanceType: $balanceType, fastagInfo: $fastagInfo, kycDocuments: $kycDocuments, thresholdLimit: $thresholdLimit, vehicleImages: $vehicleImages, contactNumber: $contactNumber)';
  }
}

class FastagInfo {
  FastagInfo({
    this.serialNumber,
    this.vehicleClass,
  });

  final String? serialNumber;
  final VehicleInputClass? vehicleClass;

  factory FastagInfo.fromJson(Map<String, dynamic> json) => FastagInfo(
        serialNumber: json["serialNumber"],
        vehicleClass: VehicleInputClass.fromJson(json["vehicleClass"]),
      );

  Map<String, dynamic> toJson() => {
        "serialNumber": serialNumber,
        "vehicleClass": vehicleClass!.toJson(),
      };
}

class VehicleInputClass {
  VehicleInputClass({
    this.tagClass,
    this.axleCount,
    this.mapperClass,
  });

  final String? tagClass;
  final int? axleCount;
  final String? mapperClass;

  factory VehicleInputClass.fromJson(Map<String, dynamic> json) => VehicleInputClass(
        tagClass: json["tagClass"],
        axleCount: json["axleCount"],
        mapperClass: json["mapperClass"],
      );

  Map<String, dynamic> toJson() => {
        "tagClass": tagClass,
        "axleCount": axleCount,
        "mapperClass": mapperClass,
      };
}

// class VehicleTagKycDocuments {
//   VehicleTagKycDocuments({
//     required this.identityProof,
//     required this.addressProof,
//     required this.rcBookImage,
//   });

//   final AddressProof identityProof;
//   final AddressProof addressProof;
//   final AddressProof rcBookImage;

//   VehicleTagKycDocuments copyWith({
//     AddressProof? identityProof,
//     AddressProof? addressProof,
//     AddressProof? rcBookImage,
//   }) {
//     return VehicleTagKycDocuments(
//       identityProof: identityProof ?? this.identityProof,
//       addressProof: addressProof ?? this.addressProof,
//       rcBookImage: rcBookImage ?? this.rcBookImage,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'IDENTITY_PROOF': identityProof.toJson(),
//       'ADDRESS_PROOF': addressProof.toJson(),
//       'RC_BOOK_IMAGE': rcBookImage.toJson(),
//     };
//   }

//   factory VehicleTagKycDocuments.fromMap(Map<String, dynamic> map) {
//     return VehicleTagKycDocuments(
//       identityProof: AddressProof.fromJson(map['identityProof']),
//       addressProof: AddressProof.fromJson(map['addressProof']),
//       rcBookImage: AddressProof.fromJson(map['rcBookImage']),
//     );
//   }

//   factory VehicleTagKycDocuments.fromJson(Map<String, dynamic> source) => VehicleTagKycDocuments.fromMap(source);
// }

// class AddressProof {
//   AddressProof({
//     this.url,
//   });

//   final String? url;

//   factory AddressProof.fromJson(Map<String, dynamic> json) => AddressProof(
//         url: json["url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//       };
// }
