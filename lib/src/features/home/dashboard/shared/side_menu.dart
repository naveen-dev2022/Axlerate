// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/app_router.gr.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
import 'package:axlerate/src/features/home/dashboard/axle_view_util.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/dashboard_controller.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/selected_organisation_controller.dart';
import 'package:axlerate/src/features/home/dashboard/shared/axle_side_menu.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/dashboard_controllers.dart';
import 'package:axlerate/src/features/home/profile/presentation/controllers/profile_image_controller.dart';
import 'package:axlerate/src/features/home/profile/presentation/profile_page_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SideMenu extends ConsumerStatefulWidget {
  SideMenu({
    Key? key,
    required this.menu,
  }) : super(key: key);
  List<SideMenuItem> menu;

  @override
  ConsumerState<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends ConsumerState<SideMenu> {
  late double screenWidth;
  late double screenHeight;
  late String _currentPath;

  String userName = '';

  String userProfile = '';

  @override
  void initState() {
    if (ref.read(profileDataStateProvider) == null) {
      getProfileData();
    }

    super.initState();
  }

  void getProfileData() async {
    ref.read(profileDataStateProvider.notifier).state = await ref.read(profileControllerProvider).getUserProfileData();
  }

  void _onTilePressed(BuildContext context, WidgetRef ref, String pageName) {
    context.router.navigateNamed(pageName.toLowerCase());
    if (ref.read(selectedPageNameProvider.notifier).state != pageName) {
      ref.read(selectedPageNameProvider.notifier).state = pageName;
    }
  }

  @override
  Widget build(BuildContext context) {
    //final selectedPageName =
    //ref.watch(selectedPageNameProvider);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    _currentPath = AutoRouter.of(context).currentPath;
    userName = ref.read(sharedPreferenceProvider).getString(Storage.username) ?? '';
    // userEmail = ref.read(sharedPreferenceProvider).getString(Storage.userEmail) ?? '';

    SelectedOrganizationModel selOrg = ref.watch(selectedOrganizationStateProvider);

    if (_currentPath.contains('/app/select-org')) {
      widget.menu = SideMenuItem.getMenuItemsWithSelection(OrgType.dummy, path: _currentPath);
    }

    return Drawer(
      width: 300,
      backgroundColor: sideMenuBgColor,
      child: Padding(
        padding: const EdgeInsets.all(defaultMobilePadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            DrawerHeader(child: Image.asset("assets/images/axlerate_text_logo_white.png")),
            Expanded(
              child: ListView(
                children: [
                  for (final item in widget.menu)
                    DrawerListTile(
                        title: item.title,
                        svgSrc: item.svgSrc,
                        press: item.onPressed ??
                            () {
                              if (Responsive.isMobile(context)) {
                                if (Navigator.canPop(context)) {
                                  Navigator.of(context).pop();
                                }
                              }
                              ref.read(sideNavSwitchIndex.notifier).state = widget.menu.indexOf(item);
                              _onTilePressed(context, ref, item.path!());
                            },
                        isSelected: ref.read(sideNavSwitchIndex.notifier).state == widget.menu.indexOf(item)
                            ? true
                            : false), // item.isSelected),
                ],
              ),
            ),
            _currentPath != '/app/select-org'
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SelectedOrganisationCard(selOrg: selOrg),
                      showMainPopUpMenuButton(context, ref),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget profileCard(BuildContext context, WidgetRef ref) {
    userProfile = ref.watch(profileImageStateProvider);

    return Container(
        margin: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0 : 8.0, vertical: 12.0),
        padding: EdgeInsets.symmetric(vertical: Responsive.isMobile(context) ? 0 : 2.0),
        decoration: BoxDecoration(
          color: highlightColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Responsive.isMobile(context) ? Colors.transparent : highlightColor),
        ),
        child: ListTile(
          mouseCursor: SystemMouseCursors.click,

          leading: userProfile.isEmpty
              ? const Icon(
                  Icons.account_circle,
                  size: 40.0,
                )
              : ClipOval(
                  child: Image.network(
                    userProfile,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userName,
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  Text(
                    ref.watch(profileDataStateProvider)?.data?.message?.contactNumber ?? '',
                    style: GoogleFonts.inter(color: const Color.fromRGBO(154, 206, 255, 1), fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(color: Colors.white38, width: 1, height: 40),
                  const SizedBox(width: 10),
                  SvgPicture.asset("assets/new_assets/icons/right_arrow.svg", height: 20, width: 10),
                ],
              )
            ],
          ),
          // trailing: showMainPopUpMenuButton(context, ref),
        ));
  }

  Widget showMainPopUpMenuButton(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      position: PopupMenuPosition.under,
      tooltip: 'More Options',
      offset: const Offset(110, 00),
      onSelected: (value) async {
        switch (value) {
          case 'profile':
            if (Responsive.isMobile(context)) {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
            context.router.navigateNamed('/app/profile');
            break;
          case 'log-out':
            bool isSuccess = await ref.read(authStateProvider.notifier).logout();
            if (isSuccess) {
              context.router.replaceAll([LoginWithOtpForm()]);
              //context.router.pushNamed('/auth');
            }
            break;
        }
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
            color: appBlue,
          )),
      itemBuilder: (context) {
        return [
          PopupMenuItem<String>(
            value: 'profile',
            child: Row(
              children: [
                const Icon(
                  Icons.person_outline_sharp,
                  color: primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Profile',
                  style:
                      GoogleFonts.inter(textStyle: const TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
                ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'log-out',
            child: Row(
              children: [
                const Icon(Icons.logout_rounded, color: primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Log Out',
                  style:
                      GoogleFonts.inter(textStyle: const TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
                ),
              ],
            ),
          ),
        ];
      },
      child: profileCard(context, ref),
      // child: Text("Test"),
      // icon: SvgPicture.asset(
      //   "assets/new_assets/icons/right_arrow.svg",
      //   height: 20,
      //   width: 10,
      // ),
    );
  }
}

class SelectedOrganisationCard extends ConsumerWidget {
  const SelectedOrganisationCard({
    Key? key,
    required this.selOrg,
  }) : super(key: key);

  final SelectedOrganizationModel selOrg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 0 : 8.0,
        vertical: 12.0,
      ),
      padding: EdgeInsets.symmetric(
        // horizontal:
        //     Responsive.isMobile(context) ? 0 : 2.0,
        vertical: Responsive.isMobile(context) ? 0 : 2.0,
      ),
      child: ListTile(
        leading: selOrg.logoUrl != null && selOrg.logoUrl!.isNotEmpty
            ? ClipOval(
                child: Image.network(
                  selOrg.logoUrl!,
                  width: 42,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(
                Icons.business_outlined,
                color: Colors.white54,
                size: 40.0,
              ),

        // Image.asset(
        //   "assets/images/profile_pic.png",
        //   height: 38,
        // ),

        title: Text(selOrg.name,
            maxLines: 2, style: AxleTextStyle.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: selOrg.enrollmentId.isEmpty
            ? Text(selOrg.type, style: AxleTextStyle.labelMedium.copyWith(color: Colors.white))
            : Text('${selOrg.type} (${selOrg.enrollmentId})',
                style: AxleTextStyle.labelMedium.copyWith(color: Colors.white)),
        trailing: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.white,
          child: IconButton(
            splashRadius: 1,
            icon: const Icon(Icons.swap_horiz_sharp, size: 16, color: Colors.black),
            onPressed: () {
              ref.invalidate(servicesIndexProvider);

              // axleApiCancelToken.cancel();
              if (Responsive.isMobile(context)) {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              }
              context.router.replaceAll([const SelectOrgnaizationRoute()]);
              //context.router.navigateNamed('/app/select-org');
            },
          ),
        ),
      ),
    );
  }
}

// class MainPopUpMenuButton extends StatelessWidget {
//   const MainPopUpMenuButton({Key? key}) : super(key: key);

// @override
// Widget build(BuildContext context) {
//   return PopupMenuButton<String>(
//     position: PopupMenuPosition.under,
//     onSelected: (value) async {
//       switch (value) {
//         case 'switch':
//           context.go('/app/select-org');
//           break;
//         case 'log-out':
//           // Provider.of<AuthProvider>(context, listen: false).logout();
//           Snackbar.success("Logged out successfully");
//           // NavigatorService.goto(context, Pages.login);
//           break;
//       }
//     },
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//         side: const BorderSide(
//           color: appBlue,
//         )),
//     itemBuilder: (context) {
//       return [
//         PopupMenuItem<String>(
//           value: 'switch',
//           child: Row(
//             children: [
//               const Icon(Icons.switch_account, color: primaryColor),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 'Switch Organization',
//                 style: GoogleFonts.inter(textStyle: const TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
//               ),
//             ],
//           ),
//         ),
//         PopupMenuItem<String>(
//           value: 'log-out',
//           child: Row(
//             children: [
//               const Icon(Icons.logout_rounded, color: primaryColor),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 'Log Out',
//                 style: GoogleFonts.inter(textStyle: const TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
//               ),
//             ],
//           ),
//         ),
//       ];
//     },
//     icon: const Icon(
//       Icons.more_vert,
//       color: iconGrey,
//     ),
//   );
// }

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.isSelected,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // selected: isSelected,
      selectedTileColor: highlightColor,
      onTap: title.toLowerCase().contains("dummy") ? null : press,
      horizontalTitleGap: 15.0,
      leading: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: AxleColors.axleBlueColor,
                borderRadius: BorderRadius.circular(10.0),
              )
            : const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            svgSrc,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            height: 16,
          ),
        ),
      ),
      title: title.toLowerCase().contains("dummy")
          ? SizedBox(
              // width: 200.0,
              height: 35.0,
              child: Shimmer.fromColors(
                baseColor: grey300,
                highlightColor: grey100,
                child: Container(
                  decoration: const BoxDecoration(
                    color: iconGrey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            )
          : Text(
              title,
              style: isSelected ? AxleTextStyle.subtitle1WhiteBold : AxleTextStyle.subtitle1IconGrey,
            ),
    );
  }
}
