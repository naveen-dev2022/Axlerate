import 'package:axlerate/src/features/home/services/domain/response_model.dart';
import 'package:axlerate/src/features/home/user/domain/add_lqtag_input_model.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_fuel_response_model.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_response_model.dart';
import 'package:axlerate/src/features/home/user/domain/retry_user_fuel_card_input_model.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_by_enrolment_id_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_fuel_card_input_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_ppi_graph_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/ui_controller.dart';
import 'package:axlerate/src/features/home/vehicles/domain/gps_notification_user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/app_util/typedefs/typedefs.dart';
import 'package:axlerate/src/features/home/user/data/user_repository.dart';
import 'package:axlerate/src/features/home/user/domain/fetch_balance_response_model.dart';
import 'package:axlerate/src/features/home/user/domain/list_orgs_by_type_model.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_query_params.dart';
import 'package:axlerate/src/features/home/user/domain/set_user_ppi_preference_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_account_info_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_card_preferences_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';

final userDetailsProvider = StateProvider<UserDoc?>((ref) {
  return null;
  // return UserDoc(name: "Jasper", enrollmentId: 'AXU52', organizations: Organizations(userEntityId: "AXLAER1234"));
});

final userDetailsByEnrollmentIdStateProvider = StateProvider<UserByEnrolmentIdModel?>((ref) {
  return null;
});
final updateduserDetailsByEnrollmentIdStateProvider = StateProvider<UpdatedUserByEnrolmentIdModel?>((ref) {
  return null;
});

final loggedInUserByEnrollmentIdStateProvider = StateProvider<UpdatedUserByEnrolmentIdModel?>((ref) {
  return null;
});

final listofUsersStateProvider = StateProvider<ListUserResponseModel?>((ref) {
  return null;
});

final userAccountInfoStateProvider = StateProvider<UserAccountInfoModel?>((ref) {
  return null;
});

final userPpiCreditGraphStateProvider = StateProvider<UserPpiGraphResponseModel?>((ref) {
  return null;
});

final userPpiDebitGraphStateProvider = StateProvider<UserPpiGraphResponseModel?>((ref) {
  return null;
});

final userControllerProvider = Provider<UserController>((ref) {
  return UserController(ref);
});

class UserController {
  final Ref ref;

  const UserController(
    this.ref,
  );

  // * Get List of Users
  Future<ListUserResponseModel> getUsersList({ListUserQueryParams? queryParams}) async {
    ListUserResponseModel res = ListUserResponseModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).getUsersList(
            userOrgId: userOrgId,
            queryParams: queryParams,
          );
      try {
        res = ListUserResponseModel.fromJson(result.data);
      } catch (e) {
        // debugPrint('List User ERROR -> $e');
      }
      return res;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Users By EnrolmentId
  Future<UpdatedUserByEnrolmentIdModel> getUserByEnrolmentId({required String userEnrolmentId}) async {
    UpdatedUserByEnrolmentIdModel res = const UpdatedUserByEnrolmentIdModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).getUserByEnrolmentId(
            userOrgId: userOrgId,
            userEnrolmentId: userEnrolmentId,
          );
      try {
        res = UpdatedUserByEnrolmentIdModel.fromJson(result.data);
      } catch (e) {
        // debugPrint('List User By EnrolmentId ERROR -> $e');
      }
      ref.read(updateduserDetailsByEnrollmentIdStateProvider.notifier).state = res;
      return res;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get List of Staffs
  Future<ListUserResponseModel> getStaffsList({ListUserQueryParams? queryParams}) async {
    ListUserResponseModel res = ListUserResponseModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).getStaffsList(
            userOrgId: userOrgId,
            queryParams: queryParams,
          );
      try {
        res = ListUserResponseModel.fromJson(result.data);
      } catch (e) {
        // debugPrint('List User ERROR -> $e');
      }
      return res;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get List of Staffs
  Future<NotificationUserModel> getOrgUsersListforGPSNotifications(String orgEnrolId,
      {ListUserQueryParams? queryParams}) async {
    NotificationUserModel res = NotificationUserModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).getOrgUsersListforGPSNotifications(
            userOrgId: userOrgId,
            orgEnrolId: orgEnrolId,
            queryParams: queryParams,
          );
      try {
        res = NotificationUserModel.fromMap(result.data['data']['message']);
      } catch (e) {
        // debugPrint('List User ERROR -> $e');
      }
      return res;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Create User (Staff)
  Future<bool> createUser({
    required String userName,
    required OrganizationID underOrgId,
    required String role,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(userRepositoryProvider).createUser(
            userOrgId: userOrgId,
            userName: userName,
            underOrgId: underOrgId,
            role: role,
          );
      Snackbar.success('User Created Successfully');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Deactivate User
  Future<void> deactivateUser({
    required UserID userId,
    required OrganizationID orgId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).deactivateUser(
            userOrgId: userOrgId,
            userId: userId,
            orgId: orgId,
          );

      Snackbar.success(ApiHelper.getSuccessMessage(result));
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Reactivate User
  Future<void> reactivateUser({
    required UserID userId,
    required OrganizationID orgId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).reactivateUser(
            userOrgId: userOrgId,
            userId: userId,
            orgId: orgId,
          );
      Snackbar.success(ApiHelper.getSuccessMessage(result));
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Get list of Organizations by type
  Future<ListOrgsByTypeModel?> getListOfOrganizationByType({
    required String orgType,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).getOrganizationListByType(
            userOrgId: userOrgId,
            orgType: orgType,
          );
      ListOrgsByTypeModel orgsList = ListOrgsByTypeModel.fromJson(result.data);
      return orgsList;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return null;
    }
  }

  // * Change User Role
  Future<void> changeUserRole({
    required UserID userId,
    required OrganizationID orgId,
    required String role,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).changeUserRole(
            userOrgId: userOrgId,
            userId: userId,
            orgId: orgId,
            role: role,
          );
      Snackbar.success(ApiHelper.getSuccessMessage(result));
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Fetch User Card Preferences
  Future<UserCardPreferencesModel?> fetchUserCardPreference({
    required String entityId,
    required OrganizationID orgId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).fetchUserCardPreferences(
            userOrgId,
            entityId: entityId,
            orgId: orgId,
          );
      UserCardPreferencesModel userPref = UserCardPreferencesModel.fromJson(result.data);
      return userPref;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return null;
    }
  }

  // * Set User PPI Preference
  Future<void> setUserPPIPreference({
    required SetUserPpiPreferenceModel preference,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      debugPrint("setUserPPIPreference ${preference.toJson()}");

      Response result = await ref.read(userRepositoryProvider).setUserPPIPreference(
            userOrgId,
            preference: preference,
          );
      Snackbar.success(ApiHelper.getSuccessMessage(result));
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Set User Card Preference
  Future<void> setUserCardPreference({
    required String entityId,
    required OrganizationID orgId,
    required String status,
    required String type,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(userRepositoryProvider).setUserCardPreference(
            userOrgId,
            entityId: entityId,
            orgId: orgId,
            status: status,
            type: type,
          );
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Set User Card Preference Limit
  Future<void> setUserCardPreferenceLimit({
    required String entityId,
    required OrganizationID orgId,
    required String txnType,
    required String dailyLimitValue,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(userRepositoryProvider).setUserCardPreferenceLimit(
            userOrgId,
            entityId: entityId,
            orgId: orgId,
            txnType: txnType,
            dailyLimitValue: dailyLimitValue,
          );
      Snackbar.success('Preference updated');
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Fetch available balance
  Future<FetchBalanceResponseModel?> fetchUserBalance({
    required String entityId,
  }) async {
    FetchBalanceResponseModel res = FetchBalanceResponseModel.unknown();
    // final userBalance = ref.read(userDashBalanceProvider.notifier);
    try {
      final authId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(userRepositoryProvider).fetchUserBalance(
            authId: authId,
            entityId: entityId,
          );
      FetchBalanceResponseModel balance = FetchBalanceResponseModel.fromJson(result.data);
      // userBalance.state = balance;
      return balance;
    } catch (e) {
      // userBalance.state = FetchBalanceResponseModel.unknown();
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Set Pin PCI widget
  Future<String?> setPinPciWidget({
    required String entityId,
    required String userEnrollmentId,
    required OrganizationID orgId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).setPinPciWidget(
            userOrgId,
            entityId: entityId,
            userEnrollmentId: userEnrollmentId,
            orgId: orgId,
          );
      return result.data['data']['message'];
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return null;
    }
  }

  // * Get Card PCI Widget
  Future<String> getCardPciWidget({
    required String userEnrollId,
    required String orgId,
  }) async {
    try {
      final authId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(userRepositoryProvider).getCardPciWidget(
            authId: authId,
            userEnrollId: userEnrollId,
            orgId: orgId,
          );
      String iFrameUrl = result.data['data']['message'];
      return iFrameUrl;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '';
    }
  }

  // * Lock Unlock Card
  Future<void> lockUnlockCard({
    required String entityId,
    required OrganizationID orgId,
    required String flag,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(userRepositoryProvider).lockUnloackCard(
            userOrgId,
            entityId: entityId,
            orgId: orgId,
            flag: flag,
          );
      Snackbar.success('Done');
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Fund load
  Future<bool> fundLoad({
    required String orgId,
    // required String partnerOrgId,
    required String userEntityId,
    required String userEnrollmentId,
    required int amount,
    required String description,
  }) async {
    try {
      final authId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(userRepositoryProvider).fundLoad(
            authId,
            orgId: orgId,
            // partnerOrgId: partnerOrgId,
            userEntityId: userEntityId,
            userEnrollmentId: userEnrollmentId,
            amount: amount,
            description: description,
          );
      Snackbar.success('Amount added successfully!');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Get User Crad Status
  Future<String> getUserCardStatus({
    required String userEntityId,
    required String orgId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).getUserCardStatus(
            authId: userOrgId,
            userEntityId: userEntityId,
            orgId: orgId,
          );
      try {
        return result.data['data']['message']['status'];
      } catch (e) {
        return '';
      }
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '';
    }
  }

  // * Get V-KYC Link
  Future<String?> getVKycLink({
    required String userEntityId,
    required String orgId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).getVKycLink(
            authId: userOrgId,
            userEntityId: userEntityId,
            orgId: orgId,
          );
      try {
        return result.data['data']['message']['link'];
      } catch (e) {
        return null;
      }
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return null;
    }
  }

  // * Get User Account Information
  Future<UserAccountInfoModel> getUserAccountInfo({
    required String userEntityId,
  }) async {
    UserAccountInfoModel res = const UserAccountInfoModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(userRepositoryProvider).getUserAccountInfo(
            userOrgId,
            userEntityId: userEntityId,
          );
      try {
        res = UserAccountInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        // log(e.toString());
        return res;
      }
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get User Account Information
  Future<String> userPpiTxnAmount({
    required String userEntityId,
    required String dataType,
    required String txnType,
  }) async {
    final creditProvider = ref.read(userPpiTxnCreditAmountProvider.notifier);
    final debitProvider = ref.read(userPpiTxnDebitAmountProvider.notifier);

    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(userRepositoryProvider).userPpiTxnAmount(
            userOrgId,
            userEntityId: userEntityId,
            dataType: dataType,
            txnType: txnType,
            isGraph: false,
          );
      try {
        // log('Inside Function - Try (Credit , Debit -> $txnType)');
        if (txnType == 'credit') {
          // log('Inside credit ----');
          creditProvider.state = result.data['data']['message']['value'].toString();
        } else {
          // log('Inside Debit ----');

          debitProvider.state = result.data['data']['message']['value'].toString();
        }
        return result.data['data']['message']['value'].toString();
      } catch (e) {
        creditProvider.state = '0';
        debitProvider.state = '0';
        // debugPrint('User PI Amount Txn -> $txnType  --->$e');

        // log(e.toString());
        return '0';
      }
    } catch (e) {
      creditProvider.state = '0';
      debitProvider.state = '0';
      // debugPrint('User PI Amount Txn -> $txnType  --->$e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '0';
    }
  }

  // * Get User Account Information
  Future<UserPpiGraphResponseModel> userPpiTxnGraph({
    required String userEntityId,
    required String dataType,
    required String txnType,
  }) async {
    UserPpiGraphResponseModel res = UserPpiGraphResponseModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(userRepositoryProvider).userPpiTxnAmount(
            userOrgId,
            userEntityId: userEntityId,
            dataType: dataType,
            txnType: txnType,
            isGraph: true,
          );
      try {
        res = UserPpiGraphResponseModel.fromJson(result.data);
        if (txnType == 'credit') {
          //ref.read(userPpiCreditGraphStateProvider.notifier).state = null;
          ref.read(userPpiCreditGraphStateProvider.notifier).state = res;
        } else {
          //ref.read(userPpiDebitGraphStateProvider.notifier).state = null;
          ref.read(userPpiDebitGraphStateProvider.notifier).state = res;
        }
        return res;
      } catch (e) {
        // debugPrint('User PPI Txn Graph -> $txnType  --->$e');
        return res;
      }
    } catch (e) {
      // debugPrint('User PPI Txn Graph -> $txnType  --->$e');
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Add LQ Tag Service
  Future<bool> addLqTagService({
    required AddLqTaginputModel inputs,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(userRepositoryProvider).addLqTagService(
            userOrgId: userOrgId,
            inputs: inputs,
          );
      Snackbar.success('Enabled Successfully');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Generate LQTag OTP
  Future<bool> generateLqTagOtp({
    required String userEnrollId,
    required String orgEnrollId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(userRepositoryProvider).generateLqTagOtp(
            userOrgId: userOrgId,
            userEnrollId: userEnrollId,
            orgEnrollId: orgEnrollId,
          );
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Get V-KYC Link for lq-tag
  Future<String?> getVKycLinkLqTag({
    required String userEnrollId,
    required String orgEnrollId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).getVKycLinkLqTag(
            userOrgId: userOrgId,
            userEnrollId: userEnrollId,
            orgEnrollId: orgEnrollId,
          );
      try {
        return result.data['data']['message']['link'];
      } catch (e) {
        return null;
      }
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return null;
    }
  }

  // * Add Fuel Service
  Future<bool> addFuelService({
    required AddFuelServiceToUserInputModel inputs,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(userRepositoryProvider).addFuelService(
            userOrgId: userOrgId,
            inputs: inputs,
          );

      try {
        if (result.data['result']['error'] != null) {
          Snackbar.error(ApiHelper.getSuccessMessage(result.data['result']['error']));
          return true;
        }
      } catch (e) {
        print(e);
      }

      final res = Mtopresponse.fromJson(result.data);
      print(res);
      Snackbar.success(res.data!.message);

      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      debugPrint(e.toString());

      return false;
    }
  }

  // *Retry Add Fuel Service
  Future<bool> retryAddFuelService({
    required RetryAddFuelServiceToUserInputModel inputs,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(userRepositoryProvider).retryAddFuelService(
            userOrgId: userOrgId,
            inputs: inputs,
          );

      if (result.data['result']['error'] != null) {
        Snackbar.error(ApiHelper.getSuccessMessage(result.data['result']['error']));
      } else {
        Snackbar.success(ApiHelper.getSuccessMessage(result));
      }
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Fetch available user for mapping (fuel)
  Future<ListUserFuelMappingResponseModel> fetchUserForMapping({String? orgEnrollId}) async {
    ListUserFuelMappingResponseModel res = ListUserFuelMappingResponseModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(userRepositoryProvider).fetchUserForMapping(
            userOrgId: userOrgId,
            orgEnrollId: orgEnrollId,
          );
      try {
        res = ListUserFuelMappingResponseModel.fromJson(result.data);
      } catch (e) {
        // debugPrint('List User ERROR -> $e');
      }
      return res;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }
}
