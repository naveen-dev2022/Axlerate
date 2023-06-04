class AddLqTaginputModel {
  AddLqTaginputModel({
    required this.otp,
    required this.userEnrollmentId,
    required this.organizationEnrollmentId,
    required this.kycDocuments,
    required this.gender,
    required this.lastName,
    required this.firstName,
    required this.emailAddress,
    required this.title,
    required this.addresses,
    required this.communicationInfo,
    required this.dateInfo,
  });

  final String? otp;
  final String? userEnrollmentId;
  final String? organizationEnrollmentId;
  final KycDocuments? kycDocuments;
  final String gender;
  final String lastName;
  final String firstName;
  final String emailAddress;
  final String title;
  final Map<String, dynamic> addresses;
  final List<CommunicationInfo> communicationInfo;
  final List<DateInfo> dateInfo;

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "userEnrollmentId": userEnrollmentId,
        "organizationEnrollmentId": organizationEnrollmentId,
        "kycDocuments": kycDocuments?.toJson(),
        "gender": gender,
        "lastName": lastName,
        "firstName": firstName,
        "emailAddress": emailAddress,
        "title": title,
        "addresses": addresses,
        "communicationInfo": communicationInfo.map((x) => x.toJson()).toList(),
        "dateInfo": dateInfo.map((x) => x.toJson()).toList(),
      };
}

class Addresses {
  Addresses({
    required this.addressAsPerAadhar,
  });

  final AddressAsPerAadhar? addressAsPerAadhar;

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return Addresses(
      addressAsPerAadhar:
          json["addressAsPerAadhar"] == null ? null : AddressAsPerAadhar.fromJson(json["addressAsPerAadhar"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "addressAsPerAadhar": addressAsPerAadhar?.toJson(),
      };
}

class AddressAsPerAadhar {
  AddressAsPerAadhar({
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
  });

  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? country;
  final String? pinCode;

  factory AddressAsPerAadhar.fromJson(Map<String, dynamic> json) {
    return AddressAsPerAadhar(
      address1: json["address1"],
      address2: json["address2"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      pinCode: json["pinCode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "country": country,
        "pinCode": pinCode,
      };
}

class CommunicationInfo {
  CommunicationInfo({
    required this.emailId,
    required this.notification,
  });

  final String? emailId;
  final bool? notification;

  factory CommunicationInfo.fromJson(Map<String, dynamic> json) {
    return CommunicationInfo(
      emailId: json["emailId"],
      notification: json["notification"],
    );
  }

  Map<String, dynamic> toJson() => {
        "emailId": emailId,
        "notification": notification,
      };
}

class DateInfo {
  DateInfo({
    required this.dateType,
    required this.date,
  });

  final String? dateType;
  final String? date;

  factory DateInfo.fromJson(Map<String, dynamic> json) {
    return DateInfo(
      dateType: json["dateType"],
      date: json["date"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "dateType": dateType,
        "date": date,
      };
}

class KycDocuments {
  KycDocuments({
    required this.addressProof,
    required this.pan,
  });

  final AddressProof? addressProof;
  final Pan? pan;

  factory KycDocuments.fromJson(Map<String, dynamic> json) {
    return KycDocuments(
      addressProof: json["addressProof"] == null ? null : AddressProof.fromJson(json["addressProof"]),
      pan: json["PAN"] == null ? null : Pan.fromJson(json["PAN"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "addressProof": addressProof?.toJson(),
        "PAN": pan?.toJson(),
      };
}

class AddressProof {
  AddressProof({
    required this.url,
  });

  final String? url;

  factory AddressProof.fromJson(Map<String, dynamic> json) {
    return AddressProof(
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Pan {
  Pan({
    required this.documentNo,
  });

  final String? documentNo;

  factory Pan.fromJson(Map<String, dynamic> json) {
    return Pan(
      documentNo: json["documentNo"],
    );
  }

  Map<String, dynamic> toJson() => {
        "documentNo": documentNo,
      };
}
