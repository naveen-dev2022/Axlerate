// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FundTransferModelC2C {
  final String organizationEnrollmentId;
  final String fromUserEnrollmentId;
  final String toUserEnrollmentId;
  final double amount;
  final String description;

  FundTransferModelC2C({
    required this.organizationEnrollmentId,
    required this.fromUserEnrollmentId,
    required this.toUserEnrollmentId,
    required this.amount,
    required this.description,
  });

  FundTransferModelC2C copyWith({
    String? organizationEnrollmentId,
    String? fromUserEnrollmentId,
    String? toUserEnrollmentId,
    double? amount,
    String? description,
  }) {
    return FundTransferModelC2C(
      organizationEnrollmentId: organizationEnrollmentId ?? this.organizationEnrollmentId,
      fromUserEnrollmentId: fromUserEnrollmentId ?? this.fromUserEnrollmentId,
      toUserEnrollmentId: toUserEnrollmentId ?? this.toUserEnrollmentId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'organizationEnrollmentId': organizationEnrollmentId,
      'fromUserEnrollmentId': fromUserEnrollmentId,
      'toUserEnrollmentId': toUserEnrollmentId,
      'amount': amount,
      'description': description,
    };
  }

  factory FundTransferModelC2C.fromMap(Map<String, dynamic> map) {
    return FundTransferModelC2C(
      organizationEnrollmentId: map['organizationEnrollmentId'] as String,
      fromUserEnrollmentId: map['fromUserEnrollmentId'] as String,
      toUserEnrollmentId: map['toUserEnrollmentId'] as String,
      amount: map['amount'] as double,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FundTransferModelC2C.fromJson(String source) =>
      FundTransferModelC2C.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FundTransferModelC2C(organizationEnrollmentId: $organizationEnrollmentId, fromUserEnrollmentId: $fromUserEnrollmentId, toUserEnrollmentId: $toUserEnrollmentId, amount: $amount, description: $description)';
  }
}
