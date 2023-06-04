import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/values/org_type_contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides instance of shared preference
final sharedPreferenceProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// Provide instance of LocalStorage class
final localStorageProvider = Provider<LocalStorage>((ref) {
  final sharedPreference = ref.watch(sharedPreferenceProvider);
  return LocalStorage(sharedPreference);
});

class LocalStorage {
  LocalStorage(this.sharedPref);

  final SharedPreferences sharedPref;

  OrgType getOrgType() {
    OrgType toRet = OrgType.dummy;
    // final List<dynamic> orgList = jsonDecode(sharedPref.getString(Storage.userOrganisations) ?? '');
    // if (orgList.isNotEmpty) {
    //   List<UserDecodedOrganization> list = orgList.getOrgsList;
    //   final userOrgType = list[0].organizationType;

    String userOrgType = sharedPreferences.getString(Storage.currentlyPickedOrgType) ?? '';
    String userRole = sharedPreferences.getString(Storage.currentUserRole) ?? '';

    switch (userOrgType) {
      case OrgTypeConst.axlerate:
        toRet = OrgType.axlerate;
        break;

      case OrgTypeConst.partner:
        toRet = OrgType.partner;
        break;

      case OrgTypeConst.logistics:
        switch (userRole) {
          case 'ADMIN':
            toRet = OrgType.logisticsAdmin;
            break;
          case 'STAFF':
            toRet = OrgType.logisticsStaff;
            break;
          default:
            toRet = OrgType.logisticsAdmin;
            break;
        }
        break;
      default:
        toRet = OrgType.dummy;
        break;
      // }
    }

    return toRet;
  }
}
