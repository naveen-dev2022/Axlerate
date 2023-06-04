import 'package:axlerate/src/network/axle_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

CancelToken axleApiCancelToken = CancelToken();
// CancelToken getVehiclesListApiCancelToken = CancelToken();

final dioProvider = Provider<DioClient>((ref) {
  return DioClient(ref);
});

class DioClient {
  final Ref ref;

  final Dio _dio = Dio();

  Dio get dio => _dio;

  DioClient(this.ref) {
    _dio.interceptors.add(AxlerateInterceptor(_dio, ref));
    _dio.interceptors.add(
      RetryInterceptor(
        retryDelays: const [Duration(seconds: 2), Duration(seconds: 3)],
        dio: _dio,
        retryableExtraStatuses: {498},
        retries: 2,
      ),
    );
  }
}
