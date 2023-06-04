// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:axlerate/src/features/home/vehicles/data/vehicle_repository.dart';
import 'package:axlerate/src/features/home/vehicles/domain/gps_value_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final gpsDetailToggleSwitchIndex = StateProvider<int>((ref) {
//   return 0;
// });

final gpsValueDataProvider = StateProvider<GPSValueResponseModel?>((ref) {
  return null;
});

final gpsDetailControllerProvider = Provider<GpsDetailController>((ref) {
  return GpsDetailController(ref);
});

class GpsDetailController {
  final Ref ref;

  const GpsDetailController(this.ref);

  // * Get Value API (GET)
  Future<GPSValueResponseModel?> getGpsValueData({required String vehicleRegistrationNumber}) async {
    GPSValueResponseModel? res; // = null;
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getGpsValueData(userOrgId, vehicleRegistrationNumber);
      try {
        res = GPSValueResponseModel.fromMap(result.data);
        return res;
      } catch (e) {
        // debugPrint('GPS Value API ERROR -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }
}
