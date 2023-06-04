import 'package:axlerate/src/utils/doc_upload/axle_file_uploader.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_controller.dart';
import 'package:axlerate/src/utils/snackbar_strings.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'dart:convert' show utf8;

final fileUploadProvider = Provider<FileUploadUtil>((ref) {
  return FileUploadUtil(ref);
});

class FileUploadUtil {
  FileUploadUtil(this.ref);

  final Ref ref;

  static final allTypeList = ['jpg', 'jpeg', 'png', 'pdf'];
  static final allImageList = ['jpg', 'jpeg', 'png'];
  static final onlyPdfList = ['pdf'];

  // Picks File and returns the bytes as Uint8List type
  // NOTE: When you access file.path - on web path is always null
  static Future<Map<String, String>?> pickImagefromGallery(
    WidgetRef ref, {
    required String docType,
    required String orgEnrollId,
    bool showSuccessSnackbar = true,
    bool allowPdf = false,
    bool onlyPdf = false,
    FileType axleFileType = FileType.custom,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: axleFileType == FileType.custom
          ? onlyPdf
              ? onlyPdfList
              : allowPdf
                  ? allTypeList
                  : allImageList
          : null,
      type: axleFileType,
      allowCompression: true,
      withData: true,
    );

    if (result != null) {
      PlatformFile pickedImage = result.files.first;
      // log('Image Size: ${pickedImage.size}');
      // log('Image Format: ${pickedImage.extension}');
      // log('Image Name: ${pickedImage.name}');
      // log('Image Identifier: ${pickedImage.identifier}');

      if (pickedImage.size > 3000000) {
        Snackbar.error(SnackbarStrings.imagLessThanMsg);
      } else if (!(allowPdf
          ? allTypeList.contains(pickedImage.extension!.toLowerCase())
          : allImageList.contains(pickedImage.extension!.toLowerCase()))) {
        Snackbar.error(SnackbarStrings.fileTypeAllowedMsg);
      } else {
        // log('Entering -> UploadBytes withLink');
        try {
          String url = await uploadBytesWithLink(
            ref,
            bytes: pickedImage.bytes,
            mimeType: getMimeType(pickedImage) ?? '',
            docType: docType,
            orgEnrollId: orgEnrollId,
          );
          // log('URL is -> $url');
          // Snackbar.success(url.split('?').first);
          if (showSuccessSnackbar) {
            Snackbar.success('File Uploaded Successfully');
          }
          // log('Got Signed URL');
          return {
            'url': url.split('?').first,
            'name': pickedImage.name,
          };
        } catch (e) {
          // debugPrint(e.toString());
          Snackbar.error('Upload Error');
          return null;
        }
      }
    } else {
      debugPrint("Error while getting Image from Gallery");
    }
    return null;
  }

  static Future uploadBytesWithLink(
    WidgetRef ref, {
    required Uint8List? bytes,
    required String mimeType,
    required String docType,
    required String orgEnrollId,
  }) async {
    // print('Uploading -> $mimeType');
    // print('Uploading -> $docType');
    // print('Uploading -> $orgEnrollId');

    final url = await ref
        .read(fileUploadControllerProvider)
        .getSignedUrl(mimeType: mimeType, type: docType, enrollmentId: orgEnrollId);
    // log('Inside function -> Got the URL - is $url');
    // log('Bytes is -> $bytes');

    if (!isValidUrl(url)) throw ("Invalid URL from Server");

    AxleFileUploader fileUploader = AxleFileUploader();
    await fileUploader.uploadFile(url, imageBytes: bytes);
    return url;
  }

  static String? getMimeType(PlatformFile file) {
    return lookupMimeType(file.name);
  }

  static bool isValidUrl(String url) {
    if (Flavor.I.environment == Environment.production) {
      // debugPrint("Checking valid url for PROD");
      return url.startsWith('https://axlerate.s3.ap-south-1.amazonaws.com/', 0) ||
          url.startsWith('https://s3.ap-south-1.amazonaws.com/axlerate/', 0);
    } else {
      // debugPrint("Checking valid url for non PROD");
      return url.startsWith('https://axle-tag-dev.s3.ap-south-1.amazonaws.com/', 0) ||
          url.startsWith('https://s3.ap-south-1.amazonaws.com/axle-tag-dev/', 0);
    }
  }
}

class CSVFileUploadUtil {
  static final allowedDocumentExtensions = ['csv'];

  static Future<String?> pickCsvFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, allowedExtensions: allowedDocumentExtensions, type: FileType.custom, withData: true);

    // return result?.files[0].bytes;
    if (result != null) {
      //final file = result.files.first;
      final bytes = utf8.decode((result.files.first.bytes)!.toList());

      return bytes;

      // String s = String.fromCharCodes(file.bytes);
      //   // Get the UTF8 decode as a Uint8List
      //   var outputAsUint8List = Uint8List.fromList(file.bytes..codeUnits);
      //   // split the Uint8List by newline characters to get the csv file rows
      //   csvFileContentList = utf8.decode(file.bytes?.buffer.asInt16List()).split('\n');
      //   print('Selected CSV File contents: ');
      //   print(csvFileContentList);
      // // final input = File(file.bytes).openRead();
      // final fields = await file.bytes!
      //     .transform(utf8.decoder)
      //     .transform(const CsvToListConverter())
      //     .toList();

      // print(fields);
    }

    throw ("File was not picked");
  }
}
