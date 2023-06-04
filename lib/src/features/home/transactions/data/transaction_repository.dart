import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/domain/ppi_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_query_params.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionsRepoProvider = Provider<TransactionRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return TransactionRepository(dio);
});

class TransactionRepository {
  final Dio dio;

  TransactionRepository(this.dio);

  static String basePPITxnUrl = '${Strings.baseUrl}/api/ppi-transaction';
  static String baseTxnUrl = '${Strings.baseUrl}/api/transaction';
  static String baseLqUrl = '${Strings.baseUrl}/api/lqtag-transaction';
  static String baseFuelUrl = '${Strings.baseUrl}/api/fuel-transaction';

  // * Get PPI Transactions
  Future<Response> listPpiTransactions({
    required String userOrgEnrollId,
    required PpiTxnQueryParams? qParams,
  }) async {
    String path = '$basePPITxnUrl/$userOrgEnrollId${ApiPath.listPpiTransactions}';

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

  // * Get TAG Transactions
  Future<Response> listTagTransactions({
    required String userOrgEnrollId,
    required TagTxnQueryParams? qParams,
  }) async {
    String path = '$baseTxnUrl/$userOrgEnrollId';

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

  // * Get TAG Transactions
  Future<Response> listLqTagTransactions({
    required String userOrgId,
    required TagTxnQueryParams? qParams,
  }) async {
    String path = '$baseLqUrl/$userOrgId/list-transaction';

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

  // * Get Fuel Transactions
  Future<Response> listFuelTransactions({
    required String userOrgEnrollId,
    required FuelTxnQueryParams? qParams,
  }) async {
    String path = '$baseFuelUrl/$userOrgEnrollId';

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
