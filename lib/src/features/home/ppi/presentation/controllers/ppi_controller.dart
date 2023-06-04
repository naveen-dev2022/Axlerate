import 'package:axlerate/app_util/typedefs/typedefs.dart';
import 'package:axlerate/src/features/home/ppi/data/ppi_repository.dart';
import 'package:axlerate/src/features/home/ppi/domain/add_ppi_service_to_user_input_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ppiControllerProvider = Provider<PpiController>((ref) {
  return PpiController(ref);
});

class PpiController {
  final Ref ref;
  PpiController(this.ref);

  Future<bool> addPpiServiceToUser({
    required AddPpiServiceToUserInputModel formInput,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(ppiRepositoryProvider).addPpiServiceToUser(
            userOrgId: userOrgId,
            formInput: formInput,
          );
      Snackbar.success('PPI service added to the user');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  Future<bool> generateUserPPIOtp({
    required String mobile,
    required UserID userId,
    required OrganizationID orgId,
    // required OrgEntityID orgEntityId,
  }) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(ppiRepositoryProvider).generateUserPPIOtp(
            userOrgId: userOrgId,
            mobile: mobile,
            userId: userId,
            orgId: orgId,
            // orgEntityId: orgEntityId,
          );
      Snackbar.success('OTP has been sent to $mobile');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }
}
