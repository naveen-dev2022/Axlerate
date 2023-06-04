import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/features/home/common_widgets/dashboard_graph.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_toggle_menu.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/dashboard_controller.dart';
import 'package:axlerate/src/features/home/dashboard/domain/sa_dash_count_model.dart';
import 'package:axlerate/src/features/home/dashboard/presentation/widgets/sa_dash_summary_card.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';

class SuperAdminDashboard extends ConsumerStatefulWidget {
  const SuperAdminDashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuperAdminDashboardState();
}

double screenWidth = 0.0;
double screenHeight = 0.0;
// double availableWidth = 0.0;
bool isMobile = false;

class _SuperAdminDashboardState extends ConsumerState<SuperAdminDashboard> {
  late Future<SaDashCount> dashCountFuture;
  late OrgType orgType;

  @override
  void initState() {
    orgType = ref.read(localStorageProvider).getOrgType();
    if (orgType == OrgType.axlerate) {
      dashCountFuture = getDashCount();
    }
    super.initState();
  }

  Future<SaDashCount> getDashCount() async {
    return await ref.read(saDashControllerProvider).getSaDashCount();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: FutureBuilder<SaDashCount>(
        future: dashCountFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return AxleLoader.axleProgressIndicator();
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                if (snapshot.data?.data == null) {
                  return const Center(child: AxleErrorWidget());
                }

                return SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: isMobile
                          ? const EdgeInsets.all(defaultPadding)
                          : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isMobile)
                            const Column(
                              children: [
                                DashboardHeader(title: "Dashboard", showBack: false),
                                SizedBox(height: defaultPadding),
                              ],
                            ),

                          SuperAdminDashboardSummary(
                            countInfo: snapshot.data!,
                          ),

                          const SizedBox(
                            height: 32,
                          ),
                          DashboardGraph(
                            orgType: orgType.name.toUpperCase(),
                          ),
                          // LogisticsDashboardServices(orgId: widget.orgId, count: snapshot.data!)
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return AxleLoader.axleProgressIndicator();
              }
          }
        },
      ),
    );
  }
}

class SuperAdminDashboardSummary extends ConsumerStatefulWidget {
  const SuperAdminDashboardSummary({
    super.key,
    required this.countInfo,
  });

  final SaDashCount countInfo;

  @override
  ConsumerState<SuperAdminDashboardSummary> createState() => _SuperAdminDashboardSummaryState();
}

class _SuperAdminDashboardSummaryState extends ConsumerState<SuperAdminDashboardSummary> {
  // * For Txn Section
  late Future<String> tagTxnAmountFuture;
  late Future<String> ppiTxnAmountFuture;
  // * For Reveue Section
  late Future<String> tagRevenueAmountFuture;
  late Future<String> ppiRevenueAmountFuture;

  @override
  void initState() {
    tagTxnAmountFuture = getTagTxnAmount();
    ppiTxnAmountFuture = getPpiTxnAmount();
    tagRevenueAmountFuture = getTagRevenueAmount();
    ppiRevenueAmountFuture = getPpiRevenueAmount();
    super.initState();
  }

  // * For Txn Section
  Future<String> getTagTxnAmount() async =>
      await ref.read(saDashControllerProvider).getSaDashTagTxnAnalytics(dataType: 'year');
  Future<String> getPpiTxnAmount() async =>
      await ref.read(saDashControllerProvider).getSaDashPpiTxnAnalytics(dataType: 'year');
  // * For Reveue Section
  Future<String> getTagRevenueAmount() async =>
      await ref.read(saDashControllerProvider).getSaDashTagRevenueAmount(dataType: 'year');
  Future<String> getPpiRevenueAmount() async =>
      await ref.read(saDashControllerProvider).getSaDashPpiRevenueAmount(dataType: 'year');

  @override
  Widget build(BuildContext context) {
    return AxleToggleMenu(provider: saDashSummaryToggleSwitchIndex, title: "Summary",
        showFilter: false, items: [
      AxleToggleMenuItem(label: "Onboarding", child: showOnboardingCards()),
      AxleToggleMenuItem(label: "Sales", child: showSalesCards()),
      AxleToggleMenuItem(label: "Revenue", child: showRevenueCards()),
      AxleToggleMenuItem(label: "Transactions", child: showTransactionCards()),
    ]);
  }

  Widget showOnboardingCards() {
    return Wrap(
      spacing: isMobile ? defaultPadding : defaultPadding * 2,
      runSpacing: defaultPadding,
      children: [
        SaDashSummaryCard(
          title: "Partners",
          value: widget.countInfo.data?.message?.partners?.toString() ?? '-',
          borderColor: AxleColors.dashPurple,
          svgPath: "assets/new_assets/icons/partner_dash_icon.svg",
        ),
        SaDashSummaryCard(
          title: "Customers",
          value: widget.countInfo.data?.message?.customers?.toString() ?? '-',
          borderColor: AxleColors.dashBlue,
          svgPath: "assets/new_assets/icons/customers_dash_icon.svg",
        ),
        SaDashSummaryCard(
          title: "Vehicles",
          value: widget.countInfo.data?.message?.vehicles?.toString() ?? '-',
          borderColor: AxleColors.dashGreen,
          svgPath: "assets/new_assets/icons/dashboard_card_vehicle.svg",
        ),
        SaDashSummaryCard(
          title: "Staff",
          value: widget.countInfo.data?.message?.staff?.toString() ?? '-',
          borderColor: AxleColors.dashPink,
          svgPath: "assets/new_assets/icons/dashboard_card_staff.svg",
        )
      ],
    );
  }

  Widget showSalesCards() {
    return Wrap(
      spacing: isMobile ? defaultPadding : defaultPadding * 2,
      runSpacing: defaultPadding,
      children: [
        SaDashSummaryCard(
          title: "FASTags",
          value: widget.countInfo.data?.message?.fastag?.toString() ?? '-',
          borderColor: AxleColors.dashPurple,
          svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg",
        ),
        SaDashSummaryCard(
          title: "Prepaid Cards",
          value: widget.countInfo.data?.message?.prepaidCards?.toString() ?? '-',
          borderColor: AxleColors.dashBlue,
          svgPath: "assets/new_assets/icons/dashboard_card_ppi.svg",
        ),
        SaDashSummaryCard(
          title: "GPS",
          value: widget.countInfo.data?.message?.gps?.toString() ?? '-',
          borderColor: AxleColors.dashPink,
          svgPath: "assets/new_assets/icons/dashboard_card_gps.svg",
        ),
        SaDashSummaryCard(
          fontSize: 15,
          title: "Fuel Cards",
          value: 'Coming Soon',
          borderColor: AxleColors.dashGreen,
          svgPath: "assets/new_assets/icons/fuel_card_icon.svg",
        ),
      ],
    );
  }

  Widget showRevenueCards() {
    return Wrap(
      spacing: isMobile ? defaultPadding : defaultPadding * 2,
      runSpacing: defaultPadding,
      children: [
        FutureBuilder<String>(
          future: tagRevenueAmountFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  height: 150,
                  width: 150,
                  decoration: CommonStyleUtil.axleContainerDecoration,
                  child: AxleLoader.axleProgressIndicator(),
                );
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return SaDashSummaryCard(
                    iconSize: 35,
                    fontSize: 24,
                    title: "FASTags",
                    subTitle: "Total Income",
                    value: snapshot.data!.isEmpty
                        ? '-'
                        : axleCurrencyFormatterwithDecimals.format(double.parse(snapshot.data!)),
                    borderColor: AxleColors.dashPurple,
                    svgPath: "assets/new_assets/icons/dashboard_card_credit.svg",
                  );
                } else {
                  return Container(
                    height: 150,
                    width: 150,
                    decoration: CommonStyleUtil.axleContainerDecoration,
                    child: AxleLoader.axleProgressIndicator(),
                  );
                }
            }
          },
        ),
        FutureBuilder<String>(
          future: ppiRevenueAmountFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  height: 150,
                  width: 150,
                  decoration: CommonStyleUtil.axleContainerDecoration,
                  child: AxleLoader.axleProgressIndicator(),
                );
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return SaDashSummaryCard(
                    iconSize: 35,
                    fontSize: 24,
                    title: "Prepaid Cards",
                    subTitle: "Total Income",
                    value: snapshot.data!.isEmpty
                        ? '-'
                        : axleCurrencyFormatterwithDecimals.format(double.parse(snapshot.data!)),
                    borderColor: AxleColors.dashBlue,
                    svgPath: "assets/new_assets/icons/dashboard_card_credit.svg",
                  );
                } else {
                  return Container(
                    height: 150,
                    width: 150,
                    decoration: CommonStyleUtil.axleContainerDecoration,
                    child: AxleLoader.axleProgressIndicator(),
                  );
                }
            }
          },
        ),
        SaDashSummaryCard(
          iconSize: 35,
          fontSize: 15,
          title: "Fuel Cards",
          subTitle: "Total Income",
          value: "Coming Soon",
          borderColor: AxleColors.dashGreen,
          svgPath: "assets/new_assets/icons/dashboard_card_credit.svg",
        ),
        // SaDashSummaryCard(
        //   iconSize: 35,
        //   fontSize: 15,
        //   title: "GPS",
        //   subTitle: "Total Income",
        //   value: "Coming Soon",
        //   borderColor: AxleColors.dashPink,
        //   svgPath: "assets/new_assets/icons/dashboard_card_credit.svg",
        // )
      ],
    );
  }

  Widget showTransactionCards() {
    return Wrap(
      spacing: isMobile ? defaultPadding : defaultPadding * 2,
      runSpacing: defaultPadding,
      children: [
        FutureBuilder<String>(
          future: tagTxnAmountFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  height: 150,
                  width: 150,
                  decoration: CommonStyleUtil.axleContainerDecoration,
                  child: AxleLoader.axleProgressIndicator(),
                );
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return SaDashSummaryCard(
                    iconSize: 35,
                    fontSize: 20,
                    title: "FASTags",
                    subTitle: "Total Transaction ",
                    value: snapshot.data!.isEmpty
                        ? '-'
                        : axleCurrencyFormatterwithDecimals.format(double.parse(snapshot.data!)),
                    borderColor: AxleColors.dashPurple,
                    svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg",
                  );
                } else {
                  return Container(
                    height: 150,
                    width: 150,
                    decoration: CommonStyleUtil.axleContainerDecoration,
                    child: AxleLoader.axleProgressIndicator(),
                  );
                }
            }
          },
        ),
        FutureBuilder<String>(
          future: ppiTxnAmountFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  height: 150,
                  width: 150,
                  decoration: CommonStyleUtil.axleContainerDecoration,
                  child: AxleLoader.axleProgressIndicator(),
                );
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return SaDashSummaryCard(
                    iconSize: 35,
                    fontSize: 20,
                    title: "Prepaid Cards",
                    subTitle: "Total Transaction ",
                    value: snapshot.data!.isEmpty
                        ? '-'
                        : axleCurrencyFormatterwithDecimals.format(double.parse(snapshot.data!)),
                    borderColor: AxleColors.dashBlue,
                    svgPath: "assets/new_assets/icons/dashboard_card_ppi.svg",
                  );
                } else {
                  return Container(
                    height: 150,
                    width: 150,
                    decoration: CommonStyleUtil.axleContainerDecoration,
                    child: AxleLoader.axleProgressIndicator(),
                  );
                }
            }
          },
        ),
        SaDashSummaryCard(
          iconSize: 35,
          fontSize: 15,
          title: "Fuel Cards",
          subTitle: "Total Transaction",
          value: "Coming Soon",
          borderColor: AxleColors.dashGreen,
          svgPath: "assets/new_assets/icons/fuel_card_icon.svg",
        ),
        // SaDashSummaryCard(
        //   iconSize: 35,
        //   fontSize: 15,
        //   title: "GPS",
        //   subTitle: "Total Transaction",
        //   value: "Coming Soon",
        //   borderColor: AxleColors.dashPink,
        //   svgPath: "assets/new_assets/icons/dashboard_card_gps.svg ",
        // )
      ],
    );
  }
}
