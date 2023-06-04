import 'package:axlerate/src/features/home/logistics/domain/fuel_limit_vehicle_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/create_vehicle_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/enable_fuel_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/enable_gps_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_fastag_service_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_lqtag_service_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/verify_veh_kyc_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/simple_vehicle_list_query_params.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_query_params.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vehicleRepoProvider = Provider<VehicleRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return VehicleRepository(dio);
});

class VehicleRepository {
  final Dio dio;

  const VehicleRepository(this.dio);

  static String baseOrgUrl = '${Strings.baseUrl}/api/organization';
  static String baseVehicleUrl = '${Strings.baseUrl}/api/vehicle';
  static String baseDashUrl = '${Strings.baseUrl}/api/dashboard';
  static String baseTxnUrl = '${Strings.baseUrl}/api/transaction';
  static String baseFundUrl = '${Strings.baseUrl}/api/fund';
  static String baseTagUrl = '${Strings.baseUrl}/api/tag';
  static String baseGpsUrl = '${Strings.baseUrl}/api/gps';
  static String baseAccInfoUrl = '${Strings.baseUrl}/api/accountInformation';
  static String baseAccInfoLivquikUrl = '${Strings.baseUrl}/api/lqtagAccountInformation';
  static String baseFuelUrl = '${Strings.baseUrl}/api/fuel';
  static String baseUserUrl = '${Strings.baseUrl}/api/user';

  // * Create Vehicle (POST)
  Future<Response> createVehicle(String authId, {required CreateVehicleInputModel formData}) async {
    try {
      String path = '$baseOrgUrl/$authId${ApiPath.vehicle}';
      Response response = await dio.post(
        path,
        data: formData.toMap(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Vehicle List (GET)
  Future<Response> getVehiclesList(String authId, {VehicleQueryParams? params}) async {
    try {
      String path = '$baseVehicleUrl/$authId${ApiPath.listVehicle}';
      Response response = await dio.get(
        path,
        queryParameters: params != null ? params.toMap() : {},
        // cancelToken: getVehiclesListApiCancelToken,
      );
      return response;
    } catch (xe) {
      rethrow;
    }
  }

  // * Enable Fastag Service for Vehicle
  Future<Response> enableFastagForVehicle(String authId, VehicleFastTagServiceInputModel input) async {
    try {
      String path = '$baseVehicleUrl/$authId${ApiPath.addTagService}';
      Response response = await dio.post(
        path,
        data: input.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> enableLqtagForVehicle(String authId, VehicleLqTagInputModel input) async {
    try {
      String path = '$baseVehicleUrl/$authId${ApiPath.addLqtagService}';
      Response response = await dio.post(
        path,
        data: input.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> changeLQFastagAdmin(
      String authId, String organizationId, String vehicleEntityId, String parentEntityId) async {
    try {
      String path = '$baseVehicleUrl/$authId/update-vehicle-parent';
      Response response = await dio.patch(
        path,
        data: {
          "organizationEnrollmentId": organizationId,
          "vehicleRegistrationNumber": vehicleEntityId,
          "userEnrollmentId": parentEntityId,
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Enable GPS Service for Vehicle
  Future<Response> enableGpsForVehicle(String authId, EnableGpsInputModel input) async {
    try {
      String path = '$baseGpsUrl/$authId${ApiPath.setGpsDevice}';
      Response response = await dio.patch(
        path,
        data: input.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Tag Class Based on The Serial Number
  Future<Response> getTagclass(String authId, {required String serialNum}) async {
    try {
      String path = '$baseTagUrl/$authId${ApiPath.getTagClass}/$serialNum';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get vehicle Details by ID
  Future<Response> getVehicleDetails(String authId, {required String vehicleId}) async {
    try {
      String path = '$baseVehicleUrl/$authId${ApiPath.getVehicleById}/$vehicleId';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      // debugPrint('Repo Error -> $e');
      rethrow;
    }
  }

  // * Get vehicle Details by RegistrationNumber
  Future<Response> getVehicleByRegistrationNumber(String authId, {required String vehicleId}) async {
    try {
      String path = '$baseVehicleUrl/$authId${ApiPath.getVehicleByRegistrationNumber}/$vehicleId';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      // debugPrint('Repo Error -> $e');
      rethrow;
    }
  }

  // * Get Vehicle Account Info
  Future<Response> getVehicleAccInfo({required String userOrgEnrollId, required String vehicleRegNo}) async {
    try {
      String path = '$baseDashUrl${ApiPath.vehicleAccountInfo}/$userOrgEnrollId/$vehicleRegNo';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      // debugPrint('Repo Error -> $e');
      rethrow;
    }
  }

  // * Get Vehicle Last Debit Transaction
  Future<Response> getVehicleLastDebitTxn(String authId, {required String vehicleRegNo}) async {
    try {
      String path = '$baseTxnUrl/$authId${ApiPath.lastDebitTxn}';
      Response response = await dio.get(
        path,
        queryParameters: {
          'filterField': 'vehicleId',
          'filterText': vehicleRegNo,
        },
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Vehicle Tag Txn List
  Future<Response> getVehicleTagTxnList(String authId, {required String vehicleRegNo}) async {
    try {
      String path = '$baseTxnUrl/$authId';
      Response response = await dio.get(
        path,
        queryParameters: {
          'filterField': 'vehicleId',
          'filterText': vehicleRegNo,
        },
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Vehicle Trip History
  Future<Response> getVehicleTripHistory(
    String authId, {
    required String vehicleRegNo,
    required String date,
  }) async {
    try {
      String path = '$baseGpsUrl/$authId${ApiPath.tripHistory}/$vehicleRegNo';
      Response response = await dio.get(
        path,
        queryParameters: {'date': date},
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Fund Load for Tag
  Future<Response> fundLoadForTag(
    String authId, {
    required String orgId,
    required String vehicleRegNo,
    required int amount,
  }) async {
    try {
      String path = '$baseFundUrl/$authId${ApiPath.fundLoad}';
      Response response = await dio.post(
        path,
        data: {
          "organizationId": orgId,
          "vehicleEntityId": vehicleRegNo,
          "amount": amount,
        },
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Vehicle GPS Info
  Future<Response> getVehicleGpsInfo(String authId, {required String vehicleRegNo}) async {
    try {
      String path = '$baseGpsUrl/$authId${ApiPath.vehicleGpsInfo}/$vehicleRegNo';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Vehicle GPS Account Info
  Future<Response> getVehicleGpsAccountInfo(String authId, {required String vehicleRegNo}) async {
    try {
      String path = '$baseGpsUrl/$authId${ApiPath.vehicleGpsAccountInfo}/$vehicleRegNo';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      // debugPrint("getVehicleGpsInfo : ${response.data}");
      // log("getVehicleGpsInfo : $path");

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Vehicle Vehicle GPS Value Data
  Future<Response> getGpsValueData(String authId, vehicleRegNo) async {
    try {
      String path = '$baseGpsUrl/$authId${ApiPath.gpsValue}/$vehicleRegNo/W';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      // debugPrint('Repo Error -> $e');
      rethrow;
    }
  }

  // * Switch Vehicle Balance Type
  Future<Response> switchVehicleBalanceType(
    String authId, {
    required String orgId,
    required String vehicleRegNo,
    required String balanceType,
    required int? thresLimit,
  }) async {
    try {
      String path = '$baseVehicleUrl/$authId${ApiPath.modifyTruckType}';
      Map<String, dynamic> params = {
        "organizationId": orgId,
        "vehicleEntityId": vehicleRegNo,
        "vehicleBalanceType": balanceType,
      };

      if (thresLimit != null) {
        params.addAll({
          "thresholdLimit": thresLimit,
        });
      }
      Response response = await dio.patch(
        path,
        data: params,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getYesBankTagAccInfoDetailsByEntityId(String authId, {required String entityId}) async {
    try {
      String path = '$baseAccInfoUrl/$authId/$entityId';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      // debugPrint('Vehicle Repo Error -> $e');
      rethrow;
    }
  }

  // Update Threshold limit of a Vehicle
  Future<Response> updateVehicleThresholdLimit(
    String authId, {
    required String orgId,
    required String vehicleRegNo,
    required int threshold,
  }) async {
    try {
      String path = '$baseAccInfoUrl${ApiPath.updateVehicleThreshold}/$authId';
      Response response = await dio.patch(
        path,
        data: {
          "organizationId": orgId,
          "vehicleEntityId": vehicleRegNo,
          "thresholdLimit": threshold,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      // debugPrint('Vehicle Repo Error -> $e');
      rethrow;
    }
  }

  // * Enable Fuel Service for Vehicle
  Future<Response> enableFuelForVehicle(
    String authId,
    VehicleFuelServiceInputModel input,
  ) async {
    try {
      String path = '$baseFuelUrl/$authId${ApiPath.addFuelServiceToVehicle}';
      Response response = await dio.post(
        path,
        data: input.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // *Retry Enable Fuel Service for Vehicle
  Future<Response> retryEnableFuelForVehicle(
    String authId,
    VehicleFuelServiceInputModel input,
  ) async {
    try {
      String path = '$baseFuelUrl/$authId${ApiPath.updateVehicle}';
      Response response = await dio.put(
        path,
        data: input.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Verify kyc to Organization
  Future<Response> verifyVehKyc(
    String userOrgId,
    String vehicleEnrollId,
    VerifyVehicleKycInputModel input,
  ) async {
    try {
      String path = '$baseFuelUrl/$vehicleEnrollId/$userOrgId${ApiPath.verifyVehKyc}';
      Response response = await dio.post(
        path,
        data: input.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Set Vehicle FUEL limit
  Future<Response> setVehicleFuelLimit({
    required String userOrgId,
    required String vehicleEnrollId,
    required SetVehicleFuelInputModel formInput,
  }) async {
    String path = '$baseFuelUrl/$vehicleEnrollId/$userOrgId${ApiPath.setLimitVehicle}';

    try {
      Response response = await dio.post(
        path,
        data: formInput.toJson(),
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Approve/Decline Vehicle LQTAG
  Future<Response> approveOrDeclineLqVehicle({
    required String userOrgId,
    required String userEnrollId,
    required String orgEnrollId,
    required String vehicleRegNum,
    required String status,
    required String rejReason,
  }) async {
    try {
      Map<String, dynamic> params = {
        "userEnrollmentId": userEnrollId,
        "organizationEnrollmentId": orgEnrollId,
        "vehicleRegistrationNumber": vehicleRegNum,
        "status": status,
      };

      if (rejReason.isNotEmpty) {
        params.addAll({"rejectionReason": rejReason});
      }

      String path = '$baseVehicleUrl/$userOrgId${ApiPath.approveDeclineVehicleTagService}';
      Response response = await dio.post(
        path,
        data: params,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Set Driver to  Vehicle
  Future<Response> mapDriverToVehicle({
    required String userOrgId,
    required String vehicleRegNo,
    required String mapStatus,
    required String driverEnrollmentId,
    required String organizationEnrollmentId,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.manageDriverMapping}';

    try {
      Response response = await dio.post(
        path,
        data: {
          "organizationEnrollmentId": organizationEnrollmentId,
          "vehicleRegistrationNumber": vehicleRegNo,
          "userEnrollmentId": driverEnrollmentId,
          "mapStatus": mapStatus, // MAP, UNMAP, REASSIGN
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // // * Get Vehicle FUEL status
  // Future<Response> getVehicleFuelStatus({
  //   required String userOrgId,
  //   required String orgId,
  // }) async {
  //   String path = '$baseFuelUrl/$userOrgId/$orgId${ApiPath.fetchVehicleStatus}';
  //   try {
  //     Response response = await dio.get(
  //       path,
  //       cancelToken: axleApiCancelToken,
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // * Get LQ Tag Org User
  Future<Response> getLQTagAdminOrgUser(String userOrgId, {required String orgEnrolId}) async {
    try {
      String path = '$baseUserUrl/$userOrgId${ApiPath.listlqtagserviceusers}/$orgEnrolId';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      // debugPrint('Repo Error -> $e');
      rethrow;
    }
  }

  // Retry LQ vehicle [S]
  Future<Response> retryLqVehicle(
    String userOrgId, {
    required String orgEnrolId,
    required String userEnrolId,
    required String vehicleRegNo,
  }) async {
    try {
      String path = '$baseVehicleUrl/$userOrgId${ApiPath.retryLqTagService}';
      Response response = await dio.patch(
        path,
        data: {
          "userEnrollmentId": userEnrolId,
          "organizationEnrollmentId": orgEnrolId,
          "vehicleRegistrationNumber": vehicleRegNo,
        },
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      rethrow;
      // debugPrint('Repo Error -> $e');
    }
  }

  // * Load Amount to  Card
  Future<Response> loadAmountToCard({
    required String userOrgId,
    required String orgId,
    required String vehicleRegNo,
    required int amount,
    required String description,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.cardLoad}';
    try {
      Response response = await dio.post(
        path,
        data: {
          "organizationEnrollmentId": orgId,
          "vehicleRegistrationNumber": vehicleRegNo,
          "amount": amount,
          "description": description,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // *WithDraw Amount
  Future<Response> withDrawAmount({
    required String userOrgId,
    required String orgId,
    required String vehicleRegNo,
    required int amount,
    required String description,
    required String vehicleEntityId,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.cardWithDraw}';
    try {
      Response response = await dio.post(
        path,
        data: {
          "organizationEnrollmentId": orgId,
          "vehicleRegistrationNumber": vehicleRegNo,
          "amount": amount,
          "description": description,
          "vehicleEntityId": vehicleEntityId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Load Amount to  Vehicle Wallet
  Future<Response> loadAmountToVehicleWallet({
    required String userOrgId,
    required String orgId,
    required String vehicleRegNo,
    required int amount,
    required String vehicleEnrollId,
  }) async {
    String path = '$baseFuelUrl/$userOrgId/$vehicleEnrollId/${ApiPath.addFundsToVehicleWallet}';

    try {
      Response response = await dio.post(
        path,
        data: {
          "organizationEnrollmentId": orgId,
          "vehicleRegistrationNumber": vehicleRegNo,
          "amount": amount,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get List-lqtag-vehicles
  Future<Response> getListLqtagVehicles({
    required String userOrgId,
  }) async {
    String path = '$baseVehicleUrl/$userOrgId${ApiPath.listLqTagVehicles}';
    try {
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getLivquikTagAccInfoDetailsByEnrollmentId(String authId, {required String orgEnrollId}) async {
    try {
      String path = '$baseAccInfoLivquikUrl/$authId/$orgEnrollId${ApiPath.organizationAccountInformation}';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      // debugPrint('Vehicle Repo Error -> $e');
      rethrow;
    }
  }

  Future<Response> getLivquikTagAccInfo(String authId,
      {required String organizationEnrollmentId, required String userEnrollmentId}) async {
    try {
      String path = '$baseAccInfoLivquikUrl/$authId${ApiPath.getUserBalance}';
      Response response = await dio.get(
        path,
        queryParameters: {
          'organizationEnrollmentId': organizationEnrollmentId,
          'userEnrollmentId': userEnrollmentId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      // debugPrint('Vehicle Repo Error -> $e');
      rethrow;
    }
  }

  // * Get TAG Vehicle List
  Future<Response> listofVehicles({
    required String userOrgId,
    required SimpleVehicleListQueryParams? qParams,
  }) async {
    String path = '$baseVehicleUrl/$userOrgId/simple-list-vehicle';

    try {
      Response response = await dio.get(
        path,
        queryParameters: qParams != null ? qParams.toMap() : {},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
