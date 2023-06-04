import 'package:axlerate/src/common/common_controllers/list_org_by_type_controller.dart';
import 'package:axlerate/src/features/home/user/domain/list_orgs_by_type_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/lqtag_admin_org_response_model.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listOrgByTypeProvider = FutureProvider.family.autoDispose<ListOrgsByTypeModel, String>((ref, orgType) async {
  try {
    ListOrgsByTypeModel? list = await ref.read(listOrgByTypeControllerProvider).getListOfOrganizationByType(
          orgType: orgType,
        );
    return list ?? [] as ListOrgsByTypeModel;
  } catch (e) {
    return [] as ListOrgsByTypeModel;
  }
});

final listOrgLqAdminProvider =
    FutureProvider.family.autoDispose<LqTagAdminOrgResponseModel, String>((ref, orgEnrolId) async {
  try {
    LqTagAdminOrgResponseModel? list =
        await ref.read(vehicleControllerProvider).getLQTagAdminOrgUser(orgEnrolId: orgEnrolId);
    return list;
  } catch (e) {
    return [] as LqTagAdminOrgResponseModel;
  }
});




// final currentOrgStatusProvider = StateProvider<String?>((ref) {
//   return null;
// });
