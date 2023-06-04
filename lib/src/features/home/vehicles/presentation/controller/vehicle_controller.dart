import 'package:axlerate/src/features/home/logistics/domain/fuel_limit_vehicle_input_model.dart';
import 'package:axlerate/src/features/home/services/domain/response_model.dart';
import 'package:axlerate/src/features/home/vehicles/data/vehicle_repository.dart';
import 'package:axlerate/src/features/home/vehicles/domain/create_vehicle_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/list_lq_tag_vehicle_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/enable_fuel_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/enable_gps_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/lq_tag_account_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/lqtag_admin_org_response_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/yesbank_tag_account_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_fastag_service_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_list_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_lqtag_service_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/verify_veh_kyc_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/simple_vehicle_list.dart';
import 'package:axlerate/src/features/home/vehicles/domain/simple_vehicle_list_query_params.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_tag_txn_list_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_gps_acc_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_acc_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_gps_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_last_debit_txn_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_query_params.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_trip_history_model.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/tag_documnets_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vehicleDetailsProvider = StateProvider<Vehicle?>((ref) {
  return null;
});

final listofVehiclesStateProvider = StateProvider<ListVehicleUpdatedModel?>((ref) {
  return null;
});

final vehicleControllerProvider = Provider<VehicleController>((ref) {
  return VehicleController(ref);
});

final listofLqTagVehiclesStateProvider = StateProvider<ListLqtagVehicles?>((ref) {
  return null;
});

final listofLQTagAdminOrgUserStateProvider = StateProvider<LqTagAdminOrgResponseModel?>((ref) {
  return null;
});
final listofVehicleStateProvider = StateProvider<SimpleVehicleListModel?>((ref) {
  return null;
});

class VehicleController {
  final Ref ref;

  const VehicleController(this.ref);

  // * Create Vehicle (POST)
  Future<bool> createVehicle(CreateVehicleInputModel formData) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).createVehicle(userOrgId, formData: formData);
      Snackbar.success(ApiHelper.getSuccessMessage(result));
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Get Vehicle List (GET)
  Future<ListVehicleUpdatedModel> getVehiclesList({required VehicleQueryParams? params}) async {
    ListVehicleUpdatedModel res = const ListVehicleUpdatedModel.unknown();
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getVehiclesList(userOrgId, params: params);
      try {
        res = ListVehicleUpdatedModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('List vehicleERROR -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<bool> enableTagService(VehicleFastTagServiceInputModel formData) async {
    try {
      // log('In Controller');
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).enableFastagForVehicle(userOrgId, formData);
      Snackbar.success('Service enabled successfully');
      return true;
    } catch (e) {
      // debugPrint('In Controller - Error -> $e');

      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  Future<bool> enableLqTagService(VehicleLqTagInputModel formData) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).enableLqtagForVehicle(userOrgId, formData);
      Snackbar.success('Service enabled successfully');
      return true;
    } catch (e) {
      // debugPrint('In enableLqTagService Controller - Error -> $e');

      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  Future<bool> changeLQFastagAdmin(String organizationId, String vehicleEntityId, String parentEntityId) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      await ref
          .read(vehicleRepoProvider)
          .changeLQFastagAdmin(userOrgId, organizationId, vehicleEntityId, parentEntityId);
      Snackbar.success('LQ FASTag Admin changed successfully');
      return true;
    } catch (e) {
      debugPrint('Error in changing LQ FASTag Admin :: $e');

      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  Future<bool> enableGpsService(EnableGpsInputModel formData) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).enableGpsForVehicle(userOrgId, formData);
      Snackbar.success('Service enabled successfully');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  Future<String?> getTagClass({required String serialNum}) async {
    final statusReader = ref.read(tagStatusIconProvider.notifier);
    statusReader.state = const SizedBox(height: 16.0, width: 16.0, child: CircularProgressIndicator());

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getTagclass(userOrgId, serialNum: serialNum);
      try {
        String res = result.data['data']['message']['class'];
        // log('Data is ------> $res');
        statusReader.state = const Icon(
          Icons.check,
          size: 16.0,
          color: Colors.green,
        );
        return res;
      } catch (e) {
        statusReader.state = const Icon(
          Icons.close,
          size: 16.0,
          color: Colors.redAccent,
        );
        // log('Data is ----After--> 1213');

        return null;
      }
    } catch (e) {
      statusReader.state = const Icon(
        Icons.close,
        size: 16.0,
        color: Colors.redAccent,
      );
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return null;
    }
  }

  // * Get vehicle details by ID
  Future<DetailVehicleUpdatedModel> getVehicleDetailsById({required String vehicleId}) async {
    DetailVehicleUpdatedModel res = const DetailVehicleUpdatedModel.unknown();
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getVehicleDetails(userOrgId, vehicleId: vehicleId);
      try {
        res = DetailVehicleUpdatedModel.fromJson(result.data);
        // debugPrint("Vehicle Details :: ${jsonEncode(result.data)}");
        return res;
      } catch (e) {
        // debugPrint('Vehicle Details Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('Controler Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get vehicle details by RegistrationNumber
  Future<void> getVehicleByRegistrationNumber(
      {required String vehicleEnrolId, bool isSetVehicleDetailProvider = false}) async {
    DetailVehicleUpdatedModel res = const DetailVehicleUpdatedModel.unknown();
    if (ref.read(vehicleDetailsProvider.notifier).state?.enrollmentId == vehicleEnrolId &&
        !isSetVehicleDetailProvider) {
      return;
    }

    ref.read(vehicleDetailsProvider.notifier).state = null;

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result =
          await ref.read(vehicleRepoProvider).getVehicleByRegistrationNumber(userOrgId, vehicleId: vehicleEnrolId);
      try {
        res = DetailVehicleUpdatedModel.fromJson(result.data);
        // debugPrint("Vehicle Details :: ${jsonEncode(result.data)}");
        ref.read(vehicleDetailsProvider.notifier).state = res.data!.message;
        // return res;
      } catch (e) {
        // debugPrint('Vehicle Details Error -> ${e.toString()}');
        // return res;
      }
    } catch (e) {
      // debugPrint('Controler Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      // return res;
    }
  }

// * Get vehicle details by Enrol ID (Manage Tag)
  Future<DetailVehicleUpdatedModel> getVehicleDetailsModelByEnrolId({required String vehicleEnrolId}) async {
    DetailVehicleUpdatedModel res = const DetailVehicleUpdatedModel.unknown();

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result =
          await ref.read(vehicleRepoProvider).getVehicleByRegistrationNumber(userOrgId, vehicleId: vehicleEnrolId);
      try {
        res = DetailVehicleUpdatedModel.fromJson(result.data);
        // debugPrint("Vehicle Details :: ${jsonEncode(result.data)}");
        return res;
      } catch (e) {
        // debugPrint('Vehicle Details Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('Controler Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Vehicle Account Info
  Future<VehicleAccInfoModel> getVehicleAccInfo({required String vehicleRegNo}) async {
    VehicleAccInfoModel res = VehicleAccInfoModel.unknown();
    try {
      String userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      Response result = await ref
          .read(vehicleRepoProvider)
          .getVehicleAccInfo(userOrgEnrollId: userOrgEnrollId.toLowerCase(), vehicleRegNo: vehicleRegNo.toLowerCase());
      try {
        res = VehicleAccInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Vehicle Acc Info  Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Vehicle Last Debit Txn
  Future<VehicleLastDebitTxnModel> getVehicleLastDebitTxn({required String vehicleRegNo}) async {
    VehicleLastDebitTxnModel res = VehicleLastDebitTxnModel.unknown();
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result =
          await ref.read(vehicleRepoProvider).getVehicleLastDebitTxn(userOrgId, vehicleRegNo: vehicleRegNo);
      try {
        // log('entering Try ');
        // if (result.data['data']['message'][0]) == null;
        res = VehicleLastDebitTxnModel.fromJson(result.data);

        return res;
      } catch (e) {
        // debugPrint('Vehicle Last Debit Txn Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('Vehicle Last Debit Txn Error 2 -> ${e.toString()}');

      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Vehicle Tag Txn List
  Future<VehicleTagTxnListModel> getVehicleTagTxnList({required String vehicleRegNo}) async {
    VehicleTagTxnListModel res = VehicleTagTxnListModel.unknown();
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getVehicleTagTxnList(userOrgId, vehicleRegNo: vehicleRegNo);
      try {
        res = VehicleTagTxnListModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint(' Vehicle Tag Txn List Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint(' Vehicle Tag Txn List Error 2 -> ${e.toString()}');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Vehicle Trip History
  Future<VehicleTripHistoryModel> getVehicleTripHistory({
    required String vehicleRegNo,
    required String date,
  }) async {
    VehicleTripHistoryModel res = VehicleTripHistoryModel.unknown();
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getVehicleTripHistory(
            userOrgId,
            vehicleRegNo: vehicleRegNo,
            date: date,
          );
      try {
        res = VehicleTripHistoryModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint(' Vehicle Tag Txn List Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint(' Vehicle Tag Txn List Error 2 -> ${e.toString()}');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Fund Load for Tag
  Future<bool> fundLoadForTag({
    required String orgId,
    required String vehicleRegNo,
    required int amount,
  }) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).fundLoadForTag(
            userOrgId,
            orgId: orgId,
            vehicleRegNo: vehicleRegNo,
            amount: amount,
          );
      return true;
    } catch (e) {
      // debugPrint(' Fund Load for Tag Error -> ${e.toString()}');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Load Amount to  Card
  Future<bool> loadAmountFuelCard({
    required String orgId,
    required String vehicleRegNo,
    required int amount,
    String description = '',
  }) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).loadAmountToCard(
            userOrgId: userOrgId,
            orgId: orgId,
            vehicleRegNo: vehicleRegNo,
            amount: amount,
            description: description,
          );
      return true;
    } catch (e) {
      // debugPrint(' Fund Load for Tag Error -> ${e.toString()}');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * WithDraw Amount
  Future<bool> withDrawAmountFuelCard({
    required String orgId,
    required String vehicleRegNo,
    required int amount,
    required String vehicleEntityId,
    String description = '',
  }) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).withDrawAmount(
            userOrgId: userOrgId,
            orgId: orgId,
            vehicleRegNo: vehicleRegNo,
            amount: amount,
            description: description,
            vehicleEntityId: vehicleEntityId,
          );
      return true;
    } catch (e) {
      // debugPrint(' Fund Load for Tag Error -> ${e.toString()}');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Get Vehicle GPS Info
  Future<VehicleGPSInfoModel> getVehicleGpsInfo({required String vehicleRegNo}) async {
    String vehicleNo = vehicleRegNo.toUpperCase();
    VehicleGPSInfoModel res = VehicleGPSInfoModel.unknown();

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getVehicleGpsInfo(userOrgId, vehicleRegNo: vehicleNo);
      try {
        res = VehicleGPSInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('  Vehicle GPS Info -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('  Vehicle GPS Info -> ${e.toString()}');
      // Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Vehicle GPS Account Info
  Future<VehicleGPSAccountInfoModel> getVehicleGpsAccountInfo({required String vehicleRegNo}) async {
    VehicleGPSAccountInfoModel res = VehicleGPSAccountInfoModel.unknown();
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result =
          await ref.read(vehicleRepoProvider).getVehicleGpsAccountInfo(userOrgId, vehicleRegNo: vehicleRegNo);
      try {
        res = VehicleGPSAccountInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('  Vehicle GPS Info -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('  Vehicle GPS Info -> ${e.toString()}');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Switch Vehicle Balance Type
  Future<bool> switchVehicleBalanceType({
    required String orgId,
    required String vehicleRegNo,
    required String balanceType,
    required int? thresLimit,
  }) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).switchVehicleBalanceType(
            userOrgId,
            orgId: orgId,
            vehicleRegNo: vehicleRegNo,
            balanceType: balanceType,
            thresLimit: thresLimit,
          );
      return true;
    } catch (e) {
      // debugPrint('  VehicleSwitch Balance -> ${e.toString()}');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Get YesBank Tag Account details by ID
  Future<YesBankTagAccountInfoModel> getYesBankTagAccInfoDetailsByEntityId({required String entityId}) async {
    YesBankTagAccountInfoModel res = const YesBankTagAccountInfoModel.unknown();

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result =
          await ref.read(vehicleRepoProvider).getYesBankTagAccInfoDetailsByEntityId(userOrgId, entityId: entityId);
      try {
        res = YesBankTagAccountInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Tag Acc Details Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('Controler Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<bool> updateVehicleThresholdLimit({
    required String orgId,
    required String vehicleRegNo,
    required int threshold,
  }) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).updateVehicleThresholdLimit(
            userOrgId,
            orgId: orgId,
            vehicleRegNo: vehicleRegNo,
            threshold: threshold,
          );
      return true;
    } catch (e) {
      // debugPrint('Update Threshold vehicle Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  Future<bool> enableFuelService(VehicleFuelServiceInputModel formData) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).enableFuelForVehicle(userOrgId, formData);
      Snackbar.success('Service enabled successfully');
      return true;
    } catch (e) {
      // debugPrint('In Controller - Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

// Retry Enable Fuel Service
  Future<bool> retryEnableFuelService(VehicleFuelServiceInputModel formData) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).retryEnableFuelForVehicle(userOrgId, formData);
      Snackbar.success('Service enabled successfully');
      return true;
    } catch (e) {
      // debugPrint('In Controller - Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  Future<bool> verifyVehKyc(
    VerifyVehicleKycInputModel formData,
    String vehicleEnrollId,
  ) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).verifyVehKyc(userOrgId, vehicleEnrollId, formData);
      final res = Mtopresponse.fromJson(result.data);
      print(res);
      Snackbar.success(res.data!.message);
      return true;
    } catch (e) {
      // debugPrint('In Controller - Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Set Driver to  Vehicle
  Future<bool> mapDriverToVehicle({
    required String driverEnrollmentId,
    required String mapStatus,
    required String organizationEnrollmentId,
    required String vehicleRegNo,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).mapDriverToVehicle(
            userOrgId: userOrgId,
            driverEnrollmentId: driverEnrollmentId,
            mapStatus: mapStatus,
            organizationEnrollmentId: organizationEnrollmentId,
            vehicleRegNo: vehicleRegNo,
          );
      final res = Mtopresponse.fromJson(result.data);
      print(res);
      Snackbar.success(res.data!.message);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Set Vehicle FUEL limit
  Future<bool> setVehicleFuelLimit({
    required SetVehicleFuelInputModel formInput,
    required String vehicleEnrollId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).setVehicleFuelLimit(
            vehicleEnrollId: vehicleEnrollId,
            userOrgId: userOrgId,
            formInput: formInput,
          );
      final res = Mtopresponse.fromJson(result.data);
      print(res);
      Snackbar.success(res.data!.message);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Approve / Decline LQTAG Vehicle
  Future<bool> approveOrDeclineLqVehicle({
    required String userEnrollId,
    required String orgEnrollId,
    required String vehicleRegNum,
    required String status,
    String rejReason = '',
  }) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).approveOrDeclineLqVehicle(
            userOrgId: userOrgId,
            userEnrollId: userEnrollId,
            orgEnrollId: orgEnrollId,
            vehicleRegNum: vehicleRegNum,
            rejReason: rejReason,
            status: status,
          );
      if (status.toLowerCase() == 'declined') {
        Snackbar.warn('LQ Tag Service Declined - $rejReason');
      } else {
        Snackbar.success('LQ Tag Service Approved successfully');
      }

      return true;
    } catch (e) {
      // debugPrint('In Controller - Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // *Get LQ Tag Org User
  Future<LqTagAdminOrgResponseModel> getLQTagAdminOrgUser({required String orgEnrolId}) async {
    LqTagAdminOrgResponseModel res = const LqTagAdminOrgResponseModel.unknown();

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getLQTagAdminOrgUser(userOrgId, orgEnrolId: orgEnrolId);
      try {
        res = LqTagAdminOrgResponseModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Vehicle Details Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('Controler Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // *Get LQ Tag Org User
  Future<SimpleVehicleListModel> getSimpleListOfVehicles({required SimpleVehicleListQueryParams qParams}) async {
    SimpleVehicleListModel res = const SimpleVehicleListModel.unknown();

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      qParams = qParams.copyWith(organizationEnrollmentId: userOrgId);
      Response result =
          await ref.read(vehicleRepoProvider).listofVehicles(userOrgId: userOrgId.toLowerCase(), qParams: qParams);
      try {
        res = SimpleVehicleListModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Vehicle Details Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('Controler Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // *Get LQ Tag Org User
  Future<bool> retryLqVehicle({
    required String orgEnrolId,
    required String userEnrolId,
    required String vehicleRegNo,
  }) async {
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(vehicleRepoProvider).retryLqVehicle(
            userOrgId,
            orgEnrolId: orgEnrolId,
            userEnrolId: userEnrolId,
            vehicleRegNo: vehicleRegNo,
          );
      return true;
    } catch (e) {
      // debugPrint('Controler Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Get Vehicle ListLqtagVehicles
  Future<ListLqtagVehicles> getListLqtagVehicles() async {
    ListLqtagVehicles res = ListLqtagVehicles.unknown();
    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getListLqtagVehicles(userOrgId: userOrgId);
      try {
        res = ListLqtagVehicles.fromJson(result.data);
        return res;
      } catch (e) {
        return res;
      }
    } catch (e) {
      return res;
    }
  }

  // * Get Livquik Tag Account details by Enrollment ID
  Future<LqTagAccountInfoModel> getLivquikTagAccInfoDetailsByEnrollmentId({
    required String orgEnrollId,
  }) async {
    LqTagAccountInfoModel res = const LqTagAccountInfoModel.unknown();

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref
          .read(vehicleRepoProvider)
          .getLivquikTagAccInfoDetailsByEnrollmentId(userOrgId, orgEnrollId: orgEnrollId);
      try {
        res = LqTagAccountInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Tag Acc Details Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('Controler Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Livquik Tag Account details
  Future<LqTagAccountInfoModel> getLivquikTagAccInfo(
      {required String organizationEnrollmentId, required String userEnrollmentId}) async {
    LqTagAccountInfoModel res = const LqTagAccountInfoModel.unknown();

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(vehicleRepoProvider).getLivquikTagAccInfo(
            userOrgId,
            organizationEnrollmentId: organizationEnrollmentId,
            userEnrollmentId: userEnrollmentId,
          );
      try {
        res = LqTagAccountInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Tag Acc Details Error -> ${e.toString()}');
        return res;
      }
    } catch (e) {
      // debugPrint('Controler Error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }
}
