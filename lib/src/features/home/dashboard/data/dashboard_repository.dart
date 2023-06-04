import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/values/strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:axlerate/src/network/dio_client.dart';

final saDashRepositoryProvider = Provider<SaDashRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return SaDashRepository(dio);
});

class SaDashRepository {
  final Dio dio;

  const SaDashRepository(this.dio);

  static String baseDashUrl = '${Strings.baseUrl}/api/dashboard';

  // * Get  Dash Count
  Future<Response> getSaOrgDashCount({
    required String superOrgEnrollId,
  }) async {
    String path = '$baseDashUrl${ApiPath.superAdminDashCount}/$superOrgEnrollId';
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

  // * Get SA Dash TAG TXN Analytics
  // * dataType : 'year', 'week', 'day', 'month'
  Future<Response> getSaDashTagTxnAnalytics({
    required String userOrgId,
    required String dataType,
  }) async {
    String path = '$baseDashUrl${ApiPath.superAdmin}${ApiPath.tagAnalytics}/$userOrgId/$dataType';
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

  // * Get SA Dash PPI TXN Analytics
  // * dataType : 'year', 'week', 'day', 'month'
  Future<Response> getSaDashPpiTxnAnalytics({
    required String userOrgId,
    required String dataType,
  }) async {
    String path = '$baseDashUrl${ApiPath.superAdmin}${ApiPath.ppiAnalytics}/$userOrgId/$dataType';
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

  // * Get SA TAG revenue Analytics (Graph and Amosunt value)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<Response> getSaDashTagRevenueAnalytics({
    required String userOrgId,
    required String dataType,
    required bool isGraph,
  }) async {
    String path = '$baseDashUrl${ApiPath.superAdmin}${ApiPath.tagRewards}/$userOrgId/$dataType/$isGraph';
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

  // * Get SA PPI Revenue Analytics (Graph and Amount value)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<Response> getSaDashPpiRevenueAnalytics({
    required String userOrgId,
    required String dataType,
    required bool isGraph,
  }) async {
    String path = '$baseDashUrl${ApiPath.superAdmin}${ApiPath.ppiRewards}/$userOrgId/$dataType/$isGraph';
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
