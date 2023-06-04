import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:axlerate/src/features/home/partner/domain/create_partner_input_model.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final partnerRepositoryProvider = Provider<PartnerRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return PartnerRepository(dio);
});

class PartnerRepository {
  final Dio dio;

  const PartnerRepository(this.dio);

  static String baseUrl = '${Strings.baseUrl}/api/organization';
  static String baseDashUrl = '${Strings.baseUrl}/api/dashboard';

  Future<Response> createPartner({
    required String userOrgId,
    required CreatePartnerInputModel formInput,
  }) async {
    String path = '$baseUrl/$userOrgId${ApiPath.partner}';

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

  // * Get Partner Org Dash Count Info
  Future<Response> getPartnerDashCount({
    required String userOrgEnrollId,
    required String orgId,
  }) async {
    String path = '$baseDashUrl${ApiPath.partnerOrgCountInfoDash}/$userOrgEnrollId/$orgId';
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

  // * Get Partner Tag Rewards (Amount)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<Response> getPartnerTagReward({
    required String userOrgId,
    required String orgId,
    required String dataType,
    required bool isGraph,
  }) async {
    String path = '${Strings.baseUrl}${ApiPath.partnerDashTagRewardUnencodedPath}/$userOrgId/$orgId/$dataType/$isGraph';
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

  Future<Response> getPartnerLqTagReward({
    required String userOrgId,
    required String orgId,
    required String dataType,
    required bool isGraph,
  }) async {
    String path =
        '${Strings.baseUrl}${ApiPath.partnerDashLqTagRewardUnencodedPath}/$userOrgId/$orgId/$dataType/$isGraph';
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

  // * Get Partner PPI Rewards (Amount)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<Response> getPartnerPpiReward({
    required String userOrgId,
    required String orgId,
    required String dataType,
    required bool isGraph,
  }) async {
    String path = '${Strings.baseUrl}${ApiPath.partnerDashPpiRewardUnencodedPath}/$userOrgId/$orgId/$dataType/$isGraph';
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

  Future<Response> getPartnerDashTagTxnAnalytics({
    required String userOrgId,
    required String orgId,
    required String dataType,
  }) async {
    String path = '${Strings.baseUrl}${ApiPath.partnerDashTagAnalyticsUnencodedPath}/$userOrgId/$orgId/$dataType';
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

  Future<Response> getPartnerDashPpiTxnAnalytics({
    required String userOrgId,
    required String orgId,
    required String dataType,
  }) async {
    String path = '${Strings.baseUrl}${ApiPath.partnerDashPpiAnalyticsUnencodedPath}/$userOrgId/$orgId/$dataType';
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

  Future<Response> getOrgWiseCommissionData(
      {required String userOrgId, required String orgId, required String startDate, required String endDate}) async {
    String path = "${Strings.baseUrl}/api/report/$userOrgId/get-cashback-summary";
    Map<String, dynamic> queryParams = {'organizationEnrollmentId': orgId, 'fromDate': startDate, 'toDate': endDate};
    try {
      Response resp = await dio.get(path, queryParameters: queryParams);

      return resp;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> downloadOrgWiseCommissionData(
      {required String userOrgId,
      required String orgId,
      required String startDate,
      required String endDate,
      String? fileType}) async {
    String path = "${Strings.baseUrl}/api/report/$userOrgId/get-cashback-summary";
    Map<String, dynamic> queryParams = {'organizationEnrollmentId': orgId, 'fromDate': startDate, 'toDate': endDate};
    if (fileType != null) queryParams.addAll({'fileType': fileType});
    try {
      Response resp = await dio.get(path, queryParameters: queryParams);

      return resp;
    } catch (e) {
      rethrow;
    }
  }

  Future downloadFile(String url, String path) async {
    try {
      await dio.download(url, path);
    } catch (e) {
      rethrow;
    }
  }
}
