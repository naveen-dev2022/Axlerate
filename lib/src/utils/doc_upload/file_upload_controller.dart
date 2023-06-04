import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_repository.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileUploadControllerProvider = Provider<FileUploadController>((ref) {
  return FileUploadController(ref);
});

class FileUploadController {
  const FileUploadController(this.ref);

  final Ref ref;

  Future<String> getSignedUrl({
    required String mimeType,
    required String type,
    required String enrollmentId,
  }) async {
    try {
      Response result = await ref.read(fileUploadRepoProvider).getSignedUrl(
            mimeType: mimeType,
            type: type,
            enrollmentId: enrollmentId,
          );
      final String url = result.data['data']['message'];
      return url;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '';
    }
  }

  Future<String> fileDownloadSignedUrl({
    required String urlStr,
  }) async {
    try {
      Response result = await ref.read(fileUploadRepoProvider).downloadSignedUrl(
            url: urlStr,
          );
      debugPrint('The download response is ---> ${result.data}');
      final String url = result.data['data']['message'];
      return url;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '';
    }
  }
}
