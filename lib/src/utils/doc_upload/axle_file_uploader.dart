// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

///Helper class to handle file uploads throughout the app.
class AxleFileUploader {
  late Client _client;

  ///Helper class to handle file uploads throughout the app.
  ///[httpClient] - Used only for testing purpose.
  AxleFileUploader({Client? httpClient}) {
    if (httpClient != null) {
      _client = httpClient;
    } else {
      _client = Client();
    }
  }

  /// Uploades the file in the specified [url].
  /// [imageFile] - image as [File].
  /// [imageBytes] - image as  [Uint8List].
  /// If [imageFile] is specified, it will be automatically converted to [imageBytes].
  /// Error will be thrown if both [imageFile] and [imageBytes] are [Null].
  Future<void> uploadFile(String url, {File? imageFile, Uint8List? imageBytes}) async {
    try {
      if (imageBytes == null) {
        throw "invalid data";
      }
      // imageBytes ??= await imageFile!.readAsBytes();
      Response response = await _client.put(Uri.parse(url), body: imageBytes);
      // log("uploadFile Url : $url");
      // log("uploadFile Status code : ${response.statusCode}");
      // log("uploadFile Response body : ${response.body}");
      if (response.statusCode != 200) {
        throw response.body;
      }
    } catch (e) {
      // debugPrint('error while uploading file : $e');
      return await Future.error(e);
    }
  }
}
