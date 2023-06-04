import 'dart:convert';

class CreatePartnerInputModel {
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime incorporateDate;
  final String natureOfBusiness;
  final String panNumber;
  final String contactNumber;
  final PartnerAddresses addresses;
  final PartnerAdmin admin;
  final double tagCashBackPercentage;
  final double ppiCashBackPercentage;

  CreatePartnerInputModel({
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
    required this.tagCashBackPercentage,
    required this.ppiCashBackPercentage,
  });

  CreatePartnerInputModel copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? incorporateDate,
    String? natureOfBusiness,
    String? panNumber,
    String? contactNumber,
    PartnerAddresses? addresses,
    PartnerAdmin? admin,
    double? tagCashBackPercentage,
    double? ppiCashBackPercentage,
  }) {
    return CreatePartnerInputModel(
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
      tagCashBackPercentage: tagCashBackPercentage ?? this.tagCashBackPercentage,
      ppiCashBackPercentage: ppiCashBackPercentage ?? this.ppiCashBackPercentage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'incorporateDate': incorporateDate.millisecondsSinceEpoch,
      'natureOfBusiness': natureOfBusiness,
      'panNumber': panNumber,
      'contactNumber': contactNumber,
      'addresses': addresses.toMap(),
      'admin': admin.toMap(),
      "tagCashBackPercentage": tagCashBackPercentage,
      "ppiCashBackPercentage": ppiCashBackPercentage,
    };
  }

  // factory CreatePartnerInputModel.fromMap(Map<String, dynamic> map) {
  //   return CreatePartnerInputModel(
  //     title: map['title'] ?? '',
  //     firstName: map['firstName'] ?? '',
  //     lastName: map['lastName'] ?? '',
  //     email: map['email'] ?? '',
  //     incorporateDate: DateTime.fromMillisecondsSinceEpoch(map['incorporateDate']),
  //     natureOfBusiness: map['natureOfBusiness'] ?? '',
  //     panNumber: map['panNumber'] ?? '',
  //     contactNumber: map['contactNumber'] ?? '',
  //     addresses: PartnerAddresses.fromMap(map['addresses']),
  //     admin: PartnerAdmin.fromMap(map['admin']),

  //   );
  // }

  factory CreatePartnerInputModel.fromJson(Map<String, dynamic> source) => CreatePartnerInputModel.fromJson(source);

  @override
  String toString() {
    return 'CreatePartnerInputModel(title: $title, firstName: $firstName, lastName: $lastName, email: $email, incorporateDate: $incorporateDate, natureOfBusiness: $natureOfBusiness, panNumber: $panNumber, contactNumber: $contactNumber, addresses: $addresses, admin: $admin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreatePartnerInputModel &&
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
    return title.hashCode ^
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

class PartnerAddresses {
  final PartnerAddress officeAddress;
  final PartnerAddress communicationAddress;
  PartnerAddresses({
    required this.officeAddress,
    required this.communicationAddress,
  });

  PartnerAddresses copyWith({
    PartnerAddress? officeAddress,
    PartnerAddress? communicationAddress,
  }) {
    return PartnerAddresses(
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

  factory PartnerAddresses.fromMap(Map<String, dynamic> map) {
    return PartnerAddresses(
      officeAddress: PartnerAddress.fromMap(map['officeAddress']),
      communicationAddress: PartnerAddress.fromMap(map['communicationAddress']),
    );
  }

  factory PartnerAddresses.fromJson(String source) => PartnerAddresses.fromMap(json.decode(source));

  @override
  String toString() => 'Addresses(officeAddress: $officeAddress, communicationAddress: $communicationAddress)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PartnerAddresses &&
        other.officeAddress == officeAddress &&
        other.communicationAddress == communicationAddress;
  }

  @override
  int get hashCode => officeAddress.hashCode ^ communicationAddress.hashCode;
}

class PartnerAddress {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String state;
  final String zipCode;
  PartnerAddress({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.state,
    required this.zipCode,
  });

  PartnerAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? country,
    String? state,
    String? zipCode,
  }) {
    return PartnerAddress(
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

  factory PartnerAddress.fromMap(Map<String, dynamic> map) {
    return PartnerAddress(
      addressLine1: map['addressLine1'] ?? '',
      addressLine2: map['addressLine2'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
    );
  }

  factory PartnerAddress.fromJson(String source) => PartnerAddress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, country: $country, state: $state, zipCode: $zipCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PartnerAddress &&
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

class PartnerAdmin {
  final String userName;
  PartnerAdmin({
    required this.userName,
  });

  PartnerAdmin copyWith({
    String? userName,
  }) {
    return PartnerAdmin(
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
    };
  }

  factory PartnerAdmin.fromMap(Map<String, dynamic> map) {
    return PartnerAdmin(
      userName: map['userName'] ?? '',
    );
  }

  factory PartnerAdmin.fromJson(String source) => PartnerAdmin.fromMap(json.decode(source));

  @override
  String toString() => 'Admin(userName: $userName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PartnerAdmin && other.userName == userName;
  }

  @override
  int get hashCode => userName.hashCode;
}
