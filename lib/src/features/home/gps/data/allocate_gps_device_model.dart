// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AllocateGpsDeviceModel {
  List<AllocateGpsDeviceItemModel> devices;
  String organizationId;
  AllocateGpsDeviceModel({
    required this.devices,
    required this.organizationId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'devices': devices.map((x) => x.toMap()).toList(),
      'organizationId': organizationId,
    };
  }

  factory AllocateGpsDeviceModel.fromMap(Map<String, dynamic> map) {
    return AllocateGpsDeviceModel(
      devices: List<AllocateGpsDeviceItemModel>.from(
        (map['devices'] as List<int>).map<AllocateGpsDeviceItemModel>(
          (x) => AllocateGpsDeviceItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      organizationId: map['organizationId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllocateGpsDeviceModel.fromJson(String source) =>
      AllocateGpsDeviceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class AllocateGpsDeviceItemModel {
  String imei;
  AllocateGpsDeviceItemModel({
    required this.imei,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imei': imei,
    };
  }

  factory AllocateGpsDeviceItemModel.fromMap(Map<String, dynamic> map) {
    return AllocateGpsDeviceItemModel(
      imei: map['imei'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllocateGpsDeviceItemModel.fromJson(String source) =>
      AllocateGpsDeviceItemModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
