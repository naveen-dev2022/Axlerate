// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FundTransferModelP2C {
  final String organizationEnrollmentId;
  final String userEnrollmentId;
  final String userEntityId;
  final double amount;
  final String description;

  FundTransferModelP2C({
    required this.organizationEnrollmentId,
    required this.userEnrollmentId,
    required this.userEntityId,
    required this.amount,
    required this.description,
  });

  FundTransferModelP2C copyWith({
    String? organizationEnrollmentId,
    String? userEnrollmentId,
    String? userEntityId,
    double? amount,
    String? description,
  }) {
    return FundTransferModelP2C(
      organizationEnrollmentId: organizationEnrollmentId ?? this.organizationEnrollmentId,
      userEnrollmentId: userEnrollmentId ?? this.userEnrollmentId,
      userEntityId: userEntityId ?? this.userEntityId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'organizationEnrollmentId': organizationEnrollmentId,
      'userEnrollmentId': userEnrollmentId,
      'userEntityId': userEntityId,
      'amount': amount,
      'description': description,
    };
  }

  factory FundTransferModelP2C.fromMap(Map<String, dynamic> map) {
    return FundTransferModelP2C(
      organizationEnrollmentId: map['organizationEnrollmentId'] as String,
      userEnrollmentId: map['userEnrollmentId'] as String,
      userEntityId: map['userEntityId'] as String,
      amount: map['amount'] as double,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FundTransferModelP2C.fromJson(String source) =>
      FundTransferModelP2C.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FundTransferModelP2C(organizationEnrollmentId: $organizationEnrollmentId, userEnrollmentId: $userEnrollmentId, userEntityId: $userEntityId, amount: $amount, description: $description)';
  }
}
