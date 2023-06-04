import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VehicleGPSAccountInfoModel {
  Data? data;

  VehicleGPSAccountInfoModel({this.data});

  VehicleGPSAccountInfoModel.unknown() : data = null;

  VehicleGPSAccountInfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Message? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  VehicelGpsInfo? vehicelGpsInfo;

  Message({this.vehicelGpsInfo});

  Message.fromJson(Map<String, dynamic> json) {
    vehicelGpsInfo = json['vehicelGpsInfo'] != null ? VehicelGpsInfo.fromJson(json['vehicelGpsInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (vehicelGpsInfo != null) {
      data['vehicelGpsInfo'] = vehicelGpsInfo!.toJson();
    }
    return data;
  }
}

class VehicelGpsInfo {
  String? sId;
  String? imei;
  String? status;
  String? issuer;
  String? vendor;
  String? type;
  bool? immobilize;
  int? speedLimit;
  GpsNotifications? notifications;
  int? iV;
  String? createdAt;
  String? updatedAt;
  String? logisticsOrganization;
  String? logisticsOrganizationEnrollmentId;
  VehicleInfo? vehicleInfo;
  List<String>? notificationUsers;

  VehicelGpsInfo(
      {this.sId,
      this.imei,
      this.status,
      this.issuer,
      this.vendor,
      this.type,
      this.immobilize,
      this.notifications,
      this.iV,
      this.createdAt,
      this.updatedAt,
      this.logisticsOrganization,
      this.logisticsOrganizationEnrollmentId,
      this.vehicleInfo,
      this.notificationUsers,
      this.speedLimit});

  VehicelGpsInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    imei = json['imei'];
    status = json['status'];
    issuer = json['issuer'];
    vendor = json['vendor'];
    type = json['type'];
    immobilize = json['immobilize'];
    speedLimit = json['speedLimit'];
    notifications = json['notifications'] != null ? GpsNotifications.fromMap(json['notifications']) : null;
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    logisticsOrganization = json['logisticsOrganization'];
    logisticsOrganizationEnrollmentId = json['logisticsOrganizationEnrollmentId'];
    vehicleInfo = json['vehicleInfo'] != null ? VehicleInfo.fromMap(json['vehicleInfo']) : null;
    notificationUsers =
        json['notificationUsers'] != null ? List<String>.from(json["notificationUsers"].map((x) => x)) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['imei'] = imei;
    data['status'] = status;
    data['issuer'] = issuer;
    data['vendor'] = vendor;
    data['type'] = type;
    data['immobilize'] = immobilize;
    data['speedLimit'] = speedLimit;
    if (notifications != null) {
      data['notifications'] = notifications!.toJson();
    }
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['logisticsOrganization'] = logisticsOrganization;
    data['logisticsOrganizationEnrollmentId'] = logisticsOrganizationEnrollmentId;
    if (vehicleInfo != null) {
      data['vehicleInfo'] = vehicleInfo!.toJson();
    }
    return data;
  }
}

class GpsNotifications {
  bool speedAlert;
  bool ignitionAlert;
  bool engineCutRestoreAlert;
  bool powerDisconnectAlert;
  bool lowBatteryAlert;
  bool antiTheftAlert;
  bool noGpsSignalAlert;
  bool parkingAlarmAlert;
  bool acOnOffAlert;
  bool driverBehaviourAlert;
  bool temperatureAlert;

  // bool? zoneAlert;
  // String? sId;

  GpsNotifications({
    required this.speedAlert,
    required this.ignitionAlert,
    required this.engineCutRestoreAlert,
    required this.powerDisconnectAlert,
    required this.lowBatteryAlert,
    required this.antiTheftAlert,
    required this.noGpsSignalAlert,
    required this.parkingAlarmAlert,
    required this.acOnOffAlert,
    required this.driverBehaviourAlert,
    required this.temperatureAlert,
    // this.sId
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'speedAlert': speedAlert,
      'parkingAlarmAlert': parkingAlarmAlert,
      'powerDisconnectAlert': powerDisconnectAlert,
      'ignitionAlert': ignitionAlert,
      'acOnOffAlert': acOnOffAlert,
      'antiTheftAlert': antiTheftAlert,
      // 'sId': sId,
      'engineCutRestoreAlert': engineCutRestoreAlert,
      'lowBatteryAlert': lowBatteryAlert,
      'noGpsSignalAlert': noGpsSignalAlert,
      'driverBehaviourAlert': driverBehaviourAlert,
      'temperatureAlert': temperatureAlert,
    };
  }

  factory GpsNotifications.fromMap(Map<String, dynamic> map) {
    return GpsNotifications(
      // zoneAlert: map['zoneAlert'] != null ? map['zoneAlert'] as bool : null,
      parkingAlarmAlert: map['parkingAlarmAlert'] != null ? map['parkingAlarmAlert'] as bool : false,
      speedAlert: map['speedAlert'] != null ? map['speedAlert'] as bool : false,
      powerDisconnectAlert: map['powerDisconnectAlert'] != null ? map['powerDisconnectAlert'] as bool : false,
      ignitionAlert: map['ignitionAlert'] != null ? map['ignitionAlert'] as bool : false,
      acOnOffAlert: map['acOnOffAlert'] != null ? map['acOnOffAlert'] as bool : false,
      antiTheftAlert: map['antiTheftAlert'] != null ? map['antiTheftAlert'] as bool : false,
      // sId: map['sId'] != null ? map['sId'] as String : null,
      engineCutRestoreAlert: map['engineCutRestoreAlert'] != null ? map['engineCutRestoreAlert'] as bool : false,
      lowBatteryAlert: map['lowBatteryAlert'] != null ? map['lowBatteryAlert'] as bool : false,
      noGpsSignalAlert: map['noGpsSignalAlert'] != null ? map['noGpsSignalAlert'] as bool : false,
      driverBehaviourAlert: map['driverBehaviourAlert'] != null ? map['driverBehaviourAlert'] as bool : false,
      temperatureAlert: map['temperatureAlert'] != null ? map['temperatureAlert'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory GpsNotifications.fromJson(String source) =>
      GpsNotifications.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GpsNotifications(speedAlert: $speedAlert, ignitionAlert: $ignitionAlert, engineCutRestoreAlert: $engineCutRestoreAlert, powerDisconnectAlert: $powerDisconnectAlert, lowBatteryAlert: $lowBatteryAlert, antiTheftAlert: $antiTheftAlert, noGpsSignalAlert: $noGpsSignalAlert, parkingAlarmAlert: $parkingAlarmAlert, acOnOffAlert: $acOnOffAlert, driverBehaviourAlert: $driverBehaviourAlert, temperatureAlert: $temperatureAlert)';
  }
}

class VehicleInfo {
  String? vehicleEnrollmentId;
  String? vehicleEntityId;

  VehicleInfo({this.vehicleEnrollmentId, this.vehicleEntityId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicleEnrollmentId': vehicleEnrollmentId,
      'vehicleEntityId': vehicleEntityId,
    };
  }

  factory VehicleInfo.fromMap(Map<String, dynamic> map) {
    return VehicleInfo(
      vehicleEnrollmentId: map['vehicleEnrollmentId'] != null ? map['vehicleEnrollmentId'] as String : null,
      vehicleEntityId: map['vehicleEntityId'] != null ? map['vehicleEntityId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleInfo.fromJson(String source) => VehicleInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
