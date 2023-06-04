import 'package:axlerate/src/features/home/logistics/domain/create_logistics_input_model.dart';
import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:axlerate/src/features/home/logistics/domain/fuel_limit_set_input_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/fund_transfer_c2c_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/fund_transfer_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/set_org_ppi_preference_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/vehicle_toll_query_params.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logisticsRepositoryProvider = Provider<LogisticsRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return LogisticsRepository(dio);
});

class LogisticsRepository {
  final Dio dio;

  const LogisticsRepository(this.dio);

  static String baseUrl = '${Strings.baseUrl}/api/organization';
  static String baseUserUrl = '${Strings.baseUrl}/api/user';
  static String baseLqAccInfoUrl = '${Strings.baseUrl}/api/lqtagAccountInformation';
  static String baseDashUrl = '${Strings.baseUrl}/api/dashboard';
  static String baseGPSUrl = '${Strings.baseUrl}/api/gps';
  static String baseFuelUrl = '${Strings.baseUrl}/api/fuel';
  static String basePpiAccUrl = '${Strings.baseUrl}/api/ppiAccountInformation';
  static String baseLqUrl = '${Strings.baseUrl}/api/lqtag';
  static String baseFuelAccInfoUrl = '${Strings.baseUrl}/api/fuelAccountInformation';
  static String vehicleBaseUrl = '${Strings.baseUrl}/api/vehicle';

  Future<Response> createLogistics({
    required String userOrgId,
    required CreateLogisticsInputModel formInput,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.logistics}';

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

  // * Invite Logistics
  Future<Response> inviteLogistics({
    required String userOrgId,
    required String orgCode,
    required String email,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.logistics}${ApiPath.invite}';

    try {
      Response response = await dio.post(
        path,
        data: {
          "orgCode": orgCode,
          "admin": {"userName": email}
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Update Invited Logistics
  Future<Response> updateLogistics({
    required String userOrgId,
    required String orgId,
    required CreateLogisticsInputModel formInput,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.logistics}${ApiPath.updateInvitedOrg}';
    final Map<String, dynamic> jsonFormData = formInput.toMap(isUpdate: true, orgId: orgId);
    try {
      Response response = await dio.put(
        path,
        data: jsonFormData,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getLogisticsList({
    required String userOrgId,
    ListOrgsQueryParams? queryParams,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.listOrganization}';
    try {
      Response response = await dio.get(
        path,
        queryParameters: queryParams?.toMap() ?? {},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Check Org Code
  Future<Response> checkOrgCode({
    required String userOrgId,
    required String code,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.checkOrgCodeAvailability}';
    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          'orgCode': code,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Update Organization PPI Preference
  Future<Response> updateOrgPPiPreference({
    required String userOrgId,
    required SetOrgPpiPreferenceModel inputs,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.updateCardPreference}';
    try {
      Response response = await dio.patch(
        path,
        data: inputs.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Logistics Dash Count
  Future<Response> getOrgDashCount({
    required String currentUserOrgEnrollmentId,
    required String userOrgEnrollmentId,
  }) async {
    String path = '$baseDashUrl${ApiPath.logisticsOrgDashCount}/$currentUserOrgEnrollmentId/$userOrgEnrollmentId';
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

  // * Get Logistics Tag Account Info
  Future<Response> getOrgDashTagAccountInfo({
    required String currentUserOrgEnrollId,
    required String userOrgEnrollId,
  }) async {
    String path = '$baseDashUrl${ApiPath.ybTagAccountInfoDash}/$currentUserOrgEnrollId/$userOrgEnrollId';
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

  // * Get Logistics PPI Account Info
  Future<Response> getOrgDashPpiAccountInfo({
    required String currentUserOrgEnrollId,
    required String userOrgEnrollId,
  }) async {
    String path = '$baseDashUrl${ApiPath.ppiAccountInfoDash}/$currentUserOrgEnrollId/$userOrgEnrollId';
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

  // * Get Logistics Fuel Account Info
  Future<Response> getOrgDashFuelAccountInfo({
    required String currentUserOrgEnrollId,
    required String userOrgEnrollId,
    required String entityType,
  }) async {
    String path = '$baseFuelAccInfoUrl/$currentUserOrgEnrollId${ApiPath.fuelAccInfo}';
    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          'enrollmentId': userOrgEnrollId,
          'entityType': entityType,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Logistics Tag Rewards (Amount)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<Response> getOrgTagReward({
    required String currentUserOrgEnrollId,
    required String userOrgEnrollId,
    required String dataType,
  }) async {
    String path =
        '$baseDashUrl${ApiPath.logOrg}${ApiPath.tagRewards}/$currentUserOrgEnrollId/$userOrgEnrollId/$dataType';
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

  // * Get Logistics PPI Rewards (Amount)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<Response> getOrgPpiReward({
    required String userOrgId,
    required String orgId,
    required String dataType,
  }) async {
    String path = '$baseDashUrl${ApiPath.logOrg}${ApiPath.ppiRewards}/$userOrgId/$orgId/$dataType';
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

  // * Get Org Dash Tag TXN Analytics (Debit and Credit)
  // * dataType : 'year', 'week', 'day', 'month'
  // * TxnType : 'credit', 'debit'
  Future<Response> getOrgDashTagTxnAnalytics({
    required String currentUserOrgEnrollId,
    required String userOrgEnrollId,
    required String dataType,
    required String txType,
  }) async {
    String path =
        '$baseDashUrl${ApiPath.logOrg}${ApiPath.tagAnalytics}/$currentUserOrgEnrollId/$userOrgEnrollId/$dataType/$txType';
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

  // * Get Org Dash PPI TXN Analytics (Debit and Credit)
  // * dataType : 'year', 'week', 'day', 'month'
  // * TxnType : 'credit', 'debit'
  Future<Response> getOrgDashPpiTxnAnalytics({
    required String currentUserOrgEnrollId,
    required String userOrgEnrollId,
    required String dataType,
    required String txType,
  }) async {
    String path =
        '$baseDashUrl${ApiPath.logOrg}${ApiPath.ppiAnalytics}/$currentUserOrgEnrollId/$userOrgEnrollId/$dataType/$txType';
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

  Future<Response> getOrgByEnrolId({
    required String userOrgId,
    required String orgEnrolId,
  }) async {
    String path = '$baseUrl/$userOrgId/getOrgByEnrolmentId/$orgEnrolId';

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

  // * Get Organization Account Info
  Future<Response> getOrgAccountInfo(
    String authId, {
    required String userEntityId,
  }) async {
    String path = '$basePpiAccUrl/$authId${ApiPath.getPpiAccountInfoById}';

    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          "entityId": userEntityId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Organization GPS Info
  Future<Response> getLogisticsGpsInfo({
    required String authId,
    required String orgId,
  }) async {
    String path = '$baseGPSUrl/$authId${ApiPath.logisticGpsInfo}/$orgId';
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

  // * Set Organization FUEL limit
  Future<Response> setLogisticsFuelLimit({
    required String userOrgId,
    required FuelSetInputModel formInput,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.setLimitOrganization}';

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

  // * Add BusinessConfig With FuelLimit for Organization
  Future<Response> addBusinessConfigWithFuelLimit({
    required String userOrgId,
    required String orgEnrolId,
    // required AddBusinessConfigWithFuelInputModel formInput,
  }) async {
    String path = '$baseFuelUrl/$orgEnrolId/$userOrgId${ApiPath.addBusinessConfigWithFuelLimits}';

    try {
      Response response = await dio.post(
        path,
        // data: formInput.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Organization/Vehicle/Staff FUEL limit
  Future<Response> getFuelLimitByEntityType({
    required String userOrgId,
    required String orgEnrollId,
    required String entityId,
    required String entityType,
    required String issuerName,
    String? vehicleRegistrationNumber,
  }) async {
    String path = '$baseFuelUrl/$userOrgId/$orgEnrollId${ApiPath.fetchLimit}';
    Map<String, dynamic> params = {
      "entityId": entityId,
      "entityType": entityType,
      "issuerName": issuerName,
      if (vehicleRegistrationNumber != null && vehicleRegistrationNumber.isNotEmpty)
        "vehicleRegistrationNumber": vehicleRegistrationNumber,
    };
    try {
      Response response = await dio.get(
        path,
        queryParameters: params,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Organization/Vehicle/Staff FUEL balance
  Future<Response> getFuelBalanceByEntityId({
    required String userOrgId,
    required String orgEnrollId,
    required String entityId,
    required String entityType,
    String? vehicleRegistrationNumber,
    required String issuerName,
  }) async {
    String path = '$baseFuelUrl/$userOrgId/$orgEnrollId${ApiPath.fetchBalanceFuel}';
    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          "entityId": entityId,
          "entityType": entityType,
          "issuerName": issuerName,
          if (vehicleRegistrationNumber != null && vehicleRegistrationNumber.isNotEmpty)
            "vehicleRegistrationNumber": vehicleRegistrationNumber,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Add LQTag Service
  Future<Response> lqTagAccountInfo({
    required String userOrgId,
    required String userEnrollId,
    required String orgEnrollId,
  }) async {
    String path = '$baseUserUrl/$userOrgId${ApiPath.getLqAccInfoByEnrollId}';

    try {
      Response response = await dio.patch(
        path,
        data: {
          "userEnrollmentId": userEnrollId,
          "organizationEnrollmentId": orgEnrollId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * LQTag Account Information
  Future<Response> lqTagGenerateOTP({
    required String userOrgId,
    required String userEnrollId,
  }) async {
    String path = '$baseLqAccInfoUrl/$userOrgId${ApiPath.lqTagGenerateOtp}';

    try {
      Response response = await dio.get(
        path,
        queryParameters: {'enrollmentId': userEnrollId},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * LQTAG Accounts info for Org
  Future<Response> lqTagAccInfoforOrg({
    required String userOrgEnrollId,
    required String orgEnrollId,
  }) async {
    String path = '$baseDashUrl${ApiPath.lqTagAccountInfoDash}/$userOrgEnrollId/$orgEnrollId';

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

  // // * LQTAG Acc info by enroll id
  // Future<Response> lqTagAccInfoByEnrollmentId({
  //   required String userOrgId,
  //   required String orgEnrollId,
  //   String? userEnrollId,
  // }) async {
  //   String path = '$baseDashUrl/$userOrgId${ApiPath.getLqAccInfoByEnrollId}/$orgEnrollId';

  //   try {
  //     Response response = await dio.get(
  //       path,
  //       // queryParameters: {'enrollmentId': orgEnrollId},
  //       cancelToken: axleApiCancelToken,
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // * LQTAG FundLoad P2C
  Future<Response> lqTagFundLoadP2C({
    required String userOrgId,
    required FundTransferModelP2C data,
  }) async {
    String path = '$baseLqUrl/$userOrgId${ApiPath.fundLoadCorporateToUser}';

    try {
      Response response = await dio.post(
        path,
        data: data.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * LQTAG FundLoad C2C
  Future<Response> lqTagFundLoadC2C({
    required String userOrgId,
    required FundTransferModelC2C data,
  }) async {
    String path = '$baseLqUrl/$userOrgId${ApiPath.fundLoadUserToUser}';

    try {
      Response response = await dio.post(
        path,
        data: data.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * LQTAG FundLoad C2P
  Future<Response> lqTagFundLoadC2P({
    required String userOrgId,
    required FundTransferModelP2C data,
  }) async {
    String path = '$baseLqUrl/$userOrgId${ApiPath.fundLoadUserToCorporate}';

    try {
      Response response = await dio.post(
        path,
        data: data.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadLogisticOrgLogo({required String logisticOrgId, required String url}) async {
    String path = '$baseUrl/$logisticOrgId${ApiPath.uploadLogisticsOrgLogo}';
    try {
      await dio.patch(
        path,
        data: {
          "organizationId": logisticOrgId,
          "logo": url,
        },
        cancelToken: axleApiCancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getVehiclewiseData({required String userOrgId, required VehicleTollQueryParams params}) async {
    String path = '$vehicleBaseUrl/$userOrgId/list-vehicle-toll-amount';
    try {
      Response response = await dio.get(path, queryParameters: params.toMap());
      return response;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      rethrow;
    }
  }
}
