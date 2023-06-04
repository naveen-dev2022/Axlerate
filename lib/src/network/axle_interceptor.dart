import 'dart:convert';

import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AxlerateInterceptor extends QueuedInterceptor {
  final Dio dio;
  final Ref ref;

  AxlerateInterceptor(this.dio, this.ref);
  bool isGetRefreshTokenCalled = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String token = ref.read(sharedPreferenceProvider).getString(Storage.accessToken) ?? '';
    if (token.isNotEmpty) {
      bool hasExpired = JwtDecoder.isExpired(token);

      if (hasExpired) {
        try {
          token = await getRefreshToken() ?? '';
        } catch (e) {
          // debugPrint("Exception while getting Refresh Token ::  $e");
        }
      }
    } else {
      token = ref.read(sharedPreferenceProvider).getString(Storage.createPasswordToken) ?? '';
    }

    options.headers.addAll({
      "Authorization": "Bearer $token",
    });
    debugPrint('Request Path -> ${options.path}');
    debugPrint('Request params -> ${options.queryParameters}');
    // debugPrint('Request headers -> ${options.headers}');
    debugPrint('Request data -> ${options.data}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response Status Code -> ${response.statusCode}');
    debugPrint('Response Status Message -> ${response.statusMessage}');
    debugPrint('Response data ${response.realUri} -> -> ${jsonEncode(response.data)}');

    if (response.headers.value(Strings.xAuthToken) != null) {
      // debugPrint("Sending FCM Token");
      sendFcmToken(response.headers.value(Strings.xAuthToken)!);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // debugPrint('ERROR! ${err.response?.toString()}');
    debugPrint('ERROR Message -> ${err.message}');
    debugPrint('ERROR Status Code -> ${err.response?.statusCode}');
    debugPrint('ERROR URL PATH-> ${err.requestOptions.path}');

    // debugPrint('ERROR Code Message -> ${err.response?.data['errorCode']}');
    // debugPrint('ERROR Type -> ${err.type}');

    int errorStatusCode = err.response?.statusCode ?? 0;
    String errorCodeMessage = err.response?.data['errorCode'] ?? '';

    if (errorStatusCode == 498 && errorCodeMessage == "INV_TOKEN") {
      // axleApiCancelToken.cancel();
      if (!isGetRefreshTokenCalled) {
        isGetRefreshTokenCalled = true;
        getRefreshToken();
      }
    }

    super.onError(err, handler);
  }

  Future<String?> getRefreshToken() async {
    // debugPrint('REQUEST[GET] => PATH: ${Strings.baseUrl + Strings.refreshTokenUnencodedPath}');
    try {
      String refreshToken = ref.read(sharedPreferenceProvider).getString(Storage.refreshToken) ?? '';
      if (refreshToken.isNotEmpty) {
        Response response = await Dio().get(Strings.baseUrl + Strings.refreshTokenUnencodedPath,
            options: Options(
              headers: {
                'Authorization': "Bearer $refreshToken",
              },
            ),
            cancelToken: axleApiCancelToken);
        String xAuthToken = response.headers.value(Strings.xAuthToken)!;
        //String xAuthRefreshToken = response.headers.value(Strings.xAuthRefreshToken)!;
        // debugPrint("interceptor x Auth Token :: $xAuthToken");
        // debugPrint("interceptor x Auth Refresh Token :: $xAuthRefreshToken");

        // // Storing Tokens
        // await ref.watch(sharedPreferenceProvider).setString(Storage.accessToken, xAuthToken);
        // await ref.watch(sharedPreferenceProvider).setString(Storage.refreshToken, xAuthRefreshToken);

        await ref.read(authStateProvider.notifier).storeTokensInStorage(response.headers, null);

        // axleApiCancelToken = CancelToken();
        isGetRefreshTokenCalled = false;
        return xAuthToken;
      } else {
        isGetRefreshTokenCalled = false;
        return Future.error('Session Expired. Please login to continue');
      }
    } catch (e) {
      isGetRefreshTokenCalled = false;
      // debugPrint("Get Refresh Token Error :: $e");

      // Clear Preferences
      await ref.read(sharedPreferenceProvider).clear();
      ref.read(authStateProvider.notifier).changeToUnknown();
      // Logout the user redirect to Login Screen
      // ref.read(appRouterProvider).router.go('/auth/login');

      return Future.error(e);
    }
  }

  Future<void> sendFcmToken(String authToken) async {
    // debugPrint('REQUEST[POST] => PATH: ${Strings.baseUrl + Strings.fcmTokenUnencodedPath}');

    await FirebaseMessaging.instance.getToken().then((fcmtoken) async {
      // debugPrint("FCM Token successful - $fcmtoken");
      try {
        await Dio().patch(
          Strings.baseUrl + Strings.fcmTokenUnencodedPath,
          data: {'fcmToken': fcmtoken},
          options: Options(
            headers: {
              'Authorization': "Bearer $authToken",
            },
          ),
        );
      } catch (e) {
        // debugPrint("Update FCM Token Error :: $e.message");
      }
    }).catchError((error) {
      // ("Unable to Generate FCM Token", error: error, level: 5);
      // debugPrint(error.toString());
    });
  }
}
