import 'dart:convert';
import 'package:axlerate/src/features/home/gps/data/gps_device_model.dart';

class GpsDeviceListModel {
  final Data? data;

  const GpsDeviceListModel.unknown() : data = null;

  GpsDeviceListModel({
    required this.data,
  });

  factory GpsDeviceListModel.fromMap(Map<String, dynamic> map) {
    return GpsDeviceListModel(
      data: Data.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  factory GpsDeviceListModel.fromJson(Map<String, dynamic> json) => GpsDeviceListModel(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final Message message;
  Data({
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message.toMap(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      message: Message.fromMap(map['message'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: Message.fromJson(json['message']),
      );
}

class Message {
  final List<GpsDevice> docs;
  final int count;

  Message({
    required this.docs,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docs': docs.map((x) => x.toMap()).toList(),
      'count': count,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      docs: List<GpsDevice>.from(
        (map['docs'] as List<int>).map<GpsDevice>(
          (x) => GpsDevice.fromMap(x as Map<String, dynamic>),
        ),
      ),
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(Map<String, dynamic> json) {
    // log('Message');
    return Message(
      docs: json["docs"] == null ? [] : List<GpsDevice>.from(json["docs"]!.map((x) => GpsDevice.fromMap(x))),
      count: json["count"] ?? 0,
    );
  }
}
