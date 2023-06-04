import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:axlerate/src/features/home/dashboard/axle_view_util.dart';

// enum OrgType {
//   axlerate,
//   partner,
//   customer,
//   contractor,
// }

List<AxleSideMenuItem> allSideMenuItemList = [
  AxleSideMenuItem(
    title: 'Dashboard',
    iconPath: '',
    path: () => '/app/dashboard',
    allowedOrgTypes: [OrgType.axlerate],
  ),
];

class AxleSideMenuItem {
  final String title;
  final String iconPath;
  final Function path;
  final bool isSelected;
  final dynamic onPressed;
  final List<OrgType> allowedOrgTypes;

  AxleSideMenuItem({
    required this.title,
    required this.iconPath,
    required this.path,
    required this.allowedOrgTypes,
    this.isSelected = false,
    this.onPressed,
  });

  // static List<AxleSideMenuItem> getAllowedorgTypes(OrgType type) {}
}

class AxleSideMenu extends ConsumerWidget {
  const AxleSideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageName = ref.watch(selectedPageNameProvider);
    return ListView.builder(
      itemCount: axlePages.keys.length,
      itemBuilder: (context, index) => AxleSideMenuItemTile(
        selectedPage: selectedPageName,
        pageName: axlePages.keys.elementAt(index),
        iconPath: axlePagesIcons[0],
        onPress: () => _onTilePressed(context, ref, axlePages.keys.elementAt(index)),
      ),
    );
  }

  void _onTilePressed(BuildContext context, WidgetRef ref, String pageName) {
    context.router.navigateNamed('/app/${pageName.toLowerCase()}');

    if (ref.read(selectedPageNameProvider.notifier).state != pageName) {
      ref.read(selectedPageNameProvider.notifier).state = pageName;
    }
  }
}

class AxleSideMenuItemTile extends ConsumerWidget {
  const AxleSideMenuItemTile({
    super.key,
    required this.selectedPage,
    required this.pageName,
    required this.iconPath,
    this.onPress,
  });

  final String selectedPage;
  final String pageName;
  final String iconPath;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      hoverColor: Colors.green.shade200,
      onTap: onPress,
      leading: SvgPicture.asset(
        iconPath,
        colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
      title: Text(pageName, style: TextStyle(color: (selectedPage == pageName) ? Colors.white : sideMenuTextColor)),
    );
  }
}

// enum OrgTypes { dummy, axlerate, partner, logistics }

class SideMenuItem {
  String svgSrc;
  String title;
  Function? path;
  bool isSelected;
  dynamic onPressed;
  List<OrgType> allowedOrgTypes;

  SideMenuItem({
    required this.title,
    required this.svgSrc,
    this.path,
    required this.allowedOrgTypes,
    this.isSelected = false,
    this.onPressed,
  });

  static List<SideMenuItem> getSideMenuItems(OrgType org) {
    return items.where((ele) => ele.allowedOrgTypes.contains(org)).toList();
  }

  static List<SideMenuItem> getMenuItemsWithSelection(OrgType org, {String? path}) {
    // log(" Path :: $path");
    return getSideMenuItems(org).map((e) {
      String currentPath = e.path!();
      currentPath = currentPath.toLowerCase();
      print("Arul-->Current Path :: $currentPath");
      //(path ?? "").toLowerCase().contains(currentPath) ? e.isSelected = true : e.isSelected = false;
      return e;
    }).toList();
  }
}

List<SideMenuItem> items = [
  SideMenuItem(
    title: "Dummy",
    svgSrc: 'assets/new_assets/icons/dashboard_icon.svg',
    path: RouteUtils.getDashboardPath,
    allowedOrgTypes: [OrgType.dummy],
  ),
  SideMenuItem(
    title: "Dummy",
    svgSrc: 'assets/new_assets/icons/dashboard_icon.svg',
    path: RouteUtils.getDashboardPath,
    allowedOrgTypes: [OrgType.dummy],
  ),
  SideMenuItem(
    title: "Dummy",
    svgSrc: 'assets/new_assets/icons/dashboard_icon.svg',
    path: RouteUtils.getDashboardPath,
    allowedOrgTypes: [OrgType.dummy],
  ),
  SideMenuItem(
    title: "Dummy",
    svgSrc: 'assets/new_assets/icons/dashboard_icon.svg',
    path: RouteUtils.getDashboardPath,
    allowedOrgTypes: [OrgType.dummy],
  ),
  SideMenuItem(
    title: "Dummy",
    svgSrc: 'assets/new_assets/icons/dashboard_icon.svg',
    path: RouteUtils.getDashboardPath,
    allowedOrgTypes: [OrgType.dummy],
  ),
  SideMenuItem(
    title: "Dashboard",
    svgSrc: 'assets/new_assets/icons/dashboard_icon.svg',
    path: RouteUtils.getDashboardPath,
    isSelected: true,
    allowedOrgTypes: [OrgType.axlerate, OrgType.partner, OrgType.logisticsAdmin, OrgType.logisticsStaff],
  ),
  SideMenuItem(
    title: "Partners",
    svgSrc: 'assets/new_assets/icons/partner_icon.svg',
    path: RouteUtils.getPartnersPath,
    isSelected: false,
    allowedOrgTypes: [OrgType.axlerate],
  ),
  SideMenuItem(
    title: "Customers",
    svgSrc: 'assets/new_assets/icons/customer_icon.svg',
    path: RouteUtils.getCustomerspath,
    isSelected: false,
    allowedOrgTypes: [OrgType.axlerate, OrgType.partner],
  ),
  SideMenuItem(
    title: "Vehicles",
    svgSrc: 'assets/new_assets/icons/vehicle_line_icon.svg',
    path: RouteUtils.getVehiclesPath,
    isSelected: false,
    allowedOrgTypes: [OrgType.axlerate, OrgType.logisticsAdmin],
  ),
  SideMenuItem(
    title: "Staff",
    svgSrc: 'assets/new_assets/icons/staff_icon.svg',
    path: RouteUtils.getStaffsPath,
    isSelected: false,
    allowedOrgTypes: [OrgType.axlerate, OrgType.partner, OrgType.logisticsAdmin],
  ),
  SideMenuItem(
    title: "Commissions",
    svgSrc: 'assets/new_assets/icons/commissions.svg',
    path: RouteUtils.getCommissionsPath,
    isSelected: false,
    allowedOrgTypes: [OrgType.partner],
  ),
  // SideMenuItem(
  //   title: "Tag Management",
  //   svgSrc: 'assets/new_assets/icons/dashboard_icon.svg',
  //   path: RouteUtils.getTagManagementPath,
  //   isSelected: false,
  //   allowedOrgTypes: [OrgType.axlerate],
  // ),
  // SideMenuItem(
  //   title: "User Management",
  //   svgSrc: 'assets/new_assets/icons/manage_tag_icon.svg',
  //   path: RouteUtils.getUserManagementPath,
  //   isSelected: false,
  //   allowedOrgTypes: [OrgType.axlerate],
  // ),
  SideMenuItem(
    title: "Transaction History",
    svgSrc: 'assets/new_assets/icons/transaction_history_icon.svg',
    path: RouteUtils.getTransactionsHistoryPath,
    isSelected: false,
    allowedOrgTypes: [OrgType.axlerate, OrgType.logisticsAdmin, OrgType.logisticsStaff],
  ),
  SideMenuItem(
    title: "GPS Management",
    svgSrc: 'assets/icons/gps_icon.svg',
    path: RouteUtils.getGpsManagePath,
    isSelected: false,
    allowedOrgTypes: [OrgType.axlerate],
  ),
  SideMenuItem(
    title: "Invoice",
    svgSrc: 'assets/new_assets/icons/customer_icon.svg',
    path: RouteUtils.getInvoicePath,
    isSelected: false,
    allowedOrgTypes: [OrgType.axlerate],
  ),
  SideMenuItem(
    title: "Ecard",
    svgSrc: 'assets/new_assets/icons/customer_icon.svg',
    path: RouteUtils.getECardPath,
    isSelected: false,
    allowedOrgTypes: [OrgType.axlerate],
  ),
  // SideMenuItem(
  //   title: "Payments",
  //   svgSrc: 'assets/icons/gps_icon.svg',
  //   path: RouteUtils.getPaymentsPath,
  //   isSelected: false,
  //   allowedOrgTypes: [OrgType.axlerate, OrgType.logisticsAdmin],
  // ),
  // SideMenuItem(
  //   title: "Fund Load",
  //   svgSrc: 'assets/new_assets/icons/fund_load_icon.svg',
  //   path: RouteUtils.getFundLoadPath,
  //   isSelected: false,
  //   allowedOrgTypes: [OrgType.axlerate, OrgType.logistics],
  // ),
];
