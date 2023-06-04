import 'dart:convert';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/src/features/authentication/data/auth_repository.dart';
import 'package:axlerate/src/features/authentication/domain/auth_result.dart';
import 'package:axlerate/src/features/authentication/domain/auth_state.dart';
import 'package:axlerate/src/features/authentication/domain/user_decode_model.dart';
import 'package:axlerate/src/features/authentication/domain/user_model.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_constants.dart';
import 'package:axlerate/src/features/home/profile/presentation/controllers/profile_image_controller.dart';
import 'package:axlerate/src/features/home/profile/presentation/profile_page_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// Provides whether the authentication network call is in loading or not
final isAuthLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isLoading;
});

// Provides current auth result
final authResultProvider = Provider<AuthResult?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result;
});

final authTokenProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.token;
});

// Provide cussted logged in state
final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});

// Provides an instance of AuthStateNotifier
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(ref),
);

// It holds current AuthState
class AuthStateNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthStateNotifier(this.ref) : super(const AuthState.unknown()) {
    final isAlreadyLoggedIn = ref.watch(sharedPreferenceProvider).getBool(Storage.isLoggedIn) ?? false;
    if (isAlreadyLoggedIn) {
      state = const AuthState(
        result: AuthResult.success,
        isLoading: false,
      );
    }
  }

  void changeToUnknown() {
    state = const AuthState.unknown();
  }

  // Login with Credentials
  // Future<void> loginWithCredentials({
  //   required String username,
  //   required String password,
  // }) async {
  //   state = state.copiedWith(true);
  //   try {
  //     final Response result = await ref.read(authRepositoryProvider).loginWithCredentials(
  //           username: username,
  //           password: password,
  //         );
  //     UserModel user = UserModel.fromJson(result.data);

  //     // Storing keys in shared preferences
  //     await storeTokensInStorage(result.headers, user);
  //   } catch (e) {
  //     // debugPrint('${e} -> Token Error');
  //     Snackbar.error(ApiHelper.getErrorMessage(e));
  //     state = state.copiedWith(false);
  //   }
  // }

  // Login With OTP
  Future<String> loginWithOtp({required String number, required String otp}) async {
    state = state.copiedWith(true);
    String appType = 'mobile';
    if (kIsWeb) {
      appType = 'web';
    }
    try {
      final Response result = await ref.read(authRepositoryProvider).loginWithOtp(
            number: number,
            otp: otp,
            appType: appType,
          );
      UserModel user = UserModel.fromJson(result.data);
      final userStatus = user.data.message.status;
      if (userStatus == 'PENDING') {
        sendUserToNextPage(user, result.headers);
      } else {
        await storeTokensInStorage(result.headers, user);
      }
      // if (userStatus == 'ACTIVE') {
      //   // Storing keys in shared preferences
      //   await storeTokensInStorage(result.headers, user);
      // } else if (userStatus == 'PENDING') {
      //   firstTimeLoginWithOtp(result.headers);
      // }
      return "success";
    } catch (e) {
      // debugPrint('Exception while login with OTP :: $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      state = state.copiedWith(false);
      return ApiHelper.getErrorMessage(e).toString();
    }
  }

  // Set New Password when user clicks forgot password
  // Future<bool?> setNewPassword({
  //   required String contactId,
  //   required String otp,
  //   required String password,
  //   bool isEmail = false,
  // }) async {
  //   state = state.copiedWith(true);
  //   try {
  //     final Response result = await ref.read(authRepositoryProvider).setNewPassword(
  //           contactId: contactId,
  //           otp: otp,
  //           password: password,
  //           isEmail: isEmail,
  //         );
  //     UserModel user = UserModel.fromJson(result.data);

  //     // Storing keys in shared preferences
  //     await storeTokensInStorage(result.headers, user);
  //     bool userStatus = sendUserToNextPage(user, result.headers);
  //     return userStatus;
  //   } catch (e) {
  //     Snackbar.error(ApiHelper.getErrorMessage(e));
  //     state = state.copiedWith(false);
  //     return null;
  //   }
  // }

  // Activate Account
  Future<void> activateAccount({
    required String name,
    // required String password,
    required String contactId,
    required String otp,
  }) async {
    // state = state.copiedWith(true);
    try {
      final Response result = await ref.read(authRepositoryProvider).activateAccount(
            name: name,
            // password: password,
            otp: otp,
            contactId: contactId,
            isEmail: contactId.isEmail,
          );
      UserModel user = UserModel.fromJson(result.data);
      Snackbar.success('Account Activated Successfully');
      // Storing keys in shared preferences
      await storeTokensInStorage(result.headers, user);
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      state = state.copiedWith(false);
    }
  }

  // Logout User
  Future<bool> logout() async {
    // state = const AuthState.unknown();

    try {
      await ref.read(authRepositoryProvider).logout();
      axleApiCancelToken.cancel();
      axleApiCancelToken = CancelToken();
      Snackbar.warn('Logged out successfully');
      state = const AuthState.unknown();
      await ref.read(sharedPreferenceProvider).clear();
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      // state = const AuthState.unknown();
    }
    return false;
  }

  // Generate an OTP to verify (Used in profile Page)
  Future<bool> generateOtpToVerify({
    required String contactID,
    String? token,
    bool isEmail = false,
  }) async {
    state.copiedWith(true);
    try {
      if (token != null) {
        ref.read(sharedPreferenceProvider).setString(Storage.accessToken, token);
      }
      await ref.read(authRepositoryProvider).generateOtpToVerify(
            contactID: contactID,
            isEmail: isEmail,
          );
      Snackbar.success('OTP has been sent to $contactID');
      state.copiedWith(true);
      return true;
    } catch (e) {
      state.copiedWith(true);
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // Generate OTP
  Future<bool> generateOtp({
    required String contactMethod,
    bool isEmail = false,
  }) async {
    state = state.copiedWith(true);
    try {
      await ref.read(authRepositoryProvider).generateOtp(
            contactMethod: contactMethod,
            isEmail: isEmail,
          );
      Snackbar.success('OTP has been sent to $contactMethod');
      state = state.copiedWith(false);
      return true;
    } catch (e) {
      state = state.copiedWith(false);
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // Send user to next page depend on user status
  bool sendUserToNextPage(UserModel user, Headers headers) {
    final status = user.data.message.status;
    // log('User Status ---> $status');
    // log('x-auth-crt-pwd-token -> Token ---> ${headers.value('x-auth-crt-pwd-token')}');

    if (status == active) {
      state = AuthState.success(user);
      return true;
    } else if (status == 'PENDING') {
      final token = headers.value('x-auth-crt-pwd-token') ?? '';
      // Snackbar.success("Welcome, Kindly Activate your Account");
      if (token.isNotEmpty) {
        state = AuthState.pending(user, token);
      } else {
        state = AuthState.pending(user, null);
      }
      return false;
    } else {
      state = AuthState.pending(user, null);
      return false;
    }
  }

  Map<String, dynamic> getFromDecodedToken(Headers result) {
    final decoded = JwtDecoder.decode(result.value(accessToken) ?? '');
    return decoded;
  }

  Map<String, dynamic> getUserOrgnaizationsList(Map<String, dynamic> result) {
    // print('Only Orgs -> ${result['organizations']}');
    return result['organizations'];
  }

  // Store Tokens in Local Storage
  Future<void> storeTokensInStorage(Headers result, UserModel? user) async {
    // Storing Tokens
    await ref.read(sharedPreferenceProvider).setString(Storage.accessToken, result.value(accessToken) ?? '');
    await ref.read(sharedPreferenceProvider).setString(Storage.refreshToken, result.value(refreshToken) ?? '');

    try {
      UserDecodedModel decodeModel = UserDecodedModel.fromJson(getFromDecodedToken(result));
      // Storing major user data
      await ref.read(sharedPreferenceProvider).setString(Storage.userEnrollmentId, decodeModel.enrollmentId);
      // log('The ORGS are -> ${decodeModel.organizations}');

      await ref
          .read(sharedPreferenceProvider)
          .setString(Storage.userOrganisations, jsonEncode(decodeModel.organizations));
    } catch (e) {
      debugPrint('Exception while decoding token :: $e');
    }

    await getAndStoreProfileData();

    if (user != null) {
      final userData = user.data.message;
      await ref.read(sharedPreferenceProvider).setString(Storage.username, userData.name);
      await ref.read(sharedPreferenceProvider).setString(Storage.profileUrl, userData.profilePic ?? "");

      ref.read(profileImageStateProvider.notifier).state = userData.profilePic ?? "";

      // Setting logged in to true
      await ref.read(sharedPreferenceProvider).setBool(Storage.isLoggedIn, sendUserToNextPage(user, result));
    }
  }

  Future<void> getAndStoreProfileData() async {
    // log('Getting auth Profile Data');
    ref.read(profileDataStateProvider.notifier).state = await ref.read(profileControllerProvider).getUserProfileData();
    ref.read(profileDataStateProvider);
    // await ref.read(sharedPreferenceProvider).setString(Storage.userEmail, profileData?.data?.message?.email ?? '');
    // await ref
    //     .read(sharedPreferenceProvider)
    //     .setString(Storage.userMobile, profileData?.data?.message?.contactNumber ?? '');
  }
}
