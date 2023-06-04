import 'package:axlerate/src/features/home/payments/domain/create_payment_link_input_model.dart';
import 'package:axlerate/src/features/home/payments/domain/list_invoice_saved_customer_query.dart';
import 'package:axlerate/src/features/home/payments/domain/payment_list_search_query_params.dart';
import 'package:axlerate/src/features/home/payments/domain/request_invoice_input_model.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentsRepoProvider = Provider<PaymentsRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return PaymentsRepository(dio);
});

class PaymentsRepository {
  final Dio dio;

  const PaymentsRepository(this.dio);

  static String baseInvoiceUrl = '${Strings.baseUrl}/api/invoice';

  // * Request Invoice Service [SL]
  Future<Response> requestInvoiceService(String authId, {required RequestInvoiceInputModel inputs}) async {
    String path = '$baseInvoiceUrl/$authId/${ApiPath.requestInvoice}';
    try {
      Response response = await dio.post(
        path,
        data: inputs.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Enable Invoice Service [S]
  Future<Response> enableInvoiceService(String authId, {required RequestInvoiceInputModel inputs}) async {
    String path = '$baseInvoiceUrl/$authId/${ApiPath.enableInvoice}';
    try {
      Response response = await dio.post(
        path,
        data: inputs.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Create Payment Link [SL]
  Future<Response> createPaymnetLink(String authId, {required CreatePaymentLinkInputModel inputs}) async {
    String path = '$baseInvoiceUrl/$authId/${ApiPath.createCharge}';
    try {
      Response response = await dio.post(
        path,
        data: inputs.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * List Payments Link [SL]
  Future<Response> listPaymnetsLink(String userOrgEnrollId, {PaymentListQueryParams? params}) async {
    String path = '$baseInvoiceUrl/$userOrgEnrollId/${ApiPath.listPaymentlink}';
    try {
      Response response = await dio.get(
        path,
        queryParameters: params != null ? params.toMap() : {},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Payments Link by Order ID [SL]
  Future<Response> paymentLinkByOrderId(String authId, {required String orderId}) async {
    String path = '$baseInvoiceUrl/$authId/${ApiPath.paymentLink}/$orderId';
    try {
      Response response = await dio.get(
        path,
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * Drop a payment link [SL]
  Future<Response> dropPaymentLink(String authId, {required String orgEnrollId, required String orderId}) async {
    String path = '$baseInvoiceUrl/$authId/${ApiPath.dropPaymentLink}';
    try {
      Response response = await dio.patch(
        path,
        data: {
          "organizationEnrollmentId": orgEnrollId,
          "orderId": orderId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // * List Invoice Customer
  Future<Response> listInvoiceCustomer(String authId, {required ListInvoiceCustomerQuery query}) async {
    String path = '$baseInvoiceUrl/$authId/${ApiPath.invoiceCustomer}';
    try {
      Response response = await dio.get(
        path,
        queryParameters: query.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
