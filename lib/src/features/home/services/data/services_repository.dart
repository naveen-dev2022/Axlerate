import 'package:axlerate/src/features/home/services/domain/add_ppi_service_input_mode.dart';
import 'package:axlerate/src/features/home/services/domain/add_tag_service_input_modal.dart';
import 'package:axlerate/src/features/home/services/domain/fuel_service_input_model.dart';
import 'package:axlerate/src/features/home/services/domain/fuel_service_input_retry_model.dart';
import 'package:axlerate/src/features/home/services/domain/fuel_service_input_update_model.dart';
import 'package:axlerate/src/features/home/services/domain/verify_org_kyc_input_model.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesRepoProvider = Provider<ServicesRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return ServicesRepository(dio);
});

class ServicesRepository {
  final Dio dio;

  const ServicesRepository(this.dio);

  static String baseUrl = '${Strings.baseUrl}/api/organization';
  static String baseFuelUrl = '${Strings.baseUrl}/api/fuel';
  static String lqTagCorporateWalletUrl = '${Strings.baseUrl}/api/dashboard${ApiPath.lqtagCorporateAccountInfoDash}';

  // Add PPI service to Organization
  Future<Response> addPpiServiceToOrganization({
    required String userOrgId,
    required EnablePpiServiceInputModel formInput,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.addService}';

    try {
      Response response = await dio.post(
        path,
        data: formInput.toMap(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Retry Add PPI service to Organization
  Future<Response> retryaddPpiServiceToOrganization({
    required String userOrgId,
    required String orgId,
    // required EnablePpiServiceInputModel formInput,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.retryPpiCorporate}';

    try {
      Response response = await dio.post(
        path,
        data: {
          "organizationId": orgId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Add Tag service to Organization
  Future<Response> addTagServiceToOrganization({
    required String userOrgId,
    required AddTagServiceInputModel formInput,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.addService}';

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

  // Add GPS service to Organization
  Future<Response> addGpsServiceToOrganization({
    required String userOrgId,
    required String orgId,
    required String partnerOrgId,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.addService}/$orgId';

    try {
      Response response = await dio.post(
        path,
        data: {
          "organizationId": orgId,
          "partnerOrgId": partnerOrgId,
          "serviceType": "GPS",
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

// * Fuel Module Api *//

  // * Get list of Cities
  Future<Response> getListOfCities({
    required String userOrgId,
    required String state,
  }) async {
    try {
      String path = '$baseFuelUrl/$userOrgId${ApiPath.cities}';
      Response response = await dio.get(
        path,
        queryParameters: {'state': state},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Get list of States
  Future<Response> getListOfStates({
    required String userOrgId,
  }) async {
    try {
      String path = '$baseFuelUrl/$userOrgId${ApiPath.states}';
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Add Fuel service to Organization
  Future<Response> addFuelServiceToOrganization({
    required String userOrgId,
    required FuelServiceInputModel formInput,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.addFuelServiceToLogOrg}';
    try {
      Response response = await dio.post(
        path,
        data: formInput.toMap(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Retry Add Fuel service to Organization
  Future<Response> retryAddFuelServiceToOrganization({
    required String userOrgId,
    required FuelServiceRetryInputModel formInput,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.retryAddFuelServiceToLogOrg}';
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

  //Updating Add Fuel service to Organization
  Future<Response> updateAddFuelServiceToOrganization({
    required String orgEnrollId,
    required FuelServiceUpdateInputModel formInput,
  }) async {
    String path = '$baseFuelUrl/$orgEnrollId${ApiPath.updateOperatorInfo}';
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

  // * Get Org By ID
  Future<Response> getOrgById({
    required String userOrgId,
    required String orgId,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.getOrgById}/$orgId';

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

  // Verify kyc to Organization
  Future<Response> verifyOrgKyc({
    required String userOrgId,
    required VerifyOrgKycInputModel formInput,
  }) async {
    String path = '$baseFuelUrl/$userOrgId${ApiPath.verifyOrgKyc}';
    try {
      Response response = await dio.post(
        path,
        data: formInput.toMap(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Create Corporate Wallet for LQTag Service

  Future<Response> createLqTagCorporateWallet({required String userOrgId, required String orgEnrollId}) async {
    String path = '$baseUrl/$userOrgId/upgrade-lqtag';
    try {
      Response response = await dio.post(
        path,
        data: {'organizationEnrollmentId': orgEnrollId},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getLqTagCorporateWallet({required String userOrgEnrollId, required String orgEnrollId}) async {
    String path = '$lqTagCorporateWalletUrl/$userOrgEnrollId/$orgEnrollId';
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
}
