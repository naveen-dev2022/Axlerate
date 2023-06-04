// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GPSValueResponseModel {
  Data data;
  GPSValueResponseModel({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
    };
  }

  factory GPSValueResponseModel.fromMap(Map<String, dynamic> map) {
    return GPSValueResponseModel(
      data: Data.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory GPSValueResponseModel.fromJson(String source) {
    return GPSValueResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}

class Data {
  Message message;
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

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Message {
  List<GPSValueResponseModelItem> details;
  Message({
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'details': details.map((x) => x.toMap()).toList(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      details: List<GPSValueResponseModelItem>.from(
        (map['details'] as List<dynamic>).map<GPSValueResponseModelItem>(
          (x) => GPSValueResponseModelItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);
}

class GPSValueResponseModelItem {
  // int trvledDist;
  int distance;
  int avgSpeed;
  int maxSpeed;
  int minSpeed;
  int engOnTime;
  int totalStops;
  int totalGPSOff;
  double fuelConsumed;
  double fuelCost;

  String timeFrom;
  String timeTo;
  double dayLat;
  double dayLng;
  int FatigueDrivingCount;
  int HarshBrakingCount;
  int SuddenAccelCount;
  int SuddenDeAccelCount;
  int SharpTurnCount;
  int OverSpeedCount;
  int DrivingScore;
  int avgStopTimeInMin;
  String IMEI;
  String logisticsOrganizationName;
  GPSValueResponseModelItem({
    // required this.trvledDist,
    required this.avgSpeed,
    required this.maxSpeed,
    required this.minSpeed,
    required this.engOnTime,
    required this.totalStops,
    required this.totalGPSOff,
    required this.fuelConsumed,
    required this.fuelCost,
    required this.timeFrom,
    required this.timeTo,
    required this.dayLat,
    required this.dayLng,
    required this.FatigueDrivingCount,
    required this.HarshBrakingCount,
    required this.SuddenAccelCount,
    required this.SuddenDeAccelCount,
    required this.SharpTurnCount,
    required this.OverSpeedCount,
    required this.DrivingScore,
    required this.distance,
    required this.avgStopTimeInMin,
    required this.IMEI,
    required this.logisticsOrganizationName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'trvledDist': trvledDist,
      'avgSpeed': avgSpeed,
      'maxSpeed': maxSpeed,
      'minSpeed': minSpeed,
      'engOnTime': engOnTime,
      'totalStops': totalStops,
      'totalGPSOff': totalGPSOff,
      'fuelConsumed': fuelConsumed,
      'fuelCost': fuelCost,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'dayLat': dayLat,
      'dayLng': dayLng,
      'FatigueDrivingCount': FatigueDrivingCount,
      'HarshBrakingCount': HarshBrakingCount,
      'SuddenAccelCount': SuddenAccelCount,
      'SuddenDeAccelCount': SuddenDeAccelCount,
      'SharpTurnCount': SharpTurnCount,
      'OverSpeedCount': OverSpeedCount,
      'DrivingScore': DrivingScore,
      'distance': distance,
      'avgStopTimeInMin': avgStopTimeInMin,
      'IMEI': IMEI,
      'logisticsOrganizationName': logisticsOrganizationName,
    };
  }

  factory GPSValueResponseModelItem.fromMap(Map<String, dynamic> map) {
    return GPSValueResponseModelItem(
      // trvledDist: map['trvledDist'] as int,
      avgSpeed: map['avgSpeed'] as int,
      maxSpeed: map['maxSpeed'] as int,
      minSpeed: map['minSpeed'] as int,
      engOnTime: map['engOnTime'] as int,
      totalStops: map['totalStops'] as int,
      totalGPSOff: map['totalGPSOff'] as int,
      fuelConsumed: num.parse(map['fuelConsumed'].toString()).toDouble(),
      fuelCost: num.parse(map['fuelCost'].toString()).toDouble(),
      timeFrom: map['timeFrom'] as String,
      timeTo: map['timeTo'] as String,
      dayLat: map['dayLat'] as double,
      dayLng: map['dayLng'] as double,
      FatigueDrivingCount: map['FatigueDrivingCount'] as int,
      HarshBrakingCount: map['HarshBrakingCount'] as int,
      SuddenAccelCount: map['SuddenAccelCount'] as int,
      SuddenDeAccelCount: map['SuddenDeAccelCount'] as int,
      SharpTurnCount: map['SharpTurnCount'] as int,
      OverSpeedCount: map['OverSpeedCount'] as int,
      DrivingScore: map['DrivingScore'] as int,
      distance: map['Distance'] as int,
      avgStopTimeInMin: map['avgStopTimeInMin'] as int,
      IMEI: map['IMEI'] as String,
      logisticsOrganizationName: map['logisticsOrganizationName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GPSValueResponseModelItem.fromJson(String source) =>
      GPSValueResponseModelItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
