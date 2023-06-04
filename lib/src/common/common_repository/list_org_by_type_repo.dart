import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listOrgByTypeProvider = Provider<ListOrgByType>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return ListOrgByType(dio);
});

class ListOrgByType {
  final Dio dio;
  const ListOrgByType(this.dio);

  static String baseUserUrl = '${Strings.baseUrl}/api/user';
  static String baseOrgUrl = '${Strings.baseUrl}/api/organization';

  // Get list of Organizations by type
  Future<Response> getOrganizationListByType({
    required String userOrgId,
    required String orgType,
  }) async {
    try {
      String path = '$baseOrgUrl/$userOrgId${ApiPath.listOrganizationByType}';
      Response response = await dio.get(
        path,
        queryParameters: {"organizationType": orgType},
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
