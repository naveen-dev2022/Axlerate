import 'dart:convert';

class CreateLogisticsInputModel {
  final String orgCode;
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime incorporateDate;
  final String natureOfBusiness;
  final String panNumber;
  final String contactNumber;
  final OrgAddresses addresses;
  final Admin admin;

  CreateLogisticsInputModel({
    required this.orgCode,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.incorporateDate,
    required this.natureOfBusiness,
    required this.panNumber,
    required this.contactNumber,
    required this.addresses,
    required this.admin,
  });

  CreateLogisticsInputModel copyWith({
    String? orgCode,
    String? title,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? incorporateDate,
    String? natureOfBusiness,
    String? panNumber,
    String? contactNumber,
    OrgAddresses? addresses,
    Admin? admin,
  }) {
    return CreateLogisticsInputModel(
      orgCode: orgCode ?? this.orgCode,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      incorporateDate: incorporateDate ?? this.incorporateDate,
      natureOfBusiness: natureOfBusiness ?? this.natureOfBusiness,
      panNumber: panNumber ?? this.panNumber,
      contactNumber: contactNumber ?? this.contactNumber,
      addresses: addresses ?? this.addresses,
      admin: admin ?? this.admin,
    );
  }

  Map<String, dynamic> toMap({
    String orgId = '',
    bool isUpdate = false,
  }) {
    Map<String, dynamic> params = {
      'orgCode': orgCode,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'incorporateDate': incorporateDate.toString(),
      'natureOfBusiness': natureOfBusiness,
      'panNumber': panNumber,
      'contactNumber': contactNumber,
      'addresses': addresses.toMap(),
      'admin': admin.toMap(),
    };

    if (isUpdate) {
      params.remove('orgCode');
      params.remove('admin');
      params.addAll({'organizationId': orgId});
      return params;
    }
    return params;
  }

  factory CreateLogisticsInputModel.fromMap(Map<String, dynamic> map) {
    return CreateLogisticsInputModel(
      orgCode: map['orgCode'] ?? '',
      title: map['title'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      incorporateDate: DateTime(map['incorporateDate']),
      natureOfBusiness: map['natureOfBusiness'] ?? '',
      panNumber: map['panNumber'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      addresses: OrgAddresses.fromMap(map['addresses']),
      admin: Admin.fromMap(map['admin']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateLogisticsInputModel.fromJson(String source) => CreateLogisticsInputModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateLogisticsInputModel(orgCode: $orgCode, title: $title, firstName: $firstName, lastName: $lastName, email: $email, incorporateDate: $incorporateDate, natureOfBusiness: $natureOfBusiness, panNumber: $panNumber, contactNumber: $contactNumber, addresses: $addresses, admin: $admin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateLogisticsInputModel &&
        other.orgCode == orgCode &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.incorporateDate == incorporateDate &&
        other.natureOfBusiness == natureOfBusiness &&
        other.panNumber == panNumber &&
        other.contactNumber == contactNumber &&
        other.addresses == addresses &&
        other.admin == admin;
  }

  @override
  int get hashCode {
    return orgCode.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        incorporateDate.hashCode ^
        natureOfBusiness.hashCode ^
        panNumber.hashCode ^
        contactNumber.hashCode ^
        addresses.hashCode ^
        admin.hashCode;
  }
}

// * Adresses
class OrgAddresses {
  final OrgAddress officeAddress;
  final OrgAddress communicationAddress;
  OrgAddresses({
    required this.officeAddress,
    required this.communicationAddress,
  });

  OrgAddresses copyWith({
    OrgAddress? officeAddress,
    OrgAddress? communicationAddress,
  }) {
    return OrgAddresses(
      officeAddress: officeAddress ?? this.officeAddress,
      communicationAddress: communicationAddress ?? this.communicationAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'officeAddress': officeAddress.toMap(),
      'communicationAddress': communicationAddress.toMap(),
    };
  }

  factory OrgAddresses.fromMap(Map<String, dynamic> map) {
    return OrgAddresses(
      officeAddress: OrgAddress.fromMap(map['officeAddress']),
      communicationAddress: OrgAddress.fromMap(map['communicationAddress']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrgAddresses.fromJson(String source) => OrgAddresses.fromMap(json.decode(source));

  @override
  String toString() => 'Addresses(officeAddress: $officeAddress, communicationAddress: $communicationAddress)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrgAddresses &&
        other.officeAddress == officeAddress &&
        other.communicationAddress == communicationAddress;
  }

  @override
  int get hashCode => officeAddress.hashCode ^ communicationAddress.hashCode;
}

// * Single Address
class OrgAddress {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String state;
  final String zipCode;
  OrgAddress({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.state,
    required this.zipCode,
  });

  OrgAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? country,
    String? state,
    String? zipCode,
  }) {
    return OrgAddress(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      country: country ?? this.country,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'country': country,
      'state': state,
      'zipCode': zipCode,
    };
  }

  factory OrgAddress.fromMap(Map<String, dynamic> map) {
    return OrgAddress(
      addressLine1: map['addressLine1'] ?? '',
      addressLine2: map['addressLine2'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
    );
  }

  factory OrgAddress.fromJson(String source) => OrgAddress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, country: $country, state: $state, zipCode: $zipCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrgAddress &&
        other.addressLine1 == addressLine1 &&
        other.addressLine2 == addressLine2 &&
        other.city == city &&
        other.country == country &&
        other.state == state &&
        other.zipCode == zipCode;
  }

  @override
  int get hashCode {
    return addressLine1.hashCode ^
        addressLine2.hashCode ^
        city.hashCode ^
        country.hashCode ^
        state.hashCode ^
        zipCode.hashCode;
  }
}

// * Admin
class Admin {
  final String userName;
  Admin({
    required this.userName,
  });

  Admin copyWith({
    String? userName,
  }) {
    return Admin(
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      userName: map['userName'] ?? '',
    );
  }

  factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source));

  @override
  String toString() => 'Admin(userName: $userName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Admin && other.userName == userName;
  }

  @override
  int get hashCode => userName.hashCode;
}
