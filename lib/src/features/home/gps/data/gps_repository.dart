import 'package:axlerate/src/features/home/gps/data/add_gps_device_model.dart';
import 'package:axlerate/src/features/home/gps/data/allocate_gps_device_model.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/gps/widgets/manage_notifications.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gpsRepoProvider = Provider<GpsDeviceRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return GpsDeviceRepository(dio);
});

class GpsDeviceRepository {
  final Dio dio;

  GpsDeviceRepository(this.dio);

  static String baseUrl = '${Strings.baseUrl}/api/gps';

  // * Get GPS Devices
  Future<Response> listGpsDevices({
    required String userOrgId,
    // required PpiTxnQueryParams? qParams,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.listGpsDevices}';

    try {
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,

        // queryParameters: qParams != null ? qParams.toMap() : {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addGpsDevices({required String userOrgId, required AddGpsDevicesModel devices
      // required PpiTxnQueryParams? qParams,
      }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.addGpsDevices}';

    try {
      Response response = await dio.post(
        path, data: devices.toJson(),
        cancelToken: axleApiCancelToken,

        // queryParameters: qParams != null ? qParams.toMap() : {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> allocateGpsDevices({required String userOrgId, required AllocateGpsDeviceModel devices
      // required PpiTxnQueryParams? qParams,
      }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.allocateGpsDevices}';

    try {
      Response response = await dio.post(
        path, data: devices.toJson(),
        cancelToken: axleApiCancelToken,

        // queryParameters: qParams != null ? qParams.toMap() : {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateGpsNotifications({required String userOrgId, required GpsUpdateNotificationModel data
      // required PpiTxnQueryParams? qParams,
      }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.updateGpsnotifications}';

    try {
      Response response = await dio.patch(
        path, data: data.toJson(),
        cancelToken: axleApiCancelToken,

        // queryParameters: qParams != null ? qParams.toMap() : {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
