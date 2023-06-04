import 'package:axlerate/main.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return AuthRepository(dio);
});

class AuthRepository {
  final Dio dio;

  const AuthRepository(this.dio);

  static String baseUserApi = '${Strings.baseUrl}/api/user';

  // Login with credentials
  // Future<Response> loginWithCredentials({
  //   required String username,
  //   required String password,
  // }) async {
  //   String path = '$baseUserApi${ApiPath.login}';

  //   String recaptchaToken = "";
  //   try {
  //     recaptchaToken = await appCheck.getToken(false) ?? "";
  //     // debugPrint("App Check Token :: $recaptchaToken");
  //   } catch (e) {
  //     Snackbar.error("Too many requests, please try again");
  //     // debugPrint("Exception while getting App Check Token :: $e");
  //   }
  //   String appType = kIsWeb ? "web" : "mobile";

  //   try {
  //     // Make API Call
  //     Response response = await dio.post(
  //       path,
  //       data: {
  //         "userName": username,
  //         "password": password,
  //         "appType": appType,
  //       },
  //       options: Options(
  //         headers: {
  //           'X-Firebase-AppCheck': recaptchaToken,
  //         },
  //       ),
  //     );

  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Login with OTP;
  Future<Response> loginWithOtp({required String number, required String otp, required String appType}) async {
    String path = '$baseUserApi${ApiPath.loginWithOtp}';
    String recaptchaToken = "";

    try {
      recaptchaToken = await appCheck.getToken(false) ?? "";
    } catch (e) {
      Snackbar.error("Too many requests, please try again");
      // debugPrint("Exception while getting App Check Token :: $e");
    }
    try {
      Response response = await dio.post(
        path,
        data: {"contactNumber": number, "otp": otp, "appType": appType},
        options: Options(
          headers: {
            'X-Firebase-AppCheck': recaptchaToken,
          },
        ),
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Set New Password - When users clicks forgot password
  // Future<Response> setNewPassword({
  //   required String contactId,
  //   required String otp,
  //   required String password,
  //   bool isEmail = false,
  // }) async {
  //   String path = '$baseUserApi${ApiPath.setNewPassword}';

  //   try {
  //     Response response = await dio.patch(
  //       path,
  //       data: {
  //         "userName": {
  //           isEmail ? "email" : "contactNumber": contactId,
  //         },
  //         "otp": otp,
  //         "password": password,
  //         "appType": "web"
  //       },
  //     );

  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Activate account
  Future<Response> activateAccount({
    required String name,
    // required String password,
    required String contactId,
    required bool isEmail,
    required String otp,
  }) async {
    String path = '$baseUserApi${ApiPath.activateAccount}';

    Map<String, String> queryParameters = {
      "name": name,
      "appType": kIsWeb ? "web" : "mobile",
    };

    // if (contactId.isNotEmpty && otp.isNotEmpty) {
    if (contactId.isNotEmpty) {
      queryParameters.addAll({
        isEmail ? 'email' : 'contactNumber': contactId,
      });
    }

    if (otp.isNotEmpty) {
      queryParameters.addAll({
        'otp': otp,
      });
    }

    try {
      Response response = await dio.patch(
        path,
        data: queryParameters,
        cancelToken: axleApiCancelToken,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Logout User
  Future<Response> logout() async {
    String path = '$baseUserApi${ApiPath.logout}';
    try {
      Response response = await dio.patch(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Generate OTP to verify contact number
  Future<void> generateOtpToVerify({
    required String contactID,
    bool isEmail = false,
  }) async {
    String path = '$baseUserApi${ApiPath.verifyGenerateOtp}';
    try {
      await dio.patch(
        path,
        data: {
          "userName": {
            isEmail ? "email" : "contactNumber": contactID,
          }
        },
        cancelToken: axleApiCancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Generate OTP (To Login)
  Future<void> generateOtp({
    required String contactMethod,
    bool isEmail = false,
  }) async {
    String path = '$baseUserApi${ApiPath.generateOtp}';
    String recaptchaToken = "";
    try {
      recaptchaToken = await appCheck.getToken(false) ?? "";
    } catch (e) {
      Snackbar.error("Too many requests, please try again");
      // debugPrint("Exception while getting App Check Token :: $e");
    }
    try {
      await dio.patch(
        path,
        data: {
          "userName": {
            isEmail ? "email" : "contactNumber": contactMethod,
          },
        },
        options: Options(
          headers: {
            'X-Firebase-AppCheck': recaptchaToken,
          },
        ),
        cancelToken: axleApiCancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }
}
