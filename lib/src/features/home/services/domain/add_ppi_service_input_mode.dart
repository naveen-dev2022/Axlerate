import 'dart:convert';

import 'package:flutter/foundation.dart';

class EnablePpiServiceInputModel {
  final String serviceType;
  final String organizationId;
  final String issuerName;
  String? partnerOrgId;
  double? cashBackPercentage;
  final Map<String, Map<String, String>> kycDocuments;

  EnablePpiServiceInputModel({
    required this.serviceType,
    required this.organizationId,
    required this.issuerName,
    this.partnerOrgId,
    this.cashBackPercentage,
    required this.kycDocuments,
  });

  EnablePpiServiceInputModel copyWith({
    String? serviceType,
    String? organizationId,
    String? issuerName,
    String? partnerOrgId,
    double? cashBackPercentage,
    Map<String, Map<String, String>>? kycDocuments,
  }) {
    return EnablePpiServiceInputModel(
      serviceType: serviceType ?? this.serviceType,
      organizationId: organizationId ?? this.organizationId,
      issuerName: issuerName ?? this.issuerName,
      partnerOrgId: partnerOrgId ?? this.partnerOrgId,
      cashBackPercentage: cashBackPercentage ?? this.cashBackPercentage,
      kycDocuments: kycDocuments ?? this.kycDocuments,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {
      'serviceType': serviceType,
      'organizationId': organizationId,
      'issuerName': issuerName,
      // 'partnerOrgId': partnerOrgId,
      // 'cashBackPercentage': cashBackPercentage,
      'kycDocuments': kycDocuments,
    };
    partnerOrgId != null ? params.addAll({'partnerOrgId': partnerOrgId}) : params;

    cashBackPercentage != null ? params.addAll({'cashBackPercentage': cashBackPercentage}) : params;

    return params;
  }

  // factory EnablePpiServiceInputModel.fromMap(Map<String, dynamic> map) {
  //   return EnablePpiServiceInputModel(
  //     serviceType: map['serviceType'] ?? '',
  //     organizationId: map['organizationId'] ?? '',
  //     partnerOrgId: map['partnerOrgId'] ?? '',
  //     cashBackPercentage: map['cashBackPercentage']?.toDouble() ?? 0.0,
  //     kycDocuments: Map<String, EnbalePpiServiceKycDocument>.from(map['kycDocuments']),
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory EnablePpiServiceInputModel.fromJson(String source) => EnablePpiServiceInputModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnablePpiServiceInputModel(serviceType: $serviceType, organizationId: $organizationId, partnerOrgId: $partnerOrgId, cashBackPercentage: $cashBackPercentage, kycDocuments: $kycDocuments,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnablePpiServiceInputModel &&
        other.serviceType == serviceType &&
        other.organizationId == organizationId &&
        other.partnerOrgId == partnerOrgId &&
        other.cashBackPercentage == cashBackPercentage &&
        mapEquals(other.kycDocuments, kycDocuments);
  }

  @override
  int get hashCode {
    return serviceType.hashCode ^
        organizationId.hashCode ^
        partnerOrgId.hashCode ^
        cashBackPercentage.hashCode ^
        kycDocuments.hashCode;
  }
}

class EnbalePpiServiceKycDocument {
  final String name;
  final String url;
  EnbalePpiServiceKycDocument({
    required this.name,
    required this.url,
  });

  EnbalePpiServiceKycDocument copyWith({
    String? name,
    String? url,
  }) {
    return EnbalePpiServiceKycDocument(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory EnbalePpiServiceKycDocument.fromMap(Map<String, dynamic> map) {
    return EnbalePpiServiceKycDocument(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }

  factory EnbalePpiServiceKycDocument.fromJson(String source) =>
      EnbalePpiServiceKycDocument.fromMap(json.decode(source));

  @override
  String toString() => 'KycDocument(name: $name, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnbalePpiServiceKycDocument && other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}


// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// class AddPpiServiceInputModel {
//   final String organizationId;
//   final String partnerOrgId;
//   final String serviceType;
//   final String issuerName;
//   final CommunicationAddress communicationAddress;
//   final double cashBackPercentage;
//   final int thresholdLimit;

//   AddPpiServiceInputModel({
//     required this.organizationId,
//     required this.partnerOrgId,
//     required this.serviceType,
//     required this.issuerName,
//     required this.communicationAddress,
//     required this.cashBackPercentage,
//     required this.thresholdLimit,
//   });

//   AddPpiServiceInputModel copyWith({
//     String? organizationId,
//     String? partnerOrgId,
//     String? serviceType,
//     String? issuerName,
//     CommunicationAddress? communicationAddress,
//     double? cashBackPercentage,
//     int? thresholdLimit,
//   }) {
//     return AddPpiServiceInputModel(
//       organizationId: organizationId ?? this.organizationId,
//       partnerOrgId: partnerOrgId ?? this.partnerOrgId,
//       serviceType: serviceType ?? this.serviceType,
//       issuerName: issuerName ?? this.issuerName,
//       communicationAddress: communicationAddress ?? this.communicationAddress,
//       cashBackPercentage: cashBackPercentage ?? this.cashBackPercentage,
//       thresholdLimit: thresholdLimit ?? this.thresholdLimit,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'organizationId': organizationId,
//       'partnerOrgId': partnerOrgId,
//       'serviceType': serviceType,
//       'issuerName': issuerName,
//       'communicationAddress': communicationAddress.toMap(),
//       'cashBackPercentage': cashBackPercentage,
//       'thresholdLimit': thresholdLimit,
//     };
//   }

//   factory AddPpiServiceInputModel.fromMap(Map<String, dynamic> map) {
//     return AddPpiServiceInputModel(
//       organizationId: map['organizationId'] ?? '',
//       partnerOrgId: map['partnerOrgId'] ?? '',
//       serviceType: map['serviceType'] ?? '',
//       issuerName: map['issuerName'] ?? '',
//       communicationAddress: CommunicationAddress.fromMap(map['communicationAddress']),
//       cashBackPercentage: map['cashBackPercentage']?.toDouble() ?? 0.0,
//       thresholdLimit: map['thresholdLimit']?.toInt() ?? 0,
//     );
//   }

//   factory AddPpiServiceInputModel.fromJson(String source) => AddPpiServiceInputModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'AddPpiServiceInputModel(organizationId: $organizationId, partnerOrgId: $partnerOrgId, serviceType: $serviceType, issuerName: $issuerName, communicationAddress: $communicationAddress, cashBackPercentage: $cashBackPercentage, thresholdLimit: $thresholdLimit)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is AddPpiServiceInputModel &&
//         other.organizationId == organizationId &&
//         other.partnerOrgId == partnerOrgId &&
//         other.serviceType == serviceType &&
//         other.issuerName == issuerName &&
//         other.communicationAddress == communicationAddress &&
//         other.cashBackPercentage == cashBackPercentage &&
//         other.thresholdLimit == thresholdLimit;
//   }

//   @override
//   int get hashCode {
//     return organizationId.hashCode ^
//         partnerOrgId.hashCode ^
//         serviceType.hashCode ^
//         issuerName.hashCode ^
//         communicationAddress.hashCode ^
//         cashBackPercentage.hashCode ^
//         thresholdLimit.hashCode;
//   }
// }

// class CommunicationAddress {
//   final List<Address> address;
//   final String contactNo1;
//   final String emailAddress1;
//   final String emailAddress2;

//   CommunicationAddress({
//     required this.address,
//     required this.contactNo1,
//     required this.emailAddress1,
//     required this.emailAddress2,
//   });

//   CommunicationAddress copyWith({
//     List<Address>? address,
//     String? contactNo1,
//     String? emailAddress1,
//     String? emailAddress2,
//   }) {
//     return CommunicationAddress(
//       address: address ?? this.address,
//       contactNo1: contactNo1 ?? this.contactNo1,
//       emailAddress1: emailAddress1 ?? this.emailAddress1,
//       emailAddress2: emailAddress2 ?? this.emailAddress2,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'address': address.map((x) => x.toMap()).toList(),
//       'contactNo1': contactNo1,
//       'emailAddress1': emailAddress1,
//       'emailAddress2': emailAddress2,
//     };
//   }

//   factory CommunicationAddress.fromMap(Map<String, dynamic> map) {
//     return CommunicationAddress(
//       address: List<Address>.from(map['address']?.map((x) => Address.fromMap(x))),
//       contactNo1: map['contactNo1'] ?? '',
//       emailAddress1: map['emailAddress1'] ?? '',
//       emailAddress2: map['emailAddress2'] ?? '',
//     );
//   }

//   factory CommunicationAddress.fromJson(String source) => CommunicationAddress.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'CommunicationAddress(address: $address, contactNo1: $contactNo1, emailAddress1: $emailAddress1, emailAddress2: $emailAddress2)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is CommunicationAddress &&
//         listEquals(other.address, address) &&
//         other.contactNo1 == contactNo1 &&
//         other.emailAddress1 == emailAddress1 &&
//         other.emailAddress2 == emailAddress2;
//   }

//   @override
//   int get hashCode {
//     return address.hashCode ^ contactNo1.hashCode ^ emailAddress1.hashCode ^ emailAddress2.hashCode;
//   }
// }

// class Address {
//   final String title;
//   final String address1;
//   final String address2;
//   final String city;
//   final String state;
//   final String country;
//   final String pinCode;

//   Address({
//     required this.title,
//     required this.address1,
//     required this.address2,
//     required this.city,
//     required this.state,
//     required this.country,
//     required this.pinCode,
//   });

//   Address copyWith({
//     String? title,
//     String? address1,
//     String? address2,
//     String? city,
//     String? state,
//     String? country,
//     String? pinCode,
//   }) {
//     return Address(
//       title: title ?? this.title,
//       address1: address1 ?? this.address1,
//       address2: address2 ?? this.address2,
//       city: city ?? this.city,
//       state: state ?? this.state,
//       country: country ?? this.country,
//       pinCode: pinCode ?? this.pinCode,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'address1': address1,
//       'address2': address2,
//       'city': city,
//       'state': state,
//       'country': country,
//       'pinCode': pinCode,
//     };
//   }

//   factory Address.fromMap(Map<String, dynamic> map) {
//     return Address(
//       title: map['title'] ?? '',
//       address1: map['address1'] ?? '',
//       address2: map['address2'] ?? '',
//       city: map['city'] ?? '',
//       state: map['state'] ?? '',
//       country: map['country'] ?? '',
//       pinCode: map['pinCode'] ?? '',
//     );
//   }

//   factory Address.fromJson(String source) => Address.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Address(title: $title, address1: $address1, address2: $address2, city: $city, state: $state, country: $country, pinCode: $pinCode)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Address &&
//         other.title == title &&
//         other.address1 == address1 &&
//         other.address2 == address2 &&
//         other.city == city &&
//         other.state == state &&
//         other.country == country &&
//         other.pinCode == pinCode;
//   }

//   @override
//   int get hashCode {
//     return title.hashCode ^
//         address1.hashCode ^
//         address2.hashCode ^
//         city.hashCode ^
//         state.hashCode ^
//         country.hashCode ^
//         pinCode.hashCode;
//   }
// }
