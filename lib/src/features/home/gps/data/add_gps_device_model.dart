// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:axlerate/src/features/home/gps/data/gps_device_model.dart';

class AddGpsDevicesModel {
  List<AddGpsDeviceItemModel> devices;
  AddGpsDevicesModel({
    required this.devices,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'devices': devices.map((x) => x.toMap()).toList(),
    };
  }

  factory AddGpsDevicesModel.fromMap(Map<String, dynamic> map) {
    return AddGpsDevicesModel(
      devices: List<AddGpsDeviceItemModel>.from(
        (map['devices'] as List<int>).map<AddGpsDeviceItemModel>(
          (x) => AddGpsDeviceItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddGpsDevicesModel.fromJson(String source) =>
      AddGpsDevicesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddGpsDeviceItemModel {
  String imei;
  GpsDeviceType type;
  AddGpsDeviceItemModel({
    required this.imei,
    required this.type,
  }) : assert(imei.length == 15, 'Imei should be 15 digits');

  AddGpsDeviceItemModel copyWith({
    String? imei,
    GpsDeviceType? type,
  }) {
    return AddGpsDeviceItemModel(
      imei: imei ?? this.imei,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imei': imei,
      'type': type.apiText,
    };
  }

  factory AddGpsDeviceItemModel.fromMap(Map<String, dynamic> map) {
    return AddGpsDeviceItemModel(
      imei: map['imei'] as String,
      type: map['type'] as GpsDeviceType,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddGpsDeviceItemModel.fromJson(String source) =>
      AddGpsDeviceItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AddGpsDeviceItemModel(imei: $imei, type: $type)';

  @override
  bool operator ==(covariant AddGpsDeviceItemModel other) {
    if (identical(this, other)) return true;

    return other.imei == imei && other.type == type;
  }

  @override
  int get hashCode => imei.hashCode ^ type.hashCode;
}
