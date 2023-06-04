// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_acc_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_last_debit_txn_model.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/balance_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/logistics_dashboard_services.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/values/constants.dart';

@RoutePage()
class VehicleManageFastag extends ConsumerStatefulWidget {
  const VehicleManageFastag(
      {@PathParam('vehicleRegNo') required this.vehicleRegNo,
      @PathParam('custId') required this.orgEnrollId,
      super.key});
  final String vehicleRegNo;
  final String orgEnrollId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleManageFastagState();
}

TextEditingController controller = TextEditingController();

class _VehicleManageFastagState extends ConsumerState<VehicleManageFastag> {
  late Future<VehicleAccInfoModel> vehicleAccInfoFuture;
  late Future<VehicleLastDebitTxnModel> vehicleLastDebitTxnFuture;
  late Future<DetailVehicleUpdatedModel> vehicleDetailFuture;

  OrgDoc? org;
  Vehicle? vehicle;

  @override
  void initState() {
    vehicleAccInfoFuture = getVehicleAccountInfo();
    vehicleLastDebitTxnFuture = getVehicleLastDebitTxn();
    vehicleDetailFuture = getVehicleDetail();

    super.initState();
  }

  Future<VehicleAccInfoModel> getVehicleAccountInfo() async =>
      await ref.read(vehicleControllerProvider).getVehicleAccInfo(vehicleRegNo: widget.vehicleRegNo);

  Future<VehicleLastDebitTxnModel> getVehicleLastDebitTxn() async =>
      await ref.read(vehicleControllerProvider).getVehicleLastDebitTxn(vehicleRegNo: widget.vehicleRegNo);

  Future<DetailVehicleUpdatedModel> getVehicleDetail() async => await ref
      .read(vehicleControllerProvider)
      .getVehicleDetailsModelByEnrolId(vehicleEnrolId: widget.vehicleRegNo.toUpperCase());

  bool isMobile = false;
  double availableWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);
    vehicle = ref.watch(vehicleDetailsProvider);
    // final vehiclesList = ref.watch(listofVehiclesStateProvider);

    isMobile = Responsive.isMobile(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double sideBarWidth = Responsive.isMobile(context) ? 0 : 300;
    availableWidth = screenWidth - sideBarWidth - (defaultPadding * 3);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: vehicle?.services == null
            ? AxleLoader.axleProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: isMobile
                      ? const EdgeInsets.all(defaultPadding)
                      : const EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
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
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isMobile
                                    ? Column(
                                        children: [
                                          Row(children: [
                                            GestureDetector(
                                                onTap: () => context.router.pushNamed(
                                                    RouteUtils.getVehicleDashboardPath(
                                                        widget.orgEnrollId, widget.vehicleRegNo)),
                                                child: Text("< Back", style: AxleTextStyle.labelLarge))
                                          ]),
                                          const SizedBox(height: defaultPadding)
                                        ],
                                      )
                                    : DashboardHeader(
                                        title: "Manage Tag",
                                        vehicleId: widget.vehicleRegNo,
                                        orgName: org != null ? " ${org?.displayName}" : '',
                                      ),
                                SizedBox(
                                  height: isMobile ? 0 : defaultPadding,
                                ),
                                isMobile
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/new_assets/icons/gps_imei_icon.svg",
                                                width: 24,
                                                height: 24,
                                              ),
                                              const SizedBox(width: defaultMobilePadding),
                                              Text(
                                                "FASTag Serial Number",
                                                style: AxleTextStyle.miniHeadingBlackStyle,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: defaultMobilePadding),
                                          AxleTextWithBg(
                                            text: vehicle?.services
                                                        .indexWhere((element) => element.serviceType == 'TAG') !=
                                                    null
                                                ? vehicle?.services != null
                                                    ? ("${getVehicleService(vehicle, 'TAG')?.serialNumber}")
                                                    : ''
                                                : '',
                                            // vehicle?.services?.tag.first.serialNumber ?? "-",
                                            textColor: primaryColor,
                                          )
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(defaultPadding),
                                            child: SvgPicture.asset(
                                              "assets/new_assets/icons/gps_imei_icon.svg",
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                          Text(
                                            "FASTag Serial Number",
                                            style: AxleTextStyle.miniHeadingBlackStyle,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(defaultPadding),
                                            child: AxleTextWithBg(
                                              text: vehicle?.services
                                                          .indexWhere((element) => element.serviceType == 'TAG') !=
                                                      null
                                                  ? vehicle?.services != null
                                                      ? ("${getVehicleService(vehicle, 'TAG')?.serialNumber}")
                                                      : ''
                                                  : '',
                                              //  vehicle?.services?.tag.first.serialNumber ?? "-",
                                              textColor: primaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Container(
                                  decoration: CommonStyleUtil.axleContainerDecoration,
                                  width: screenWidth,
                                  //height: 400,
                                  child: Padding(
                                    padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
                                    child: Wrap(
                                      runSpacing: defaultPadding,
                                      alignment: WrapAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 425,
                                          height: isMobile ? 280 : 300,
                                          child: Column(
                                            children: [
                                              BalanceWidget(
                                                wallet: WalletDisplayModel(
                                                    balance: msgData?.availableBalance?.toDouble() ?? 0.0,
                                                    type: WalletType.user,
                                                    upiId: msgData?.upiId ?? ' -',
                                                    kitNo: "",
                                                    accountNumber: "",
                                                    ifscCode: "",
                                                    walletName: ""),
                                                type: DashboardServicesType.ppi,
                                              ),
                                              // Text(
                                              //   "Vehicle Wallet Balance",
                                              //   style:
                                              //       AxleTextStyle.walletBalanceText,
                                              // ),
                                              const Expanded(
                                                child: Text(""),
                                              ),

                                              Row(
                                                children: [
                                                  Text(
                                                    "Threshold Limit",
                                                    style: AxleTextStyle.upiIdText,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    msgData?.thresholdLimit != null
                                                        ? "₹ ${msgData?.thresholdLimit.toString() ?? '-'}"
                                                        : " -",
                                                    style: AxleTextStyle.thresholdLimitValue,
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      showThresholdLimitDialog(
                                                        context,
                                                        orgId: org?.id ?? '',
                                                        vehicleRegNo: vehicle?.registrationNumber ?? '',
                                                      );
                                                    },
                                                    icon: const Icon(Icons.edit),
                                                    iconSize: 24,
                                                    color: const Color(0xFF809FB8),
                                                  )
                                                ],
                                              ),

                                              const Expanded(
                                                child: Text(""),
                                              ),

                                              AxlePrimaryButton(
                                                buttonText: "Switch Balance Type",
                                                onPress: () {
                                                  showSwitchBalanceDialog(context, msgData);
                                                },
                                                buttonWidth: double.maxFinite,
                                              )
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 425,
                                        //   height: 300,
                                        //   child: Column(
                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //     children: [
                                        //       if (isMobile) const SizedBox(height: defaultPadding),
                                        //       Text(
                                        //         "Tag Status",
                                        //         style: AxleTextStyle.walletBalanceText,
                                        //       ),
                                        //       isMobile
                                        //           ? Column(
                                        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //               crossAxisAlignment: CrossAxisAlignment.center,
                                        //               children: [
                                        //                 AxleTextWithBg(
                                        //                     height: 48,
                                        //                     text:
                                        //                         vehicle?.services?.tag.first.balanceType.toUiCase ?? '',
                                        //                     textColor: Colors.red),
                                        //                 const SizedBox(height: defaultMobilePadding),
                                        //                 AxleSearchDropDownField(
                                        //                     dropdownHeight: 120,
                                        //                     fieldHint: "Select Action",
                                        //                     fieldController: controller,
                                        //                     dropDownOptions: const [
                                        //                       "Block",
                                        //                       "Hotlist",
                                        //                       "Close",
                                        //                       "Replace",
                                        //                       "Unblock",
                                        //                       "Remove Hotlist"
                                        //                     ],
                                        //                     onChanged: (val) {
                                        //                       controller.text = val;
                                        //                     })
                                        //               ],
                                        //             )
                                        //           : Row(
                                        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //               crossAxisAlignment: CrossAxisAlignment.center,
                                        //               children: [
                                        //                 AxleTextWithBg(
                                        //                   height: 48,
                                        //                   text: vehicle?.services?.tag.first.balanceType.toUiCase ?? '',
                                        //                   textColor: Colors.red,
                                        //                 ),
                                        //                 AxleSearchDropDownField(
                                        //                     fieldWidth: 220,
                                        //                     fieldHint: "Select Action",
                                        //                     fieldController: controller,
                                        //                     dropDownOptions: const [
                                        //                       "Block",
                                        //                       "Hotlist",
                                        //                       "Close",
                                        //                       "Replace",
                                        //                       "Unblock",
                                        //                       "Remove Hotlist"
                                        //                     ],
                                        //                     onChanged: (val) {
                                        //                       controller.text = val;
                                        //                     })
                                        //               ],
                                        //             ),
                                        //       AxlePrimaryButton(
                                        //         buttonText: "Tag Action",
                                        //         onPress: () {},
                                        //         buttonWidth: double.maxFinite,
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                        AxleTextWithBg(
                                          text: (vehicle?.services != null &&
                                                  vehicle?.services
                                                          .indexWhere((element) => element.serviceType == 'TAG') !=
                                                      null)
                                              ? getVehicleService(vehicle, 'TAG')?.balanceType ==
                                                      "VEHICLE_LEVEL_BALANCE"
                                                  ? "This vehicle is currently under Vehicle Level Balance"
                                                  : "This vehicle is currently under Customer Level Balance"
                                              : '',
                                          maxLines: 2,
                                          wrapText: true,
                                          textColor: Colors.black,
                                          backgroundColor: const Color(0xFFDCECFF),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return AxleLoader.axleProgressIndicator();
                          }
                      }
                    },
                  ),

                  //  Builder(builder: (context) {
                  //   return Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       DashboardHeader(
                  //         title: "Manage Tag",
                  //         vehicleId: widget.vehicleRegNo,
                  //         orgName: org != null ? " ${(org!.firstName + org!.lastName)}" : '',
                  //       ),
                  //       const SizedBox(
                  //         height: defaultPadding,
                  //       ),
                  //       Row(
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.all(defaultPadding),
                  //             child: SvgPicture.asset(
                  //               "assets/new_assets/icons/gps_imei_icon.svg",
                  //               width: 24,
                  //               height: 24,
                  //             ),
                  //           ),
                  //           Text(
                  //             "FASTag Serial Number",
                  //             style: AxleTextStyle.miniHeadingBlackStyle,
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.all(defaultPadding),
                  //             child: AxleTextWithBg(
                  //               text: vehicle?.services?.tag.first.serialNumber ?? "-",
                  //               textColor: primaryColor,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //       const SizedBox(
                  //         height: defaultPadding,
                  //       ),
                  //       Container(
                  //         decoration: CommonStyleUtil.axleContainerDecoration,
                  //         width: screenWidth,
                  //         height: 400,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(defaultPadding),
                  //           child: Wrap(
                  //             runSpacing: defaultPadding,
                  //             alignment: WrapAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 width: 425,
                  //                 height: 300,
                  //                 child: Column(
                  //                   children: [
                  //                     BalanceWidget(
                  //                       wallet: Wallet(balance: 5000, upiId: "12345"),
                  //                       type: DashboardServicesType.ppi,
                  //                     ),
                  //                     // Text(
                  //                     //   "Vehicle Wallet Balance",
                  //                     //   style:
                  //                     //       AxleTextStyle.walletBalanceText,
                  //                     // ),
                  //                     const Expanded(
                  //                       child: Text(""),
                  //                     ),

                  //                     Row(
                  //                       children: [
                  //                         Text(
                  //                           "Threshold Limit",
                  //                           style: AxleTextStyle.upiIdText,
                  //                         ),
                  //                         Text(
                  //                           "₹ 1000",
                  //                           style: AxleTextStyle.thresholdLimitValue,
                  //                         ),
                  //                         IconButton(
                  //                           onPressed: () {
                  //                             showThresholdLimitDialog(context);
                  //                           },
                  //                           icon: const Icon(Icons.edit),
                  //                           iconSize: 24,
                  //                           color: const Color(0xFF809FB8),
                  //                         )
                  //                       ],
                  //                     ),

                  //                     const Expanded(
                  //                       child: Text(""),
                  //                     ),

                  //                     AxlePrimaryButton(
                  //                       buttonText: "Switch Balance Type",
                  //                       onPress: () {
                  //                         showSwitchBalanceDialog(context);
                  //                       },
                  //                       buttonWidth: double.maxFinite,
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //               Container(
                  //                 width: 425,
                  //                 height: 300,
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text(
                  //                       "Tag Status",
                  //                       style: AxleTextStyle.walletBalanceText,
                  //                     ),
                  //                     // SizedBox(
                  //                     //   height: defaultPadding,
                  //                     // ),
                  //                     Row(
                  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                       crossAxisAlignment: CrossAxisAlignment.center,
                  //                       children: [
                  //                         const AxleTextWithBg(
                  //                             height: 48, text: "Low Balance Tag", textColor: Colors.red),
                  //                         AxleSearchDropDownField(
                  //                             fieldWidth: 220,
                  //                             fieldHint: "Select Action",
                  //                             fieldController: controller,
                  //                             dropDownOptions: const [
                  //                               "Block",
                  //                               "Hotlist",
                  //                               "Close",
                  //                               "Replace",
                  //                               "Unblock",
                  //                               "Remove Hotlist"
                  //                             ],
                  //                             onChanged: (val) {
                  //                               controller.text = val;
                  //                             })
                  //                       ],
                  //                     ),
                  //                     // Expanded(
                  //                     //   child: Text(""),
                  //                     // ),
                  //                     AxlePrimaryButton(
                  //                       buttonText: "Tag Action",
                  //                       onPress: () {},
                  //                       buttonWidth: double.maxFinite,
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //               const AxleTextWithBg(
                  //                 text: "This vehicle is currently under Vehicle Level Balance",
                  //                 textColor: Colors.black,
                  //                 backgroundColor: Color(0xFFDCECFF),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   );
                  // }),
                ),
              ),
      ),
    );
  }

  showSwitchBalanceDialog(BuildContext context, Messagee? message) {
    return showDialog(
      context: context,
      builder: (context) {
        GlobalKey<FormState> formKey = GlobalKey<FormState>();

        TextEditingController? controller = TextEditingController();
        return AlertDialog(
          title: Column(
            children: [
              Text(
                "Switch Balance Type",
                style: AxleTextStyle.headline6BlackStyle,
              ),
              const SizedBox(
                height: 24.0,
              ),
              (vehicle?.services != null &&
                      vehicle?.services.indexWhere((element) => element.serviceType == 'TAG') != null)
                  ? SizedBox(
                      width: 350,
                      child: Text(
                        getVehicleService(vehicle, 'TAG')?.balanceType == "VEHICLE_LEVEL_BALANCE"
                            ? "Are you sure you want to switch the balance type from Vehicle level balance to Customer level balance?"
                            : "Are you sure you want to switch the balance type from Customer level balance to Vehicle level balance?",
                        style: AxleTextStyle.subtitle2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(
                      width: 400,
                      height: 35,
                    ),
            ],
          ),
          titlePadding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: 24),
          content: Form(
            key: formKey,
            child: getVehicleService(vehicle, 'TAG')?.balanceType == "VEHICLE_LEVEL_BALANCE"
                ? const SizedBox(
                    width: 400,
                    height: 8,
                  )
                : AxleFormTextField(
                    autofocus: true,
                    textType: TextInputType.number,
                    fieldController: controller,
                    fieldHint: "Enter Threshold Limit",
                    fieldHeading: "Threshold Limit - Vehicle",
                    isOnlyDigits: true,
                    lengthLimit: 8,
                    fieldAction: TextInputAction.done,
                    onSubmit: (_) {
                      onChangeSwitchBalanceToVehicle(
                        formKey.currentState!.validate(),
                        message,
                        controller,
                        context,
                      );
                    },
                    validate: Validators("Threshold Limit").required().max(6),
                  ),
          ),
          contentPadding: getVehicleService(vehicle, 'TAG')?.balanceType == "VEHICLE_LEVEL_BALANCE"
              ? const EdgeInsets.symmetric(vertical: 8, horizontal: 56)
              : const EdgeInsets.symmetric(vertical: 40, horizontal: 56),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            AxleOutlineButton(
              buttonWidth: isMobile ? availableWidth * 35 / 100 : 200,
              buttonText: "Cancel",
              onPress: () => Navigator.of(context).pop(),
            ),
            AxlePrimaryButton(
              buttonWidth: isMobile ? availableWidth * 35 / 100 : 200,
              buttonText: "Update",
              onPress: () {
                bool isValidated = formKey.currentState!.validate();

                if (vehicle?.services != null &&
                    vehicle?.services.indexWhere((element) => element.serviceType == 'TAG') != null) {
                  getVehicleService(vehicle, 'TAG')?.balanceType == "VEHICLE_LEVEL_BALANCE"
                      ? onChangeSwitchBalanceToCustomer(
                          message,
                          context,
                        )
                      : onChangeSwitchBalanceToVehicle(
                          isValidated,
                          message,
                          controller,
                          context,
                        );
                }
              },
              buttonColor: AxleColors.axleBlueColor,
            )
          ],
          actionsPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
        );
      },
    );
  }

  onChangeSwitchBalanceToVehicle(
    bool isValidated,
    Messagee? message,
    TextEditingController controller,
    BuildContext context,
  ) async {
    if (isValidated == true) {
      int value = int.parse(controller.text);
      if (value > 0) {
        AxleLoader.show(context);
        bool result = await ref.read(vehicleControllerProvider).switchVehicleBalanceType(
              orgId: message != null ? message.organizationId ?? "" : '',
              vehicleRegNo: message != null ? message.entityId ?? "" : '',
              balanceType: "VEHICLE_LEVEL_BALANCE",
              thresLimit: int.parse(controller.text),
            );

        if (result) {
          Navigator.of(context).pop();
          vehicleAccInfoFuture = getVehicleAccountInfo();
          vehicleDetailFuture = getVehicleDetail();
          setState(() {});
          Snackbar.success("Updated Successfully");
          AxleLoader.hide();
        }
      } else {
        Snackbar.error("Should be greater than 0 ");
      }
    }
  }

  onChangeSwitchBalanceToCustomer(
    Messagee? message,
    BuildContext context,
  ) async {
    AxleLoader.show(context);
    bool result = await ref.read(vehicleControllerProvider).switchVehicleBalanceType(
          orgId: message != null ? message.organizationId ?? "" : '',
          vehicleRegNo: message != null ? message.entityId ?? "" : '',
          balanceType: "CUSTOMER_LEVEL_BALANCE",
          thresLimit: null,
        );
    if (result) {
      Navigator.of(context).pop();
      vehicleAccInfoFuture = getVehicleAccountInfo();
      vehicleDetailFuture = getVehicleDetail();
      setState(() {});
      Snackbar.success("Updated Successfully");
      AxleLoader.hide();
    }
  }

  showThresholdLimitDialog(
    BuildContext context, {
    required String orgId,
    required vehicleRegNo,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        GlobalKey<FormState> formKey = GlobalKey<FormState>();
        TextEditingController control = TextEditingController();
        return AlertDialog(
          title: Center(
            child: Text(
              "Edit Threshold Limit",
              style: AxleTextStyle.headline6BlackStyle,
            ),
          ),
          titlePadding: const EdgeInsets.symmetric(
            vertical: defaultPadding,
          ),
          content: Form(
            key: formKey,
            child: AxleFormTextField(
              fieldController: control,
              autofocus: true,
              fieldHint: "Enter Threshold Limit",
              fieldHeading: "Threshold Limit - Vehicle",
              lengthLimit: 6,
              isOnlyDigits: true,
              textType: TextInputType.number,
              fieldAction: TextInputAction.done,
              validate: Validators("Threshold Limit").required().max(6),
              onSubmit: (_) async {
                if (formKey.currentState!.validate()) {
                  AxleLoader.show(context);
                  bool res = await ref.read(vehicleControllerProvider).updateVehicleThresholdLimit(
                        orgId: orgId,
                        vehicleRegNo: vehicleRegNo,
                        threshold: int.parse(control.text),
                      );
                  AxleLoader.hide();
                  if (res) {
                    Navigator.of(context).pop(true);
                    vehicleAccInfoFuture = getVehicleAccountInfo();
                    vehicleDetailFuture = getVehicleDetail();
                    Snackbar.success("Updated Successfully");
                    setState(() {});
                  }
                }
              },
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 56),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            AxleOutlineButton(
              buttonWidth: isMobile ? availableWidth * 35 / 100 : 200,
              buttonText: "Cancel",
              onPress: () => Navigator.of(context).pop(),
            ),
            AxlePrimaryButton(
              buttonWidth: isMobile ? availableWidth * 35 / 100 : 200,
              buttonText: "Update",
              onPress: () async {
                if (formKey.currentState!.validate()) {
                  AxleLoader.show(context);
                  bool res = await ref.read(vehicleControllerProvider).updateVehicleThresholdLimit(
                        orgId: orgId,
                        vehicleRegNo: vehicleRegNo,
                        threshold: int.parse(control.text),
                      );
                  AxleLoader.hide();
                  if (res) {
                    Navigator.of(context).pop(true);
                    vehicleAccInfoFuture = getVehicleAccountInfo();
                    Snackbar.success("Updated Successfully");
                    setState(() {});
                  }
                }
              },
              buttonColor: AxleColors.axleBlueColor,
            )
          ],
          actionsPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
        );
      },
    );
  }
}
