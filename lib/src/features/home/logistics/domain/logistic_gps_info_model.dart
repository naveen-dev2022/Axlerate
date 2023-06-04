class LogisticsGpsInfoModel {
  LogisticsGpsInfoModel({
    required this.data,
  });

  LogisticsGpsInfoModel.unknown() : data = null;

  final Data? data;

  factory LogisticsGpsInfoModel.fromJson(Map<String, dynamic> json) {
    return LogisticsGpsInfoModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.message,
  });

  final List<LogisticsGpsInfoModelMessage> message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] == null
          ? []
          : List<LogisticsGpsInfoModelMessage>.from(
              json["message"]!.map((x) => LogisticsGpsInfoModelMessage.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.map((x) => x.toJson()).toList(),
      };
}

class LogisticsGpsInfoModelMessage {
  LogisticsGpsInfoModelMessage({
    required this.enrollmentId,
    required this.entityId,
    required this.gpsInfo,
    required this.id,
    required this.locationTime,
    required this.unixTime,
    required this.unixTimeInMiliSecond,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.batteryPercent,
    required this.isIgnitionOn,
    required this.fuelcut,
    required this.mileage,
    required this.imei,
    required this.gprsConnected,
    required this.weakGps,
    required this.aircondition,
    required this.alarm,
    required this.vehicleNo,
    required this.clientName,
    required this.ignitionChangeTime,
    required this.odoMeter,
    required this.location,
    required this.direction,
    required this.deviceStatus,
    required this.fuelPer,
  });

  final String enrollmentId;
  final String entityId;
  final GpsInfo? gpsInfo;
  final String id;
  final DateTime? locationTime;
  final int unixTime;
  final int unixTimeInMiliSecond;
  final String latitude;
  final String longitude;
  final int speed;
  final int batteryPercent;
  final bool isIgnitionOn;
  final bool fuelcut;
  final int mileage;
  final String imei;
  final bool gprsConnected;
  final bool weakGps;
  final bool aircondition;
  final String alarm;
  final String vehicleNo;
  final String clientName;
  final DateTime? ignitionChangeTime;
  final int odoMeter;
  final String location;
  final int direction;
  final String deviceStatus;
  final int fuelPer;

  factory LogisticsGpsInfoModelMessage.fromJson(Map<String, dynamic> json) {
    return LogisticsGpsInfoModelMessage(
      enrollmentId: json["enrollmentId"] ?? "",
      entityId: json["entityId"] ?? "",
      gpsInfo: json["gpsInfo"] == null ? null : GpsInfo.fromJson(json["gpsInfo"]),
      id: json["_id"] ?? "",
      locationTime: json["LocationTime"] == null ? null : DateTime.parse(json["LocationTime"]),
      unixTime: json["UnixTime"] ?? 0,
      unixTimeInMiliSecond: json["UnixTimeInMiliSecond"] ?? 0,
      latitude: json["Latitude"] ?? "",
      longitude: json["longitude"] ?? "",
      speed: json["Speed"] ?? 0,
      batteryPercent: json["BatteryPercent"] ?? 0,
      isIgnitionOn: json["IsIgnitionOn"] ?? false,
      fuelcut: json["Fuelcut"] ?? false,
      mileage: json["Mileage"] ?? 0,
      imei: json["IMEI"] ?? "",
      gprsConnected: json["GPRSConnected"] ?? false,
      weakGps: json["WeakGPS"] ?? false,
      aircondition: json["Aircondition"] ?? false,
      alarm: json["Alarm"] ?? "",
      vehicleNo: json["VehicleNo"] ?? "",
      clientName: json["ClientName"] ?? "",
      ignitionChangeTime: json["IgnitionChangeTime"] == null ? null : DateTime.parse(json["IgnitionChangeTime"]),
      odoMeter: json["OdoMeter"] ?? 0,
      location: json["Location"] ?? "",
      direction: json["Direction"] ?? 0,
      deviceStatus: json["DeviceStatus"] ?? "",
      fuelPer: json["fuelPer"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "enrollmentId": enrollmentId,
        "entityId": entityId,
        "gpsInfo": gpsInfo?.toJson(),
        "_id": id,
        "LocationTime": locationTime?.toIso8601String(),
        "UnixTime": unixTime,
        "UnixTimeInMiliSecond": unixTimeInMiliSecond,
        "Latitude": latitude,
        "longitude": longitude,
        "Speed": speed,
        "BatteryPercent": batteryPercent,
        "IsIgnitionOn": isIgnitionOn,
        "Fuelcut": fuelcut,
        "Mileage": mileage,
        "IMEI": imei,
        "GPRSConnected": gprsConnected,
        "WeakGPS": weakGps,
        "Aircondition": aircondition,
        "Alarm": alarm,
        "VehicleNo": vehicleNo,
        "ClientName": clientName,
        "IgnitionChangeTime": ignitionChangeTime?.toIso8601String(),
        "OdoMeter": odoMeter,
        "Location": location,
        "Direction": direction,
        "DeviceStatus": deviceStatus,
        "fuelPer": fuelPer,
      };
}

class GpsInfo {
  GpsInfo({
    required this.imei,
    required this.kycDocuments,
    required this.status,
  });

  final String imei;
  final KycDocuments? kycDocuments;
  final String status;

  factory GpsInfo.fromJson(Map<String, dynamic> json) {
    return GpsInfo(
      imei: json["imei"] ?? "",
      kycDocuments: json["kycDocuments"] == null ? null : KycDocuments.fromJson(json["kycDocuments"]),
      status: json["status"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "imei": imei,
        "kycDocuments": kycDocuments?.toJson(),
        "status": status,
      };
}

class KycDocuments {
  KycDocuments({
    required this.rcBookImage,
    required this.otherProof1,
  });

  final OtherProof1? rcBookImage;
  final OtherProof1? otherProof1;

  factory KycDocuments.fromJson(Map<String, dynamic> json) {
    return KycDocuments(
      rcBookImage: json["RC_BOOK_IMAGE"] == null ? null : OtherProof1.fromJson(json["RC_BOOK_IMAGE"]),
      otherProof1: json["OTHER_PROOF1"] == null ? null : OtherProof1.fromJson(json["OTHER_PROOF1"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "RC_BOOK_IMAGE": rcBookImage?.toJson(),
        "OTHER_PROOF1": otherProof1?.toJson(),
      };
}

class OtherProof1 {
  OtherProof1({
    required this.documentNo,
    required this.documentExpiry,
    required this.url,
    required this.docUploadStatus,
  });

  final String documentNo;
  final DateTime? documentExpiry;
  final String url;
  final String docUploadStatus;

  factory OtherProof1.fromJson(Map<String, dynamic> json) {
    return OtherProof1(
      documentNo: json["documentNo"] ?? "",
      documentExpiry: json["documentExpiry"] == null ? null : DateTime.parse(json["documentExpiry"]),
      url: json["url"] ?? "",
      docUploadStatus: json["docUploadStatus"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "documentNo": documentNo,
        "documentExpiry": documentExpiry?.toIso8601String(),
        "url": url,
        "docUploadStatus": docUploadStatus,
      };
}

class LogisticsGpsInfoStateProvider {
  String orgId;
  LogisticsGpsInfoModel data;
  late DateTime modifiedAt;

  LogisticsGpsInfoStateProvider({
    required this.orgId,
    required this.data,
  }) {
    modifiedAt = DateTime.now();
  }
}
