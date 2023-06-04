import 'dart:convert';
import 'dart:developer';
import 'package:axlerate/src/common/common_controllers/wallets_controller.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/logistics/data/logistics_repository.dart';
import 'package:axlerate/src/features/home/logistics/domain/fund_transfer_c2c_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/fund_transfer_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/lq_user_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/create_logistics_input_model.dart';
import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:axlerate/src/features/home/logistics/domain/fuel_limit_set_input_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/fuel_limit_response_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/logistic_gps_info_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/logistics_dash_count_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_account_info_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_dash_ppi_account_info.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_dash_tag_account_info.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_fuel_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/set_org_ppi_preference_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/vehicle_toll_query_params.dart';
import 'package:axlerate/src/features/home/logistics/domain/vehiclewise_usage_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/dashboard_controllers.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_ui_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';
import 'package:axlerate/src/features/home/services/domain/response_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/fetch_fuel_vehicle_balance_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orgDetailsProvider = StateProvider<OrgDoc?>((ref) {
  return null;
});

final listofLogisticsStateProvider = StateProvider<ListOrgUpdatedModel?>((ref) {
  return null;
});

final logisticsControllerProvider = Provider<LogisticsController>((ref) {
  final LogisticsRepository logisticsRepo = ref.watch(logisticsRepositoryProvider);
  return LogisticsController(ref, logisticsRepo);
});

final livquikTagAccDetailsProvider = StateProvider<LqUserAccInfoModel?>((ref) {
  return null;
});

final gpsLocStateProvider = StateProvider<LogisticsGpsInfoStateProvider?>((ref) {
  return null;
});

class LogisticsController {
  final LogisticsRepository logisticsRepository;
  final Ref ref;

  const LogisticsController(this.ref, this.logisticsRepository);

  // * Create Logistics
  Future<bool> createLogistics(CreateLogisticsInputModel formInput) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(logisticsRepositoryProvider).createLogistics(
            userOrgId: userOrgId,
            formInput: formInput,
          );
      Snackbar.success('Organization created Successfully');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Invite Logistics
  Future<bool> inviteLogistics({
    required String orgCode,
    required String email,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(logisticsRepositoryProvider).inviteLogistics(
            userOrgId: userOrgId,
            orgCode: orgCode,
            email: email,
          );
      // print(result.data);
      Snackbar.success('Invite has been sent to $email');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Update Logistics
  Future<bool> updateLogistics(String orgId, CreateLogisticsInputModel formInput) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(logisticsRepositoryProvider).updateLogistics(
            userOrgId: userOrgId,
            orgId: orgId,
            formInput: formInput,
          );
      // print(result.data);
      Snackbar.success('Details Updated Successfully');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Get Logistics List
  Future<ListOrgUpdatedModel> getLogisticsList({ListOrgsQueryParams? queryParams}) async {
    ListOrgUpdatedModel res = ListOrgUpdatedModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(logisticsRepositoryProvider).getLogisticsList(
            userOrgId: userOrgId,
            queryParams: queryParams,
          );
      // debugPrint("List Org Response ::  " + jsonEncode(result.data).toString());
      try {
        res = ListOrgUpdatedModel.fromJson(result.data);
        if (res.data != null) {
          ref.read(logsListEndPageProvider.notifier).state = res.data!.message.count;
        } else {
          ref.read(logsListEndPageProvider.notifier).state = 0;
        }
        return res;
      } catch (e) {
        // debugPrint('List Org Error -> $e');
        return res;
      }
    } catch (e) {
      // debugPrint('Catch 2 error -> $e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<bool> checkOrgCode({required String code}) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(logisticsRepositoryProvider).checkOrgCode(
            userOrgId: userOrgId,
            code: code,
          );
      return result.data['data']['message'];
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Set Orgz PPI Preference
  Future<bool> updateOrgPPiPreference({
    required SetOrgPpiPreferenceModel inputs,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(logisticsRepositoryProvider).updateOrgPPiPreference(
            userOrgId: userOrgId,
            inputs: inputs,
          );
      Snackbar.success('Preference Updated Successfully');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Get Org Dash Count
  Future<OrgDashCountModel> getOrgDashCount({
    required String userOrgEnrollmentId,
  }) async {
    OrgDashCountModel res = OrgDashCountModel.unknown();

    try {
      final currentUserOrgEnrollmentId =
          ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';

      Response result = await ref.read(logisticsRepositoryProvider).getOrgDashCount(
            currentUserOrgEnrollmentId: currentUserOrgEnrollmentId.toLowerCase(),
            userOrgEnrollmentId: userOrgEnrollmentId.toLowerCase(),
          );
      try {
        res = OrgDashCountModel.fromJson(result.data);

        return res;
      } catch (e) {
        // debugPrint('Logis Dash count Error -> $e');
        return res;
      }
    } catch (e) {
      // Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Org Dash Tag Account Info
  Future<OrgDashTagAccountInfo> getOrgDashTagAccountInfo({
    required String userOrgEnrollId,
  }) async {
    OrgDashTagAccountInfo res = OrgDashTagAccountInfo.unknown();

    try {
      final currentUserOrgEnrollId =
          ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';

      Response result = await ref.read(logisticsRepositoryProvider).getOrgDashTagAccountInfo(
            currentUserOrgEnrollId: currentUserOrgEnrollId.toLowerCase(),
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
          );
      try {
        res = OrgDashTagAccountInfo.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Logis Dash tag Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Org Dash PPI Account Info
  Future<OrgDashPpiAccountInfo> getOrgDashPpiAccountInfo({
    required String userOrgEnrollId,
  }) async {
    OrgDashPpiAccountInfo res = OrgDashPpiAccountInfo.unknown();

    try {
      final currentUserOrgEnrollId =
          ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';

      Response result = await ref.read(logisticsRepositoryProvider).getOrgDashPpiAccountInfo(
            currentUserOrgEnrollId: currentUserOrgEnrollId.toLowerCase(),
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
          );
      try {
        res = OrgDashPpiAccountInfo.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Logis Dash ppi Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Org Dash Fuel Account Info
  Future<OrgFuelAccInfo> getOrgDashFuelAccountInfo({
    required String userOrgEnrollId,
    required String entityType,
  }) async {
    OrgFuelAccInfo res = OrgFuelAccInfo.unknown();

    try {
      final currentUserOrgEnrollId =
          ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';

      Response result = await ref.read(logisticsRepositoryProvider).getOrgDashFuelAccountInfo(
          currentUserOrgEnrollId: currentUserOrgEnrollId.toLowerCase(),
          userOrgEnrollId: userOrgEnrollId.toLowerCase(),
          entityType: entityType);
      try {
        res = OrgFuelAccInfo.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Logis Dash ppi Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Logistics TAG Rewards (Amount) (Dashboard)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<String> getOrgTagReward({
    required String userOrgEnrollId,
    required String dataType,
  }) async {
    try {
      final currentUserOrgEnrollId =
          ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      // log("Currently picked Org ID :: " +
      //     ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId)!);

      Response result = await ref.read(logisticsRepositoryProvider).getOrgTagReward(
            currentUserOrgEnrollId: currentUserOrgEnrollId.toLowerCase(),
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
            dataType: dataType,
          );
      try {
        return result.data["data"]["message"]["value"].toString();
      } catch (e) {
        // debugPrint('Org Tag Reward Error -> $e');
        return '';
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '';
    }
  }

  // * Get Logistics PPI Rewards (Amount) - (Dashboard)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<String> getOrgPpiReward({
    required String orgId,
    String dataType = 'year',
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(logisticsRepositoryProvider).getOrgPpiReward(
            userOrgId: userOrgId,
            orgId: orgId,
            dataType: dataType,
          );
      try {
        return result.data["data"]["message"]["value"].toString();
      } catch (e) {
        // debugPrint('Org TPPIag Reward Error -> $e');
        return '0';
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '0';
    }
  }

  // * Get Org Dash Tag TXN Analytics (Debit and Credit)
  // * dataType : 'year', 'week', 'day', 'month'
  // * TxnType : 'credit', 'debit'
  Future<void> getOrgDashTagTxnAnalytics({
    required String userOrgEnrollId,
    String dataType = 'year',
    String txType = 'credit',
  }) async {
    final tagCreditState = ref.read(txnTagCreditStateProvider.notifier);
    final tagDebitState = ref.read(txnTagDebitStateProvider.notifier);
    try {
      final currentUserOrgEnrollId =
          ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      Response result = await ref.read(logisticsRepositoryProvider).getOrgDashTagTxnAnalytics(
            currentUserOrgEnrollId: currentUserOrgEnrollId.toLowerCase(),
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
            dataType: dataType,
            txType: txType,
          );
      try {
        if (txType == 'credit') {
          tagCreditState.state = result.data['data']['message']['value'].toString();
        } else {
          tagDebitState.state = result.data['data']['message']['value'].toString();
        }
      } catch (e) {
        tagCreditState.state = '0';
        tagDebitState.state = '0';
        // debugPrint('Org Dash TAG txn Analytics Error -> $e');
      }
    } catch (e) {
      tagCreditState.state = '0';
      tagDebitState.state = '0';
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Get Org Dash PPI TXN Analytics (Debit and Credit)
  // * dataType : 'year', 'week', 'day', 'month'
  // * TxnType : 'credit', 'debit'
  Future<void> getOrgDashPpiTxnAnalytics({
    required String userOrgEnrollId,
    String dataType = 'year',
    String txType = 'credit',
  }) async {
    final ppiCreditState = ref.read(txnPpiCreditStateProvider.notifier);
    final ppiDebitState = ref.read(txnPpiDebitStateProvider.notifier);

    try {
      final currentUserOrgEnrollId =
          ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      Response result = await ref.read(logisticsRepositoryProvider).getOrgDashPpiTxnAnalytics(
            currentUserOrgEnrollId: currentUserOrgEnrollId.toLowerCase(),
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
            dataType: dataType,
            txType: txType,
          );
      try {
        if (txType == 'credit') {
          ppiCreditState.state = result.data['data']['message']['value'].toString();
        } else {
          ppiDebitState.state = result.data['data']['message']['value'].toString();
        }
      } catch (e) {
        ppiCreditState.state = '0';
        ppiDebitState.state = '0';
        // debugPrint('Org Dash PPI txn Analytics Error -> $e');
      }
    } catch (e) {
      ppiCreditState.state = '0';
      ppiDebitState.state = '0';
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  Future<bool> getOrganisationByEnrolmentId({required String enrolId, bool isSetOrgDetailProvider = false}) async {
    try {
      OrgDoc? currentOrg = ref.read(orgDetailsProvider);
      if (currentOrg != null && currentOrg.enrollmentId == enrolId && !isSetOrgDetailProvider) {
        return false;
      }
      ref.read(orgDetailsProvider.notifier).state = null;

      // log('Getting Org Details ');
      //The Api Call

      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(logisticsRepositoryProvider).getOrgByEnrolId(
            userOrgId: userOrgId,
            orgEnrolId: enrolId,
          );
      // debugPrint("Org Doc ->" + jsonEncode(result.data));
      debugPrint(result.data.toString());

      OrgDoc org = OrgDoc.fromJson(result.data['data']['message']);
      //log('Got Org Details ----> ${ref.read(orgDetailsProvider).toString()}');
      // log("getOrganisationByEnrolmentId $result");

      ref.read(orgDetailsProvider.notifier).state = org;
      return true;
    } catch (e) {
      log(e.toString());
      // debugPrint(e.toString());
      // Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Get Organization Account Info
  Future<OrgAccountInfoModel> getOrgAccountInfo({
    required String orgEntityId,
  }) async {
    OrgAccountInfoModel res = OrgAccountInfoModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(logisticsRepositoryProvider).getOrgAccountInfo(
            userOrgId,
            userEntityId: orgEntityId,
          );
      try {
        res = OrgAccountInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint(e.toString());
        return res;
      }
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Organization Account Info
  Future<LogisticsGpsInfoModel> getLogisticsGpsInfo({
    required String orgId,
  }) async {
    LogisticsGpsInfoModel res = LogisticsGpsInfoModel.unknown();
    dynamic result;
    try {
      LogisticsGpsInfoStateProvider? state = ref.read(gpsLocStateProvider.notifier).state;

      if (state == null || state.orgId != orgId || DateTime.now().difference(state.modifiedAt).inMinutes >= 1) {
        final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
        if (userOrgId.isNotEmpty) {
          result = await ref.read(logisticsRepositoryProvider).getLogisticsGpsInfo(
                authId: userOrgId,
                orgId: orgId,
              );
        }
        try {
          res = LogisticsGpsInfoModel.fromJson(result.data);
          ref.read(gpsLocStateProvider.notifier).state = LogisticsGpsInfoStateProvider(orgId: orgId, data: res);
          return res;
        } catch (e) {
          // debugPrint("Logistics GPS Info Error -> $e");
          return res;
        }
      } else {
        return state.data;
      }
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Set Organization FUEL limit
  Future<bool> setLogisticsFuelLimit({
    required FuelSetInputModel formInput,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(logisticsRepositoryProvider).setLogisticsFuelLimit(
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

  // * Add BusinessConfig With FuelLimit for Organization
  Future<bool> addBusinessConfigWithFuelLimit({
    // required AddBusinessConfigWithFuelInputModel formInput,
    required String orgEnrolId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(logisticsRepositoryProvider).addBusinessConfigWithFuelLimit(
            userOrgId: userOrgId,
            // formInput: formInput,
            orgEnrolId: orgEnrolId,
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

  // * Get Organization/Vehicle/Staff FUEL limit
  Future<FuelLimitResponseModel> getFuelLimitByEntityType({
    required String entityId,
    required String entityType,
    required String orgEnrollId,
    required String issuerName,
    String? vehicleRegistrationNumber,
  }) async {
    FuelLimitResponseModel res = FuelLimitResponseModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(logisticsRepositoryProvider).getFuelLimitByEntityType(
          userOrgId: userOrgId,
          entityId: entityId,
          entityType: entityType,
          orgEnrollId: orgEnrollId,
          issuerName: issuerName,
          vehicleRegistrationNumber: vehicleRegistrationNumber);

      res = FuelLimitResponseModel.fromJson(result.data);
    } catch (e) {
      log(e.toString());
    }
    return res;
  }

  // * Get Organization/Vehicle/Staff FUEL balance
  Future<FetchFuelVehicleBalanceModel> getFuelBalanceByEntityId({
    required String entityId,
    required String entityType,
    required String issuerName,
    required String orgEnrollId,
    String? vehicleRegistrationNumber,
  }) async {
    FetchFuelVehicleBalanceModel res = const FetchFuelVehicleBalanceModel.unknown();

    try {
      String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(logisticsRepositoryProvider).getFuelBalanceByEntityId(
            userOrgId: userOrgId,
            entityId: entityId,
            entityType: entityType,
            issuerName: issuerName,
            orgEnrollId: orgEnrollId,
            vehicleRegistrationNumber: vehicleRegistrationNumber,
          );
      try {
        res = FetchFuelVehicleBalanceModel.fromJson(result.data);
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

  // * Add LQ Tag Service
  Future<void> lqGenerateOTP({
    required String userEnrollId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(logisticsRepositoryProvider).lqTagGenerateOTP(
            userOrgId: userOrgId,
            userEnrollId: userEnrollId,
          );
      Snackbar.success('OTP sent successfully');
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * GET LQ Tag User Accounts and set it to the provider
  Future<void> lqTagAccountInfo({
    required String userEnrollId,
    required String orgEnrollId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(logisticsRepositoryProvider).lqTagAccountInfo(
            userOrgId: userOrgId,
            userEnrollId: userEnrollId,
            orgEnrollId: orgEnrollId,
          );
      Snackbar.success('OTP sent successfully');
    } catch (e) {
      // debugPrint(e.toString());
      // Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * LQTAG Acc info for Org
  Future<LqUserAccInfoModel> lqTagAccInfoforOrg({
    required String orgEnrollId,
  }) async {
    LqUserAccInfoModel res = LqUserAccInfoModel.unknown();
    try {
      final userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      Response result = await ref.read(logisticsRepositoryProvider).lqTagAccInfoforOrg(
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
            orgEnrollId: orgEnrollId,
          );
      try {
        res = LqUserAccInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        debugPrint("LQTAG Acc Info Error -> $e");
        return res;
      }
    } catch (e) {
      // debugPrint(e.toString());
      return res;
    }
  }

  // * LQTAG Acc info by enroll id
  Future<LqUserAccInfoModel> lqTagAccInfoByEnrollmentId({
    required String orgEnrollId,
  }) async {
    LqUserAccInfoModel res = LqUserAccInfoModel.unknown();
    try {
      final userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      Response result = await ref.read(logisticsRepositoryProvider).lqTagAccInfoforOrg(
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
            orgEnrollId: orgEnrollId,
          );
      try {
        res = LqUserAccInfoModel.fromJson(result.data);

        List<WalletDisplayModel> wallets = res.getWallets();
        ref.read(lqTagWalletsNotifierProvider.notifier).addWallets(wallets);
        debugPrint("Logistics lqTagAccInfoByEnrollmentId -> ${jsonEncode(result.data)}");

        return res;
      } catch (e) {
        debugPrint("Logistics lqTagAccInfoByEnrollmentId -> $e");
        return res;
      }
    } catch (e) {
      debugPrint(e.toString());
      return res;
    }
  }

  // * LQTAG Fund Transfer P2C
  Future<bool> lqTagFundTransferP2C({
    required FundTransferModelP2C data,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(logisticsRepositoryProvider).lqTagFundLoadP2C(
            userOrgId: userOrgId,
            data: data,
          );
      Snackbar.success('Wallet Loaded Successfully!');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * LQTAG Fund Transfer C2C
  Future<bool> lqTagFundTransferC2C({
    required FundTransferModelC2C data,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(logisticsRepositoryProvider).lqTagFundLoadC2C(
            userOrgId: userOrgId,
            data: data,
          );
      Snackbar.success('Wallet Loaded Successfully!');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * LQTAG Fund Transfer C2P
  Future<bool> lqTagFundTransferC2P({
    required FundTransferModelP2C data,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(logisticsRepositoryProvider).lqTagFundLoadC2P(
            userOrgId: userOrgId,
            data: data,
          );
      Snackbar.success('Wallet Loaded Successfully!');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  Future<bool> uploadLogisticsOrgLogo({
    required String enrollmentId,
    required String url,
  }) async {
    try {
      await logisticsRepository.uploadLogisticOrgLogo(
        logisticOrgId: enrollmentId,
        url: url,
      );
      Snackbar.success('Logo Updated Successfully');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  getVehiclewiseData({required VehicleTollQueryParams params}) async {
    VehiclewiseUsageRespMessage res;
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result =
          await ref.read(logisticsRepositoryProvider).getVehiclewiseData(userOrgId: userOrgId, params: params);
      if (params.fileType != null) {
        return result.data;
      }

      // String result =
      //     '{"data":{"message":{"count":2,"docs":[{"vehRegNo":"TN12345","lqTag":100,"ybTag":150,"fuel":1221.12},{"vehRegNo":"TN12AX1234","lqTag":2,"fuel":123.23}]}}}';
      try {
        res = VehiclewiseResponse.fromMap(result.data).data.message;
        return res;
      } catch (e) {
        // debugPrint('Org Dash PPI txn Analytics Error -> $e');
        rethrow;
      }
    } catch (e) {
      // Snackbar.error(ApiHelper.getErrorMessage(e));
      rethrow;
    }
  }
}
