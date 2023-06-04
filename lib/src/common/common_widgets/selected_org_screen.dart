import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/router/utils/loader_provider.dart';
import 'package:axlerate/src/features/authentication/domain/user_decode_model.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/selected_organisation_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SelectedOrgScreen extends ConsumerStatefulWidget {
  const SelectedOrgScreen({@PathParam('selOrg') required this.selOrg, super.key});
  final String selOrg;

  @override
  ConsumerState<SelectedOrgScreen> createState() => _SelectedOrgScreenState();
}

class _SelectedOrgScreenState extends ConsumerState<SelectedOrgScreen> {
  @override
  void initState() {
    Future(() => saveSelectedOrgToSharedPreferences());
    super.initState();
  }

  saveSelectedOrgToSharedPreferences() async {
    List<dynamic> organisations =
        jsonDecode(ref.read(sharedPreferenceProvider).getString(Storage.userOrganisations) ?? "");

    List<UserDecodedOrganization> orgs = organisations.getOrgsList;

    UserDecodedOrganization org =
        orgs.firstWhere((element) => element.organizationEnrollmentId.toLowerCase() == widget.selOrg.toLowerCase());
    await selectOrganisation(org);
  }

  Future<void> selectOrganisation(UserDecodedOrganization org) async {
    final sharedPref = ref.read(sharedPreferenceProvider);
    await sharedPref.setString(Storage.currentlyPickedOrgId, org.organizationId);
    await sharedPref.setString(Storage.currentlyPickedOrgCode, org.orgCode);
    await sharedPref.setString(Storage.currentlyPickedOrgEnrollId, org.organizationEnrollmentId);
    await sharedPref.setString(Storage.currentlyPickedOrgType, org.organizationType);
    await sharedPref.setString(Storage.currentlyPickedOrgName, org.displayName);
    await sharedPref.setString(Storage.currentUserRole, org.role.first);
    print(org.toString());
    //await sharedPref.setBool(Storage.isPpiEnabledForCurrentUser, org.isPpiRegistered);
    await sharedPref.setString(Storage.selectedUserEntityId, org.userEntityId ?? '');
    await sharedPref.setString(Storage.selectedOrgStatus, org.status);
    // ref.read(currentOrgStatusProvider.notifier).state = org.status ?? '';

    // Setting this to disable Sidebar Navigation
    if (!kIsWeb && (org.organizationType == "AXLERATE")) {
      await sharedPref.setString(Storage.currentlyPickedOrgType, 'dummy');
    }

    SelectedOrganizationModel selOrg = SelectedOrganizationModel(
      name: org.displayName,
      enrollmentId: org.organizationEnrollmentId,
      type: org.organizationType,
      status: org.status,
      logoUrl: org.logo,
    );
    ref.read(selectedOrganizationStateProvider.notifier).state = selOrg;
    await sharedPref.setString(Storage.selectedOrgData, jsonEncode(selOrg.toJson()));
    // String selectedOrgStatus = org.status;
    // log('Org Status ===> $selectedOrgStatus');
  }

  // navigation() {
  //   if (selectedOrgStatus == 'INVITED' && mounted) {
  //     context.go(
  //       '/app/${org.organizationEnrollmentId.toLowerCase()}/${AxleRoutePath.completeReg}',
  //       extra: org.organizationId,
  //     );
  //   } else {
  //     final userRole = ref.read(sharedPreferenceProvider).getString(Storage.currentUserRole);
  //     if (userRole == 'STAFF') {
  //       final orgEnroll = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
  //       final userEnroll = ref.read(sharedPreferenceProvider).getString(Storage.userEnrollmentId) ?? '';

  //       context.go(RouteUtils.getStaffDashboard(orgEnroll, userEnroll));
  //     } else {
  //       context.go(RouteUtils.getDashboardPath());
  //     } //'/app/${org.organizationEnrollmentId.toLowerCase()}/dashboard');
  //   }
  // }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // log("Guard Loader :: Build " + isLoading.toString() + " ::" + guardObserver.guardInProgress.toString());
    isLoading = ref.watch(loadingProvider);
    return Stack(
        children: [const AutoRouter(), Visibility(visible: isLoading, child: AxleLoader.axleProgressIndicator())]);
  }
}
