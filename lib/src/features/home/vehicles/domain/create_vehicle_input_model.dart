import 'dart:convert';

class CreateVehicleInputModel {
  final String organizationId;
  final String registrationNumber;
  final String registrationDate;
  final String engineNumber;
  final String chasisNumber;
  final String fuelType;
  // final String? contactNumber;
  final String insuranceExpiryDate;
  final String fitnessUpto;
  final CreateVehicleType vehicleType;
  final String vehicleCategory;

  CreateVehicleInputModel({
    required this.organizationId,
    required this.registrationNumber,
    required this.registrationDate,
    required this.engineNumber,
    required this.chasisNumber,
    required this.fuelType,
    // required this.contactNumber,
    required this.insuranceExpiryDate,
    required this.fitnessUpto,
    required this.vehicleType,
    required this.vehicleCategory,
  });

  CreateVehicleInputModel copyWith({
    String? organizationId,
    String? registrationNumber,
    String? registrationDate,
    String? engineNumber,
    String? chasisNumber,
    String? fuelType,
    // String? contactNumber,
    String? insuranceExpiryDate,
    String? fitnessUpto,
    CreateVehicleType? vehicleType,
    String? vehicleCategory,
  }) {
    return CreateVehicleInputModel(
      organizationId: organizationId ?? this.organizationId,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      registrationDate: registrationDate ?? this.registrationDate,
      engineNumber: engineNumber ?? this.engineNumber,
      chasisNumber: chasisNumber ?? this.chasisNumber,
      fuelType: fuelType ?? this.fuelType,
      // contactNumber: contactNumber ?? this.contactNumber,
      insuranceExpiryDate: insuranceExpiryDate ?? this.insuranceExpiryDate,
      fitnessUpto: fitnessUpto ?? this.fitnessUpto,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleCategory: vehicleCategory ?? this.vehicleCategory,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {
      'organizationId': organizationId,
      'registrationNumber': registrationNumber,
      'registrationDate': registrationDate,
      'engineNumber': engineNumber,
      'chasisNumber': chasisNumber,
      'fuelType': fuelType,
      'insuranceExpiryDate': insuranceExpiryDate,
      'fitnessUpto': fitnessUpto,
      'vehicleCategory': vehicleCategory,
    };

    // if (contactNumber != null && contactNumber!.isNotEmpty) {
    //   params.addAll({'contactNumber': contactNumber});
    // }

    if (vehicleType.maker != null && vehicleType.maker!.isNotEmpty) {
      params.addAll({'vehicleType': vehicleType.toMap()});
    }

    return params;
  }

  // String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CreateVehicleInputModel(organizationId: $organizationId, registrationNumber: $registrationNumber, registrationDate: $registrationDate, engineNumber: $engineNumber, chasisNumber: $chasisNumber, fuelType: $fuelType, insuranceExpiryDate: $insuranceExpiryDate, fitnessUpto: $fitnessUpto, vehicleType: $vehicleType, vehicleCategory: $vehicleCategory)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateVehicleInputModel &&
        other.organizationId == organizationId &&
        other.registrationNumber == registrationNumber &&
        other.registrationDate == registrationDate &&
        other.engineNumber == engineNumber &&
        other.chasisNumber == chasisNumber &&
        other.fuelType == fuelType &&
        // other.contactNumber == contactNumber &&
        other.insuranceExpiryDate == insuranceExpiryDate &&
        other.fitnessUpto == fitnessUpto &&
        other.vehicleType == vehicleType &&
        other.vehicleCategory == vehicleCategory;
  }

  @override
  int get hashCode {
    return organizationId.hashCode ^
        registrationNumber.hashCode ^
        registrationDate.hashCode ^
        engineNumber.hashCode ^
        chasisNumber.hashCode ^
        fuelType.hashCode ^
        // contactNumber.hashCode ^
        insuranceExpiryDate.hashCode ^
        fitnessUpto.hashCode ^
        vehicleType.hashCode ^
        vehicleCategory.hashCode;
  }
}

class CreateVehicleType {
  final String? maker;

  CreateVehicleType({
    required this.maker,
  });

  CreateVehicleType copyWith({
    String? maker,
  }) {
    return CreateVehicleType(
      maker: maker ?? this.maker,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'maker': maker,
    };
  }

  factory CreateVehicleType.fromMap(Map<String, dynamic> map) {
    return CreateVehicleType(
      maker: map['maker'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  factory CreateVehicleType.fromJson(String source) => CreateVehicleType.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VehicleType(maker: $maker)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateVehicleType && other.maker == maker;
  }

  @override
  int get hashCode {
    return maker.hashCode;
  }
}
