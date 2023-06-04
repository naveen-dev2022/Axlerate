import 'package:axlerate/app_util/typedefs/typedefs.dart';
import 'package:axlerate/src/features/home/ppi/domain/add_ppi_service_to_user_input_model.dart';
import 'package:axlerate/src/network/api_path.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:axlerate/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ppiRepositoryProvider = Provider<PpiRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return PpiRepository(dio);
});

class PpiRepository {
  final Dio dio;
  PpiRepository(this.dio);

  static String baseApi = '${Strings.baseUrl}/api/user';

  Future<Response> addPpiServiceToUser({
    required String userOrgId,
    required AddPpiServiceToUserInputModel formInput,
  }) async {
    String path = '$baseApi/$userOrgId${ApiPath.addPpiService}';

    try {
      Response response = await dio.post(
        path,
        data: formInput.toJson(),
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> generateUserPPIOtp({
    required String userOrgId,
    required String mobile,
    required UserID userId,
    required OrganizationID orgId,
    // required OrgEntityID orgEntityId,
  }) async {
    String path = '$baseApi/$userOrgId${ApiPath.ppiGenerateOtp}';

    try {
      // Make API Call
      Response response = await dio.patch(
        path,
        data: {
          // "contactNumber": mobile,
          "userId": userId,
          "organizationId": orgId,
          // "organizationEntityId": orgEntityId,
        },
        cancelToken: axleApiCancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
