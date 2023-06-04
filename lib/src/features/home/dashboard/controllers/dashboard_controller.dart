import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/src/common/common_models/graph_response_model.dart';
import 'package:axlerate/src/features/home/dashboard/data/dashboard_repository.dart';
import 'package:axlerate/src/features/home/dashboard/domain/sa_dash_count_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final saDashSummaryToggleSwitchIndex = StateProvider<int>((ref) {
  return 0;
});

final saDashGraphToggleSwitchIndex = StateProvider<int>((ref) {
  return 0;
});

final saDashControllerProvider = Provider<SaDashContoller>((ref) {
  OrgType type = ref.read(localStorageProvider).getOrgType();
  return SaDashContoller(
    ref,
    type == OrgType.axlerate,
  );
});

final sideNavSwitchIndex = StateProvider<int>((ref) {
  return 0;
});

class SaDashContoller {
  final Ref ref;
  final bool isSuperAdmin;

  const SaDashContoller(this.ref, this.isSuperAdmin);

  Future<SaDashCount> getSaDashCount() async {
    SaDashCount res = SaDashCount.unknown();

    try {
      final superOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';

      Response result =
          await ref.read(saDashRepositoryProvider).getSaOrgDashCount(superOrgEnrollId: superOrgEnrollId.toLowerCase());
      try {
        res = SaDashCount.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Logis Dash count Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // // * Get SA Dash Tag Rewards (Revenue)
  // Future<String> getSaDashTagRewards({
  //   required String dataType,
  // }) async {
  //   try {
  //     final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
  //     Response result =
  //         await ref.read(saDashRepositoryProvider).getSaDashTagRewards(userOrgId: userOrgId, dataType: dataType);
  //     try {
  //       return result.data['data']['message']['totalTagRewards'].toString();
  //     } catch (e) {
  //       return '';
  //     }
  //   } catch (e) {
  //     Snackbar.error(ApiHelper.getErrorMessage(e));
  //     return '';
  //   }
  // }

  // * Get SA Dash TAG TXN Analytics
  // * dataType : 'year', 'week', 'day', 'month'

  Future<String> getSaDashTagTxnAnalytics({
    required String dataType,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(saDashRepositoryProvider).getSaDashTagTxnAnalytics(
            userOrgId: userOrgId,
            dataType: dataType,
          );
      try {
        if (result.data['data']['message']['value'] != null) {
          return result.data['data']['message']['value'].toString();
        } else {
          return '0.0';
        }
      } catch (e) {
        // debugPrint('SA DASH TAG TXN Amount Error -> $e');
        return '0.0';
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '0.0';
    }
  }

  // * Get SA Dash PPI TXN Analytics
  // * dataType : 'year', 'week', 'day', 'month'
  Future<String> getSaDashPpiTxnAnalytics({
    required String dataType,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(saDashRepositoryProvider).getSaDashPpiTxnAnalytics(
            userOrgId: userOrgId,
            dataType: dataType,
          );
      try {
        if (result.data['data']['message']['value'] != null) {
          return result.data['data']['message']['value'].toString();
        } else {
          return '0.0';
        }
      } catch (e) {
        // debugPrint('SA DASH PPI TXN Amount Error -> $e');
        return '0.0';
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '0.0';
    }
  }

  // * Get SA Dash Tag Revenue Amount
  // * dataType : 'year', 'week', 'day', 'month'
  Future<String> getSaDashTagRevenueAmount({
    required String dataType,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(saDashRepositoryProvider).getSaDashTagRevenueAnalytics(
            userOrgId: userOrgId,
            dataType: dataType,
            isGraph: false,
          );
      try {
        if (result.data['data']['message']['value'] != null) {
          return result.data['data']['message']['value'].toString();
        } else {
          return '0.0';
        }
      } catch (e) {
        // debugPrint('SA DASH Tag Revenue Amount Error -> $e');
        return '0.0';
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '0.0';
    }
  }

  // * Get SA Dash Tag Revenue Analytics
  // * dataType : 'year', 'week', 'day', 'month'
  Future<GraphResponseModel> getSaDashTagRevenueAnalytics({
    required String dataType,
  }) async {
    GraphResponseModel res = GraphResponseModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(saDashRepositoryProvider).getSaDashTagRevenueAnalytics(
            userOrgId: userOrgId,
            dataType: dataType,
            isGraph: true,
          );
      try {
        res = GraphResponseModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('SA DASH Tag Revenue Analytics Error -> from Json Error');
        // debugPrint('SA DASH Tag Revenue Analytics Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get SA Dash PPI Revenue Amount
  // * dataType : 'year', 'week', 'day', 'month'
  Future<String> getSaDashPpiRevenueAmount({
    required String dataType,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(saDashRepositoryProvider).getSaDashPpiRevenueAnalytics(
            userOrgId: userOrgId,
            dataType: dataType,
            isGraph: false,
          );
      try {
        if (result.data['data']['message']['value'] != null) {
          return result.data['data']['message']['value'].toString();
        } else {
          return '0.0';
        }
      } catch (e) {
        // debugPrint('SA DASH PPI Revenue Amount Error -> $e');
        return '0.0';
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return '0.0';
    }
  }

  // * Get SA Dash Tag Revenue Analytics
  // * dataType : 'year', 'week', 'day', 'month'
  Future<GraphResponseModel> getSaDashPpiRevenueAnalytics({
    required String dataType,
  }) async {
    GraphResponseModel res = GraphResponseModel.unknown();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(saDashRepositoryProvider).getSaDashPpiRevenueAnalytics(
            userOrgId: userOrgId,
            dataType: dataType,
            isGraph: true,
          );
      try {
        res = GraphResponseModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('SA DASH PPI Revenue Analytics Error -> from Json Error');
        // debugPrint('SA DASH PPI Revenue Analytics Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }
}
