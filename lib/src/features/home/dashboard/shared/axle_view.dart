// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/dashboard_controller.dart';
import 'package:axlerate/src/features/home/dashboard/shared/axle_side_menu.dart';
import 'package:axlerate/src/features/home/dashboard/shared/side_menu.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/values/constants.dart';
import 'package:axlerate/values/org_type_contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage(name: 'AxleScaffold')
class AxleView extends ConsumerWidget {
  AxleView({
    super.key,
    // required this.pageWidget,
    // required this.routerState,
    this.appBarTitle = '',
  });

  // final Widget pageWidget;
  // final GoRouterState routerState;
  String appBarTitle;
  late OrgType orgType = OrgType.dummy;
  late String orgTypeString;

  bool isYellowTheme = false;

  bool isStaff(WidgetRef ref) {
    final role = ref.read(sharedPreferenceProvider).getString(Storage.currentUserRole);
    return role == 'STAFF';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ancestorScaffold = Scaffold.maybeOf(context);
    final hasDrawer = ancestorScaffold != null && ancestorScaffold.hasDrawer;

    final isMobile = Responsive.isMobile(context);
    //SelectedOrganizationModel selOrg = ref.watch(selectedOrganizationStateProvider);
    // String selectedOrg = selOrg.type;

    orgTypeString = sharedPreferences.getString(Storage.currentlyPickedOrgType) ?? '';

    orgType = getSelectedOrgType(orgTypeString);

    appBarTitle = getTitle(context.router.currentPath, ref);

    if (isMobile) {
      return Scaffold(
          appBar: AppBar(
            foregroundColor: isYellowTheme ? primaryColor : primaryColor,
            title: Text(
              appBarTitle,
              style: AxleTextStyle.titleMedium,
            ),
            centerTitle: false,
            backgroundColor: isYellowTheme ? secondaryColor : Colors.white,
            leading: hasDrawer
                ? IconButton(
                    icon: const Icon(Icons.menu_rounded),
                    onPressed: hasDrawer ? () => ancestorScaffold.openDrawer() : null,
                  )
                : null,
            actions: appBarTitle.toLowerCase().contains('dashboard') && orgType != OrgType.partner
                ? [
                    InkWell(
                      onTap: () {
                        final orgEnrollId =
                            ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
                        context.router.pushNamed(RouteUtils.getCustomerServicesPath(custEnrollId: orgEnrollId));
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: defaultPadding),
                        child: Icon(Icons.settings_suggest_sharp),
                      ),
                    )
                  ]
                : null,
          ),
          drawer: SideMenu(menu: SideMenuItem.getMenuItemsWithSelection(orgType, path: context.router.currentPath)),
          bottomNavigationBar: (orgType == OrgType.axlerate)
              ? null
              : Bottombar(menu: SideMenuItem.getMenuItemsWithSelection(orgType, path: context.router.currentPath)),
          body: const AutoRouter()
          // pageWidget,
          );
    } else {
      return Scaffold(
        body: Row(
          children: [
            SideMenu(
              menu: SideMenuItem.getMenuItemsWithSelection(orgType, path: context.router.currentPath),
              // orgType: orgType,
            ),
            const Expanded(flex: 3, child: AutoRouter()),
          ],
        ),
      );
    }
  }

  String getTitle(String routerPath, WidgetRef ref) {
    List<String> locations = routerPath.split('/');
    String toRet = locations.last;

    if (locations.length > 1) {
      int length = locations.length;

      const pattern = r'(axl)|(axu)|(axv)|(axp)';
      final regExp = RegExp(pattern, caseSensitive: false);
      String str1 = '';
      String str2 = '';
      if (regExp.hasMatch(locations[length - 2])) {
        str1 = locations[length - 2].toUpperCase();
      } else {
        str1 = locations[length - 2].toTitleCase();
      }

      if (regExp.hasMatch(locations.last) || locations[length - 2].toLowerCase().contains('vehicle')) {
        if (locations.last.toLowerCase() == 'view') {
          str2 = locations.last.toUiTitleCase;
        } else {
          str2 = locations.last.toUpperCase();
        }
      } else {
        str2 = locations.last.toUiTitleCase;
      }

      toRet = "$str1 • $str2";

      if (toRet.toLowerCase().contains('select-org')) {
        toRet = 'Dashboard';
      } else if (toRet.toLowerCase().contains('customers')) {
        toRet = 'Dashboard';
      } else if (toRet.toLowerCase().contains('static dashboard')) {
        final orgName = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgName) ?? '';
        final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
        toRet = '${orgName.toUiCase} • ${orgEnrollId.toUpperCase()}';
      }
    }

    return toRet;

    //return getPageTitle(routerState.fullpath.toString());
  }

  OrgType getSelectedOrgType(String userOrgType) {
    final userRole = sharedPreferences.getString(Storage.currentUserRole) ?? '';

    OrgType toRet = OrgType.dummy;
    switch (userOrgType.toUpperCase()) {
      case OrgTypeConst.axlerate:
        toRet = OrgType.axlerate;
        break;

      case OrgTypeConst.partner:
        toRet = OrgType.partner;
        break;

      case OrgTypeConst.logistics:
        switch (userRole) {
          case OrgTypeConst.logisticsAdmin:
            toRet = OrgType.logisticsAdmin;
            break;
          case OrgTypeConst.logisticsStaff:
            toRet = OrgType.logisticsStaff;
            break;
          default:
            toRet = OrgType.dummy;
            break;
        }
        break;

      default:
        toRet = OrgType.dummy;
        break;
    }
    return toRet;
  }
}

int getSelectedIndex(List<SideMenuItem> menu, ref) {
  //int index = menu.indexWhere((element) => element.isSelected == true);
  int index = ref.read(sideNavSwitchIndex);
  return index == -1 ? 0 : index;
}

class Bottombar extends ConsumerWidget {
  Bottombar({super.key, required this.menu});
  List<SideMenuItem> menu;
  bool isYellowTheme = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String currentPath = context.router.currentPath;
    log("Current path :: $currentPath");
    if (currentPath.contains('/app/select-org')) {
      menu = SideMenuItem.getMenuItemsWithSelection(OrgType.dummy, path: currentPath);
    }

    if (menu[0].title.toLowerCase().contains("dummy")) {
      return SizedBox(
          height: 50,
          child: Card(child: Center(child: Text("Please choose an Organization.", style: AxleTextStyle.labelMedium))));
    } else {
      return BottomNavigationBar(
          elevation: 10.0,
          backgroundColor: isYellowTheme ? secondaryColor : Colors.white,
          selectedLabelStyle: AxleTextStyle.labelLarge,
          unselectedLabelStyle: AxleTextStyle.labelSmall,
          selectedItemColor: isYellowTheme ? primaryColor : primaryColor,
          unselectedItemColor: isYellowTheme ? primaryColor.withOpacity(0.7) : primaryColor.withOpacity(0.5),
          type: BottomNavigationBarType.fixed,
          currentIndex: getSelectedIndex(menu, ref),
          onTap: ((value) {
            // NavigatorService.goto(context, menu[value].path());
            //context.go(menu[value].path!());
            ref.read(sideNavSwitchIndex.notifier).state = value;
            context.router.navigateNamed(menu[value].path!());
          }),
          items: [
            for (final item in menu)
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    item.svgSrc,
                    colorFilter: ColorFilter.mode(isYellowTheme ? primaryColor : primaryColor, BlendMode.srcIn),
                    height: 22,
                  ),
                  icon: SvgPicture.asset(
                    item.svgSrc,
                    colorFilter: ColorFilter.mode(
                        isYellowTheme ? primaryColor.withOpacity(0.7) : primaryColor.withOpacity(0.5), BlendMode.srcIn),
                    height: 18,
                  ),
                  label: item.title.split(' ').length > 1 ? '${item.title.split(' ').first}s' : item.title,
                  tooltip: item.title)
          ]);
    }
  }
}
