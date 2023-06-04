import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/axle_route_path.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/profile_widget.dart';
import 'package:axlerate/src/features/authentication/domain/user_decode_model.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/dashboard_controller.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/selected_organisation_controller.dart';
import 'package:axlerate/src/features/home/profile/presentation/profile_page_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

final isPageLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

@RoutePage()
class SelectOrgnaizationPage extends ConsumerStatefulWidget {
  const SelectOrgnaizationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectOrgnaizationState();
}

class _SelectOrgnaizationState extends ConsumerState<SelectOrgnaizationPage> {
  late List<dynamic> orgList;
  late List<UserDecodedOrganization> list;
  late String currentlySelectedId;
  late String username;
  // late String userEmail;
  late String userProfileUrl;

  bool isLoading = false;

  @override
  void initState() {
    final userData = ref.read(profileDataStateProvider);
    if (userData == null) {
      getAndStoreUserDetails();
    }
    orgList = jsonDecode(ref.read(sharedPreferenceProvider).getString(Storage.userOrganisations) ?? '');
    list = orgList.getOrgsList;
    currentlySelectedId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

    username = ref.read(sharedPreferenceProvider).getString(Storage.username) ?? '';
    // userEmail = ref.read(profileDataStateProvider);
    userProfileUrl = ref.read(sharedPreferenceProvider).getString(Storage.profileUrl) ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (list.length == 1) {
        selectOrganisation(list.first);
      }
    });

    super.initState();
  }

  void getAndStoreUserDetails() async {
    ref.read(profileDataStateProvider.notifier).state = await ref.read(profileControllerProvider).getUserProfileData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);

    // log('The List is -> $list');

    return Scaffold(
      backgroundColor: AxleColors.axleWhiteColor,
      body: ref.watch(isPageLoadingProvider)
          ? AxleLoader.axleProgressIndicator()
          : SizedBox(
              width: isMobile ? null : screenWidth / 60 * 100,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                scrollable: true,
                // titlePadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                contentPadding: const EdgeInsets.all(0.0),
                // title: Container(
                //   decoration: const BoxDecoration(
                //     color: AxleColors.axleBackgroundColor,
                //   ),
                //   child: SizedBox(
                //     width: double.infinity,
                //     height: 200,
                //     child: Container(
                //       alignment: const Alignment(0.0, 2.5),
                //       child: ClipOval(child: Image.network(userProfileUrl, width: 40, height: 40, fit: BoxFit.cover)),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 60,
                // ),

                content: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: const Alignment(0.0, 8),
                        children: [
                          Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AxleColors.axleBackgroundColor,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          ProfileImageWidget(url: userProfileUrl, width: 40, height: 40, radius: 40),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Text(username, style: isMobile ? AxleTextStyle.titleMedium : AxleTextStyle.headingPrimary),
                      Text(ref.watch(profileDataStateProvider)?.data?.message?.contactNumber ?? '',
                          style: isMobile ? AxleTextStyle.titleSmall : AxleTextStyle.headline6BlackStyle),
                      const SizedBox(height: 15.0),
                      Center(
                        child: Text(
                          'Choose Organization',
                          style: isMobile ? AxleTextStyle.titleLarge : AxleTextStyle.mainBigHeading,
                        ),
                      ),
                      const Divider(
                        color: AxleColors.axleShadowColor,
                        thickness: 1.5,
                        indent: defaultPadding,
                        endIndent: defaultPadding,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Column(
                          children: list
                              .map(
                                (item) => orgCard(context, item),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void selectOrganisation(UserDecodedOrganization org) async {
    final loader = ref.read(isPageLoadingProvider.notifier);
    loader.state = true;
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
    ref.read(sideNavSwitchIndex.notifier).state = 0;
    ref.read(selectedOrganizationStateProvider.notifier).state = selOrg;
    await sharedPref.setString(Storage.selectedOrgData, jsonEncode(selOrg.toJson()));
    String selectedOrgStatus = org.status;
    loader.state = false;
    clearPreviousRoutes();
    // log('Org Status ===> $selectedOrgStatus');
    if (selectedOrgStatus == 'INVITED' && mounted) {
      context.router.pushNamed(
        '/app/${org.organizationEnrollmentId.toLowerCase()}/${AxleRoutePath.completeReg}',

        // extra: org.organizationId,
      );
    } else {
      final userRole = ref.read(sharedPreferenceProvider).getString(Storage.currentUserRole);
      if (userRole == 'STAFF') {
        final orgEnroll = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
        final userEnroll = ref.read(sharedPreferenceProvider).getString(Storage.userEnrollmentId) ?? '';
        context.router.pushNamed(RouteUtils.getStaffDashboard(orgEnroll, userEnroll));
      } else {
        context.router.pushNamed(RouteUtils.getDashboardPath());
      } //'/app/${org.organizationEnrollmentId.toLowerCase()}/dashboard');
    }
  }

  clearPreviousRoutes() {
    context.router.popUntilRouteWithName(RouteUtils.getSelectOrganizationPath());
  }

  Widget orgCard(
    BuildContext context,
    UserDecodedOrganization org,
  ) {
    // log(org.displayName + org.orgCode);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: currentlySelectedId == org.organizationId ? const Color(0xffCFE8FF) : Colors.white,
      ),
      child: ListTile(
        hoverColor: Colors.grey,
        mouseCursor: SystemMouseCursors.click,
        onTap: () => selectOrganisation(org),
        leading: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(defaultMobilePadding),
            child: org.logo!.isNotEmpty
                ? Image.network(org.logo!, width: 40, height: 40, fit: BoxFit.cover)
                : const Icon(Icons.apartment_outlined, color: Color(0xff023874), size: 12.0),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              org.displayName.trim().isEmpty ? org.orgCode : org.displayName,
              overflow: TextOverflow.clip,
              style: AxleTextStyle.bodyMedium,
            ),
            const SizedBox(height: 4.0),
            Text(
              org.organizationEnrollmentId,
              overflow: TextOverflow.clip,
              style: AxleTextStyle.bodySmall.copyWith(color: Colors.black),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getOrgIndicatorCard(org.organizationType),
            !(Responsive.isMobile(context)) ? const SizedBox(width: 10.0) : const SizedBox(),
            !(Responsive.isMobile(context))
                ? currentlySelectedId == org.organizationId
                    ? const Icon(Icons.check, color: AxleColors.axleBlueColor, size: 18.0)
                    : const SizedBox(width: 18.0)
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  // Organization Indicator Card
  Widget getOrgIndicatorCard(String orgName) {
    Color cardColor = const Color(0xffA792CA);
    String cardText = '';
    switch (orgName) {
      case 'AXLERATE':
        cardColor = const Color(0xff616161);
        cardText = 'Super Admin';
        break;
      case 'PARTNER':
        cardColor = const Color(0xff92CA9B);
        cardText = 'Partner';
        break;
      case 'LOGISTICS':
        cardColor = const Color(0xffA792CA);
        cardText = 'Logistics';
        break;
    }
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(8.0)),
      child: Text(
        cardText,
        overflow: TextOverflow.ellipsis,
        style: AxleTextStyle.labelSmall.copyWith(color: Colors.white),
      ),
    );
  }
}
