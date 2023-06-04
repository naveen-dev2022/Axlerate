import 'dart:core';
import 'dart:developer';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/common_widgets/pie_chart_widget.dart';
import 'package:axlerate/src/features/home/dashboard/domain/chart_items_model.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/features/home/logistics/domain/logistics_dash_count_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/lq_user_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_dash_ppi_account_info.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_dash_tag_account_info.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_fuel_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/account_info_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/gps_dash_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';
import 'package:axlerate/src/features/home/logistics/presentation/widgets/payment_link_widgets.dart';
import 'package:axlerate/src/features/home/payments/domain/payment_list_search_query_params.dart';
import 'package:axlerate/src/features/home/payments/presentation/controller/payments_controller.dart';
import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/domain/ppi_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/presentation/fuel_txn_table.dart';
import 'package:axlerate/src/features/home/transactions/presentation/lq_txn_table_widget.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/transaction_controller.dart';
import 'package:axlerate/src/features/home/transactions/presentation/ppi_txn_table.dart';
import 'package:axlerate/src/features/home/transactions/presentation/tag_txn_table.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_toggle_menu.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/dashboard_controllers.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/balance_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/status_analytics_slider.dart';

enum DashboardServicesType { fastag, ppi, fuel }

class LogisticsDashboardServices extends ConsumerStatefulWidget {
  const LogisticsDashboardServices({
    Key? key,
    required this.count,
    required this.orgId,
    required this.orgEnrollId,
  }) : super(key: key);

  final OrgDashCountModel count;
  final String orgId;
  final String orgEnrollId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogisticsDashboardServicesState();
}

class _LogisticsDashboardServicesState extends ConsumerState<LogisticsDashboardServices> {
  late Future<OrgDashTagAccountInfo> orgDashTagInfoFuture;
  late Future<OrgDashPpiAccountInfo> orgDashPpiInfoFuture;
  late Future<LqUserAccInfoModel> orgDashLqTagInfoFuture;
  late Future<OrgFuelAccInfo> orgDashFuelInfoFuture;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  ScrollController cardSummaryController = ScrollController(initialScrollOffset: 0.0);
  OrgDoc? org;
  PaymentListQueryParams params = PaymentListQueryParams(
    pageIndex: 1,
    size: 15,
  );

  @override
  void initState() {
    org = ref.read(orgDetailsProvider);
    loadInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(servicesIndexProvider.notifier).state = 0;
    });

    super.initState();
  }

  loadInit() async {
    if (org == null) {
      await ref
          .read(logisticsControllerProvider)
          .getOrganisationByEnrolmentId(enrolId: widget.orgEnrollId.toUpperCase());
      org = ref.read(orgDetailsProvider);
      setState(() {});
    }
    orgDashTagInfoFuture = getTagInfo();
    orgDashPpiInfoFuture = getPpiInfo();
    orgDashLqTagInfoFuture = getLqTagInfo();
    orgDashFuelInfoFuture = getFuelInfo();
    getPaymentsList(params);
  }

  Future<void> getPaymentsList(PaymentListQueryParams params) async {
    params = params.copyWith(status: "DUE");
    ref.read(dueListPaymentStateProvider.notifier).state = null;
    ref.read(dueListPaymentStateProvider.notifier).state = await ref
        .read(paymentsControllerProvider)
        .listPaymnetsLink(params: params, userOrgEnrollId: widget.orgEnrollId);
    params = params.copyWith(status: "DROPPED");
    ref.read(droppedListPaymentStateProvider.notifier).state = null;
    ref.read(droppedListPaymentStateProvider.notifier).state = await ref
        .read(paymentsControllerProvider)
        .listPaymnetsLink(params: params, userOrgEnrollId: widget.orgEnrollId);
    orgDashFuelInfoFuture = getFuelInfo();
  }

  Future<LqUserAccInfoModel> getLqTagInfo() async {
    if (getOrgService(org, 'TAG', issuerName: 'LIVQUIK') != null) {
      return await ref.read(logisticsControllerProvider).lqTagAccInfoforOrg(orgEnrollId: widget.orgEnrollId);
    } else {
      return LqUserAccInfoModel.unknown();
    }
  }

  Future<OrgDashTagAccountInfo> getTagInfo() async {
    OrganizationService? organizationService = getOrgService(org, 'TAG', issuerName: 'YESBANK');
    if (organizationService != null && organizationService.kycStatus == "APPROVED") {
      return await ref.read(logisticsControllerProvider).getOrgDashTagAccountInfo(userOrgEnrollId: widget.orgEnrollId);
    } else {
      return OrgDashTagAccountInfo.unknown();
    }
  }

  Future<OrgDashPpiAccountInfo> getPpiInfo() async {
    if (getOrgService(org, 'PPI') != null) {
      return await ref.read(logisticsControllerProvider).getOrgDashPpiAccountInfo(userOrgEnrollId: widget.orgEnrollId);
    } else {
      return OrgDashPpiAccountInfo.unknown();
    }
  }

  Future<OrgFuelAccInfo> getFuelInfo() async {
    if (getOrgService(org, 'FUEL') != null && getOrgService(org, 'FUEL')?.kycStatus == "APPROVED") {
      return await ref
          .read(logisticsControllerProvider)
          .getOrgDashFuelAccountInfo(userOrgEnrollId: widget.orgEnrollId, entityType: 'ORGANIZATION');
    } else {
      return OrgFuelAccInfo.unknown();
    }
  }

  // Future<FuelLimitResponseModel> getFuelLimit() async {
  //   return await ref.read(logisticsControllerProvider).getLogisticsFuelLimit(
  //         orgId: widget.orgId,
  //         entityType: 'ORGANIZATION',
  //         entityId: '',
  //       );
  // }

  // Future<OrgDashTagAccountInfo> func1() async {
  //   return OrgDashTagAccountInfo.unknown();
  // }

  // Future<OrgDashPpiAccountInfo> func2() async {
  //   return OrgDashPpiAccountInfo.unknown();
  // }

  @override
  Widget build(BuildContext context) {
    //org = ref.watch(orgDetailsProvider);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 4));
    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    Widget getLQTAGdata(OrganizationService orgService, String orgEnrollId) {
      return FutureBuilder<LqUserAccInfoModel>(
        future: orgDashLqTagInfoFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return AxleLoader.axleProgressIndicator();
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return const AxleErrorWidget();
              } else if (snapshot.hasData) {
                if (snapshot.data?.data == null || snapshot.data?.data?.message == null) {
                  return const AxleErrorWidget(
                    titleStr: 'No Data Found!',
                  );
                }
                final data = snapshot.data?.data?.message;
                return Container(
                  decoration: CommonStyleUtil.axleListingCardDecoration,
                  padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data?.isEmpty ?? false
                          ? const SizedBox()
                          : SizedBox(
                              height: 280,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
                                    margin: EdgeInsets.all(isMobile ? defaultMobilePadding : defaultMobilePadding),
                                    constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 300),
                                    decoration: CommonStyleUtil.axleListingCardDecoration,

                                    // decoration: BoxDecoration(
                                    //   color: AxleColors.axleShadowColor,
                                    //   borderRadius: BorderRadius.circular(8.0),
                                    // ),
                                    width: availableWidth * 30 / 100,
                                    height: 150,
                                    child: BalanceWidget(
                                      wallet: WalletDisplayModel(
                                          kitNo: data?[index].kitNumber ?? "",
                                          type: WalletType.values.byName("USER".toLowerCase()),
                                          walletName: data?[index].name ?? "",
                                          balance: data?[index].availableBalance.toDouble() ?? 0.0,
                                          upiId: data?[index].upiId ?? '-',
                                          accountNumber: data?[index].accountNumber ?? "",
                                          ifscCode: data?[index].ifsc ?? ""
                                          // vehicleLevelCount: data?[index]. ?? '-',
                                          ),
                                      showCustomerCount: false,
                                      type: DashboardServicesType.fastag,
                                    ),
                                  );
                                },
                              ),
                            ),
                      Text(
                        " Recent Transactions",
                        style: AxleTextStyle.headingPrimary,
                      ),
                      const SizedBox(height: defaultMobilePadding),
                      LQTxnTableWidget(
                        showDateFilter: false,
                        showPaginator: false,
                        txnParams: TagTxnQueryParams(size: 10, pageIndex: 1),
                        listStateProvider: tagTransactionListStateProvider,
                        userOrgEnrollId: orgEnrollId,
                      ),
                    ],
                  ),
                );
              } else {
                return AxleLoader.axleProgressIndicator();
              }
          }
        },
      );
      // } else {
      //   return const AxleErrorWidget();
      // }
    }

    Widget getYBTAGdata(OrganizationService orgService, String orgEnrollId) {
      // if (getOrgService(org, 'TAG', issuerName: 'YESBANK') != null) {
      return FutureBuilder<OrgDashTagAccountInfo>(
        future: orgDashTagInfoFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return AxleLoader.axleProgressIndicator();
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return const AxleErrorWidget();
              } else if (snapshot.hasData) {
                if (snapshot.data?.data == null || snapshot.data?.data?.message == null) {
                  return const AxleErrorWidget(
                    imgHeight: 300.0,
                    titleStr: 'No Data Found!',
                  );
                }
                final data = snapshot.data?.data?.message;
                return Container(
                  decoration: CommonStyleUtil.axleListingCardDecoration,
                  padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      servicesBalanceWithStatusAnalyticsSlider(DashboardServicesType.fastag,
                          wallet: WalletDisplayModel(
                              balance: data?.availableBalance?.toDouble() ?? 0.0,
                              upiId: data?.upiId ?? '-',
                              type: WalletType.values.byName((data?.type ?? "USER").toString().toLowerCase()),
                              customerLevelCount: widget.count.data?.message?.customerLevelBalance ?? 0,
                              vehicleLevelCount: widget.count.data?.message?.vehicleLevelBalance ?? 0,
                              kitNo: "",
                              accountNumber: data?.accountNumber ?? '',
                              ifscCode: data?.ifsc ?? '',
                              walletName: ""),
                          items: [
                            StatusAnalyticsItem(
                              primaryColor: Colors.grey.shade200,
                              value: widget.count.data?.message?.totalTag?.toString() ?? '-',
                              label: "Tags Available",
                              labelColor: Colors.white,
                              secondaryColor: const Color.fromRGBO(7, 133, 92, 0.8),
                              svgPath: "assets/new_assets/icons/magic_box.svg",
                            ),
                            StatusAnalyticsItem(
                              primaryColor: const Color.fromRGBO(8, 167, 115, 0.15),
                              value: widget.count.data?.message?.activeTag?.toString() ?? '-',
                              label: "ACTIVE",
                              labelColor: const Color.fromRGBO(128, 159, 184, 1),
                              secondaryColor: Colors.white,
                            ),
                            StatusAnalyticsItem(
                              primaryColor: const Color(0xffFAD1B2),
                              value: widget.count.data?.message?.blackListTag?.toString() ?? '-',
                              label: "Black Listed",
                              labelColor: const Color.fromRGBO(128, 159, 184, 1),
                              secondaryColor: Colors.white,
                            ),
                            StatusAnalyticsItem(
                              primaryColor: const Color(0xffD4C3FA),
                              value: widget.count.data?.message?.lowBalanceTag?.toString() ?? '-',
                              label: "Low Balance",
                              labelColor: const Color.fromRGBO(128, 159, 184, 1),
                              secondaryColor: Colors.white,
                            ),
                          ]),
                      Text(
                        " Recent Transactions",
                        style: AxleTextStyle.headingPrimary,
                      ),
                      const SizedBox(height: defaultMobilePadding),
                      TagTxnTableWidget(
                        showDateFilter: false,
                        showPaginator: false,
                        txnParams: TagTxnQueryParams(size: 10, pageIndex: 1),
                        listStateProvider: tagTransactionListStateProvider,
                        userOrgEnrollId: orgEnrollId,
                      ),
                    ],
                  ),
                );
              } else {
                return AxleLoader.axleProgressIndicator();
              }
          }
        },
      );
      // } else {
      //   return AxleErrorWidget();
      // }
    }

    Widget getGPSdata(OrganizationService orgService) {
      if (getOrgService(org, 'GPS') != null) {
        return GpsDashWidget(
          size: MediaQuery.of(context).size,
          orgId: org!.id,
        );
      } else {
        return const AxleErrorWidget();
      }
    }

    Widget getFUELdata(OrganizationService orgService, String orgEnrollId) {
      if (getOrgService(org, 'FUEL') != null) {
        log("getFuel data $orgEnrollId");
        return FutureBuilder<OrgFuelAccInfo>(
          future: orgDashFuelInfoFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return AxleLoader.axleProgressIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const AxleErrorWidget();
                } else if (snapshot.hasData) {
                  if (snapshot.data?.data == null || snapshot.data?.data?.message == null) {
                    return const AxleErrorWidget(
                      imgHeight: 300.0,
                      titleStr: 'No Data Found!',
                    );
                  }
                  final data = snapshot.data?.data?.message;
                  return Container(
                    decoration: CommonStyleUtil.axleListingCardDecoration,
                    padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              serviceAnalyticsHeader(DashboardServicesType.fuel),
                              if (!isMobile)
                                const SizedBox(
                                  height: verticalPadding,
                                ),
                              Card(
                                child: Container(
                                  constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 300),
                                  width: availableWidth * 40 / 100,
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(defaultPadding),
                                    child: BalanceWidget(
                                        wallet: WalletDisplayModel(
                                            kitNo: "",
                                            type: WalletType.values.byName(
                                                (data?.entityType == 'ORGANIZATION' ? 'LOGISTICS' : "USER")
                                                    .toString()
                                                    .toLowerCase()),
                                            accountNumber: data?.accountNumber ?? "",
                                            ifscCode: data?.ifsc ?? "",
                                            balance: data?.availableBalance.toDouble() ?? 0.0,
                                            upiId: '-',
                                            walletName: ""),
                                        type: DashboardServicesType.fuel),
                                  ),
                                ),
                              ),
                              if (!isMobile)
                                const SizedBox(
                                  width: verticalPadding,
                                ),
                              Card(
                                child: Container(
                                    constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 300),
                                    width: availableWidth * 40 / 100,
                                    height: 300,
                                    child: fuelMapInfo(0.toString(), 0.toString())),
                              ),
                            ],
                          ),
                        ),
                        if (!isMobile)
                          const SizedBox(
                            height: verticalPadding,
                          ),
                        Text(
                          " Recent Transactions",
                          style: AxleTextStyle.headingPrimary,
                        ),
                        const SizedBox(height: defaultMobilePadding),
                        FuelTxnTableWidget(
                          showDateFilter: false,
                          showPagination: false,
                          //userOrgEnrollId: orgEnrollId,
                          txnParams: FuelTxnQueryParams(
                            size: 10,
                            pageIndex: 1,
                            // transactionType: "FUEL",
                            accountInfoEntity: data!.organizationEntityId,
                            // accountInfoEntity: 'FDMC5O110',
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return AxleLoader.axleProgressIndicator();
                }
            }
          },
        );
      } else {
        return const AxleErrorWidget();
      }
    }

    Widget getPPIdata(OrganizationService orgService, String orgEnrollId) {
      if (getOrgService(org, 'PPI') != null) {
        return FutureBuilder<OrgDashPpiAccountInfo>(
          future: orgDashPpiInfoFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return AxleLoader.axleProgressIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const AxleErrorWidget();
                } else if (snapshot.hasData) {
                  if (snapshot.data?.data == null || snapshot.data?.data?.message == null) {
                    return const AxleErrorWidget(
                      imgHeight: 300.0,
                      titleStr: 'No Data Found!',
                    );
                  }
                  final data = snapshot.data?.data?.message;
                  return Container(
                    decoration: CommonStyleUtil.axleListingCardDecoration,
                    padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        servicesBalanceWithStatusAnalyticsSlider(
                          DashboardServicesType.ppi,
                          wallet: WalletDisplayModel(
                              kitNo: "",
                              type: WalletType.values.byName((data?.type ?? "USER").toString().toLowerCase()),
                              accountNumber: data?.accountNumber ?? "",
                              ifscCode: data?.ifsc ?? "",
                              balance: data?.availableBalance?.toDouble() ?? 0.0,
                              upiId: data?.upiId ?? '-',
                              walletName: ""),
                          items: [
                            StatusAnalyticsItem(
                              primaryColor: Colors.grey.shade200,
                              value: widget.count.data?.message?.totalPpi?.toString() ?? '-',
                              label: "Cards Available",
                              labelColor: Colors.white,
                              secondaryColor: const Color.fromRGBO(7, 133, 92, 0.8),
                              svgPath: "assets/new_assets/icons/magic_box.svg",
                            ),
                            StatusAnalyticsItem(
                              primaryColor: const Color.fromRGBO(8, 167, 115, 0.15),
                              value: widget.count.data?.message?.activePpi?.toString() ?? '-',
                              label: "ACTIVE",
                              labelColor: const Color.fromRGBO(128, 159, 184, 1),
                              secondaryColor: Colors.white,
                            ),
                            StatusAnalyticsItem(
                              primaryColor: const Color(0xffFCBFBF),
                              value: widget.count.data?.message?.closedPpi?.toString() ?? '-',
                              label: "Closed",
                              labelColor: const Color.fromRGBO(128, 159, 184, 1),
                              secondaryColor: Colors.white,
                            ),
                            StatusAnalyticsItem(
                              primaryColor: const Color(0xffB5B5B5),
                              value: widget.count.data?.message?.blockedPpi?.toString() ?? '-',
                              label: "Blocked",
                              labelColor: const Color.fromRGBO(128, 159, 184, 1),
                              secondaryColor: Colors.white,
                            ),
                            StatusAnalyticsItem(
                              primaryColor: const Color(0xffD4C3FA),
                              value: widget.count.data?.message?.lockedPpi?.toString() ?? '-',
                              label: "Locked",
                              labelColor: const Color.fromRGBO(128, 159, 184, 1),
                              secondaryColor: Colors.white,
                            ),
                          ],
                        ),
                        if (!isMobile)
                          const SizedBox(
                            height: verticalPadding,
                          ),
                        Text(
                          " Recent Transactions",
                          style: AxleTextStyle.headingPrimary,
                        ),
                        const SizedBox(height: defaultMobilePadding),
                        PpiTxnTableWidget(
                          showDateFilter: false,
                          showPagination: false,
                          txnParams: PpiTxnQueryParams(size: 10, pageIndex: 1),
                          userOrgEnrollId: orgEnrollId,
                        ),
                      ],
                    ),
                  );
                } else {
                  return AxleLoader.axleProgressIndicator();
                }
            }
          },
        );
      } else {
        return const AxleErrorWidget();
      }
    }

    Widget getInvoiceData() {
      return Container(
        decoration: CommonStyleUtil.axleListingCardDecoration,
        padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: AxlePrimaryButton(
                buttonText: "Payments",
                onPress: () {
                  context.router.pushNamed(RouteUtils.getPaymentsPath(widget.orgEnrollId));
                },
              ),
            ),
            if (widget.count.data != null)
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 332,
                    child: invoiceAmountInfo(
                      widget.count.data!.message!.totalPaidAmount.toString(),
                      widget.count.data!.message!.totalDueAmount.toString(),
                    ),
                  ),
                  widget.count.data!.message!.paidPaymentLink == 0 &&
                          widget.count.data!.message!.droppedPaymentLink == 0 &&
                          widget.count.data!.message!.duePaymentLink == 0
                      ? const SizedBox()
                      : SizedBox(height: 332, child: getPieChart()),
                ],
              ),
            Consumer(
              builder: (context, ref, child) {
                final duePaymentList = ref.watch(dueListPaymentStateProvider);
                return PaymentListWidgets(
                  paymentList: duePaymentList,
                  status: "DUE",
                  userOrgEnrollId: widget.orgEnrollId,
                );
              },
            ),
            const SizedBox(height: defaultPadding),
            Consumer(
              builder: (context, ref, child) {
                final droppedPaymentList = ref.watch(droppedListPaymentStateProvider);
                return PaymentListWidgets(
                  paymentList: droppedPaymentList,
                  status: "DROPPED",
                  userOrgEnrollId: widget.orgEnrollId,
                );
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
          ],
        ),
      );
    }

    Widget getData(OrganizationService orgService, String orgEnrollId) {
      switch (orgService.tabName) {
        case "LQTAG":
          return getLQTAGdata(orgService, orgEnrollId);
        case "YBTAG":
          return getYBTAGdata(orgService, orgEnrollId);
        case "GPS":
          return getGPSdata(orgService);
        case "FUEL":
          return getFUELdata(orgService, orgEnrollId);
        case "PPI":
          return getPPIdata(orgService, orgEnrollId);
        case "INVOICE":
          return getInvoiceData();
        default:
          return const AxleErrorWidget();
      }
    }

    return org == null
        ? AxleLoader.axleProgressIndicator()
        : AxleToggleMenu(
            showFilter: false,
            provider: servicesIndexProvider,
            items: [
              for (OrganizationService orgService in org!.organizationServices)
                AxleToggleMenuItem(
                    label: orgService.tabName == "INVOICE" ? "PAYMENTS" : orgService.tabName,
                    child: getData(orgService, widget.orgEnrollId)),
            ],
          );
  }

  Container getPieChart() {
    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 200),
      width: isMobile ? availableWidth : availableWidth * 50 / 100,
      // height: isMobile ? availableWidth : 580,
      //decoration: CommonStyleUtil.axleContainerDecoration,
      child: AxlePieChart(isRow: isMobile ? false : true, isNumber: true, items: [
        AxPieChartDataItem(
          label: "Paid",
          value: widget.count.data!.message!.paidPaymentLink!.toDouble(),
          radius: 100,
          color: AxleColors.dashGreen,
          titleStyle: AxleTextStyle.pieChartText,
        ),
        AxPieChartDataItem(
          label: "Due",
          value: widget.count.data!.message!.duePaymentLink!.toDouble(),
          radius: 100,
          color: AxleColors.dashBlue,
          titleStyle: AxleTextStyle.pieChartText,
        ),
        AxPieChartDataItem(
          label: "Expired",
          value: widget.count.data!.message!.droppedPaymentLink!.toDouble(),
          radius: 100,
          color: AxleColors.dashPink,
          titleStyle: AxleTextStyle.pieChartText,
        )
      ]),
    );
  }

  Widget invoiceAmountInfo(String? debitAmount, String? creditAmount) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.all(isMobile ? 0 : defaultPadding),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              debitAmount == null
                  ? AxleLoader.axleProgressIndicator(
                      height: 30.0,
                      width: 30.0,
                    )
                  : invoiceAmountOverview(
                      value: debitAmount,
                    ),
              creditAmount == null
                  ? AxleLoader.axleProgressIndicator(
                      height: 30.0,
                      width: 30.0,
                    )
                  : invoiceAmountOverview(
                      type: "pending",
                      value: creditAmount,
                    ),
            ]),
          )
        ],
      ),
    );
  }

  Container invoiceAmountOverview({String? type, required String value}) {
    // String svgPath = type == "pending"
    //     ? "assets/new_assets/icons/ppi_credit_icon.svg"
    //     : "assets/new_assets/icons/ppi_debit_icon.svg";

    // String balance = axleCurrencyFormatterwithDecimals.format(0.00);

    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 250),
      width: isMobile ? availableWidth : availableWidth * 35 / 100,
      decoration: BoxDecoration(
          color: type == "pending" ? const Color(0xFF638795) : const Color(0xFF714FD8),
          image: const DecorationImage(image: AssetImage("assets/new_assets/staff_card_bg.png"))),
      height: 124,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type == "pending" ? "Amount pending from clients" : "Amount collected from clients",
              style: AxleTextStyle.pieChartText,
            ),
            Expanded(
              child: Center(
                child: Row(
                  children: [
                    // SvgPicture.asset(svgPath),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      value == '0'
                          ? '0'
                          : axleCurrencyFormatterwithDecimals.format(
                              num.parse(value),
                            ),
                      style: AxleTextStyle.ppiOverviewCardValueText,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fuelMapInfo(String? unMapVehicle, String? unMapStaff) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.all(isMobile ? 0 : defaultPadding),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              unMapVehicle == null
                  ? AxleLoader.axleProgressIndicator(
                      height: 30.0,
                      width: 30.0,
                    )
                  : fuelMapOverview(
                      value: unMapVehicle,
                    ),
              unMapStaff == null
                  ? AxleLoader.axleProgressIndicator(
                      height: 30.0,
                      width: 30.0,
                    )
                  : fuelMapOverview(
                      type: "pending",
                      value: unMapStaff,
                    ),
            ]),
          )
        ],
      ),
    );
  }

  Container fuelMapOverview({String? type, required String value}) {
    // String svgPath = type == "pending"
    //     ? "assets/new_assets/icons/ppi_credit_icon.svg"
    //     : "assets/new_assets/icons/ppi_debit_icon.svg";

    // String balance = axleCurrencyFormatterwithDecimals.format(0.00);

    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 250),
      width: isMobile ? availableWidth : availableWidth * 35 / 100,
      decoration: BoxDecoration(
          color: type == "pending" ? const Color(0xFF638795) : const Color(0xFF714FD8),
          image: const DecorationImage(image: AssetImage("assets/new_assets/staff_card_bg.png"))),
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type == "pending" ? "Number of Unmapped Vehicles:" : "Number of Unmapped Staff:",
              style: AxleTextStyle.pieChartText,
            ),
            Expanded(
              child: Center(
                child: Row(
                  children: [
                    // SvgPicture.asset(svgPath),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      value == '0' ? '0' : value,
                      style: AxleTextStyle.ppiOverviewCardValueText,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget servicesBalanceWithStatusAnalyticsSlider(DashboardServicesType type,
      {required List<StatusAnalyticsItem> items, required WalletDisplayModel wallet}) {
    return isMobile
        ? analyticsAndTransactionsMobile(type, wallet, items)
        : analyticsAndTransactions(type, wallet, items);
  }

  Widget analyticsAndTransactions(
      DashboardServicesType type, WalletDisplayModel wallet, List<StatusAnalyticsItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        serviceAnalyticsHeader(type),
        const SizedBox(height: verticalPadding),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 300),
              width: availableWidth * 30 / 100,
              height: 300,
              child: BalanceWidget(wallet: wallet, type: type),
              // child: Column(
              //   children: [
              //     BalanceWidget(wallet: wallet, type: type),
              //     if(type == DashboardServicesType.ppi)
              //     AccountInfoWidget(accountNumber: wallet.accountNumber, ifscCode: wallet.ifscCode, upiId: ''),
              //   ],
              // ),
            ),
            Padding(
              padding: EdgeInsets.all((type == DashboardServicesType.fuel) ? 60 : horizontalPadding),
              child: Container(
                height: 200,
                width: 1,
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: Color.fromRGBO(235, 235, 251, 1), width: 2)),
                ),
              ),
            ),
            Container(
              constraints:
                  BoxConstraints(minWidth: (availableWidth * 65 / 100) < 500 ? availableWidth * 65 / 100 : 500),
              width: availableWidth * 60 / 100,
              height: 300,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Text(
                          type == DashboardServicesType.ppi
                              ? "Card Summary"
                              : (type == DashboardServicesType.fuel)
                                  ? 'Card Summary'
                                  : "FASTag Summary",
                          style: AxleTextStyle.walletBalanceText),
                    ),
                    if (items.isNotEmpty)
                      StatusAnalyticsSlider(
                        items: items,
                        width: availableWidth * 60 / 100,
                      )
                  ]),
            ),
          ],
        )
      ],
    );
  }

  Widget analyticsAndTransactionsMobile(
      DashboardServicesType type, WalletDisplayModel wallet, List<StatusAnalyticsItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        serviceAnalyticsHeader(type),
        SizedBox(height: isMobile ? defaultPadding : horizontalPadding),
        SizedBox(
          width: availableWidth,
          // child: BalanceWidget(wallet: wallet, type: type),
          child: AccountInfoWidget(accountNumber: wallet.accountNumber, ifscCode: wallet.ifscCode, upiId: ''),
        ),
        if (type == DashboardServicesType.ppi)
          Padding(
            padding: const EdgeInsets.all(defaultMobilePadding),
            child: Center(child: manageOrgSettingsButtonText(onTap: () {
              log(RouteUtils.getOrgManageCardPath(org!.enrollmentId));
              context.router.pushNamed(RouteUtils.getOrgManageCardPath(org!.enrollmentId));
            })),
          ),
        if (type == DashboardServicesType.fuel)
          Padding(
            padding: const EdgeInsets.all(defaultMobilePadding),
            child: Center(child: manageOrgSettingsButtonText(onTap: () {
              log(RouteUtils.getOrgManageCardPath(org!.enrollmentId));
              context.router.pushNamed(RouteUtils.getOrgManageFuelPath(org!.enrollmentId));
            })),
          ),
        Scrollbar(
          controller: cardSummaryController,
          thumbVisibility: true,
          thickness: 5.0,
          child: SizedBox(
            width: availableWidth,
            height: 300,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: isMobile ? defaultMobilePadding : verticalPadding),
                    child: Text(
                        type == DashboardServicesType.ppi
                            ? "Card Summary"
                            : (type == DashboardServicesType.fuel)
                                ? 'Card Summary'
                                : "FASTag Summary",
                        style: AxleTextStyle.walletBalanceText),
                  ),
                  StatusAnalyticsSlider(
                    scrollController: cardSummaryController,
                    items: items,
                    width: availableWidth,
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  Widget serviceAnalyticsHeader(DashboardServicesType type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type == DashboardServicesType.ppi
              ? "Wallet & Card Summary"
              : type == DashboardServicesType.fuel
                  ? "Wallet & Staff Detail"
                  : "Wallet & Tag Summary",
          style: AxleTextStyle.dashboardCardTitle1,
        ),
        if (!isMobile && type == DashboardServicesType.ppi)
          manageOrgSettingsButtonText(onTap: () {
            log(RouteUtils.getOrgManageCardPath(org!.enrollmentId));
            context.router.pushNamed(RouteUtils.getOrgManageCardPath(org!.enrollmentId));
          }),
        if (!isMobile && type == DashboardServicesType.fuel)
          manageOrgSettingsButtonText(onTap: () {
            log(RouteUtils.getOrgManageCardPath(org!.enrollmentId));
            context.router.pushNamed(RouteUtils.getOrgManageFuelPath(org!.enrollmentId));
          }),
      ],
    );
  }

  Widget manageOrgSettingsButtonText({required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        "Manage Organization Settings >",
        style: AxleTextStyle.dashboardCardSubTitle.copyWith(
          color: const Color(0xff809FB8),
        ),
      ),
    );
  }

  // Widget serviceAnalyticsHeaderMobile(DashboardServicesType type) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       GestureDetector(
  //         onTap: () {},
  //         child: Text(
  //           type == DashboardServicesType.ppi ? "Manage Organization Settings >" : "",
  //           style: AxleTextStyle.dashboardCardTitle1.copyWith(
  //             color: const Color(0xff809FB8),
  //           ),
  //         ),
  //       ),
  //       Text(
  //         type == DashboardServicesType.ppi ? "Wallet & Card Summary" : "Wallet & Tag Summary",
  //         style: AxleTextStyle.dashboardCardTitle1,
  //       ),
  //     ],
  //   );
  // }
}
