import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileUploadRepoProvider = Provider<FileUploadRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return FileUploadRepository(dio);
});

class FileUploadRepository {
  const FileUploadRepository(this.dio);

  final Dio dio;

  static String baseUrl = '${Strings.baseUrl}/api/cloud-storage';

  Future<Response> getSignedUrl({
    required String mimeType,
    required String type,
    required String enrollmentId,
  }) async {
    String path = '$baseUrl${ApiPath.fileUploadSignedUrl}';
    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          'mimeType': mimeType,
          'type': type,
          'enrollmentId': enrollmentId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> downloadSignedUrl({
    required String url,
  }) async {
    String path = '$baseUrl${ApiPath.fileDownloadSignedUrl}';
    try {
      Response response = await dio.get(
        path,
        queryParameters: {
          'path': url,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
