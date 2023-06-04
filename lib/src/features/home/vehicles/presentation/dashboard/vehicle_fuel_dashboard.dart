import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_fuel_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/balance_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/logistics_dashboard_services.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';
import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_list_model.dart';
import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/transaction_controller.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/lq_tag_account_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/vehicle_map_unmap_widget.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleDashboardFuelService extends ConsumerStatefulWidget {
  final OrgDoc? org;
  final String vehicleRegNo;
  final String orgEnrolld;
  final String? vehicleEntityId;
  final Vehicle? vehicle;

  const VehicleDashboardFuelService({
    super.key,
    required this.org,
    required this.vehicleRegNo,
    required this.orgEnrolld,
    required this.vehicleEntityId,
    required this.vehicle,
  });

  @override
  ConsumerState<VehicleDashboardFuelService> createState() => _VehicleDashboardFuelServiceState();
}

class _VehicleDashboardFuelServiceState extends ConsumerState<VehicleDashboardFuelService> {
  // late Future<OrgFuelAccInfo> vehicleFuelAccInfoFuture;
  // late Future<FuelTxnListModel> vehicleLastDebitTxnFuture;
  late Future<LqTagAccountInfoModel> orgDashLqTagInfoFuture;
  String? userEnrollId;
  FuelTxnListModelMessage? snapData;

  @override
  void initState() {
    // if (widget.vehicle != null) {
    //   if ((getVehicleService(widget.vehicle, 'FUEL') != null &&
    //       getVehicleService(widget.vehicle, 'FUEL')?.kycStatus == 'APPROVED')) {
    //     vehicleFuelAccInfoFuture = getVehicleFuelAccountInfo();
    //   }
    //   vehicleLastDebitTxnFuture = getVehicleLastDebitTxn();
    // }
    super.initState();
  }

  Future<OrgFuelAccInfo> getVehicleFuelAccountInfo() async {
    userEnrollId = ref.watch(vehicleDetailsProvider)?.enrollmentId ?? '';
    return await ref
        .read(logisticsControllerProvider)
        .getOrgDashFuelAccountInfo(entityType: 'VEHICLE', userOrgEnrollId: userEnrollId ?? '');
  }

  Future<FuelTxnListModel> getVehicleLastDebitTxn() async {
    // ref.read(fuelTransactionListStateProvider.notifier).state = null;
    return ref.read(fuelTransactionListStateProvider.notifier).state =
        await ref.read(transactionControlProvider).listFuelTxns(
            params: FuelTxnQueryParams(
              size: 10,
              pageIndex: 1,
              //  transactionType: "FUEL",
              vehicleEnrollmentId: widget.vehicle!.enrollmentId,
              accountInfoEntity: widget.vehicleEntityId,
            ),
            orgEnrollIdOfUser: widget.orgEnrolld);
  }

  bool isMobile = false;
  double screenWidth = 0.0;
  double availableWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double menuWidth = kIsWeb ? sideMenuWidth : 0;
    availableWidth = screenWidth - (menuWidth + (horizontalPadding * 2) + defaultPadding);
    isMobile = Responsive.isMobile(context);
    //vehicle = ref.watch(vehicleDetailsProvider);

    if (isMobile) {
      availableWidth = (screenWidth - (defaultPadding * 2));
    }

    Widget fuelWalletDetails(OrgFuelAccInfoMessage? msgData, OrgDoc? org) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Fuel", style: AxleTextStyle.titleMedium),
              InkWell(
                onTap: () async {
                  context.router
                      .pushNamed(RouteUtils.getVehicleFuelFundLoadPath(widget.orgEnrolld, widget.vehicleRegNo));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color.fromRGBO(85, 153, 244, 1),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8),
                    child: Text(
                      "Load Vehicle",
                      style: AxleTextStyle.labelMedium.copyWith(
                        color: const Color.fromRGBO(45, 135, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          BalanceWidget(
            wallet: WalletDisplayModel(
              balance: msgData?.availableBalance.toDouble() ?? 0.0,
              upiId: '',
              accountNumber: msgData?.accountNumber ?? '-',
              ifscCode: msgData?.ifsc ?? '-',
              kitNo: '',
              type: WalletType.values.byName("USER".toLowerCase()),
              walletName: '',
            ),
            type: DashboardServicesType.fuel,
          ),
        ],
      );
    }

    Container fuelWalletContainer(OrgFuelAccInfoMessage? msgData, OrgDoc? org) {
      return isMobile
          ? Container(
              width: availableWidth,
              decoration: CommonStyleUtil.axleContainerDecoration,
              child: Padding(padding: const EdgeInsets.all(defaultPadding), child: fuelWalletDetails(msgData, org)),
            )
          : Container(
              constraints: const BoxConstraints(minWidth: 400),
              width: (availableWidth * 40) / 100,
              height: 300,
              decoration: CommonStyleUtil.axleContainerDecoration,
              child: Padding(padding: const EdgeInsets.all(verticalPadding), child: fuelWalletDetails(msgData, org)),
            );
    }

    Widget lastFuelTransactionCard() {
      OrgDoc? org = ref.watch(orgDetailsProvider);
      // FuelTxnListModel? lastTransaction = ref.watch(fuelTransactionListStateProvider);

      return org == null
          ? AxleLoader.axleProgressIndicator()
          : FutureBuilder<FuelTxnListModel>(
              key: const ValueKey('get-Vehicle-Last-Debit-Txn'),
              future: getVehicleLastDebitTxn(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return AxleLoader.axleProgressIndicator();
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.data?.data == null) {
                      return const AxleErrorWidget(
                        titleStr: 'No Data Found!',
                      );
                    } else if (snapshot.hasData) {
                      snapData = snapshot.data?.data?.message;
                      return snapshot.data?.data != null && snapData != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isMobile
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Last Fuel Transaction", style: AxleTextStyle.titleMedium),
                                          const SizedBox(height: defaultMobilePadding),
                                          const AxleTextWithBg(text: "-", textColor: primaryColor),
                                        ],
                                      )
                                    : Text("Last Fuel Transaction", style: AxleTextStyle.titleMedium),
                                const SizedBox(height: 24),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapData?.docs.isNotEmpty ?? false
                                          ? snapData?.docs.first.description != null
                                              ? '${snapData?.docs.first.description.toString()}'
                                              : ' -'
                                          : ' -',
                                      style: AxleTextStyle.labelLarge.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: defaultMobilePadding),
                                    Text(
                                      snapData?.docs.isNotEmpty ?? false
                                          ? snapData?.docs.first.amount != null
                                              ? '₹ ${snapData?.docs.first.amount.toString()}'
                                              : ' -'
                                          : '₹ 0.0',
                                      style: AxleTextStyle.headlineMedium.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: horizontalPadding),
                                    Center(
                                      child: AxlePrimaryButton(
                                          buttonHeight: 40,
                                          buttonText: "Manage Limits",
                                          onPress: () {
                                            context.router.pushNamed('vehicle-fuel-card-preference');
                                          }),
                                    ),
                                  ],
                                ),
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

    Widget staffMapCard(OrgFuelAccInfoMessage? msgData, String vehicleRegNo, String orgEnrolld) {
      OrgDoc? org = ref.watch(orgDetailsProvider);
      GlobalKey<FormState> formKey = GlobalKey<FormState>();
      UserDetails? userDetails;
      Service? services;
      for (var element in widget.vehicle!.services) {
        if (element.serviceType == "FUEL" && element.issuerName == "HPCL") {
          userDetails = element.userDetails;
          services = element;
          break;
        }
      }

      return org == null
          ? AxleLoader.axleProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mapped Staff Details", style: AxleTextStyle.titleMedium),
                          const SizedBox(height: defaultMobilePadding),
                        ],
                      )
                    : Text("Mapped Staff Details", style: AxleTextStyle.titleMedium),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (userDetails != null)
                      Text(
                        "Currently Mapped Staff : ${userDetails.userName}",
                        style: AxleTextStyle.labelMedium.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      services != null && services.mapStatus.isNotEmpty
                          ? services.mapStatus == 'UNMAP'
                              ? 'None selected'
                              : services.mapStatus == 'REASSIGN'
                                  ? 'Reassigned'
                                  : 'selected'
                          : getVehicleService(widget.vehicle, 'FUEL')?.mapStatus ?? '',
                      style: AxleTextStyle.titleLarge.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: horizontalPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AxlePrimaryButton(
                            buttonHeight: 40,
                            buttonWidth: msgData?.mapStatus == 'UNMAP' ? 200 : 120,
                            buttonText: msgData?.mapStatus == 'UNMAP' ? "Map Staff" : "Reassign",
                            onPress: () async {
                              if (true) {
                                // bool val =
                                await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    // return Container();
                                    return VehicleMapDriverDialog(
                                      formKey: formKey,
                                      vehicleRegNo: vehicleRegNo,
                                      organizationEnrollmentId: orgEnrolld,
                                      isMapped: msgData?.mapStatus == 'UNMAP' ? false : true,
                                      btnValue: "",
                                      userDetails: userDetails,
                                    );
                                  },
                                );
                              }
                            }),
                        const SizedBox(width: defaultPadding),
                        if (msgData?.mapStatus == 'MAP')
                          AxlePrimaryButton(
                              buttonHeight: 40,
                              buttonWidth: 120,
                              buttonText: "UnMap",
                              onPress: () async {
                                if (true) {
                                  // bool val =
                                  await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      // return Container();
                                      return VehicleMapDriverDialog(
                                        formKey: formKey,
                                        vehicleRegNo: vehicleRegNo,
                                        organizationEnrollmentId: orgEnrolld,
                                        isMapped: msgData?.mapStatus == 'MAP' ? false : true,
                                        btnValue: 'UNMAP',
                                        userDetails: userDetails,
                                      );
                                    },
                                  );
                                }
                              }),
                      ],
                    ),
                  ],
                ),
              ],
            );
    }

    return widget.vehicle != null && getVehicleService(widget.vehicle, 'FUEL', issuerName: "HPCL") != null
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: FutureBuilder<OrgFuelAccInfo>(
                  key: const ValueKey('get-Vehicle-FuelAccountInfo'),
                  future: getVehicleFuelAccountInfo(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return AxleLoader.axleProgressIndicator();
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return const Text('Error Service');
                        } else if (snapshot.hasData) {
                          if (snapshot.data?.data == null) {
                            return const AxleErrorWidget(
                              titleStr: 'No Data Found!',
                            );
                          }
                          // msgData = snapshot.data!.data?.message;
                          return isMobile
                              ? Column(
                                  children: [
                                    fuelWalletContainer(snapshot.data!.data?.message, widget.org),
                                    const SizedBox(height: defaultPadding),
                                    Container(
                                      width: availableWidth,
                                      decoration: CommonStyleUtil.axleContainerDecoration,
                                      child: Padding(
                                        padding: const EdgeInsets.all(defaultPadding),
                                        child: (snapshot.data!.data?.message != null)
                                            ? lastFuelTransactionCard()
                                            : Container(),
                                      ),
                                    ),
                                    staffMapCard(
                                      snapshot.data!.data?.message,
                                      widget.vehicleRegNo,
                                      widget.orgEnrolld,
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    fuelWalletContainer(snapshot.data!.data?.message, widget.org),
                                    const SizedBox(
                                      width: defaultPadding,
                                    ),
                                    Container(
                                      constraints: const BoxConstraints(minWidth: 300),
                                      width: (availableWidth * 10) / 100,
                                      height: 300,
                                      decoration: CommonStyleUtil.axleContainerDecoration,
                                      child: Padding(
                                        padding: const EdgeInsets.all(verticalPadding),
                                        child: (snapshot.data!.data?.message != null)
                                            ? lastFuelTransactionCard()
                                            : Container(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: defaultPadding,
                                    ),
                                    Container(
                                      constraints: const BoxConstraints(minWidth: 350),
                                      width: (availableWidth * 20) / 100,
                                      height: 300,
                                      decoration: CommonStyleUtil.axleContainerDecoration,
                                      child: Padding(
                                        padding: const EdgeInsets.all(verticalPadding),
                                        child: (snapshot.data!.data?.message != null)
                                            ? staffMapCard(
                                                snapshot.data!.data?.message,
                                                widget.vehicleRegNo,
                                                widget.orgEnrolld,
                                              )
                                            : Container(),
                                      ),
                                    ),
                                  ],
                                );
                        } else {
                          return AxleLoader.axleProgressIndicator();
                        }
                      default:
                        return AxleLoader.axleProgressIndicator();
                    }
                  },
                )),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(horizontalPadding),
              child: Text(
                "Please Ensure your Organisation is enabled with Fuel Service",
                style: isMobile ? AxleTextStyle.bodyMedium : AxleTextStyle.headingPrimary,
              ),
            ),
          );
  }
}
