import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VehicleGPSInfoModel {
  Data? data;

  VehicleGPSInfoModel({this.data});

  VehicleGPSInfoModel.unknown() : data = null;

  VehicleGPSInfoModel.fromJson(Map<String, dynamic> json) {
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
  GpsInfo? gpsInfo;
  VehicelGpsInfo? vehicelGpsInfo;

  Message({this.gpsInfo, this.vehicelGpsInfo});

  Message.fromJson(Map<String, dynamic> json) {
    gpsInfo = json['gpsInfo'] != null ? GpsInfo.fromJson(json['gpsInfo']) : null;
    vehicelGpsInfo = json['vehicelGpsInfo'] != null ? VehicelGpsInfo.fromJson(json['vehicelGpsInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gpsInfo != null) {
      data['gpsInfo'] = gpsInfo!.toJson();
    }
    if (vehicelGpsInfo != null) {
      data['vehicelGpsInfo'] = vehicelGpsInfo!.toJson();
    }
    return data;
  }
}

class GpsInfo {
  String? locationTime;
  int? unixTime;
  int? unixTimeInMiliSecond;
  String? latitude;
  String? longitude;
  int? speed;
  int? batteryPercent;
  bool? isIgnitionOn;
  bool? fuelcut;
  int? mileage;
  String? iMEI;
  bool? gPRSConnected;
  bool? weakGPS;
  bool? aircondition;
  String? alarm;
  String? vehicleNo;
  String? clientName;
  String? ignitionChangeTime;
  int? odoMeter;
  String? location;
  int? direction;
  String? deviceStatus;
  int? fuelPer;

  GpsInfo(
      {this.locationTime,
      this.unixTime,
      this.unixTimeInMiliSecond,
      this.latitude,
      this.longitude,
      this.speed,
      this.batteryPercent,
      this.isIgnitionOn,
      this.fuelcut,
      this.mileage,
      this.iMEI,
      this.gPRSConnected,
      this.weakGPS,
      this.aircondition,
      this.alarm,
      this.vehicleNo,
      this.clientName,
      this.ignitionChangeTime,
      this.odoMeter,
      this.location,
      this.direction,
      this.deviceStatus,
      this.fuelPer});

  GpsInfo.fromJson(Map<String, dynamic> json) {
    locationTime = json['LocationTime'];
    unixTime = json['UnixTime'];
    unixTimeInMiliSecond = json['UnixTimeInMiliSecond'];
    latitude = json['Latitude'];
    longitude = json['longitude'];
    speed = json['Speed'];
    batteryPercent = json['BatteryPercent'];
    isIgnitionOn = json['IsIgnitionOn'];
    fuelcut = json['Fuelcut'];
    mileage = json['Mileage'];
    iMEI = json['IMEI'];
    gPRSConnected = json['GPRSConnected'];
    weakGPS = json['WeakGPS'];
    aircondition = json['Aircondition'];
    alarm = json['Alarm'];
    vehicleNo = json['VehicleNo'];
    clientName = json['ClientName'];
    ignitionChangeTime = json['IgnitionChangeTime'];
    odoMeter = json['OdoMeter'];
    location = json['Location'];
    direction = json['Direction'];
    deviceStatus = json['DeviceStatus'];
    fuelPer = json['fuelPer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LocationTime'] = locationTime;
    data['UnixTime'] = unixTime;
    data['UnixTimeInMiliSecond'] = unixTimeInMiliSecond;
    data['Latitude'] = latitude;
    data['longitude'] = longitude;
    data['Speed'] = speed;
    data['BatteryPercent'] = batteryPercent;
    data['IsIgnitionOn'] = isIgnitionOn;
    data['Fuelcut'] = fuelcut;
    data['Mileage'] = mileage;
    data['IMEI'] = iMEI;
    data['GPRSConnected'] = gPRSConnected;
    data['WeakGPS'] = weakGPS;
    data['Aircondition'] = aircondition;
    data['Alarm'] = alarm;
    data['VehicleNo'] = vehicleNo;
    data['ClientName'] = clientName;
    data['IgnitionChangeTime'] = ignitionChangeTime;
    data['OdoMeter'] = odoMeter;
    data['Location'] = location;
    data['Direction'] = direction;
    data['DeviceStatus'] = deviceStatus;
    data['fuelPer'] = fuelPer;
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
  GpsNotifications? notifications;
  int? iV;
  String? createdAt;
  String? updatedAt;
  String? logisticsOrganization;
  String? logisticsOrganizationEnrollmentId;
  VehicleInfo? vehicleInfo;

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
      this.vehicleInfo});

  VehicelGpsInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    imei = json['imei'];
    status = json['status'];
    issuer = json['issuer'];
    vendor = json['vendor'];
    type = json['type'];
    immobilize = json['immobilize'];
    notifications = json['notifications'] != null ? GpsNotifications.fromJson(json['notifications']) : null;
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    logisticsOrganization = json['logisticsOrganization'];
    logisticsOrganizationEnrollmentId = json['logisticsOrganizationEnrollmentId'];
    vehicleInfo = json['vehicleInfo'] != null ? VehicleInfo.fromJson(json['vehicleInfo']) : null;
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
  bool unplugDeviceAlert;
  bool lowBatteryAlert;
  bool antiTheftAlert;
  bool noGpsSignalAlert;
  bool parkingAlert;
  bool acOnOffAlert;
  bool driverBehaviourAlert;
  bool temperatureAlert;

  // bool? zoneAlert;
  String? sId;

  GpsNotifications(
      {required this.speedAlert,
      required this.ignitionAlert,
      required this.engineCutRestoreAlert,
      required this.unplugDeviceAlert,
      required this.lowBatteryAlert,
      required this.antiTheftAlert,
      required this.noGpsSignalAlert,
      required this.parkingAlert,
      required this.acOnOffAlert,
      required this.driverBehaviourAlert,
      required this.temperatureAlert,
      this.sId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'speedAlert': speedAlert,
      'parkingAlert': parkingAlert,
      'unplugDeviceAlert': unplugDeviceAlert,
      'ignitionAlert': ignitionAlert,
      'acOnOffAlert': acOnOffAlert,
      'antiTheftAlert': antiTheftAlert,
      'sId': sId,
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
      parkingAlert: map['parkingAlert'] != null ? map['parkingAlert'] as bool : false,
      speedAlert: map['speedAlert'] != null ? map['speedAlert'] as bool : false,
      unplugDeviceAlert: map['unplugDeviceAlert'] != null ? map['unplugDeviceAlert'] as bool : false,
      ignitionAlert: map['ignitionAlert'] != null ? map['ignitionAlert'] as bool : false,
      acOnOffAlert: map['acOnOffAlert'] != null ? map['acOnOffAlert'] as bool : false,
      antiTheftAlert: map['antiTheftAlert'] != null ? map['antiTheftAlert'] as bool : false,
      sId: map['sId'] != null ? map['sId'] as String : null,
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
    return 'GpsNotifications(speedAlert: $speedAlert, ignitionAlert: $ignitionAlert, engineCutRestoreAlert: $engineCutRestoreAlert, unplugDeviceAlert: $unplugDeviceAlert, lowBatteryAlert: $lowBatteryAlert, antiTheftAlert: $antiTheftAlert, noGpsSignalAlert: $noGpsSignalAlert, parkingAlert: $parkingAlert, acOnOffAlert: $acOnOffAlert, driverBehaviourAlert: $driverBehaviourAlert, temperatureAlert: $temperatureAlert, sId: $sId)';
  }
}

class VehicleInfo {
  String? vehicleEnrollmentId;
  String? vehicleEntityId;

  VehicleInfo({this.vehicleEnrollmentId, this.vehicleEntityId});

  VehicleInfo.fromJson(Map<String, dynamic> json) {
    vehicleEnrollmentId = json['vehicleEnrollmentId'];
    vehicleEntityId = json['vehicleEntityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicleEnrollmentId'] = vehicleEnrollmentId;
    data['vehicleEntityId'] = vehicleEntityId;
    return data;
  }
}
