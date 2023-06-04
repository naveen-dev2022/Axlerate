import 'package:axlerate/src/common/common_controllers/page_controller.dart';
import 'package:axlerate/src/features/home/logistics/domain/logistic_gps_info_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/logistics_dash_count_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/lq_user_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_account_info_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_dash_ppi_account_info.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_dash_tag_account_info.dart';
import 'package:flutter/material.dart' show Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orgsListPageToggleIndex = StateProvider<int>((ref) {
  return 0;
});

final orgServiceFilterPageIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final txnTabIndexProviderMobile = StateProvider<int>((ref) {
  return 0;
});

// * Current Page Index Provider
final logisticsCurrentPageProvider = StateProvider<int>((ref) {
  return 1;
});

final logisticsCopyAddressProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final logisticsSelectedDateProvider = StateProvider<DateTime?>((ref) {
  return null;
});

final orgCheckIconProvider = StateProvider<Widget?>((ref) {
  return null;
});

final logsListEndPageProvider = StateProvider<int>((ref) {
  return 3;
});

// * Logistics Page
final customerPageProvider = StateNotifierProvider.autoDispose<PageNotifierCustomer, List<int>>((ref) {
  return PageNotifierCustomer(ref);
});

class PageNotifierCustomer extends StateNotifier<List<int>> {
  PageNotifierCustomer(this.ref) : super([1, 2, 3]);

  Ref ref;

  int get lastPage => (ref.watch(logsListEndPageProvider) / 15).ceil();

  void nextPage() {
    // if (state.last < (ref.watch(logsListEndPageProvider) / 15).ceil()) {
    state = state.map((e) => e + 3).toList();
    // }
  }

  void prevPage() {
    if (state.first > 1) {
      state = state.map((e) => e - 3).toList();
    }
  }

  void backToFirst() {
    state = [1, 2, 3];
  }
}

final listLogisticsPageNotifierProvider = StateNotifierProvider<PageNotifierNew, PaginatorModel>((
  ref,
) {
  return PageNotifierNew();
});

// Mobile Dashboard Controllers

// Count
final logisticsDashCountMobileController = StateProvider.autoDispose<OrgDashCountModel?>((ref) {
  return null;
});
// Tag Account Info
final logisticsDashTagAccInfoMobileController = StateProvider.autoDispose<OrgDashTagAccountInfo?>((ref) {
  return OrgDashTagAccountInfo.reqNotSent();
});
// PPI Account Info
final logisticsDashPPIAccInfoMobileController = StateProvider.autoDispose<OrgDashPpiAccountInfo?>((ref) {
  return OrgDashPpiAccountInfo.reqNotSent();
});

// LQTAG Acc INFO
final logisticsDashLqTagAccInfoMobileController = StateProvider.autoDispose<LqUserAccInfoModel?>((ref) {
  return LqUserAccInfoModel.reqNotSent();
});

// Org GPS Info
final logisticsDashGpsInfoMobileController = StateProvider.autoDispose<LogisticsGpsInfoModel?>((ref) {
  return LogisticsGpsInfoModel.unknown();
});

// Org PPI pref state provider
final orgPpiPrefStateProvider = StateProvider.autoDispose<OrgAccountInfoModel?>((ref) {
  return null;
});

// final orgPrefNotifierProvider = NotifierProvider<OrgPrefNotifier, Map<String, dynamic>>(() {
//   return OrgPrefNotifier();
// });

// class OrgPrefNotifier extends Notifier<Map<String, dynamic>> {
//   @override
//   Map<String, dynamic> build() {
//     return {
//       'pos': true,
//       'atm': true,
//       'ecom': false,
//     };
//   }

//   void changeStatus({required String key}) {
//     Map<String, dynamic> current = state;
//     current[key] = !current[key];
//     state = current;
//   }
// }

// final orgPrefStateProvider = StateProvider<Map<String, dynamic>>((ref) {
//   return {
//     'pos': true,
//     'atm': true,
//     'ecom': false,
//   };
// });

final isOrgPrefLoadingProvider = StateProvider<bool>((ref) {
  return false;
});
