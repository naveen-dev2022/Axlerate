import 'package:axlerate/src/features/home/gps/data/add_gps_device_model.dart';
import 'package:axlerate/src/features/home/gps/data/allocate_gps_device_model.dart';
import 'package:axlerate/src/features/home/gps/data/gps_device_list_model.dart';
import 'package:axlerate/src/features/home/gps/data/gps_repository.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/gps/widgets/manage_notifications.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gpsListStateProvider = StateProvider<GpsDeviceListModel?>((ref) {
  return null;
});

final gpsControllerProvider = StateProvider<GpsController>((ref) {
  return GpsController(ref);
});

class GpsController {
  final Ref ref;

  GpsController(this.ref);

  Future<GpsDeviceListModel> listGpsDevices() async {
    GpsDeviceListModel res = const GpsDeviceListModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(gpsRepoProvider).listGpsDevices(
            userOrgId: userOrgId,
            // qParams: params,
          );
      try {
        res = GpsDeviceListModel.fromJson(result.data);
        return res;
      } catch (e) {
        // log("error--->$e");

        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<dynamic> addGpsDevices(AddGpsDevicesModel devices) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(gpsRepoProvider).addGpsDevices(userOrgId: userOrgId, devices: devices
          // qParams: params,
          );

      Snackbar.success("Data Added Successfully");

      // try {
      //   res = GpsDeviceListModel.fromJson(result.data);
      //   return res;
      // } catch (e) {
      //   debugPrint(e.toString());
      //   log(e.toString());
      //   return res;
      // }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      // return res;
      rethrow;
    }
  }

  Future<dynamic> allocateGpsDevices(AllocateGpsDeviceModel devices) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(gpsRepoProvider).allocateGpsDevices(userOrgId: userOrgId, devices: devices
          // qParams: params,
          );

      Snackbar.success("Device Allocated Successfully");
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      // return res;
      rethrow;
    }
  }

  //to update GPS notifications
  Future<dynamic> updateGpsNotifications(GpsUpdateNotificationModel data) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(gpsRepoProvider).updateGpsNotifications(userOrgId: userOrgId, data: data
          // qParams: params,
          );

      Snackbar.success("Updated Successfully");
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      // return res;
      rethrow;
    }
  }
}
