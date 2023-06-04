import 'package:axlerate/src/common/common_controllers/page_controller.dart';
import 'package:axlerate/src/features/home/user/domain/fetch_balance_response_model.dart';
import 'package:axlerate/src/features/home/user/domain/list_orgs_by_type_model.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_fuel_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listUserPageNotifierProvider = StateNotifierProvider<PageNotifierNew, PaginatorModel>((
  ref,
) {
  return PageNotifierNew();
});

final userPpiTxnCreditAmountProvider = StateProvider<String?>((ref) {
  return null;
});
final userPpiTxnDebitAmountProvider = StateProvider<String?>((ref) {
  return null;
});

// Fund load loading indicator
final fundLoadLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

// Fetches user balance
final userDashBalanceProvider = StateProvider<FetchBalanceResponseModel?>((ref) {
  return null;
});

final userBalanceProvider = StateProvider<FetchBalanceResponseModel?>((ref) {
  return null;
});

// for staff dashboard Graph toggle Switch
final staffPpiTransChart = StateProvider<int>((ref) {
  return 0;
});

// Stores currently selected Org type while creating a user
final selectedOrgTypeProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

// Stores currently selected Org Doc while creating a user
final selectedOrgDocIdProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

// Fetches selected Org type list

final selectedOrgTypeListProvider =
    FutureProvider.family.autoDispose<ListOrgsByTypeModel, String?>((ref, [String? orgValue]) async {
  try {
    ListOrgsByTypeModel? list = await ref.read(userControllerProvider).getListOfOrganizationByType(
          orgType: orgValue ?? ref.watch(selectedOrgTypeProvider),
        );
    return list ?? [] as ListOrgsByTypeModel;
  } catch (e) {
    return [] as ListOrgsByTypeModel;
  }
});

final userMapListProvider =
    FutureProvider.family.autoDispose<ListUserFuelMappingResponseModel, String?>((ref, [String? orgEnrollId]) async {
  return await ref.read(userControllerProvider).fetchUserForMapping(orgEnrollId: orgEnrollId);
});

final selectUserMapProvider = StateProvider<String>((ref) {
  return '';
});
