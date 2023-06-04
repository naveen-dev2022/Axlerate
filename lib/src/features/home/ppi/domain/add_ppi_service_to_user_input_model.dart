import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddPpiServiceToUserInputModel {
  final String contactNumber;
  final String otp;
  final String userId;
  final String organizationId;
  // final String organizationEntityId;
  final String title;
  final String firstName;
  final String lastName;
  final String gender;
  final bool isNriCustomer;
  // final String kitNumber;
  final bool isMinor;
  final bool isDependant;
  final String maritalStatus;
  final String employmentIndustry;
  final String employmentType;
  final AddPPIAddresses addresses;
  final List<AddPPICommunicationInfo> communicationInfo;
  final List<AddPPIDateInfo> dateInfo;
  final String pan;

  AddPpiServiceToUserInputModel(
      {required this.contactNumber,
      required this.otp,
      required this.userId,
      required this.organizationId,
      // required this.organizationEntityId,
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.isNriCustomer,
      // required this.kitNumber,
      required this.isMinor,
      required this.isDependant,
      required this.maritalStatus,
      required this.employmentIndustry,
      required this.employmentType,
      required this.addresses,
      required this.communicationInfo,
      required this.dateInfo,
      required this.pan});

  AddPpiServiceToUserInputModel copyWith(
      {String? contactNumber,
      String? otp,
      String? userId,
      String? organizationId,
      // String? organizationEntityId,
      String? title,
      String? firstName,
      String? lastName,
      String? gender,
      bool? isNriCustomer,
      String? kitNumber,
      bool? isMinor,
      bool? isDependant,
      String? maritalStatus,
      String? employmentIndustry,
      String? employmentType,
      AddPPIAddresses? addresses,
      List<AddPPICommunicationInfo>? communicationInfo,
      List<AddPPIDateInfo>? dateInfo,
      String? pan}) {
    return AddPpiServiceToUserInputModel(
        contactNumber: contactNumber ?? this.contactNumber,
        otp: otp ?? this.otp,
        userId: userId ?? this.userId,
        organizationId: organizationId ?? this.organizationId,
        // organizationEntityId: organizationEntityId ?? this.organizationEntityId,
        title: title ?? this.title,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        isNriCustomer: isNriCustomer ?? this.isNriCustomer,
        // kitNumber: kitNumber ?? this.kitNumber,
        isMinor: isMinor ?? this.isMinor,
        isDependant: isDependant ?? this.isDependant,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        employmentIndustry: employmentIndustry ?? this.employmentIndustry,
        employmentType: employmentType ?? this.employmentType,
        addresses: addresses ?? this.addresses,
        communicationInfo: communicationInfo ?? this.communicationInfo,
        dateInfo: dateInfo ?? this.dateInfo,
        pan: pan ?? this.pan);
  }

  Map<String, dynamic> toMap() {
    return {
      // 'contactNumber': contactNumber,
      'otp': otp,
      'userId': userId,
      'organizationId': organizationId,
      // 'organizationEntityId': organizationEntityId,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'isNRICustomer': isNriCustomer,
      // 'kitNumber': kitNumber,
      'isMinor': isMinor,
      'isDependant': isDependant,
      'maritalStatus': maritalStatus,
      'employmentIndustry': employmentIndustry,
      'employmentType': employmentType,
      'addresses': addresses.toMap(),
      'communicationInfo': communicationInfo.map((x) => x.toMap()).toList(),
      'dateInfo': dateInfo.map((x) => x.toMap()).toList(),
      'pan': pan
    };
  }

  factory AddPpiServiceToUserInputModel.fromMap(Map<String, dynamic> map) {
    return AddPpiServiceToUserInputModel(
        contactNumber: map['contactNumber'] ?? '',
        otp: map['otp'] ?? '',
        userId: map['userId'] ?? '',
        organizationId: map['organizationId'] ?? '',
        // organizationEntityId: map['organizationEntityId'] ?? '',
        title: map['title'] ?? '',
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        gender: map['gender'] ?? '',
        isNriCustomer: map['isNriCustomer'] ?? false,
        // kitNumber: map['kitNumber'] ?? '',
        isMinor: map['isMinor'] ?? false,
        isDependant: map['isDependant'] ?? false,
        maritalStatus: map['maritalStatus'] ?? '',
        employmentIndustry: map['employmentIndustry'] ?? '',
        employmentType: map['employmentType'] ?? '',
        addresses: AddPPIAddresses.fromMap(map['addresses']),
        communicationInfo: List<AddPPICommunicationInfo>.from(
            map['communicationInfo']?.map((x) => AddPPICommunicationInfo.fromMap(x))),
        dateInfo: List<AddPPIDateInfo>.from(map['dateInfo']?.map((x) => AddPPIDateInfo.fromMap(x))),
        pan: map['pan']);
  }

  String toJson() => json.encode(toMap());

  factory AddPpiServiceToUserInputModel.fromJson(String source) =>
      AddPpiServiceToUserInputModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddPpiServiceToUserInputModel(contactNumber: $contactNumber, otp: $otp, userId: $userId, organizationId: $organizationId, title: $title, firstName: $firstName, lastName: $lastName, gender: $gender, isNriCustomer: $isNriCustomer, isMinor: $isMinor, isDependant: $isDependant, maritalStatus: $maritalStatus, employmentIndustry: $employmentIndustry, employmentType: $employmentType, addresses: $addresses, communicationInfo: $communicationInfo, dateInfo: $dateInfo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddPpiServiceToUserInputModel &&
        other.contactNumber == contactNumber &&
        other.otp == otp &&
        other.userId == userId &&
        other.organizationId == organizationId &&
        // other.organizationEntityId == organizationEntityId &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.isNriCustomer == isNriCustomer &&
        // other.kitNumber == kitNumber &&
        other.isMinor == isMinor &&
        other.isDependant == isDependant &&
        other.maritalStatus == maritalStatus &&
        other.employmentIndustry == employmentIndustry &&
        other.employmentType == employmentType &&
        other.addresses == addresses &&
        listEquals(other.communicationInfo, communicationInfo) &&
        listEquals(other.dateInfo, dateInfo);
  }

  @override
  int get hashCode {
    return contactNumber.hashCode ^
        otp.hashCode ^
        userId.hashCode ^
        organizationId.hashCode ^
        // organizationEntityId.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        gender.hashCode ^
        isNriCustomer.hashCode ^
        // kitNumber.hashCode ^
        isMinor.hashCode ^
        isDependant.hashCode ^
        maritalStatus.hashCode ^
        employmentIndustry.hashCode ^
        employmentType.hashCode ^
        addresses.hashCode ^
        communicationInfo.hashCode ^
        dateInfo.hashCode;
  }
}

class AddPPIAddresses {
  final AddressAsPerAadhar addressAsPerAadhar;
  final AddressAsPerAadhar communicationAddress;

  AddPPIAddresses({
    required this.addressAsPerAadhar,
    required this.communicationAddress,
  });

  AddPPIAddresses copyWith({
    AddressAsPerAadhar? addressAsPerAadhar,
    AddressAsPerAadhar? communicationAddress,
  }) {
    return AddPPIAddresses(
      addressAsPerAadhar: addressAsPerAadhar ?? this.addressAsPerAadhar,
      communicationAddress: communicationAddress ?? this.communicationAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'addressAsPerAadhar': addressAsPerAadhar.toMap(),
      'communicationAddress': communicationAddress.toMap(),
    };
  }

  factory AddPPIAddresses.fromMap(Map<String, dynamic> map) {
    return AddPPIAddresses(
      addressAsPerAadhar: AddressAsPerAadhar.fromMap(map['addressAsPerAadhar']),
      communicationAddress: AddressAsPerAadhar.fromMap(map['communicationAddress']),
    );
  }

  factory AddPPIAddresses.fromJson(String source) => AddPPIAddresses.fromMap(json.decode(source));

  @override
  String toString() =>
      'Addresses(addressAsPerAadhar: $addressAsPerAadhar, communicationAddress: $communicationAddress)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddPPIAddresses &&
        other.addressAsPerAadhar == addressAsPerAadhar &&
        other.communicationAddress == communicationAddress;
  }

  @override
  int get hashCode => addressAsPerAadhar.hashCode ^ communicationAddress.hashCode;
}

class AddressAsPerAadhar {
  final String address1;
  final String address2;
  final String address3;
  final String city;
  final String state;
  final String country;
  final String pinCode;

  AddressAsPerAadhar({
    required this.address1,
    required this.address2,
    required this.address3,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
  });

  AddressAsPerAadhar copyWith({
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? state,
    String? country,
    String? pinCode,
  }) {
    return AddressAsPerAadhar(
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'city': city,
      'state': state,
      'country': country,
      'pinCode': pinCode,
    };
  }

  factory AddressAsPerAadhar.fromMap(Map<String, dynamic> map) {
    return AddressAsPerAadhar(
      address1: map['address1'] ?? '',
      address2: map['address2'] ?? '',
      address3: map['address3'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      pinCode: map['pinCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressAsPerAadhar.fromJson(String source) => AddressAsPerAadhar.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressAsPerAadhar(address1: $address1, address2: $address2, address3: $address3, city: $city, state: $state, country: $country, pinCode: $pinCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressAsPerAadhar &&
        other.address1 == address1 &&
        other.address2 == address2 &&
        other.address3 == address3 &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.pinCode == pinCode;
  }

  @override
  int get hashCode {
    return address1.hashCode ^
        address2.hashCode ^
        address3.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        pinCode.hashCode;
  }
}

class AddPPICommunicationInfo {
  final String contactNo;
  final String contactNo2;
  final bool notification;
  final String emailId;

  AddPPICommunicationInfo({
    required this.contactNo,
    required this.contactNo2,
    required this.notification,
    required this.emailId,
  });

  AddPPICommunicationInfo copyWith({
    String? contactNo,
    String? contactNo2,
    bool? notification,
    String? emailId,
  }) {
    return AddPPICommunicationInfo(
      contactNo: contactNo ?? this.contactNo,
      contactNo2: contactNo2 ?? this.contactNo2,
      notification: notification ?? this.notification,
      emailId: emailId ?? this.emailId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contactNo': contactNo,
      'contactNo2': contactNo2,
      'notification': notification,
      'emailId': emailId,
    };
  }

  factory AddPPICommunicationInfo.fromMap(Map<String, dynamic> map) {
    return AddPPICommunicationInfo(
      contactNo: map['contactNo'] ?? '',
      contactNo2: map['contactNo2'] ?? '',
      notification: map['notification'] ?? false,
      emailId: map['emailId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddPPICommunicationInfo.fromJson(String source) => AddPPICommunicationInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommunicationInfo(contactNo: $contactNo, contactNo2: $contactNo2, notification: $notification, emailId: $emailId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddPPICommunicationInfo &&
        other.contactNo == contactNo &&
        other.contactNo2 == contactNo2 &&
        other.notification == notification &&
        other.emailId == emailId;
  }

  @override
  int get hashCode {
    return contactNo.hashCode ^ contactNo2.hashCode ^ notification.hashCode ^ emailId.hashCode;
  }
}

class AddPPIDateInfo {
  final String dateType;
  final DateTime date;
  AddPPIDateInfo({
    required this.dateType,
    required this.date,
  });

  AddPPIDateInfo copyWith({
    String? dateType,
    DateTime? date,
  }) {
    return AddPPIDateInfo(
      dateType: dateType ?? this.dateType,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateType': dateType,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory AddPPIDateInfo.fromMap(Map<String, dynamic> map) {
    return AddPPIDateInfo(
      dateType: map['dateType'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddPPIDateInfo.fromJson(String source) => AddPPIDateInfo.fromMap(json.decode(source));

  @override
  String toString() => 'DateInfo(dateType: $dateType, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddPPIDateInfo && other.dateType == dateType && other.date == date;
  }

  @override
  int get hashCode => dateType.hashCode ^ date.hashCode;
}
