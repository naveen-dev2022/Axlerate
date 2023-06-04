import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../network/api_helper.dart';
import '../../../../../utils/snackbar_util.dart';
import '../../data/ecard_repository.dart';
import '../../domain/aadhaar_otp_entity.dart';
import '../../domain/aadhaar_otp_verified_model.dart';
import '../../domain/challan_entity.dart';
import '../../domain/cibil_detail_entity.dart';
import '../../domain/driving_license_entity.dart';
import '../../domain/pan_entity.dart';
import '../../domain/rc_entity.dart';

final eCardControllerProvider = Provider<ECardController>((ref) {
  return ECardController(ref);
});

final challanStateProvider = StateProvider<ChallanEntity?>((ref) {
  return null;
});

final rcStateProvider = StateProvider<RcEntity?>((ref) {
  return null;
});

final panStateProvider = StateProvider<PanEntity?>((ref) {
  return null;
});

final aadhaarOtpStateProvider = StateProvider<AadhaarOtpEntity?>((ref) {
  return null;
});

final verifyAadhaarOtpStateProvider =
    StateProvider<AadhaarOtpVerifiedModel?>((ref) {
  return null;
});

final drivingLicenseStateProvider = StateProvider<DrivingLicenseEntity?>((ref) {
  return null;
});

final cbilStateProvider = StateProvider<CibilDetailEntity?>((ref) {
  return null;
});

class ECardController {
  const ECardController(this.ref);

  final Ref ref;

  Future<ChallanEntity> fetchChallanData(
      String vehicleId, String chassis) async {
    ChallanEntity res = ChallanEntity.unknown();

    Map<String, dynamic> postParam = {
      "vehicle_id": "TN47BA8943",
      "chassis": "MD2JYCXGXMC003844"
    };

    try {
      // String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref
          .read(eCardRepositoryProvider)
          .getChallanData(postParam: postParam);

      try {
        res = ChallanEntity.fromJson(result.data);
        return res;
      } catch (e) {
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<RcEntity> fetchRcDetailsData({
    required String idNumber,
  }) async {
    RcEntity res = RcEntity.unknown();

    Map<String, dynamic> postParam = {"id_number": "TN38CH1948"};

    try {
      // String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref
          .read(eCardRepositoryProvider)
          .getRcData(postParam: postParam);

      try {
        res = RcEntity.fromJson(result.data);
        return res;
      } catch (e) {
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<PanEntity> fetchPanDetailsData({
    required String idNumber,
  }) async {
    PanEntity res = PanEntity.unknown();

    Map<String, dynamic> postParam = {"id_number": "LIHPS5643H"};

    try {
      // String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref
          .read(eCardRepositoryProvider)
          .getPanData(postParam: postParam);

      try {
        res = PanEntity.fromJson(result.data);
        return res;
      } catch (e) {
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<AadhaarOtpEntity> fetchAadhaarOtp({
    required String idNumber,
  }) async {
    AadhaarOtpEntity res = AadhaarOtpEntity.unknown();

    Map<String, dynamic> postParam = {"id_number": "895678459858"};

    try {
      // String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref
          .read(eCardRepositoryProvider)
          .getAadhaarOtp(postParam: postParam);

      try {
        res = AadhaarOtpEntity.fromJson(result.data);
        return res;
      } catch (e) {
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<AadhaarOtpVerifiedModel> fetchVerifyAadhaarOtp({
    required String? otp,
    required String? clientId,
  }) async {
    AadhaarOtpVerifiedModel res = AadhaarOtpVerifiedModel.unknown();

    Map<String, dynamic> postParam = {"otp": "123456", "client_id": '123'};

    try {
      // String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref
          .read(eCardRepositoryProvider)
          .verifyOtpGetData(postParam: postParam);

      try {
        res = AadhaarOtpVerifiedModel.fromJson(result.data);
        return res;
      } catch (e) {
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<DrivingLicenseEntity> fetchDrivingLicenseData({
    required String? idNumber,
  }) async {
    DrivingLicenseEntity res = DrivingLicenseEntity.unknown();

    Map<String, dynamic> postParam = {"id_number": "TN3820190002729"};

    try {
      // String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref
          .read(eCardRepositoryProvider)
          .drivingLicenseData(postParam: postParam);

      try {
        res = DrivingLicenseEntity.fromJson(result.data);
        return res;
      } catch (e) {
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<CibilDetailEntity> fetchCibilData({
    required String? fName,
    required String? lName,
    required String? phoneNumber,
    required String? panNum,
  }) async {
    CibilDetailEntity res = CibilDetailEntity.unknown();

    Map<String, dynamic> postParam = {
      "fname": "siva",
      "lname": "bannari",
      "phone_number": "6369363211",
      "pan_num": "LIHPS5643H"
    };

    try {
      // String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(eCardRepositoryProvider).getCibilData(
            postParam: postParam,
          );

      try {
        res = CibilDetailEntity.fromJson(result.data);
        return res;
      } catch (e) {
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }
}
