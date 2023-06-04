import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/src/features/home/payments/data/payment_repository.dart';
import 'package:axlerate/src/features/home/payments/domain/create_payment_link_input_model.dart';
import 'package:axlerate/src/features/home/payments/domain/list_invoice_saved_customer_model.dart';
import 'package:axlerate/src/features/home/payments/domain/list_invoice_saved_customer_query.dart';
import 'package:axlerate/src/features/home/payments/domain/payment_list_model.dart';
import 'package:axlerate/src/features/home/payments/domain/payment_list_search_query_params.dart';
import 'package:axlerate/src/features/home/payments/domain/request_invoice_input_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentsControllerProvider = Provider<PaymentsController>((ref) {
  return PaymentsController(ref);
});
final listPaymentStateProvider = StateProvider<PaymentListModel?>((ref) {
  return null;
});

final dueListPaymentStateProvider = StateProvider<PaymentListModel?>((ref) {
  return null;
});

final droppedListPaymentStateProvider = StateProvider<PaymentListModel?>((ref) {
  return null;
});

final listSavedCustomerStateProvider = StateProvider<ListInvoiceSavedCustomerModel?>((ref) {
  return null;
});

class PaymentsController {
  final Ref ref;

  const PaymentsController(this.ref);

  // * Request Invoice Service [SL]
  Future<void> requestInvoiceService({required RequestInvoiceInputModel inputs}) async {
    final String authId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    try {
      Response result = await ref.read(paymentsRepoProvider).requestInvoiceService(authId, inputs: inputs);
      Snackbar.success(ApiHelper.getSuccessMessage(result));
    } catch (e) {
      debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Enable Invoice Service [S]
  Future<bool> enableInvoiceService({required RequestInvoiceInputModel inputs}) async {
    final String authId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    try {
      Response result = await ref.read(paymentsRepoProvider).enableInvoiceService(authId, inputs: inputs);
      Snackbar.success(ApiHelper.getSuccessMessage(result));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Create Payment Link [SL]
  Future<bool> createPaymnetLink({required CreatePaymentLinkInputModel inputs}) async {
    final String authId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    try {
      Response result = await ref.read(paymentsRepoProvider).createPaymnetLink(authId, inputs: inputs);
      Snackbar.success(ApiHelper.getSuccessMessage(result));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
    return false;
  }

  // * List Payments Link [SL]
  Future<PaymentListModel> listPaymnetsLink(
      {required PaymentListQueryParams? params, String userOrgEnrollId = ''}) async {
    PaymentListModel res = const PaymentListModel.unknown();
    try {
      final OrgType type = ref.read(localStorageProvider).getOrgType();
      if (userOrgEnrollId.isEmpty) {
        userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      }
      if (type == OrgType.axlerate) {
        if (userOrgEnrollId.isNotEmpty) {
          params = params!.copyWith(organizationEnrollmentId: userOrgEnrollId.toLowerCase());
        }
        userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      }
      Response result =
          await ref.read(paymentsRepoProvider).listPaymnetsLink(userOrgEnrollId.toLowerCase(), params: params);
      try {
        res = PaymentListModel.fromJson(result.data);
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

  // * Payments Link by Order ID [SL]
  Future<void> paymentLinkByOrderId(String authId, {required String orderId}) async {
    final String authId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    try {
      Response result = await ref.read(paymentsRepoProvider).paymentLinkByOrderId(authId, orderId: orderId);
      Snackbar.success(ApiHelper.getSuccessMessage(result));
    } catch (e) {
      debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Drop a payment link [SL]
  Future<bool> dropPaymentLink({required String orderId}) async {
    final String authId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
    try {
      Response result =
          await ref.read(paymentsRepoProvider).dropPaymentLink(authId, orderId: orderId, orgEnrollId: orgEnrollId);

      Snackbar.success(ApiHelper.getSuccessMessage(result));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * List Invoice Customer
  Future<ListInvoiceSavedCustomerModel> listInvoiceCustomer(
      {required ListInvoiceCustomerQuery query, required String orgEnrollId}) async {
    ListInvoiceSavedCustomerModel res = const ListInvoiceSavedCustomerModel.unknown();
    try {
      Response result = await ref.read(paymentsRepoProvider).listInvoiceCustomer(orgEnrollId, query: query);
      try {
        res = ListInvoiceSavedCustomerModel.fromJson(result.data);
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
}
