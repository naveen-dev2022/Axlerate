import 'package:axlerate/src/features/home/profile/data/profile_repository.dart';
import 'package:axlerate/src/features/home/profile/domain/user_profile_model.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUserProfileDataProvider = FutureProvider.autoDispose<UserProfileModel?>(
  (ref) async {
    try {
      Response response = await ref.read(profileRepositoryProvider).getUserProfile();
      UserProfileModel userProfile = UserProfileModel.fromJson(response.data);
      return userProfile;
    } catch (e) {
      Snackbar.error(
        ApiHelper.getErrorMessage(e),
      );
      return null;
    }
  },
);

final profileDataStateProvider = StateProvider<UserProfileModel?>((ref) {
  return null;
});

final profileControllerProvider = Provider<ProfileController>((ref) {
  final ProfileRepository profileRepo = ref.watch(profileRepositoryProvider);
  return ProfileController(ref, profileRepo);
});

class ProfileController {
  final ProfileRepository profileRepository;
  final Ref ref;

  const ProfileController(this.ref, this.profileRepository);

  Future<UserProfileModel> getUserProfileData() async {
    UserProfileModel res = UserProfileModel.unknown();
    try {
      Response response = await ref.read(profileRepositoryProvider).getUserProfile();
      res = UserProfileModel.fromJson(response.data);
      return res;
    } catch (e) {
      Snackbar.error(
        ApiHelper.getErrorMessage(e),
      );
      return res;
    }
  }

  // Generate an OTP to verify (Used in profile Page)
  Future<bool> generateOtpToVerify({
    required String contactID,
    bool isEmail = false,
  }) async {
    try {
      await profileRepository.generateOtpToVerify(
        contactID: contactID,
        isEmail: isEmail,
      );
      Snackbar.success('OTP has been sent to $contactID');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Change Password
  Future<bool> changePassword({
    required String oldPass,
    required String newPass,
  }) async {
    try {
      await profileRepository.changePassword(
        oldPass: oldPass,
        newPass: newPass,
      );
      Snackbar.success('Password updated successfully');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // verify OTP which is generated to Verify
  Future<bool> verifyOtpForContactAddress({
    required String contactID,
    required String otp,
    bool isEmail = false,
  }) async {
    try {
      await profileRepository.verifyOtpForContactAddress(
        contactID: contactID,
        otp: otp,
        isEmail: isEmail,
      );
      // UserModel user = UserModel.fromJson(response.data);
      Snackbar.success('OTP Verified Successfully');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  Future<bool> uploadProfilePic({
    required String enrollmentId,
    required String url,
  }) async {
    try {
      await profileRepository.uploadProfilePic(
        enrollmentId: enrollmentId,
        url: url,
      );
      Snackbar.success('Profile Updated Successfully');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }
}
