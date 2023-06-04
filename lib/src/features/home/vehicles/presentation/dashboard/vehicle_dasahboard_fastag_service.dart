import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/src/common/common_controllers/wallets_controller.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/presentation/lq_txn_table_widget.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/transaction_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/fund_load_org_card.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/lq_tag_account_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/yesbank_tag_account_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/vehicle_fund_load_dialog.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/balance_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/logistics_dashboard_services.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_acc_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_last_debit_txn_model.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';

class VehicleDasahboardFastagService extends ConsumerStatefulWidget {
  const VehicleDasahboardFastagService(
      {Key? key, required this.vehicleRegNo, required this.org, required this.orgEnrolld, required this.vehicle})
      : super(key: key);

  final String vehicleRegNo;
  final OrgDoc? org;
  final String orgEnrolld;
  final Vehicle? vehicle;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleDasahboardFastagServiceState();
}

class _VehicleDasahboardFastagServiceState extends ConsumerState<VehicleDasahboardFastagService> {
  late Future<VehicleAccInfoModel> vehicleAccInfoFuture;
  late Future<VehicleLastDebitTxnModel> vehicleLastDebitTxnFuture;
  // late Future<FetchBalanceResponseModel?> fetchBalanceFuture;
  late Future<LqTagAccountInfoModel> orgDashLqTagInfoFuture;

  // Vehicle? vehicle;

  final TextEditingController lqTagAdminController = TextEditingController();
  final TextEditingController lqTagAdminUserEnrollmentId = TextEditingController();

  @override
  void initState() {
    getAllWallet();
    loadInit();

    super.initState();
  }

  loadInit() {
    if ((getVehicleService(widget.vehicle, 'TAG') != null &&
        getVehicleService(widget.vehicle, 'TAG')?.kycStatus == 'APPROVED')) {
      vehicleAccInfoFuture = getVehicleAccountInfo();
    }
    vehicleLastDebitTxnFuture = getVehicleLastDebitTxn();
    if (getVehicleService(widget.vehicle, 'TAG', issuerName: "LIVQUIK") != null &&
        getVehicleService(widget.vehicle, 'TAG', issuerName: "LIVQUIK")?.kycStatus == 'APPROVED') {
      orgDashLqTagInfoFuture = getLqTagInfo();
    }
  }

  getAllWallet({bool isLoad = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(lqTagWalletsNotifierProvider.notifier).getAllWalletsForOrg(widget.orgEnrolld);
    });
  }

  Future<LqTagAccountInfoModel> getLqTagInfo({String userEnrollmentId = ''}) async {
    if (getOrgService(widget.org, 'TAG', issuerName: 'LIVQUIK') != null) {
      final lqTagAccountInfoModel = await ref.read(vehicleControllerProvider).getLivquikTagAccInfo(
          organizationEnrollmentId:
              getVehicleService(widget.vehicle, 'TAG', issuerName: 'LIVQUIK')?.organizationEnrollmentId ?? '',
          userEnrollmentId: userEnrollmentId.isNotEmpty
              ? userEnrollmentId
              : getVehicleService(widget.vehicle, 'TAG', issuerName: 'LIVQUIK')?.userEnrollmentId ?? '');
      if (userEnrollmentId.isNotEmpty) {
        setState(() {});
      }
      return lqTagAccountInfoModel;
    } else {
      return const LqTagAccountInfoModel.unknown();
    }
  }

  Future<VehicleAccInfoModel> getVehicleAccountInfo() async =>
      await ref.read(vehicleControllerProvider).getVehicleAccInfo(vehicleRegNo: widget.vehicleRegNo);

  Future<VehicleLastDebitTxnModel> getVehicleLastDebitTxn() async =>
      await ref.read(vehicleControllerProvider).getVehicleLastDebitTxn(vehicleRegNo: widget.vehicleRegNo);

  bool isMobile = false;
  double screenWidth = 0.0;
  double availableWidth = 0.0;

  getOrg() {
    for (OrganizationService orgService in widget.org!.organizationServices) {
      log("getOrg $orgService");
      return orgService;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double menuWidth = kIsWeb ? sideMenuWidth : 0;
    availableWidth = screenWidth - (menuWidth + (horizontalPadding * 2) + defaultPadding);
    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = (screenWidth - (defaultPadding * 2));
    }

    // fetchBalanceFuture = getOrgBalanceInfo();

    return ((getVehicleService(widget.vehicle, 'TAG', issuerName: "YESBANK") != null &&
            getVehicleService(widget.vehicle, 'TAG', issuerName: "YESBANK")?.kycStatus == 'APPROVED'))
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: FutureBuilder<VehicleAccInfoModel>(
                  future: vehicleAccInfoFuture,
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
                            return const Center(
                              child: Text(
                                'No Data Found',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                              ),
                            );
                          }
                          final msgData = snapshot.data?.data?.message;
                          return isMobile
                              ? Column(
                                  children: [
                                    yesbankTagWalletContainer(msgData, widget.org),
                                    const SizedBox(height: defaultPadding),
                                    Container(
                                        width: availableWidth,
                                        decoration: CommonStyleUtil.axleContainerDecoration,
                                        child: Padding(
                                          padding: const EdgeInsets.all(defaultPadding),
                                          child: (msgData != null) ? lastDebitInfoCard(msgData) : Container(),
                                        ))
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    yesbankTagWalletContainer(msgData, widget.org),
                                    const SizedBox(
                                      width: defaultPadding,
                                    ),
                                    Container(
                                      constraints: const BoxConstraints(minWidth: 600),
                                      width: (availableWidth * 60) / 100,
                                      height: 300,
                                      decoration: CommonStyleUtil.axleContainerDecoration,
                                      child: Padding(
                                        padding: const EdgeInsets.all(defaultPadding),
                                        child: (msgData != null) ? lastDebitInfoCard(msgData) : Container(),
                                      ),
                                    ),
                                  ],
                                );
                        } else {
                          return AxleLoader.axleProgressIndicator();
                        }
                    }
                  },
                )),
          )
        : ((getVehicleService(widget.vehicle, 'TAG', issuerName: "LIVQUIK") != null &&
                getVehicleService(widget.vehicle, 'TAG', issuerName: "LIVQUIK")?.kycStatus == 'APPROVED'))
            ? FutureBuilder<LqTagAccountInfoModel>(
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

                        return lqTagWalletContainer(data);
                      } else {
                        return AxleLoader.axleProgressIndicator();
                      }
                  }
                },
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(horizontalPadding),
                  child: Text(
                    "Please Ensure your Organisation is enabled with Tag Service",
                    style: isMobile ? AxleTextStyle.bodyMedium : AxleTextStyle.headingPrimary,
                  ),
                ),
              );
  }

  Widget walletCard(WalletDisplayModel walletInfo) {
    return FundLoadOrgCard(
      title: walletInfo.walletName,
      subtitle: 'Available Balance',
      balance: axleCurrencyFormatterwithDecimals.format(walletInfo.balance),
      icon: Icons.card_giftcard,
      borderColor: const Color(0xffBBAAEC),
      textColor: const Color(0xff714FD8),
    );
  }

  Container yesbankTagWalletContainer(Messagee? msgData, OrgDoc? org) {
    return isMobile
        ? Container(
            width: availableWidth,
            // height: 200,
            decoration: CommonStyleUtil.axleContainerDecoration,
            child: Padding(padding: const EdgeInsets.all(defaultPadding), child: yesTagWalletDetails(msgData, org)),
          )
        : Container(
            constraints: const BoxConstraints(minWidth: 400),
            width: (availableWidth * 40) / 100,
            height: 300,
            decoration: CommonStyleUtil.axleContainerDecoration,
            child: Padding(padding: const EdgeInsets.all(defaultPadding), child: yesTagWalletDetails(msgData, org)),
          );
  }

  Widget lqTagWalletContainer(LqTagAccountInfoModelMessage? msgData) {
    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: availableWidth,
                decoration: CommonStyleUtil.axleContainerDecoration,
                child: Padding(padding: const EdgeInsets.all(defaultPadding), child: lqTagWalletDetails(msgData)),
              ),
              const SizedBox(height: verticalPadding),
              Text(" Recent Transactions", style: AxleTextStyle.headingPrimary),
              const SizedBox(height: defaultMobilePadding),
              LQTxnTableWidget(
                showDateFilter: false,
                showPaginator: false,
                txnParams: TagTxnQueryParams(size: 10, pageIndex: 1),
                listStateProvider: tagTransactionListStateProvider,
                userOrgEnrollId: widget.orgEnrolld,
                vehicleId: widget.vehicleRegNo,
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 400),
                width: (availableWidth * 40) / 100,
                // height: 300,
                decoration: CommonStyleUtil.axleContainerDecoration,
                child: Padding(padding: const EdgeInsets.all(defaultPadding), child: lqTagWalletDetails(msgData)),
              ),
              const SizedBox(height: defaultPadding),
              Text(" Recent Transactions", style: AxleTextStyle.headingPrimary),
              const SizedBox(height: defaultMobilePadding),
              LQTxnTableWidget(
                showDateFilter: false,
                showPaginator: false,
                txnParams: TagTxnQueryParams(size: 10, pageIndex: 1),
                listStateProvider: tagTransactionListStateProvider,
                userOrgEnrollId: widget.orgEnrolld,
                vehicleId: widget.vehicleRegNo,
              ),
            ],
          );
  }

  // Widget getLQTAGdata(OrganizationService orgService) {
  //   return
  //   // } else {
  //   //   return const AxleErrorWidget();
  //   // }
  // }

  Widget lqTagWalletDetails(LqTagAccountInfoModelMessage? data) {
    return data == null
        ? const AxleErrorWidget(
            subtitle: 'Something went wrong',
          )
        : Stack(
            alignment: Alignment.topRight,
            children: [
              BalanceWidget(
                wallet: WalletDisplayModel(
                  kitNo: data.kitNumber,
                  type: WalletType.values.byName("USER".toLowerCase()),
                  walletName: data.name,
                  balance: data.availableBalance.toDouble(),
                  upiId: data.upiId,
                  accountNumber: data.accountNumber,
                  ifscCode: data.ifsc,
                ),
                showCustomerCount: false,
                type: DashboardServicesType.fastag,
              ),
              Consumer(
                builder: (context, ref, child) {
                  List<WalletDisplayModel> walletInfoList = ref.watch(lqTagWalletsProvider);
                  bool isLoading = ref.watch(isLoadinglqTagWallets);
                  if (isLoading) {
                    return Positioned(
                        top: -10, right: 0, child: AxleLoader.axleProgressIndicator(width: 40, height: 40));
                  }
                  if (walletInfoList.length > 1) {
                    return IconButton(
                        icon: const Icon(Icons.switch_account_rounded),
                        color: primaryColor,
                        onPressed: (() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Change LQ-FASTag Admin'),
                                  titleTextStyle: AxleTextStyle.titleMedium,
                                  content: showListOfAdminWallets(walletInfoList),
                                );
                              });
                        }));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          );
  }

  Widget showListOfAdminWallets(List<WalletDisplayModel> walletInfoList) {
    return SizedBox(
      height: 1000.0, // Change as per your requirement
      width: 500.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: walletInfoList.length,
        itemBuilder: (BuildContext context, int index) {
          if (walletInfoList[index].type == WalletType.logistics) {
            return const SizedBox();
          }

          return GestureDetector(
              onTap: () {
                Navigator.pop(context);
                WalletDisplayModel wallet = walletInfoList[index];
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Change LQ FASTag Admin"),
                      content: Text("Are you sure want to change ${wallet.walletName} as FASTag Admin?"),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text("Continue"),
                          onPressed: () async {
                            Navigator.pop(context);
                            AxleLoader.show(context);
                            bool res = await ref
                                .read(vehicleControllerProvider)
                                .changeLQFastagAdmin(widget.orgEnrolld, widget.vehicleRegNo, wallet.userEnrollmentId);
                            if (res) {
                              orgDashLqTagInfoFuture = getLqTagInfo(userEnrollmentId: wallet.userEnrollmentId);
                            }
                            AxleLoader.hide();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Column(
                children: [walletCard(walletInfoList[index]), const SizedBox(height: defaultPadding)],
              ));
        },
      ),
    );
  }

  Widget yesTagWalletDetails(Messagee? msgData, OrgDoc? org) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(msgData!.issuerName ?? '', style: AxleTextStyle.titleMedium),
            InkWell(
              onTap: () async {
                AxleLoader.show(context);
                YesBankTagAccountInfoModel? res = await ref
                    .read(vehicleControllerProvider)
                    .getYesBankTagAccInfoDetailsByEntityId(
                        entityId: getOrgService(widget.org, 'TAG', issuerName: 'YESBANK') != null
                            ? (getOrgService(widget.org, 'TAG', issuerName: 'YESBANK')?.organizationEntityId) ?? ''
                            : '');
                AxleLoader.hide();
                if (res.data != null) {
                  // ignore: use_build_context_synchronously
                  bool val = await showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return VehicleFundLoadDialog(
                        msgData: msgData,
                        org: org,
                        balanceData: (res.data?.message != null)
                            ? (res.data?.message?.availableBalance.toString() ?? '0.00')
                            : '0.00',
                        formKey: formKey,
                      );
                    },
                  );
                  // log('VALUE IS ------> $val');
                  if (val) {
                    vehicleAccInfoFuture = getVehicleAccountInfo();
                    ref.read(vehicleDashTransactionListStateProvider.notifier).state = null;
                    ref.read(vehicleDashTransactionListStateProvider.notifier).state =
                        await ref.read(transactionControlProvider).listTagTxns(
                                params: TagTxnQueryParams(
                              size: 10,
                              pageIndex: 1,
                              filterField: 'vehicleId',
                              filterText: widget.vehicleRegNo.toUpperCase(),
                            ));

                    setState(() {});
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color.fromRGBO(85, 153, 244, 1))),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultMobilePadding),
                    child: Text("Load Vehicle",
                        style: AxleTextStyle.labelMedium.copyWith(color: const Color.fromRGBO(45, 135, 255, 1)))),
              ),
            ),
          ],
        ),
        BalanceWidget(
            wallet: WalletDisplayModel(
              type: WalletType.values.byName((msgData.type ?? "Logistics").toString().toLowerCase()),
              kitNo: "",
              accountNumber: msgData.accountNumber ?? '',
              ifscCode: msgData.iFSC ?? '',
              walletName: "",
              balance: msgData.availableBalance?.toDouble() ?? 0.0,
              upiId: msgData.upiId ?? '-',
            ),
            type: DashboardServicesType.ppi),
        (getVehicleService(widget.vehicle, 'TAG') != null)
            ? Container(
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), color: const Color.fromRGBO(220, 236, 255, 1)),
                child: Center(
                    child: getVehicleService(widget.vehicle, 'TAG')?.balanceType == "VEHICLE_LEVEL_BALANCE"
                        ? Text("This vehicle is under Vehicle Level Balance",
                            style: AxleTextStyle.labelLarge.copyWith(color: Colors.black))
                        : Text("This vehicle is under Customer Level Balance",
                            style: AxleTextStyle.labelLarge.copyWith(color: Colors.black))),
              )
            : const SizedBox(width: 400, height: 35),
      ],
    );
  }

  Widget lastDebitInfoCard(Messagee msgData) {
    Color statusColor = AxleColors.getTagStatusColor(msgData.status?.toLowerCase() ?? '');
    OrgDoc? org = ref.watch(orgDetailsProvider);

    return org == null
        ? AxleLoader.axleProgressIndicator()
        : FutureBuilder<VehicleLastDebitTxnModel>(
            future: vehicleLastDebitTxnFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return AxleLoader.axleProgressIndicator();
                case ConnectionState.done:
                default:
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    final snapData = snapshot.data?.data?.message;
                    return snapshot.data?.data != null && snapData != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isMobile
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("FASTag Serial Number", style: AxleTextStyle.titleMedium),
                                        const SizedBox(height: defaultMobilePadding),
                                        AxleTextWithBg(
                                            text: widget.vehicle?.services != null
                                                ? getVehicleService(widget.vehicle, 'TAG')!.serialNumber
                                                : '-',
                                            textColor: primaryColor),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text("FASTag Serial Number", style: AxleTextStyle.titleMedium),
                                        const SizedBox(width: defaultMobilePadding),
                                        AxleTextWithBg(
                                            text: widget.vehicle?.services != null
                                                ? getVehicleService(widget.vehicle, 'TAG')!.serialNumber
                                                : '-',
                                            textColor: primaryColor),
                                      ],
                                    ),
                              const SizedBox(height: 24),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (snapData.docs!.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Last Toll Transaction",
                                            style: AxleTextStyle.labelLarge.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            snapData.docs?.first.amount != null
                                                ? axleCurrencyFormatterwithDecimals.format(snapData.docs?.first.amount)
                                                : ' -',
                                            style: AxleTextStyle.displaySmall.copyWith(color: Colors.black),
                                          ),
                                          const SizedBox(height: defaultPadding),
                                          Text(
                                            snapData.docs?.first.tollPlazaName ?? '-',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(128, 159, 184, 1),
                                            ),
                                          ),
                                          Text(
                                            snapData.docs?.first.tollReaderTime != null
                                                ? DatePickerUtil.dateLongMonthYearWithTimeFormatterIsd(
                                                    DateTime.parse(snapData.docs!.first.tollReaderTime!))
                                                : '-',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(128, 159, 184, 1),
                                            ),
                                          )
                                        ],
                                      ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tag Status",
                                          style: AxleTextStyle.labelLarge.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: defaultMobilePadding),
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: statusColor.withOpacity(0.1),
                                          ),
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                              child: Text(
                                                msgData.status != null ? "${msgData.status?.toUiCase} Tag" : '',
                                                style: TextStyle(
                                                  color: statusColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container()
                                  ],
                                ),
                              ),
                              if (isMobile) const SizedBox(height: defaultMobilePadding),
                              Center(
                                child: AxlePrimaryButton(
                                    buttonHeight: 40,
                                    buttonText: "Manage Tag",
                                    onPress: () {
                                      // debugPrint("Vehicle's Enroll ID :: ${org.enrollmentId} ");
                                      context.router.pushNamed("./manage-tag"
                                          // RouteUtils.getVehicleManageTagPath(org.enrollmentId, widget.vehicleRegNo)
                                          );
                                    }),
                              )
                            ],
                          )
                        : Container();
                  } else {
                    return AxleLoader.axleProgressIndicator();
                  }
              }
            },
          );
  }
}
