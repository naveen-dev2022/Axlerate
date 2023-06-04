import 'package:axlerate/src/features/home/transactions/data/transaction_repository.dart';
import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_list_model.dart';
import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/domain/ppi_txn_list_model.dart';
import 'package:axlerate/src/features/home/transactions/domain/ppi_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_list_model.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_query_params.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ppiTransactionListStateProvider = StateProvider<PpiTxnListModel?>((ref) {
  return null;
});

final tagTransactionListStateProvider = StateProvider<TagTxnListModel?>((ref) {
  return null;
});

final lqTagTransactionListStateProvider = StateProvider<TagTxnListModel?>((ref) {
  return null;
});

final fuelTransactionListStateProvider = StateProvider<FuelTxnListModel?>((ref) {
  return null;
});

final vehicleDashTransactionListStateProvider = StateProvider<TagTxnListModel?>((ref) {
  return null;
});

final transactionControlProvider = Provider<TransactionController>((ref) {
  return TransactionController(ref);
});
final isLoadingDownloadingDocument = StateProvider<bool>((ref) {
  return false;
});

class TransactionController {
  final Ref ref;

  const TransactionController(this.ref);

  Future<PpiTxnListModel> listPpiTxns(
      {PpiTxnQueryParams? params, String? orgEnrollIdOfUser, String userOrgEnrollId = ''}) async {
    PpiTxnListModel res = const PpiTxnListModel.unknown();
    try {
      if (userOrgEnrollId.isEmpty) {
        userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      }

      if (orgEnrollIdOfUser != null && orgEnrollIdOfUser.isNotEmpty) {
        params = params!.copyWith(organizationEnrollmentId: orgEnrollIdOfUser);
      }
      Response result = await ref.read(transactionsRepoProvider).listPpiTransactions(
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
            qParams: params,
          );
      try {
        res = PpiTxnListModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint(e.toString());

        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<FuelTxnListModel> listFuelTxns(
      {FuelTxnQueryParams? params, String? orgEnrollIdOfUser, String userOrgEnrollId = ''}) async {
    FuelTxnListModel res = const FuelTxnListModel.unknown();
    try {
      if (userOrgEnrollId.isEmpty) {
        userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      }
      if (orgEnrollIdOfUser != null && orgEnrollIdOfUser.isNotEmpty) {
        params = params?.copyWith(organizationEnrollmentId: orgEnrollIdOfUser);
      }

      Response result = await ref.read(transactionsRepoProvider).listFuelTransactions(
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
            qParams: params,
          );
      try {
        res = FuelTxnListModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint(e.toString());

        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<TagTxnListModel> listTagTxns(
      {TagTxnQueryParams? params, String? orgEnrollIdOfUser, String userOrgEnrollId = ''}) async {
    TagTxnListModel res = TagTxnListModel.unknown();
    try {
      if (userOrgEnrollId.isEmpty) {
        userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      }
      if (orgEnrollIdOfUser != null && orgEnrollIdOfUser.isNotEmpty) {
        params = params?.copyWith(filterField: 'organizationEnrollmentId', filterText: orgEnrollIdOfUser);
      }
      Response result = await ref.read(transactionsRepoProvider).listTagTransactions(
            userOrgEnrollId: userOrgEnrollId,
            qParams: params,
          );

      try {
        res = TagTxnListModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint(e.toString());
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  listLqTagTxns({
    TagTxnQueryParams? params,
    String? orgEnrollIdOfUser,
    String userOrgEnrollId = '',
    String? vehicleId,
  }) async {
    TagTxnListModel res = TagTxnListModel.unknown();
    try {
      if (userOrgEnrollId.isEmpty) {
        userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      }

      if (orgEnrollIdOfUser != null && orgEnrollIdOfUser.isNotEmpty) {
        params = params?.copyWith(organizationEnrollmentId: [orgEnrollIdOfUser]);
      }
      if (vehicleId != null) {
        params = params?.copyWith(vehicleRegistrationNumber: [vehicleId]);
      }
      Response result =
          await ref.read(transactionsRepoProvider).listLqTagTransactions(userOrgId: userOrgEnrollId, qParams: params);
      if (params!.fileType != null) {
        return result.data;
      }

      try {
        res = TagTxnListModel.fromJson(result.data);
        // debugPrint("listTagTxns : --> $res");
        return res;
      } catch (e) {
        debugPrint(e.toString());
        // log(e.toString());
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }
}
