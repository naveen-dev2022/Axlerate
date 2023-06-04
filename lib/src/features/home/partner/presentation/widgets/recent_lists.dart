// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_service_icon.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/common/common_widgets/listing_card.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardRecentLists extends ConsumerStatefulWidget {
  const DashboardRecentLists({Key? key, required this.partnerOrgId}) : super(key: key);
  final String partnerOrgId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DashboardRecentListsState();
}

class DashboardRecentListsState extends ConsumerState<DashboardRecentLists> {
  bool isMobile = false;

  double screenWidth = 0.0;

  double screenHeight = 0.0;

  double availableWidth = 0.0;

  // double transactionListWidth = 0.0;
  double contentWidth = 0.0;

  List<String> recentCustomerHeaderItems = [
    "Created Date",
    "Customer Org. ID",
    "Logistics Org. Name",
    // "Axlerate Services"
  ];

  List<String> recentVehicleHeaderItems = [
    "Created Date",
    "Vehicle Reg. No.",
    "Logistics Org. Name",
    // "Axlerate Services"
  ];

  @override
  void initState() {
    super.initState();
    Future(() {
      getListOfLogistics();
    });
  }

  Future<void> getListOfLogistics() async {
    ListOrgsQueryParams params =
        ListOrgsQueryParams(organizationType: 'LOGISTICS', partnerOrgId: widget.partnerOrgId, size: 12, pageIndex: 1);
    // ref.read(listLogisticsPageNotifierProvider.notifier).setPageIndex(params.pageIndex ?? 1);
    ref.read(listofLogisticsStateProvider.notifier).state = null;
    ref.read(listofLogisticsStateProvider.notifier).state =
        await ref.read(logisticsControllerProvider).getLogisticsList(queryParams: params);
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2));
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }
    // transactionListWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2));
    contentWidth = (availableWidth - defaultMobilePadding) / recentCustomerHeaderItems.length;

    // log(contentWidth.toString());

    final logisticsList = ref.watch(listofLogisticsStateProvider);
    log(logisticsList.toString());

    return SizedBox(
      width: screenWidth,
      // height: screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Recent Customers", style: AxleTextStyle.dashboardSubHeadingText),
                InkWell(
                    onTap: () {
                      context.router.pushNamed('customers');
                    },
                    child: Text("View All >", style: AxleTextStyle.labelLarge))
              ]),
          const SizedBox(height: defaultPadding),
          logisticsList == null
              ? AxleLoader.axleProgressIndicator()
              : logisticsList.data != null && logisticsList.data!.message.docs.isNotEmpty
                  // ? GridView.builder(
                  //     itemCount: logisticsList.data!.message.docs.length,
                  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 3, mainAxisSpacing: 40, crossAxisSpacing: 24, childAspectRatio: 1.35),
                  //     shrinkWrap: true,
                  //     clipBehavior: Clip.antiAlias,
                  //     itemBuilder: (context, index) {
                  //       return ListingCard(doc: logisticsList.data!.message.docs[index]);
                  //     },
                  //   )
                  ? Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: defaultPadding,
                      spacing: defaultPadding,
                      children: logisticsList.data!.message.docs.map((doc) => ListingCard(doc: doc)).toList())
                  : emptyListResponse(),
          // Row(
          //   children: [
          //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //       AxleToggleMenu(
          //           toggleButtonWidth: 200,
          //           provider: saDashGraphToggleSwitchIndex,
          //           showFilter: false,
          //           items: [
          //             AxleToggleMenuItem(
          //               label: "Recent Customers",
          //               child: SizedBox(
          //                 width: availableWidth,
          //                 child: Column(
          //                   children: [
          //                     if (kIsWeb) transactionsHeader(isMobile, screenWidth, recentCustomerHeaderItems),
          //                     const SizedBox(
          //                       height: defaultMobilePadding,
          //                     ),
          //                     SizedBox(
          //                       height: screenHeight / 2,
          //                       child: ListView.builder(
          //                         primary: false,
          //                         shrinkWrap: true,
          //                         itemCount: 9,
          //                         itemBuilder: (BuildContext context, int index) {
          //                           List<String> itemRowData = [
          //                             '07-Dec-2022',
          //                             'AXL$index',
          //                             'ABC',
          //                             // 'Add Service',
          //                           ];
          //                           return listItem(context, isMobile, screenWidth, itemRowData);
          //                         },
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             AxleToggleMenuItem(
          //               label: "Recent Vehicles",
          //               child: SizedBox(
          //                 width: availableWidth,
          //                 child: Column(
          //                   children: [
          //                     if (kIsWeb) transactionsHeader(isMobile, screenWidth, recentVehicleHeaderItems),
          //                     const SizedBox(
          //                       height: defaultMobilePadding,
          //                     ),
          //                     SizedBox(
          //                       height: screenHeight / 2,
          //                       child: ListView.builder(
          //                         primary: false,
          //                         shrinkWrap: true,
          //                         itemCount: 9,
          //                         itemBuilder: (BuildContext context, int index) {
          //                           List<String> itemRowData = [
          //                             '07-Dec-2022',
          //                             'TN03AA171$index',
          //                             'AXL$index',
          //                             // 'Add Service',
          //                           ];
          //                           return listItem(context, isMobile, screenWidth, itemRowData);
          //                         },
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             )
          //           ]),
          //     ]),
          //   ],
          // ),
        ],
      ),
    );
  }
}

Widget transactionsHeader(bool isMobile, double screenWidth, List<String> headerItems) {
  double availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2));
  if (isMobile) {
    availableWidth = screenWidth - (defaultPadding * 2);
  }

  double contentWidth = (availableWidth - defaultMobilePadding) / headerItems.length;
  return Card(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      for (int i = 0; i < headerItems.length; i++) headerItem(contentWidth, headerItems[i]),
    ],
  ));
}

Widget emptyListResponse() {
  return const Column(
    children: [
      AxleErrorWidget(
        imgPath: 'assets/images/empty_illus.svg',
        titleStr: HomeConstants.listCustomerEmptyStr,
      ),
    ],
  );
}

SizedBox headerItem(double contentWidth, String text) {
  return SizedBox(
      width: contentWidth,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Text(text),
      ));
}

Widget listItem(BuildContext context, bool isMobile, double screenWidth, List<String> rowItem) {
  double availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2));
  if (isMobile) {
    availableWidth = screenWidth - (defaultPadding * 2);
  }

  double contentWidth = (availableWidth - defaultMobilePadding) / rowItem.length;
  return Card(
      child: Row(
    children: <Widget>[
      SizedBox(
        width: contentWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding),
          child: Text(rowItem[0]),
        ),
      ),
      SizedBox(
        width: contentWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding * 2),
          child: Text(rowItem[1]),
        ),
      ),
      SizedBox(
        width: contentWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding * 2),
          child: Text(rowItem[2]),
        ),
      ),
      if (rowItem.length > 3)
        SizedBox(
          width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding * 2),
            child: Text(rowItem[3]),
          ),
        ),
      if (rowItem.length > 4)
        SizedBox(
          width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding * 2),
            child: Text(rowItem[4]),
          ),
        ),
      if (rowItem.length > 5)
        SizedBox(
          width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding * 2),
            child: Text(rowItem[5]),
          ),
        ),
    ],
  ));
}

Widget listItemMobile(BuildContext context, List<String> rowItem, {String? iconPath}) {
  return Card(
      child: Padding(
    padding: const EdgeInsets.all(defaultMobilePadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: SizedBox(
            width: 50,
            child: AxleServiceIcon(svgPath: iconPath ?? "assets/new_assets/icons/tag_icon.svg", status: "TABLE"),
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(rowItem[1], style: AxleTextStyle.subtitle1BlackBold, maxLines: 2),
              AxleTextWithBg(
                text: rowItem[2],
                textColor: AxleColors.dashGreen,
                maxLines: 2,
                wrapText: true,
              )
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
                Icon(
                  rowItem[3] == 'DEBIT' ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                  size: 15,
                  color: rowItem[3] == 'DEBIT' ? AxleColors.rejectedStatusColor : AxleColors.enabledStatusColor,
                ),
                const SizedBox(width: 4),
                Text(
                  rowItem[4],
                  maxLines: 2,
                  style: AxleTextStyle.textFieldHeadingStyle.copyWith(
                    color: (rowItem[3] == 'DEBIT' ? AxleColors.rejectedStatusColor : AxleColors.enabledStatusColor),
                  ),
                ),
              ]),
              Text(rowItem[0], textAlign: TextAlign.right, style: AxleTextStyle.subtitle2IconGrey)
            ],
          ),
        ),
      ],
    ),
  ));
}
