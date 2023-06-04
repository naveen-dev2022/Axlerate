import 'package:dio/dio.dart';
import 'package:axlerate/values/strings.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/src/features/home/invoice/domain/create_invoice_input_model.dart';

final invoiceRepositoryProvider = Provider<InvoiceRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return InvoiceRepository(dio);
});

class InvoiceRepository {
  const InvoiceRepository(this.dio);
  final Dio dio;

  static String baseUrl = '${Strings.baseUrl}/api/organization';
  static String baseDashUrl = '${Strings.baseUrl}/api/dashboard';

  Future<Response> createInvoice({
    required CreateInvoiceInputModel formInput,
  }) async {
    String path = 'http://192.168.29.254:4800/createinvoice';
    print('#####----99999----Repository');
    try {
      Response response = await dio.post(
        path,
        data: formInput.toJson(),
      );
      print('#####----response---s---$response');
      return response;
    } catch (e) {
      print('#####----response---e---$e');
      rethrow;
    }
  }
}
