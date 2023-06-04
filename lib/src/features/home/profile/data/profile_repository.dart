import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  Dio dio = ref.watch(dioProvider).dio;
  return ProfileRepository(dio);
});

class ProfileRepository {
  final Dio dio;

  const ProfileRepository(this.dio);

  static String baseUserApi = '${Strings.baseUrl}/api/user';
  // static const baseUserApi = 'http://staging-api.axlerate.com:3000/api/user';

  // Get user profile
  Future<Response> getUserProfile() async {
    String path = '$baseUserApi${ApiPath.userProfile}';
    try {
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Change Password
  Future<Response> changePassword({
    required String oldPass,
    required String newPass,
  }) async {
    String path = '$baseUserApi${ApiPath.passwordChange}';
    try {
      Response response = await dio.patch(
        path,
        data: {
          "oldPassword": oldPass,
          "newPassword": newPass,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Generate an OTP to verify (Used in profile Page)
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

  // Verify the OTP for given contact address(Email or Mobile number) - Used in Profile Page
  Future<Response> verifyOtpForContactAddress({
    required String contactID,
    required String otp,
    bool isEmail = false,
  }) async {
    String path = '$baseUserApi${ApiPath.verifyOtp}';
    try {
      Response response = await dio.patch(
        path,
        data: {
          "userName": {isEmail ? "email" : "contactNumber": contactID},
          "otp": otp
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadProfilePic({required String enrollmentId, required String url}) async {
    String path = '$baseUserApi${ApiPath.uploadProfilePic}';
    try {
      await dio.patch(
        path,
        data: {
          "enrollmentId": enrollmentId,
          "profileUrl": url,
        },
        cancelToken: axleApiCancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }
}
