import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_models/graph_response_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_toggle_menu.dart';
import 'package:axlerate/src/features/home/common_widgets/bar_chart_widget.dart';
import 'package:axlerate/src/features/home/common_widgets/pie_chart_widget.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/dashboard_controller.dart';
import 'package:axlerate/src/features/home/dashboard/domain/chart_items_model.dart';
import 'package:axlerate/src/features/home/partner/presentation/controller/partner_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:axlerate/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardGraph extends ConsumerStatefulWidget {
  const DashboardGraph({
    super.key,
    this.orgId,
    this.orgType,
  });

  final String? orgId;
  final String? orgType;

  @override
  ConsumerState<DashboardGraph> createState() => _DashboardGraphState();
}

class _DashboardGraphState extends ConsumerState<DashboardGraph> {
  late Future<GraphResponseModel> tagBarChart;
  late Future<GraphResponseModel> ppiBarChart;

  late Future<String> tagRevenueAmountFuture;
  late Future<String> ppiRevenueAmountFuture;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;
  bool isSuperAdmin = false;

  @override
  void initState() {
    getTagAndPpiTxnAmount();
    tagRevenueAmountFuture = getTagRevenueAmount();
    ppiRevenueAmountFuture = getPpiRevenueAmount();
    super.initState();
  }

  Future<String> getTagRevenueAmount() async =>
      await ref.read(saDashControllerProvider).getSaDashTagRevenueAmount(dataType: 'year');
  Future<String> getPpiRevenueAmount() async =>
      await ref.read(saDashControllerProvider).getSaDashPpiRevenueAmount(dataType: 'year');

  getTagAndPpiTxnAmount() async {
    if (widget.orgType == "AXLERATE") {
      tagBarChart = getTagBarChart();
      ppiBarChart = getPpiBarChart();
    } else {
      if (widget.orgId != null && widget.orgId!.isNotEmpty) {
        tagBarChart = getTagBarPartner();
        ppiBarChart = getPpiBarPartner();
      }
    }
  }

  Future<GraphResponseModel> getTagBarChart() async {
    return await ref.read(saDashControllerProvider).getSaDashTagRevenueAnalytics(dataType: 'month');
  }

  Future<GraphResponseModel> getPpiBarChart() async {
    return await ref.read(saDashControllerProvider).getSaDashPpiRevenueAnalytics(dataType: 'month');
  }

  Future<GraphResponseModel> getTagBarPartner() async {
    return await ref
        .read(partnerControllerProvider)
        .getPartnerTagReward(orgId: widget.orgId!, dataType: 'month', isGraph: true);
  }

  Future<GraphResponseModel> getPpiBarPartner() async {
    return await ref
        .read(partnerControllerProvider)
        .getPartnerPpiReward(orgId: widget.orgId!, dataType: 'month', isGraph: true);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2) + (defaultPadding * 2));

    isMobile = Responsive.isMobile(context);

    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 3);
    }
    return SizedBox(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.analyticsOnRevenue, style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: defaultPadding),
          isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Scrollbar(
                      thumbVisibility: true,
                      thickness: 10,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(padding: const EdgeInsets.all(defaultMobilePadding), child: getBarGraph())),
                    ),
                    const SizedBox(height: defaultPadding),
                    Padding(padding: const EdgeInsets.all(defaultMobilePadding), child: getPieChart()),
                  ],
                )
              : Scrollbar(
                  thumbVisibility: true,
                  thickness: 10,
                  scrollbarOrientation: ScrollbarOrientation.bottom,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultMobilePadding),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultMobilePadding),
                        child: Row(
                          children: [getBarGraph(), const SizedBox(width: defaultPadding), getPieChart()],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Container getPieChart() {
    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 300),
      width: isMobile ? availableWidth : availableWidth * 30 / 100,
      height: isMobile ? availableWidth : 580,
      decoration: CommonStyleUtil.axleContainerDecoration,
      child: FutureBuilder<String>(
          future: tagRevenueAmountFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return AxleLoader.axleProgressIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const AxleErrorWidget(imgHeight: 100.0);
                } else if (snapshot.hasData) {
                  double tagAmount = double.parse(snapshot.data!);
                  return FutureBuilder<String>(
                    future: ppiRevenueAmountFuture,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return AxleLoader.axleProgressIndicator();
                        case ConnectionState.done:
                        default:
                          if (snapshot.hasError) {
                            return const AxleErrorWidget(imgHeight: 100.0);
                          } else if (snapshot.hasData) {
                            double ppiAmount = double.parse(snapshot.data!);
                            return AxlePieChart(items: [
                              AxPieChartDataItem(
                                  label: "FASTag",
                                  value: tagAmount,
                                  radius: 100,
                                  color: AxleColors.dashGreen,
                                  titleStyle: AxleTextStyle.pieChartText),
                              AxPieChartDataItem(
                                label: "PPI",
                                value: ppiAmount,
                                radius: 100,
                                color: AxleColors.dashBlue,
                                titleStyle: AxleTextStyle.pieChartText,
                              )
                            ]);
                          } else {
                            return const AxleErrorWidget(imgHeight: 100.0);
                          }
                      }
                    },
                  );
                } else {
                  return const AxleErrorWidget(imgHeight: 150.0);
                }
            }
          }),
    );
  }

  AxleToggleMenuItem getBarGraphMenuItem(String label, Future<GraphResponseModel> future, Color barColor) {
    return AxleToggleMenuItem(
      label: label,
      child: AspectRatio(
        aspectRatio: 2,
        child: FutureBuilder<GraphResponseModel>(
          future: future,
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
                    return const Text('No Data Found');
                  }
                  return AxleBarChart(
                      barColor: barColor,
                      items: snapshot.data!.data!.message!
                          .map(
                            (item) => AxBarChartData(label: item.label!, value: item.value ?? 0),
                          )
                          .toList()
                      // [
                      //   AxBarChartData(label: "Jan", value: 40000),
                      //   AxBarChartData(label: "Feb", value: 25000),
                      //   AxBarChartData(label: "Mar", value: 40000),
                      //   AxBarChartData(label: "Apr", value: 25000),
                      //   AxBarChartData(label: "May", value: 40000),
                      //   AxBarChartData(label: "Jun", value: 25000),
                      //   AxBarChartData(label: "Jul", value: 40000),
                      //   AxBarChartData(label: "Aug", value: 25000),
                      //   AxBarChartData(label: "Sep", value: 40000),
                      //   AxBarChartData(label: "Oct", value: 25000),
                      //   AxBarChartData(label: "Nov", value: 40000),
                      //   AxBarChartData(label: "Dec", value: 25000),
                      //   AxBarChartData(label: "New", value: 25000),
                      // ],
                      );
                } else {
                  return AxleLoader.axleProgressIndicator();
                }
            }
          },
        ),
      ),
    );
  }

  Container getBarGraph() {
    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth * 2 : 750),
      width: availableWidth * 70 / 100,
      height: 580,
      decoration: CommonStyleUtil.axleContainerDecoration,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AxleToggleMenu(
              provider: saDashGraphToggleSwitchIndex,
              showFilter: false,
              items: [
                // * FastTag Bar Graph
                getBarGraphMenuItem("FASTag", tagBarChart, AxleColors.dashGreen),

                // * PPI Bar Graph
                getBarGraphMenuItem("PPI", ppiBarChart, AxleColors.dashBlue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
