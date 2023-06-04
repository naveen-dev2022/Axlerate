import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/router/app_router.gr.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_toggle_menu.dart';
import 'package:axlerate/src/features/home/common_widgets/dashboard_summary_card.dart';
import 'package:axlerate/src/features/home/common_widgets/dashboard_summary_transactions.dart';
import 'package:axlerate/src/features/home/logistics/domain/logistics_dash_count_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/dashboard_controllers.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogisticsDashboardSummary extends ConsumerStatefulWidget {
  const LogisticsDashboardSummary({
    Key? key,
    required this.count,
    required this.orgId,
    required this.orgEnrollId,
  }) : super(key: key);

  final OrgDashCountModel count;
  final String orgId;
  final String orgEnrollId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogisticsDashboardSummaryState();
}

class _LogisticsDashboardSummaryState extends ConsumerState<LogisticsDashboardSummary> {
  late Future<String> tagRewardFuture;
  late Future<String> ppiRewardFuture;

  @override
  void initState() {
    tagRewardFuture = getTagReward();
    ppiRewardFuture = getPpiReward();
    Future(() {
      getTagAndPpiTxnAmount();
    });
    super.initState();
  }

  // @override
  // didChangeDependencies() {
  //   tagRewardFuture = getTagReward();
  //   ppiRewardFuture = getPpiReward();
  //   Future(() {
  //     getTagAndPpiTxnAmount();
  //   });
  //   super.didChangeDependencies();
  // }

  getTagAndPpiTxnAmount() async {
    // log('TXNS API Called');
    // * Tag Txn
    await ref
        .read(logisticsControllerProvider)
        .getOrgDashTagTxnAnalytics(userOrgEnrollId: widget.orgEnrollId, dataType: 'year');
    await ref
        .read(logisticsControllerProvider)
        .getOrgDashTagTxnAnalytics(userOrgEnrollId: widget.orgEnrollId, dataType: 'year', txType: 'debit');
    // * PPI Txn
    await ref
        .read(logisticsControllerProvider)
        .getOrgDashPpiTxnAnalytics(userOrgEnrollId: widget.orgEnrollId, dataType: 'year');
    await ref
        .read(logisticsControllerProvider)
        .getOrgDashPpiTxnAnalytics(userOrgEnrollId: widget.orgEnrollId, dataType: 'year', txType: 'debit');
  }

  Future<String> getTagReward() async => await ref
      .read(logisticsControllerProvider)
      .getOrgTagReward(userOrgEnrollId: widget.orgEnrollId, dataType: 'year');
  Future<String> getPpiReward() async =>
      await ref.read(logisticsControllerProvider).getOrgPpiReward(orgId: widget.orgEnrollId, dataType: 'year');

  // double screenWidth = 0.0;
  // double screenHeight = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    // int summaryIndex = ref.watch(summaryIndexProvider);
    // screenWidth = MediaQuery.of(context).size.width;
    // screenHeight = MediaQuery.of(context).size.height;

    // bool isMobile = Responsive.isMobile(context);

    return AxleToggleMenu(
      title: "Summary",
      provider: summaryIndexProvider,
      items: [
        AxleToggleMenuItem(label: "Onboarding", child: showOnboardingCards()),
        AxleToggleMenuItem(label: "Services", child: showServicesCards()),
        AxleToggleMenuItem(label: "Transactions", child: showTransactionsCards()),
        AxleToggleMenuItem(label: "Rewards", child: showRewardsCards())
      ],
    );
  }

  Wrap showOnboardingCards() {
    return Wrap(
      spacing: defaultPadding,
      runSpacing: 20,
      children: [
        InkWell(
          onTap: () {
            context.router.push(ListVehiclesRoute(text: widget.orgEnrollId));
          },
          child: DashSummaryCard(
            title: "Vehicle",
            value: widget.count.data?.message?.vehicle?.toString() ?? '-',
            svgPath: "assets/new_assets/icons/dashboard_card_vehicle.svg",
          ),
        ),
        InkWell(
          onTap: () {
            context.router.push(ListUsersRoute(
              userRole: 'STAFF',
            ));
          },
          child: DashSummaryCard(
            title: "Staff",
            value: widget.count.data?.message?.staffUsers?.toString() ?? '-',
            svgPath: "assets/new_assets/icons/dashboard_card_staff.svg",
          ),
        ),
        InkWell(
          onTap: () {
            context.router.push(ListUsersRoute(
              userRole: 'ADMIN',
            ));
          },
          child: DashSummaryCard(
            title: "Admins",
            value: widget.count.data?.message?.adminUsers?.toString() ?? '-',
            svgPath: "assets/new_assets/icons/dashboard_card_admin.svg",
          ),
        ),
      ],
    );
  }

  Wrap showServicesCards() {
    return Wrap(
      spacing: defaultPadding,
      runSpacing: 20,
      children: [
        DashSummaryCard(
          iconSize: isMobile ? 50 : 70,
          title: "FASTags",
          value: widget.count.data?.message?.totalTag?.toString() ?? '-',
          svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg",
        ),
        DashSummaryCard(
          iconSize: isMobile ? 50 : 70,
          title: "Prepaid",
          value: widget.count.data?.message?.totalPpi?.toString() ?? '-',
          svgPath: "assets/new_assets/icons/dashboard_card_ppi.svg",
        ),
        DashSummaryCard(
          iconSize: isMobile ? 50 : 70,
          title: "GPS",
          value: widget.count.data?.message?.gpsDeviceCount?.toString() ?? '-',
          svgPath: "assets/new_assets/icons/dashboard_card_gps.svg",
        )
      ],
    );
  }

  Wrap showTransactionsCards() {
    return Wrap(
      spacing: defaultPadding,
      runSpacing: 20,
      children: [
        ref.watch(txnTagCreditStateProvider) == null || ref.watch(txnTagDebitStateProvider) == null
            ? Container(
                width: 350,
                height: 162,
                decoration: CommonStyleUtil.axleContainerDecoration,
                child: AxleLoader.axleProgressIndicator(),
              )
            : DashSummaryTransactionsCard(
                title: "FASTags",
                credit:
                    ref.watch(txnTagCreditStateProvider)!.isEmpty ? '-' : '₹ ${ref.watch(txnTagCreditStateProvider)!}',
                debit:
                    ref.watch(txnTagDebitStateProvider)!.isEmpty ? '-' : '₹ ${ref.watch(txnTagDebitStateProvider)!}'),
        ref.watch(txnPpiDebitStateProvider) == null
            ? Container(
                width: 350,
                height: 162,
                decoration: CommonStyleUtil.axleContainerDecoration,
                child: AxleLoader.axleProgressIndicator(),
              )
            : DashSummaryTransactionsCard(
                title: "Prepaid",
                credit: ref.watch(txnPpiCreditStateProvider) != null
                    ? ref.watch(txnPpiCreditStateProvider)!.isEmpty
                        ? '-'
                        : '₹ ${ref.watch(txnPpiCreditStateProvider)!}'
                    : '0',
                debit: ref.watch(txnPpiDebitStateProvider) != null
                    ? ref.watch(txnPpiDebitStateProvider)!.isEmpty
                        ? '-'
                        : '₹ ${ref.watch(txnPpiDebitStateProvider)!}'
                    : '0',
              ),
        // DashSummaryTransactionsCard(
        //   title: "GPS",
        //   credit: "₹70",
        //   debit: "₹324,234,343,343",
        // )
      ],
    );
  }

  Wrap showRewardsCards() {
    return Wrap(
      spacing: defaultPadding,
      runSpacing: 20,
      children: [
        FutureBuilder<String>(
          future: tagRewardFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return AxleLoader.axleProgressIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  // debugPrint('Tags Future -> ${snapshot.data}');

                  return DashSummaryCard(
                      subTitle: "Total Rewards",
                      iconSize: 44,
                      fontSize: 24,
                      title: "FASTags",
                      value: snapshot.data!.isNotEmpty ? '₹ ${snapshot.data!}' : '-',
                      svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg");
                } else {
                  return AxleLoader.axleProgressIndicator();
                }
            }
          },
        ),
        FutureBuilder<String>(
          future: ppiRewardFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return AxleLoader.axleProgressIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  // debugPrint('Rewards Future -> ${snapshot.data}');
                  return DashSummaryCard(
                      subTitle: "Total Rewards",
                      iconSize: 44,
                      fontSize: 20,
                      title: "Prepaid",
                      value: snapshot.data!.isNotEmpty ? '₹ ${snapshot.data!}' : '-',
                      svgPath: "assets/new_assets/icons/dashboard_card_ppi.svg");
                } else {
                  return AxleLoader.axleProgressIndicator();
                }
            }
          },
        ),
        // DashSummaryCard(
        //     subTitle: "Total Rewards",
        //     iconSize: 44,
        //     fontSize: 24,
        //     title: "GPS",
        //     value: "₹2,20,000",
        //     svgPath: "assets/new_assets/icons/dashboard_card_gps.svg")
      ],
    );
  }
}
