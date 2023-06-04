import 'dart:io';

import 'package:axlerate/app_util/enums/report_file_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FileDownloadUtil {
  static getFileFromUrl(String url, ReportFileType fileType) async {
    try {
      // String url = result.data['data']['message'];
      Dio dio = Dio();

      if (kIsWeb) {
        await launchUrl(Uri.parse(url));
      } else {
        String path;

        Directory tempDir = await getApplicationDocumentsDirectory();
        tempDir.create();
        Directory dir = await tempDir.createTemp("axle");
        path = dir.path;

        String fileName = url.split('/').last.split('?').first;
        String filePath = '$path/$fileName';

        try {
          await dio.download(url, filePath);
        } catch (e) {
          rethrow;
        }
        await OpenFilex.open(filePath, type: fileType.mimeType);

        // await dir.delete(recursive: true);
      }
      return url;
    } catch (e) {
      debugPrint('Error downloading file :: $e');
      rethrow;
    }
  }
}
