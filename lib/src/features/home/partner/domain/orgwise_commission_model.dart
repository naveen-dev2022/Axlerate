// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrgwiseCommissionResponse {
  OrgCommissionResData data;
  OrgwiseCommissionResponse({
    required this.data,
  });

  OrgwiseCommissionResponse copyWith({
    OrgCommissionResData? data,
  }) {
    return OrgwiseCommissionResponse(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
    };
  }

  factory OrgwiseCommissionResponse.fromMap(Map<String, dynamic> map) {
    return OrgwiseCommissionResponse(
      data: OrgCommissionResData.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrgwiseCommissionResponse.fromJson(String source) =>
      OrgwiseCommissionResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrgwiseCommissionResponse(data: $data)';
}

class OrgCommissionResData {
  OrgwiseCommissionResponseMessage message;
  OrgCommissionResData({
    required this.message,
  });

  OrgCommissionResData copyWith({
    OrgwiseCommissionResponseMessage? message,
  }) {
    return OrgCommissionResData(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message.toMap(),
    };
  }

  factory OrgCommissionResData.fromMap(Map<String, dynamic> map) {
    return OrgCommissionResData(
      message: OrgwiseCommissionResponseMessage.fromMap(map['message'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrgCommissionResData.fromJson(String source) =>
      OrgCommissionResData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrgwiseCommissionResponseData(message: $message)';
}

class OrgwiseCommissionResponseMessage {
  List<OrgwiseCommission?> docs;
  int count;
  OrgwiseCommissionResponseMessage({
    required this.docs,
    required this.count,
  }) {
    if (docs.length > 1) sort();
  }

  sort() {
    docs.sort(((a, b) => a!.total > b!.total ? -1 : 1));
  }

  OrgwiseCommissionResponseMessage copyWith({
    List<OrgwiseCommission?>? docs,
    int? count,
  }) {
    return OrgwiseCommissionResponseMessage(
      docs: docs ?? this.docs,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docs': docs.map((x) => x?.toMap()).toList(),
      'count': count,
    };
  }

  factory OrgwiseCommissionResponseMessage.fromMap(Map<String, dynamic> map) {
    return OrgwiseCommissionResponseMessage(
      docs: List<OrgwiseCommission?>.from(
        (map['docs'] as List<dynamic>).map<OrgwiseCommission?>(
          (x) => OrgwiseCommission.fromMap(x as Map<String, dynamic>),
        ),
      ),
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrgwiseCommissionResponseMessage.fromJson(String source) =>
      OrgwiseCommissionResponseMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrgwiseCommissionResponseMessage(docs: $docs, count: $count)';

  @override
  bool operator ==(covariant OrgwiseCommissionResponseMessage other) {
    if (identical(this, other)) return true;

    return listEquals(other.docs, docs) && other.count == count;
  }

  @override
  int get hashCode => docs.hashCode ^ count.hashCode;
}

class OrgwiseCommission {
  final LogisticsInfo logisticsOrg;
  final num? ppi;
  final num? lqTag;
  final num? ybTag;
  late num total;
  OrgwiseCommission({
    required this.logisticsOrg,
    this.ppi,
    this.lqTag,
    this.ybTag,
  }) {
    total = 0.0;
    total = total + (ppi == null ? 0.0 : ppi!);
    total = total + (lqTag == null ? 0.0 : lqTag!);
    total = total + (ybTag == null ? 0.0 : ybTag!);
  }

  // double get total {
  //   double total = 0.0;
  //   total = total + (ppi == null ? 0.0 : ppi!.toDouble());
  //   total = total + (lqTag == null ? 0.0 : lqTag!.toDouble());

  //   total = total + (ybTag == null ? 0.0 : ybTag!.toDouble());

  //   return total;
  // }

  OrgwiseCommission copyWith({
    LogisticsInfo? logisticsOrg,
    num? ppi,
    num? lqTag,
    num? ybTag,
  }) {
    return OrgwiseCommission(
      logisticsOrg: logisticsOrg ?? this.logisticsOrg,
      ppi: ppi ?? this.ppi,
      lqTag: lqTag ?? this.lqTag,
      ybTag: ybTag ?? this.ybTag,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logisticsOrg': logisticsOrg.toMap(),
      'ppi': ppi,
      'lqTag': lqTag,
      'ybTag': ybTag,
    };
  }

  factory OrgwiseCommission.fromMap(Map<String, dynamic> map) {
    return OrgwiseCommission(
      logisticsOrg: LogisticsInfo.fromMap(map['logisticsOrg'] as Map<String, dynamic>),
      ppi: map['ppi'],
      lqTag: map['lqTag'],
      ybTag: map['ybTag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrgwiseCommission.fromJson(String source) =>
      OrgwiseCommission.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrgwiseCommission(logisticsOrg: $logisticsOrg, ppi: $ppi, lqTag: $lqTag, ybTag: $ybTag)';
  }
}

class LogisticsInfo {
  final String firstName;
  final String lastName;
  final String enrollmentId;
  final String? logo;
  LogisticsInfo({
    required this.firstName,
    required this.lastName,
    required this.enrollmentId,
    this.logo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'enrollmentId': enrollmentId,
      'logo': logo,
    };
  }

  factory LogisticsInfo.fromMap(Map<String, dynamic> map) {
    return LogisticsInfo(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      enrollmentId: map['enrollmentId'] as String,
      logo: map['logo'] != null ? map['logo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogisticsInfo.fromJson(String source) => LogisticsInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LogisticsInfo(firstName: $firstName, lastName: $lastName, enrollmentId: $enrollmentId, logo: $logo)';
  }
}
