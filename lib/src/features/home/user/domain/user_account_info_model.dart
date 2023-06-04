import 'dart:convert';

class UserAccountInfoModel {
  UserAccountInfoModel({
    this.data,
  });

  final Data? data;

  const UserAccountInfoModel.unknown() : data = null;

  factory UserAccountInfoModel.fromJson(Map<String, dynamic> json) => UserAccountInfoModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.message,
  });

  final Message message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message(
      {this.id,
      this.userId,
      this.organizationId,
      this.partnerOrganizationId,
      this.entityId,
      this.type,
      this.status,
      this.kitNumber,
      this.accountNumber,
      this.ifsc,
      this.upiId,
      this.thresholdLimit,
      this.availableBalance,
      required this.cardPreference,
      this.createdAt,
      this.updatedAt,
      required this.cardExpiryDate,
      required this.maskedCard});

  final String? id;
  final String? userId;
  final String? organizationId;
  final String? partnerOrganizationId;
  final String? entityId;
  final String? type;
  final String? status;
  final String? kitNumber;
  final String? accountNumber;
  final String? ifsc;
  final String? upiId;
  final String? thresholdLimit;
  final String? availableBalance;
  final CardPreference cardPreference;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String maskedCard;
  final DateTime cardExpiryDate;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'organizationId': organizationId,
      'partnerOrganizationId': partnerOrganizationId,
      'entityId': entityId,
      'type': type,
      'status': status,
      'kitNumber': kitNumber,
      'accountNumber': accountNumber,
      'ifsc': ifsc,
      'upiId': upiId,
      'thresholdLimit': thresholdLimit,
      'availableBalance': availableBalance,
      'cardPreference': cardPreference.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'maskedCard': maskedCard,
      'cardExpiryDate': cardExpiryDate.millisecondsSinceEpoch
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        id: map['_id'],
        userId: map['userId'],
        organizationId: map['organizationId'],
        partnerOrganizationId: map['partnerOrganizationId'],
        entityId: map['entityId'],
        type: map['type'],
        status: map['status'],
        kitNumber: map['kitNumber'],
        accountNumber: map['accountNumber'],
        ifsc: map['IFSC'],
        upiId: map['upiId'],
        thresholdLimit: map['thresholdLimit']?.toString(),
        availableBalance: map['availableBalance']?.toString(),
        cardPreference: CardPreference.fromMap(map['cardPreference']),
        createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
        updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
        cardExpiryDate: DateTime.parse(map['cardExpiryDate']),
        maskedCard: map['maskedCard']);
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(Map<String, dynamic> source) => Message.fromMap(source);
}

class CardPreference {
  CardPreference({
    this.atm,
    this.pos,
    this.ecom,
    this.international,
    this.dcc,
    this.contactless,
    this.limitConfig,
    this.categoryLimitConfig,
  });

  final bool? atm;
  final bool? pos;
  final bool? ecom;
  final bool? international;
  final bool? dcc;
  final bool? contactless;
  final LimitConfigClass? limitConfig;
  final List<dynamic>? categoryLimitConfig;

  Map<String, dynamic> toMap() {
    return {
      'atm': atm,
      'pos': pos,
      'ecom': ecom,
      'international': international,
      'dcc': dcc,
      'contactless': contactless,
      'limitConfig': limitConfig!.toMap(),
      'categoryLimitConfig': categoryLimitConfig,
    };
  }

  factory CardPreference.fromMap(Map<String, dynamic> map) {
    return CardPreference(
      atm: map['atm'],
      pos: map['pos'],
      ecom: map['ecom'],
      international: map['international'],
      dcc: map['dcc'],
      contactless: map['contactless'],
      limitConfig: map['limitConfig'] != null ? LimitConfigClass.fromJson(map['limitConfig']) : null,
      categoryLimitConfig: List<dynamic>.from(map['categoryLimitConfig']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardPreference.fromJson(Map<String, dynamic> source) => CardPreference.fromMap(source);
}

// class LimitConfig {
//   LimitConfig({
//     this.txnType,
//     this.dailyLimitValue,
//   });

//   final String? txnType;
//   final String? dailyLimitValue;

//   Map<String, dynamic> toMap() {
//     return {
//       'txnType': txnType,
//       'dailyLimitValue': dailyLimitValue,
//     };
//   }

//   factory LimitConfig.fromMap(Map<String, dynamic> map) {
//     return LimitConfig(
//       txnType: map['txnType'],
//       dailyLimitValue: map['dailyLimitValue'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LimitConfig.fromJson(Map<String, dynamic> source) => LimitConfig.fromMap(source);
// }

class LimitConfigClass {
  LimitConfigClass({
    this.atm,
    this.pos,
    this.ecom,
  });

  final String? atm;
  final String? pos;
  final String? ecom;

  Map<String, dynamic> toMap() {
    return {
      'atm': atm,
      'pos': pos,
      'ecom': ecom,
    };
  }

  factory LimitConfigClass.fromMap(Map<String, dynamic> map) {
    return LimitConfigClass(
      atm: map['ATM'],
      pos: map['POS'],
      ecom: map['ECOM'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LimitConfigClass.fromJson(Map<String, dynamic> source) => LimitConfigClass.fromMap(source);
}
