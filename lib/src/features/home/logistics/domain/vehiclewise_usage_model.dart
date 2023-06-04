// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class VehiclewiseResponse {
  VehiclewiseUsageRespData data;
  VehiclewiseResponse({
    required this.data,
  });

  VehiclewiseResponse copyWith({
    VehiclewiseUsageRespData? data,
  }) {
    return VehiclewiseResponse(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
    };
  }

  factory VehiclewiseResponse.fromMap(Map<String, dynamic> map) {
    return VehiclewiseResponse(
      data: VehiclewiseUsageRespData.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VehiclewiseResponse.fromJson(dynamic source) =>
      VehiclewiseResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VehiclewiseResponse(data: $data)';

  @override
  bool operator ==(covariant VehiclewiseResponse other) {
    if (identical(this, other)) return true;

    return other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class VehiclewiseUsageRespData {
  VehiclewiseUsageRespMessage message;
  VehiclewiseUsageRespData({
    required this.message,
  });

  VehiclewiseUsageRespData copyWith({
    VehiclewiseUsageRespMessage? message,
  }) {
    return VehiclewiseUsageRespData(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message.toMap(),
    };
  }

  factory VehiclewiseUsageRespData.fromMap(Map<String, dynamic> map) {
    return VehiclewiseUsageRespData(
      message: VehiclewiseUsageRespMessage.fromMap(map['message'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VehiclewiseUsageRespData.fromJson(String source) =>
      VehiclewiseUsageRespData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VehiclewiseUsageRespData(message: $message)';

  @override
  bool operator ==(covariant VehiclewiseUsageRespData other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class VehiclewiseUsageRespMessage {
  final List<VehiclewiseUsageModel> docs;
  final int count;
  VehiclewiseUsageRespMessage({
    required this.docs,
    required this.count,
  }) {
    sort();
  }

  sort() {
    docs.sort(((a, b) => (a.total - b.total) > 0 ? -1 : 1));
  }

  VehiclewiseUsageRespMessage copyWith({
    List<VehiclewiseUsageModel>? docs,
    int? count,
  }) {
    return VehiclewiseUsageRespMessage(
      docs: docs ?? this.docs,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docs': docs.map((x) => x.toMap()).toList(),
      'count': count,
    };
  }

  factory VehiclewiseUsageRespMessage.fromMap(Map<String, dynamic> map) {
    return VehiclewiseUsageRespMessage(
      docs: List<VehiclewiseUsageModel>.from(
        (map['docs'] as List<dynamic>).map<VehiclewiseUsageModel>(
          (x) => VehiclewiseUsageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehiclewiseUsageRespMessage.fromJson(String source) =>
      VehiclewiseUsageRespMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VehiclewiseUsageMessage(docs: $docs, count: $count)';

  @override
  bool operator ==(covariant VehiclewiseUsageRespMessage other) {
    if (identical(this, other)) return true;

    return listEquals(other.docs, docs) && other.count == count;
  }

  @override
  int get hashCode => docs.hashCode ^ count.hashCode;
}

class VehiclewiseUsageModel {
  final String vehicleRegistrationNumber;
  final double? lqtag;
  final double? ybtag;
  final double? fuel;
  late double total;
  VehiclewiseUsageModel({
    required this.vehicleRegistrationNumber,
    this.lqtag,
    this.ybtag,
    this.fuel,
  }) {
    total = 0.0;
    total = total + (fuel == null ? 0.0 : fuel!);
    total = total + (lqtag == null ? 0.0 : lqtag!);
    total = total + (ybtag == null ? 0.0 : ybtag!);
  }

  VehiclewiseUsageModel copyWith({
    String? vehicleRegistrationNumber,
    double? lqtag,
    double? ybtag,
    double? fuel,
  }) {
    return VehiclewiseUsageModel(
      vehicleRegistrationNumber: vehicleRegistrationNumber ?? this.vehicleRegistrationNumber,
      lqtag: lqtag ?? this.lqtag,
      ybtag: ybtag ?? this.ybtag,
      fuel: fuel ?? this.fuel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicleRegistrationNumber': vehicleRegistrationNumber,
      'lqtag': lqtag,
      'ybtag': ybtag,
      'fuel': fuel,
    };
  }

  factory VehiclewiseUsageModel.fromMap(Map<String, dynamic> map) {
    return VehiclewiseUsageModel(
      vehicleRegistrationNumber: map['vehicleRegistrationNumber'] as String,
      // GOT THIS EXCEPTION :: Unhandled Exception: type 'int' is not a subtype of type 'double' in type cast
      lqtag: map['lqtag'] != null ? num.parse(map['lqtag'].toString()).toDouble() : null,
      ybtag: map['ybtag'] != null ? num.parse(map['ybtag'].toString()).toDouble() : null,
      fuel: map['fuel'] != null ? num.parse(map['fuel'].toString()).toDouble() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehiclewiseUsageModel.fromJson(String source) =>
      VehiclewiseUsageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VehiclewiseUsageModel(vehicleRegistrationNumber: $vehicleRegistrationNumber, lqtag: $lqtag, ybtag: $ybtag, fuel: $fuel)';
  }

  @override
  bool operator ==(covariant VehiclewiseUsageModel other) {
    if (identical(this, other)) return true;

    return other.vehicleRegistrationNumber == vehicleRegistrationNumber &&
        other.lqtag == lqtag &&
        other.ybtag == ybtag &&
        other.fuel == fuel;
  }

  @override
  int get hashCode {
    return vehicleRegistrationNumber.hashCode ^ lqtag.hashCode ^ ybtag.hashCode ^ fuel.hashCode;
  }
}
