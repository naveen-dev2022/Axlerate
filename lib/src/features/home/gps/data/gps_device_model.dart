import 'dart:convert';

enum GpsDeviceType { basic, premium }

extension GpsDeviceTypeExtension on GpsDeviceType {
  static const names = {
    GpsDeviceType.basic: 'Basic',
    GpsDeviceType.premium: 'Premium',
  };

  static const apiNames = {
    GpsDeviceType.basic: 'BASIC',
    GpsDeviceType.premium: 'PREMIUM',
  };

  String get text => names[this]!;
  String get apiText => apiNames[this]!;
}

enum GpsDeviceStatus { available, allotted, pending_install, installed, unallotted }

extension GpsDeviceStatusExtension on GpsDeviceStatus {
  static const names = {
    GpsDeviceStatus.available: 'Available',
    GpsDeviceStatus.allotted: 'Allotted',
    GpsDeviceStatus.pending_install: 'Installation Pending',
    GpsDeviceStatus.installed: 'Active',
    GpsDeviceStatus.unallotted: "Unallotted"
  };

  String get text => names[this]!;
}

class GpsVehicleInfo {
  String vehicleEnrollmentId;
  String vehicleEntityId;
  GpsVehicleInfo({
    required this.vehicleEnrollmentId,
    required this.vehicleEntityId,
  });

  GpsVehicleInfo copyWith({
    String? vehicleEnrollmentId,
    String? vehicleEntityId,
  }) {
    return GpsVehicleInfo(
      vehicleEnrollmentId: vehicleEnrollmentId ?? this.vehicleEnrollmentId,
      vehicleEntityId: vehicleEntityId ?? this.vehicleEntityId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicleEnrollmentId': vehicleEnrollmentId,
      'vehicleEntityId': vehicleEntityId,
    };
  }

  factory GpsVehicleInfo.fromMap(Map<String, dynamic> map) {
    return GpsVehicleInfo(
      vehicleEnrollmentId: map['vehicleEnrollmentId'] ?? '',
      vehicleEntityId: map['vehicleEntityId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GpsVehicleInfo.fromJson(String source) => GpsVehicleInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GpsVehicleInfo(vehicleEnrollmentId: $vehicleEnrollmentId, vehicleEntityId: $vehicleEntityId)';

  @override
  bool operator ==(covariant GpsVehicleInfo other) {
    if (identical(this, other)) return true;

    return other.vehicleEnrollmentId == vehicleEnrollmentId && other.vehicleEntityId == vehicleEntityId;
  }

  @override
  int get hashCode => vehicleEnrollmentId.hashCode ^ vehicleEntityId.hashCode;
}

class GpsDevice {
  String imei;
  GpsDeviceType type;
  GpsDeviceStatus status;
  bool? isSelected;
  // late String statusString;

  String? logisticsOrg;
  String? logisticsOrgEnrollmentId;

  GpsVehicleInfo? vehicleInfo;
  GpsDevice(
      {required this.imei,
      required this.type,
      required this.status,
      this.logisticsOrg,
      this.logisticsOrgEnrollmentId,
      this.vehicleInfo,
      this.isSelected = false});
  // : assert(
  //           (status == GpsDeviceStatus.available && logisticsOrg == null) ||
  //               (status != GpsDeviceStatus.available && logisticsOrg != null),
  //           "Unalloted Device should not have Logistics Org");
  // // // assert(status == GpsDeviceStatus.unalloted && vehicleInfo == null,
  //     "Vehicle cannot be null for an unalloted device");

  // String get deviceStatusStr {
  //   switch (status) {
  //     case GpsDeviceStatus.installed:
  //       return 'Installed';
  //     case GpsDeviceStatus.allotted:text
  //       return 'Allotted';
  //     case GpsDeviceStatus.pending_install:
  //       return 'Installation Pending';
  //     case GpsDeviceStatus.available:
  //       return 'Available';
  //     default:
  //       return '';
  //   }
  // }

  GpsDevice copyWith({
    String? imei,
    GpsDeviceType? type,
    GpsDeviceStatus? status,
    String? logisticsOrg,
    String? logisticsOrgEnrollmentId,
    GpsVehicleInfo? vehicleInfo,
  }) {
    return GpsDevice(
      imei: imei ?? this.imei,
      type: type ?? this.type,
      status: status ?? this.status,
      logisticsOrg: logisticsOrg ?? this.logisticsOrg,
      logisticsOrgEnrollmentId: logisticsOrgEnrollmentId ?? this.logisticsOrgEnrollmentId,
      vehicleInfo: vehicleInfo ?? this.vehicleInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imei': imei,
      'type': type.apiText,
      'status': status.text,
      'logisticsOrg': logisticsOrg,
      'logisticsOrgEnrollmentId': logisticsOrgEnrollmentId,
      'vehicleInfo': vehicleInfo?.toMap(),
    };
  }

  factory GpsDevice.fromMap(Map<String, dynamic> map) {
    return GpsDevice(
      imei: map['imei'] as String,
      // type: GpsDeviceType.basic,
      // status: GpsDeviceStatus.active,
      type: GpsDeviceType.values.byName(map["type"].toString().toLowerCase()), //GpsDeviceType.basic
      status: GpsDeviceStatus.values.byName(map['status'].toString().toLowerCase()),
      logisticsOrg: map['logisticsOrganization'] != null ? map['logisticsOrganization'] as String : null,
      logisticsOrgEnrollmentId:
          map['logisticsOrganizationEnrollmentId'] != null ? map['logisticsOrganizationEnrollmentId'] as String : null,
      vehicleInfo:
          map['vehicleInfo'] != null ? GpsVehicleInfo.fromMap(map['vehicleInfo'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GpsDevice.fromJson(String source) => GpsDevice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GpsDevice(imei: $imei, type: $type, status: $status, logisticsOrg: $logisticsOrg, logisticsOrgEnrollmentId: $logisticsOrgEnrollmentId, vehicleInfo: $vehicleInfo)';
  }

  @override
  bool operator ==(covariant GpsDevice other) {
    if (identical(this, other)) return true;

    return other.imei == imei &&
        other.type == type &&
        other.status == status &&
        other.logisticsOrg == logisticsOrg &&
        other.logisticsOrgEnrollmentId == logisticsOrgEnrollmentId &&
        other.vehicleInfo == vehicleInfo;
  }

  @override
  int get hashCode {
    return imei.hashCode ^
        type.hashCode ^
        status.hashCode ^
        logisticsOrg.hashCode ^
        logisticsOrgEnrollmentId.hashCode ^
        vehicleInfo.hashCode;
  }
}
