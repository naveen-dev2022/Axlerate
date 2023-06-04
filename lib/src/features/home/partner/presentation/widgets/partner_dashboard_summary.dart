import 'dart:developer';

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/common_widgets/dashboard_summary_card.dart';
import 'package:axlerate/src/features/home/partner/presentation/controller/partner_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnerDashboardSummary extends ConsumerStatefulWidget {
  const PartnerDashboardSummary({
    Key? key,
    //required this.count,
    required this.orgId,
  }) : super(key: key);

  // final PartnerDashCountInfoModel count;
  final String orgId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PartnerDashboardSummaryState();
}

class _PartnerDashboardSummaryState extends ConsumerState<PartnerDashboardSummary> {
  late Future<double> tagRewardFuture;
  late Future<double> lqTagRewardFuture;
  late Future<double> ppiRewardFuture;
  final TextEditingController _timeRangeController = TextEditingController(text: "Month");
  String timePeriod = 'month';
  @override
  void initState() {
    tagRewardFuture = getTagReward();
    ppiRewardFuture = getPpiReward();
    lqTagRewardFuture = getLqTagReward();
    getTagAndPpiTxnAmount();
    super.initState();
  }

  getTagAndPpiTxnAmount() async {
    // * Tag Txn
    await ref.read(partnerControllerProvider).getPartnerDashTagTxnAnalytics(orgId: widget.orgId, dataType: 'year');

    // * PPI Txn
    await ref.read(partnerControllerProvider).getPartnerDashPpiTxnAnalytics(orgId: widget.orgId, dataType: 'year');
  }

  Future<double> getTagReward() async => await ref
      .read(partnerControllerProvider)
      .getPartnerTagRewardWithoutGraph(orgId: widget.orgId, dataType: timePeriod);
  Future<double> getLqTagReward() async => await ref
      .read(partnerControllerProvider)
      .getPartnerLqTagRewardWithoutGraph(orgId: widget.orgId, dataType: timePeriod);
  Future<double> getPpiReward() async => await ref
      .read(partnerControllerProvider)
      .getPartnerPpiRewardWithoutGraph(orgId: widget.orgId, dataType: timePeriod);

  double availableWidth = 0.0;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    // int summaryIndex = ref.watch(summaryIndexProvider);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    isMobile = Responsive.isMobile(context);
    // return AxleToggleMenu(
    //   title: "Summary",
    //   provider: summaryIndexProvider,
    //   showFilter: false,
    //   items: [
    //     // AxleToggleMenuItem(label: "Onboarding", child: showOnboardingCards()),
    //     // AxleToggleMenuItem(label: "Sales", child: showSalesCards()),
    //     // AxleToggleMenuItem(label: "Transactions", child: showTransactionsCards()),
    //     AxleToggleMenuItem(label: "Commissions", child: showRewardsCards())
    //   ],
    // );

    return showRewardsCards();
  }

  // Wrap showOnboardingCards() {
  //   return Wrap(
  //     spacing: isMobile ? defaultPadding : defaultPadding * 2,
  //     runSpacing: defaultPadding,
  //     children: [
  //       DashSummaryCard(
  //         title: "Customer",
  //         borderColor: AxleColors.dashGreen,
  //         value: widget.count.data?.message?.logisticsOrg?.toString() ?? '-',
  //         svgPath: "assets/new_assets/icons/customers_dash_icon.svg",
  //       ),
  //       DashSummaryCard(
  //         title: "Vehicle",
  //         borderColor: AxleColors.dashPurple,
  //         value: widget.count.data?.message?.vehicle?.toString() ?? '-',
  //         svgPath: "assets/new_assets/icons/dashboard_card_vehicle.svg",
  //       ),
  //       DashSummaryCard(
  //         title: "Staff",
  //         borderColor: AxleColors.dashBlue,
  //         value: widget.count.data?.message?.users?.toString() ?? '-',
  //         svgPath: "assets/new_assets/icons/dashboard_card_staff.svg",
  //       ),
  //     ],
  //   );
  // }

  // Wrap showSalesCards() {
  //   return Wrap(
  //     spacing: isMobile ? defaultPadding : defaultPadding * 2,
  //     runSpacing: defaultPadding,
  //     children: [
  //       DashSummaryCard(
  //         iconSize: 70,
  //         title: "FASTags",
  //         borderColor: AxleColors.dashPurple,
  //         value: widget.count.data?.message?.totalTag?.toString() ?? '-',
  //         svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg",
  //       ),
  //       DashSummaryCard(
  //         iconSize: 70,
  //         title: "Prepaid Cards",
  //         borderColor: AxleColors.dashBlue,
  //         value: widget.count.data?.message?.totalPpi?.toString() ?? '-',
  //         svgPath: "assets/new_assets/icons/dashboard_card_ppi.svg",
  //       ),
  //       DashSummaryCard(
  //         iconSize: 70,
  //         title: "GPS",
  //         borderColor: AxleColors.dashGreen,
  //         value: widget.count.data?.message?.gpsDeviceCount?.toString() ?? '-',
  //         svgPath: "assets/new_assets/icons/dashboard_card_gps.svg",
  //       ),
  //       DashSummaryCard(
  //         iconSize: 70,
  //         title: "Fuel Card",
  //         value: 'Coming Soon',
  //         borderColor: AxleColors.dashPink,
  //         svgPath: "assets/new_assets/icons/fuel_card_icon.svg",
  //       )
  //     ],
  //   );
  // }

  // Wrap showTransactionsCards() {
  //   return Wrap(
  //     spacing: isMobile ? defaultPadding : defaultPadding * 2,
  //     runSpacing: defaultPadding,
  //     children: [
  //       ref.watch(partnerTagTxnStateProvider) == null
  //           ? Container(
  //               width: 350,
  //               height: 162,
  //               decoration: CommonStyleUtil.axleContainerDecoration,
  //               child: AxleLoader.axleProgressIndicator(),
  //             )
  //           : DashSummaryTransactionsCard(
  //               title: "FASTags",
  //               subTitle: 'Total Amount Spent',
  //               borderColor: AxleColors.dashPurple,
  //               debit: ref.watch(partnerTagTxnStateProvider) != null
  //                   ? ref.watch(partnerTagTxnStateProvider)!.isEmpty
  //                       ? '-'
  //                       : axleCurrencyFormatterwithDecimals.format(double.parse(ref.watch(partnerTagTxnStateProvider)!))
  //                   : '0',
  //             ),
  //       ref.watch(partnerPpiTxnStateProvider) == null
  //           ? Container(
  //               width: 350,
  //               height: 162,
  //               decoration: CommonStyleUtil.axleContainerDecoration,
  //               child: AxleLoader.axleProgressIndicator(),
  //             )
  //           : DashSummaryTransactionsCard(
  //               title: "Prepaid Card",
  //               subTitle: 'Total Amount Spent',
  //               borderColor: AxleColors.dashBlue,
  //               debit: ref.watch(partnerPpiTxnStateProvider) != null
  //                   ? ref.watch(partnerPpiTxnStateProvider)!.isEmpty
  //                       ? '-'
  //                       : axleCurrencyFormatterwithDecimals.format(double.parse(ref.watch(partnerPpiTxnStateProvider)!))
  //                   : '0',
  //             ),
  //       // DashSummaryTransactionsCard(
  //       //   title: "Fuel Card",
  //       //   subTitle: 'Total Amount Spent',
  //       //   debit: "Coming Soon",
  //       //   borderColor: AxleColors.dashGreen,
  //       // )
  //     ],
  //   );
  // }

  Widget showRewardsCards() {
    double iconSize = isMobile ? 30 : 44;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Summary', style: AxleTextStyle.dashboardSubHeadingText),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Select Period", style: AxleTextStyle.labelLarge),
                const SizedBox(width: defaultPadding),
                AxleSearchDropDownField(
                  fieldWidth: 150,
                  fieldHint: "",
                  fieldController: _timeRangeController,
                  onChanged: (String val) {
                    log(val);
                    timePeriod = val.toLowerCase();
                    tagRewardFuture = getTagReward();
                    ppiRewardFuture = getPpiReward();
                    lqTagRewardFuture = getLqTagReward();
                    setState(() {});
                  },
                  dropDownOptions: const ["Year", "Month", "Week", "Day"],
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Wrap(
          spacing: isMobile ? defaultPadding : defaultPadding * 2,
          runSpacing: defaultPadding,
          children: [
            FutureBuilder<double>(
              future: lqTagRewardFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    // return AxleLoader.axleProgressIndicator(data: "Waiting Loader", width: 200);

                    return DashSummaryCard(
                        subTitle: 'Commission Earned',
                        iconSize: iconSize,
                        fontSize: 24,
                        borderColor: AxleColors.dashBlue,
                        title: "LQ FASTags",
                        value: "",
                        svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg",
                        isLoading: true);
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return DashSummaryCard(
                        subTitle: "Commission Earned",
                        iconSize: iconSize,
                        fontSize: 24,
                        borderColor: AxleColors.dashPurple,
                        title: "LQ FASTags",
                        svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg",
                        value: axleCurrencyFormatterwithDecimals.format(snapshot.data),
                      );
                    } else {
                      return AxleLoader.axleProgressIndicator(data: "Default Loader");
                    }
                }
              },
            ),

            FutureBuilder<double>(
              future: tagRewardFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    // return AxleLoader.axleProgressIndicator(data: "Waiting Loader", width: 200);

                    return DashSummaryCard(
                        subTitle: 'Commission Earned',
                        iconSize: iconSize,
                        fontSize: 24,
                        borderColor: AxleColors.dashBlue,
                        title: "YB FASTags",
                        value: "",
                        svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg",
                        isLoading: true);
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return DashSummaryCard(
                        subTitle: "Commission Earned",
                        iconSize: iconSize,
                        fontSize: 24,
                        borderColor: AxleColors.dashPurple,
                        title: "YB FASTags",
                        svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg",
                        value: axleCurrencyFormatterwithDecimals.format(snapshot.data),
                      );
                    } else {
                      return AxleLoader.axleProgressIndicator(data: "Default Loader");
                    }
                }
              },
            ),
            FutureBuilder<double>(
              future: ppiRewardFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    // return AxleLoader.axleProgressIndicator(width: 200);
                    return DashSummaryCard(
                        subTitle: 'Commission Earned',
                        iconSize: iconSize,
                        fontSize: 24,
                        borderColor: AxleColors.dashBlue,
                        title: "Prepaid",
                        value: "",
                        svgPath: "assets/new_assets/icons/dashboard_card_ppi.svg",
                        isLoading: true);
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return DashSummaryCard(
                          subTitle: 'Commission Earned',
                          iconSize: iconSize,
                          fontSize: 24,
                          borderColor: AxleColors.dashBlue,
                          title: "Prepaid",
                          value: axleCurrencyFormatterwithDecimals.format(snapshot.data),
                          svgPath: "assets/new_assets/icons/dashboard_card_ppi.svg");
                    } else {
                      return AxleLoader.axleProgressIndicator();
                    }
                }
              },
            ),
            // DashSummaryCard(
            //     subTitle: 'Partner Commission Earned',
            //     iconSize: 44,
            //     fontSize: 24,
            //     borderColor: AxleColors.dashGreen,
            //     title: "GPS",
            //     value: "₹2,20,000",
            //     svgPath: "assets/new_assets/icons/dashboard_card_gps.svg"),
            // DashSummaryCard(
            //     subTitle: '',
            //     iconSize: 44,
            //     fontSize: 24,
            //     borderColor: AxleColors.dashPink,
            //     title: "Fuel Card",
            //     value: 'Coming Soon',
            //     svgPath: "assets/new_assets/icons/fuel_card_icon.svg")
          ],
        ),
      ],
    );
  }
}
