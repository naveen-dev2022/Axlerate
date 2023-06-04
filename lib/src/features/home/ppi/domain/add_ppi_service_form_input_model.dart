import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddPpiServiceFormInputModel {
  final String contactNumber;
  final String otp;
  final String userId;
  final String partnerOrgId;
  final String organizationId;
  final String organizationEntityId;
  // final String kycType;
  final String title;
  final String firstName;
  final String lastName;
  final String gender;
  final bool isNriCustomer;
  final bool isMinor;
  final bool isDependant;
  final String maritalStatus;
  // final String countryCode;
  final String employmentIndustry;
  final String employmentType;
  // final String plasticCode;
  final String kitNumber;
  final List<AddressInfo> addressInfo;
  final List<CommunicationInfo> communicationInfo;
  final List<DateInfo> dateInfo;

  AddPpiServiceFormInputModel({
    required this.contactNumber,
    required this.otp,
    required this.userId,
    required this.partnerOrgId,
    required this.organizationId,
    required this.organizationEntityId,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.isNriCustomer,
    required this.isMinor,
    required this.isDependant,
    required this.maritalStatus,
    required this.employmentIndustry,
    required this.employmentType,
    required this.kitNumber,
    required this.addressInfo,
    required this.communicationInfo,
    required this.dateInfo,
  });

  AddPpiServiceFormInputModel copyWith({
    String? contactNumber,
    String? otp,
    String? userId,
    String? partnerOrgId,
    String? organizationId,
    String? organizationEntityId,
    String? title,
    String? firstName,
    String? lastName,
    String? gender,
    bool? isNriCustomer,
    bool? isMinor,
    bool? isDependant,
    String? maritalStatus,
    String? employmentIndustry,
    String? employmentType,
    String? kitNumber,
    List<AddressInfo>? addressInfo,
    List<CommunicationInfo>? communicationInfo,
    List<DateInfo>? dateInfo,
  }) {
    return AddPpiServiceFormInputModel(
      contactNumber: contactNumber ?? this.contactNumber,
      otp: otp ?? this.otp,
      userId: userId ?? this.userId,
      partnerOrgId: partnerOrgId ?? this.partnerOrgId,
      organizationId: organizationId ?? this.organizationId,
      organizationEntityId: organizationEntityId ?? this.organizationEntityId,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      isNriCustomer: isNriCustomer ?? this.isNriCustomer,
      isMinor: isMinor ?? this.isMinor,
      isDependant: isDependant ?? this.isDependant,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      employmentIndustry: employmentIndustry ?? this.employmentIndustry,
      employmentType: employmentType ?? this.employmentType,
      kitNumber: kitNumber ?? this.kitNumber,
      addressInfo: addressInfo ?? this.addressInfo,
      communicationInfo: communicationInfo ?? this.communicationInfo,
      dateInfo: dateInfo ?? this.dateInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contactNumber': contactNumber,
      'otp': otp,
      'userId': userId,
      'partnerOrgId': partnerOrgId,
      'organizationId': organizationId,
      'organizationEntityId': organizationEntityId,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'isNriCustomer': isNriCustomer,
      'isMinor': isMinor,
      'isDependant': isDependant,
      'maritalStatus': maritalStatus,
      'employmentIndustry': employmentIndustry,
      'employmentType': employmentType,
      'kitNumber': kitNumber,
      'addressInfo': addressInfo.map((x) => x.toMap()).toList(),
      'communicationInfo': communicationInfo.map((x) => x.toMap()).toList(),
      'dateInfo': dateInfo.map((x) => x.toMap()).toList(),
    };
  }

  factory AddPpiServiceFormInputModel.fromMap(Map<String, dynamic> map) {
    return AddPpiServiceFormInputModel(
      contactNumber: map['contactNumber'] ?? '',
      otp: map['otp'] ?? '',
      userId: map['userId'] ?? '',
      partnerOrgId: map['partnerOrgId'] ?? '',
      organizationId: map['organizationId'] ?? '',
      organizationEntityId: map['organizationEntityId'] ?? '',
      title: map['title'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      gender: map['gender'] ?? '',
      isNriCustomer: map['isNriCustomer'] ?? false,
      isMinor: map['isMinor'] ?? false,
      isDependant: map['isDependant'] ?? false,
      maritalStatus: map['maritalStatus'] ?? '',
      employmentIndustry: map['employmentIndustry'] ?? '',
      employmentType: map['employmentType'] ?? '',
      kitNumber: map['kitNumber'] ?? '',
      addressInfo: List<AddressInfo>.from(map['addressInfo']?.map((x) => AddressInfo.fromMap(x))),
      communicationInfo:
          List<CommunicationInfo>.from(map['communicationInfo']?.map((x) => CommunicationInfo.fromMap(x))),
      dateInfo: List<DateInfo>.from(map['dateInfo']?.map((x) => DateInfo.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddPpiServiceFormInputModel.fromJson(String source) =>
      AddPpiServiceFormInputModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddPpiServiceFormInputModel(contactNumber: $contactNumber, otp: $otp, userId: $userId, partnerOrgId: $partnerOrgId, organizationId: $organizationId, organizationEntityId: $organizationEntityId, title: $title, firstName: $firstName, lastName: $lastName, gender: $gender, isNriCustomer: $isNriCustomer, isMinor: $isMinor, isDependant: $isDependant, maritalStatus: $maritalStatus, employmentIndustry: $employmentIndustry, employmentType: $employmentType, kitNumber: $kitNumber, addressInfo: $addressInfo, communicationInfo: $communicationInfo, dateInfo: $dateInfo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddPpiServiceFormInputModel &&
        other.contactNumber == contactNumber &&
        other.otp == otp &&
        other.userId == userId &&
        other.partnerOrgId == partnerOrgId &&
        other.organizationId == organizationId &&
        other.organizationEntityId == organizationEntityId &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.isNriCustomer == isNriCustomer &&
        other.isMinor == isMinor &&
        other.isDependant == isDependant &&
        other.maritalStatus == maritalStatus &&
        other.employmentIndustry == employmentIndustry &&
        other.employmentType == employmentType &&
        other.kitNumber == kitNumber &&
        listEquals(other.addressInfo, addressInfo) &&
        listEquals(other.communicationInfo, communicationInfo) &&
        listEquals(other.dateInfo, dateInfo);
  }

  @override
  int get hashCode {
    return contactNumber.hashCode ^
        otp.hashCode ^
        userId.hashCode ^
        partnerOrgId.hashCode ^
        organizationId.hashCode ^
        organizationEntityId.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        gender.hashCode ^
        isNriCustomer.hashCode ^
        isMinor.hashCode ^
        isDependant.hashCode ^
        maritalStatus.hashCode ^
        employmentIndustry.hashCode ^
        employmentType.hashCode ^
        kitNumber.hashCode ^
        addressInfo.hashCode ^
        communicationInfo.hashCode ^
        dateInfo.hashCode;
  }
}

class AddressInfo {
  final String addressCategory;
  final String address1;
  final String address2;
  final String address3;
  final String city;
  final String state;
  final String country;
  final String pinCode;
  AddressInfo({
    required this.addressCategory,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
  });

  AddressInfo copyWith({
    String? addressCategory,
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? state,
    String? country,
    String? pinCode,
  }) {
    return AddressInfo(
      addressCategory: addressCategory ?? this.addressCategory,
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
      'addressCategory': addressCategory,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'city': city,
      'state': state,
      'country': country,
      'pinCode': pinCode,
    };
  }

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      addressCategory: map['addressCategory'] ?? '',
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

  factory AddressInfo.fromJson(String source) => AddressInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressInfo(addressCategory: $addressCategory, address1: $address1, address2: $address2, address3: $address3, city: $city, state: $state, country: $country, pinCode: $pinCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressInfo &&
        other.addressCategory == addressCategory &&
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
    return addressCategory.hashCode ^
        address1.hashCode ^
        address2.hashCode ^
        address3.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        pinCode.hashCode;
  }
}

class CommunicationInfo {
  final String contactNo;
  final String contactNo2;
  final bool notification;
  final String emailId;
  CommunicationInfo({
    required this.contactNo,
    required this.contactNo2,
    required this.notification,
    required this.emailId,
  });

  CommunicationInfo copyWith({
    String? contactNo,
    String? contactNo2,
    bool? notification,
    String? emailId,
  }) {
    return CommunicationInfo(
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

  factory CommunicationInfo.fromMap(Map<String, dynamic> map) {
    return CommunicationInfo(
      contactNo: map['contactNo'] ?? '',
      contactNo2: map['contactNo2'] ?? '',
      notification: map['notification'] ?? false,
      emailId: map['emailId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunicationInfo.fromJson(String source) => CommunicationInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommunicationInfo(contactNo: $contactNo, contactNo2: $contactNo2, notification: $notification, emailId: $emailId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommunicationInfo &&
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

class DateInfo {
  final String dateType;
  final DateTime date;
  DateInfo({
    required this.dateType,
    required this.date,
  });

  DateInfo copyWith({
    String? dateType,
    DateTime? date,
  }) {
    return DateInfo(
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

  factory DateInfo.fromMap(Map<String, dynamic> map) {
    return DateInfo(
      dateType: map['dateType'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DateInfo.fromJson(String source) => DateInfo.fromMap(json.decode(source));

  @override
  String toString() => 'DateInfo(dateType: $dateType, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DateInfo && other.dateType == dateType && other.date == date;
  }

  @override
  int get hashCode => dateType.hashCode ^ date.hashCode;
}
