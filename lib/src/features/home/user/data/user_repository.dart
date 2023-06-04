import 'package:axlerate/app_util/typedefs/typedefs.dart';
import 'package:axlerate/src/features/home/user/domain/add_lqtag_input_model.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_query_params.dart';
import 'package:axlerate/src/features/home/user/domain/retry_user_fuel_card_input_model.dart';
import 'package:axlerate/src/features/home/user/domain/set_user_ppi_preference_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_fuel_card_input_model.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return UserRepository(dio);
});

class UserRepository {
  final Dio dio;
  const UserRepository(this.dio);

  static String baseUserUrl = '${Strings.baseUrl}/api/user';
  static String baseOrgUrl = '${Strings.baseUrl}/api/organization';
  static String basePpiUrl = '${Strings.baseUrl}/api/ppi';
  static String baseFuelUrl = '${Strings.baseUrl}/api/fuel';
  static String baseDashUrl = '${Strings.baseUrl}/api/dashboard';
  static String basePpiAccountUrl = '${Strings.baseUrl}/api/ppiAccountInformation';

  // * Get List of Staffs
  Future<Response> getStaffsList({
    required String userOrgId,
    ListUserQueryParams? queryParams,
  }) async {
    String path =
        '${Strings.baseUrl}${ApiPath.userApiUnencodedPath}/$userOrgId${ApiPath.listUserByUserOrgIdUnencodedPath}';
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

  // * Get List of Staffs
  Future<Response> getOrgUsersListforGPSNotifications({
    required String userOrgId,
    required String orgEnrolId,
    ListUserQueryParams? queryParams,
  }) async {
    String path =
        '${Strings.baseUrl}${ApiPath.userApiUnencodedPath}/$userOrgId${ApiPath.listUserByUserOrgEnrolIdUnencodedPath}/$orgEnrolId';
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

  // // * Get List of Staffs
  // Future<Response> getStaffsList({
  //   required String userOrgId,
  //   ListUserQueryParams? queryParams,
  // }) async {
  //   String path =
  //       '${Strings.baseUrl}${ApiPath.userApiUnencodedPath}/$userOrgId${ApiPath.listUserByUserOrgIdUnencodedPath}';
  //   try {
  //     Response response = await dio.get(
  //       path,
  //     );
  //     "Staffs List :: " + jsonEncode(response.data).toString());
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // * Get List of Users
  Future<Response> getUsersList({
    required String userOrgId,
    ListUserQueryParams? queryParams,
  }) async {
    String path = '$baseUserUrl/$userOrgId${ApiPath.listUser}';
    try {
      Response response = await dio.get(
        path,
        queryParameters: queryParams?.toMap() ?? {},
        cancelToken: axleApiCancelToken,
      );
      // debugPrint(jsonEncode(response.data).toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Users By EnrolmentId
  Future<Response> getUserByEnrolmentId({
    required String userOrgId,
    required String userEnrolmentId,
  }) async {
    String path = '$baseUserUrl/$userOrgId${ApiPath.userByEnrolmentId}/$userEnrolmentId';
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

  // * Create User (Staff)
  Future<Response> createUser({
    required String userOrgId,
    required String userName,
    required OrganizationID underOrgId,
    required String role,
  }) async {
    try {
      String path = '$baseOrgUrl/$userOrgId${ApiPath.user}';
      Response response = await dio.post(
        path,
        data: {
          "userName": userName,
          "organizationId": underOrgId,
          "role": role,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Deactivate User
  Future<Response> deactivateUser({
    required String userOrgId,
    required UserID userId,
    required OrganizationID orgId,
  }) async {
    try {
      String path = '$baseUserUrl/$userOrgId${ApiPath.deactivate}';
      Response response = await dio.patch(
        path,
        data: {"userId": userId, "organizationId": orgId},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Reactivate User
  Future<Response> reactivateUser({
    required String userOrgId,
    required UserID userId,
    required OrganizationID orgId,
  }) async {
    try {
      String path = '$baseUserUrl/$userOrgId${ApiPath.reactivate}';
      Response response = await dio.patch(
        path,
        data: {"userId": userId, "organizationId": orgId},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get list of Organizations by type
  Future<Response> getOrganizationListByType({
    required String userOrgId,
    required String orgType,
  }) async {
    try {
      String path = '$baseOrgUrl/$userOrgId${ApiPath.listOrganizationByType}';
      Response response = await dio.get(
        path,
        queryParameters: {"organizationType": orgType},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Change User Role - WIP
  Future<Response> changeUserRole({
    required String userOrgId,
    required UserID userId,
    required OrganizationID orgId,
    required String role,
  }) async {
    try {
      String path = '$baseUserUrl/$userOrgId${ApiPath.changeUserRole}';
      Response response = await dio.patch(
        path,
        data: {
          "userId": userId,
          "organizationId": orgId,
          "role": role,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Fetch User Card Preferences
  Future<Response> fetchUserCardPreferences(String userOrgId,
      {required String entityId, required OrganizationID orgId}) async {
    try {
      String path = '$basePpiUrl/$userOrgId${ApiPath.fetchPreference}';
      Response response = await dio.post(
        path,
        data: {
          "entityId": entityId,
          "organizationId": orgId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Lock Unlock Card
  Future<Response> lockUnloackCard(String userOrgId,
      {required String entityId, required OrganizationID orgId, required String flag}) async {
    try {
      String path = '$basePpiUrl/$userOrgId${ApiPath.lockUnlockCard}';
      Response response = await dio.patch(
        path,
        data: {
          "entityId": entityId,
          "organizationId": orgId,
          "flag": flag,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Set User PPI Preference
  Future<Response> setUserPPIPreference(
    String userOrgId, {
    required SetUserPpiPreferenceModel preference,
  }) async {
    try {
      String path = '$basePpiUrl/$userOrgId${ApiPath.setPreference}';
      Response response = await dio.patch(
        path,
        data: preference.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Set User card Preference
  Future<Response> setUserCardPreference(
    String userOrgId, {
    required String entityId,
    required OrganizationID orgId,
    required String status,
    required String type,
  }) async {
    try {
      String path = '$basePpiUrl/$userOrgId${ApiPath.setPreference}';
      Response response = await dio.patch(
        path,
        data: {
          "entityId": entityId,
          "organizationId": orgId,
          "status": status,
          "type": type,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Set User card Preference Limit
  Future<Response> setUserCardPreferenceLimit(
    String userOrgId, {
    required String entityId,
    required OrganizationID orgId,
    required String txnType,
    required String dailyLimitValue,
  }) async {
    try {
      String path = '$basePpiUrl/$userOrgId${ApiPath.setPreferenceLimit}';
      Response response = await dio.patch(
        path,
        data: {
          "entityId": entityId,
          "organizationId": orgId,
          "txnType": txnType,
          "dailyLimitValue": dailyLimitValue,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Set PIN PCI Widget
  Future<Response> setPinPciWidget(
    String userOrgId, {
    required String entityId,
    required String userEnrollmentId,
    required OrganizationID orgId,
  }) async {
    try {
      String path = '$basePpiUrl/$userOrgId${ApiPath.setPinPciWidget}';
      Response response = await dio.patch(
        path,
        data: {
          "entityId": entityId,
          "organizationId": orgId,
          "userEnrollmentId": userEnrollmentId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Fetch avilable balance
  Future<Response> fetchUserBalance({
    required String authId,
    required String entityId,
  }) async {
    String path = '$basePpiUrl/$authId${ApiPath.fetchBalance}';

    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          "entityId": entityId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get Card PCI widget
  Future<Response> getCardPciWidget({
    required String authId,
    required String userEnrollId,
    required String orgId,
  }) async {
    String path = '$baseUserUrl/$authId${ApiPath.getCardPciWidget}';

    try {
      Response response = await dio.patch(
        path,
        data: {
          "userEnrollmentId": userEnrollId,
          "organizationId": orgId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Fund Load
  Future<Response> fundLoad(
    String authId, {
    required String orgId,
    // required String partnerOrgId,
    required String userEntityId,
    required String userEnrollmentId,
    required int amount,
    required String description,
  }) async {
    String path = '$basePpiUrl/$authId${ApiPath.loadFund}';

    try {
      Response response = await dio.post(
        path,
        data: {
          "organizationId": orgId,
          // "partnerOrgId": partnerOrgId,
          "userEntityId": userEntityId,
          "userEnrollmentId": userEnrollmentId,
          "amount": amount,
          "description": description
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get user Card Status
  Future<Response> getUserCardStatus({
    required String authId,
    required String userEntityId,
    required String orgId,
  }) async {
    String path = '$basePpiUrl/$authId${ApiPath.getCardStatus}';

    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          "entityId": userEntityId,
          "organizationId": orgId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get V-Kyc Link
  Future<Response> getVKycLink({
    required String authId,
    required String userEntityId,
    required String orgId,
  }) async {
    String path = '$baseUserUrl/$authId/$userEntityId${ApiPath.vKycLink}';

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

  // * Get User Account Info
  Future<Response> getUserAccountInfo(
    String authId, {
    required String userEntityId,
  }) async {
    String path = '$basePpiAccountUrl/$authId${ApiPath.getPpiAccountInfoById}';

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

  // * Get User PPI Txn Amount
  Future<Response> userPpiTxnAmount(
    String authId, {
    required String userEntityId,
    required String dataType,
    required String txnType,
    required bool isGraph,
  }) async {
    String path =
        '$baseDashUrl${ApiPath.user}${ApiPath.ppiAnalytics}/$authId/$userEntityId/$dataType/$txnType/$isGraph';

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

  // Getting User by EnrolId
  Future<Response> getUserByEnrolId({required String userOrgId, required String userEnrolId}) async {
    String path = '$baseDashUrl${ApiPath.user}${ApiPath.ppiAnalytics}/$userEnrolId';

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

  // // Getting User by EnrolId
  // Future<Response> getUserByEnrolId({required String userOrgId, required String userEnrolId}) async {
  //   String path = '$baseDashUrl${ApiPath.user}${ApiPath.ppiAnalytics}/$userEnrolId';

  //   try {
  //     Response response = await dio.get(path);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Getting Users by OrgId
  Future<Response> getUserByOrgId({required String userOrgId, required String userEnrolId}) async {
    String path = '$baseDashUrl${ApiPath.user}${ApiPath.ppiAnalytics}/$userEnrolId';

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

  // * Add LQTag Service to User
  Future<Response> addLqTagService({
    required String userOrgId,
    required AddLqTaginputModel inputs,
  }) async {
    String path = '$baseUserUrl/$userOrgId${ApiPath.addLqTagService}';

    try {
      Response response = await dio.post(
        path,
        data: inputs.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Generate LQFASTAG OTP
  Future<Response> generateLqTagOtp({
    required String userOrgId,
    required String userEnrollId,
    required String orgEnrollId,
  }) async {
    String path = '$baseUserUrl/$userOrgId${ApiPath.lqTagGenerateOtp}';

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

  // * Get V-Kyc Link for lq-tag
  Future<Response> getVKycLinkLqTag({
    required String userOrgId,
    required String userEnrollId,
    required String orgEnrollId,
  }) async {
    // String path = '$baseUserUrl/$userOrgId/$userEnrollId${ApiPath.lqtagvkyclink}';
    String path = '$baseUserUrl/$userOrgId${ApiPath.lqtagvkyclink}';

    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          "userEnrollmentId": userEnrollId.toUpperCase(),
          "organizationEnrollmentId": orgEnrollId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Add Fuel Service
  Future<Response> addFuelService({
    required String userOrgId,
    required AddFuelServiceToUserInputModel inputs,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.addFuelServiceToDriver}';

    try {
      Response response = await dio.post(
        path,
        data: inputs.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // *Retry Add Fuel Service
  Future<Response> retryAddFuelService({
    required String userOrgId,
    required RetryAddFuelServiceToUserInputModel inputs,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.retryAddFuelServiceToDriver}';

    try {
      Response response = await dio.post(
        path,
        data: inputs.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Fetch available user for mapping (fuel)
  Future<Response> fetchUserForMapping({
    required String userOrgId,
    String? orgEnrollId,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.listFuelServiceEnabledUsers}';

    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          if (orgEnrollId != null) "organizationEnrollmentId": orgEnrollId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
