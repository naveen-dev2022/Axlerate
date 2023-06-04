// Get list of Organizations by type

import 'package:axlerate/src/common/common_repository/list_org_by_type_repo.dart';
import 'package:axlerate/src/features/home/user/domain/list_orgs_by_type_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listOrgByTypeControllerProvider = Provider<ListOrgByTypeController>((ref) {
  return ListOrgByTypeController(ref);
});

class ListOrgByTypeController {
  final Ref ref;

  const ListOrgByTypeController(
    this.ref,
  );

  Future<ListOrgsByTypeModel?> getListOfOrganizationByType({
    required String orgType,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(listOrgByTypeProvider).getOrganizationListByType(
            userOrgId: userOrgId,
            orgType: orgType,
          );
      ListOrgsByTypeModel orgsList = ListOrgsByTypeModel.fromJson(result.data);
      return orgsList;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return null;
    }
  }
}
