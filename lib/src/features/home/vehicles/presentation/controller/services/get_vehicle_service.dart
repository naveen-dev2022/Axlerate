import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';

Service? getVehicleService(
  Vehicle? vehicle,
  String serviceType, {
  String? issuerName,
}) {
  try {
    int index = 0;
    if (vehicle == null || vehicle.services.isEmpty) {
      return null;
    }

    if (issuerName != null) {
      index = vehicle.services.indexWhere((element) {
        // log("********** issuerName : ${element.issuerName}");

        return element.issuerName == issuerName;
      });
    } else {
      index = vehicle.services.indexWhere((element) => element.serviceType == serviceType);
    }
    if (index == -1) {
      return null;
    }
    return vehicle.services[index];
  } catch (e) {
    return null;
  }
}
