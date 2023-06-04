import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/app_router.gr.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/domain/fuel_limit_response_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/fuel_limit_set_input_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/card_service_toggle_widget.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

@RoutePage()
class SetLogisticsFuelPreferencePage extends ConsumerStatefulWidget {
  const SetLogisticsFuelPreferencePage({
    super.key,
    @PathParam('custId') required this.orgEnrollId,
  });

  final String orgEnrollId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetLogisticsFuelPreferencePageState();
}

class _SetLogisticsFuelPreferencePageState extends ConsumerState<SetLogisticsFuelPreferencePage> {
  final TextEditingController fuelDailyLimitController = TextEditingController();
  final TextEditingController fuelMonthlyLimitController = TextEditingController();
  final TextEditingController fuelQuarterlyLimitController = TextEditingController();
  final TextEditingController fuelHalfYearlyLimitController = TextEditingController();
  final TextEditingController fuelYearlyLimitController = TextEditingController();
  final TextEditingController fuelDailyTransactionCountController = TextEditingController();
  final TextEditingController fuelMonthlyTransactionCountController = TextEditingController();
  final TextEditingController fuelQuarterlyTransactionCountController = TextEditingController();
  final TextEditingController fuelHalfYearlyTransactionCountController = TextEditingController();

  final TextEditingController walletDailyLimitController = TextEditingController();
  final TextEditingController walletMonthlyLimitController = TextEditingController();
  final TextEditingController walletQuarterlyLimitController = TextEditingController();
  final TextEditingController walletHalfYearlyLimitController = TextEditingController();
  final TextEditingController walletYearlyLimitController = TextEditingController();
  final TextEditingController walletDailyTransactionCountController = TextEditingController();
  final TextEditingController walletMonthlyTransactionCountController = TextEditingController();
  final TextEditingController walletQuarterlyTransactionCountController = TextEditingController();
  final TextEditingController walletHalfYearlyTransactionCountController = TextEditingController();
  late String orgEnrollId;

  bool isdailyLimitEnabled = false;
  bool ismonthlyLimitEnabled = false;
  bool isquarterlyLimitEnabled = false;
  bool ishalyYearlyLimitEnabled = false;
  bool isyearlyLimitEnabled = false;
  bool isdailyTransactionCountEnabled = false;
  bool ismonthlyTransactionCountEnabled = false;
  bool isquarterlyTransactionCountEnabled = false;
  bool ishalfYearlyTransactionCountEnabled = false;

  String fuelDailyLimit = '0';
  String fuelMonthlyLimit = '0';
  String fuelQuarterlyLimit = '0';
  String fuelHalyYearlyLimit = '0';
  String fuelYearlyLimit = '0';
  String fuelDailyTransactionCount = '0';
  String fuelMonthlyTransactionCount = '0';
  String fuelQuarterlyTransactionCount = '0';
  String fuelHalfYearlyTransactionCount = '0';

  String walletDailyLimit = '0';
  String walletMonthlyLimit = '0';
  String walletQuarterlyLimit = '0';
  String walletHalyYearlyLimit = '0';
  String walletYearlyLimit = '0';
  String walletDailyTransactionCount = '0';
  String walletMonthlyTransactionCount = '0';
  String walletQuarterlyTransactionCount = '0';
  String walletHalfYearlyTransactionCount = '0';

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;

  @override
  void initState() {
    Future(
      () async {
        orgEnrollId =
            ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId)?.toLowerCase() ?? '';
        getLogisticsFuelLimit();
      },
    );
    super.initState();
  }

  bool isMobile = false;
  OrgDoc? org;
  OrganizationService? orgServiceFuel;
  FuelLimitResponseModel? limitResponse;

  getLogisticsFuelLimit() async {
    await ref
        .read(logisticsControllerProvider)
        .getOrganisationByEnrolmentId(enrolId: widget.orgEnrollId.toUpperCase(), isSetOrgDetailProvider: true);
    org = ref.watch(orgDetailsProvider);
    orgServiceFuel = getOrgService(org, 'FUEL', issuerName: 'HPCL');

    limitResponse = await ref.read(logisticsControllerProvider).getFuelLimitByEntityType(
          entityId: orgServiceFuel?.organizationEntityId ?? '',
          entityType: 'ORGANIZATION',
          orgEnrollId: widget.orgEnrollId,
          issuerName: 'HPCL',
        );

    if (limitResponse?.data != null) {
      fuelDailyLimitController.text = limitResponse!.data!.message?.fuelLimits?.daily.toString() ?? '';
      fuelDailyLimit = limitResponse!.data!.message?.fuelLimits?.daily.toString() ?? '';
      fuelMonthlyLimitController.text = limitResponse!.data!.message?.fuelLimits?.monthly.toString() ?? '';
      fuelMonthlyLimit = limitResponse!.data!.message?.fuelLimits?.monthly.toString() ?? '';
      fuelQuarterlyLimitController.text = limitResponse!.data!.message?.fuelLimits?.quarterly.toString() ?? '';
      fuelQuarterlyLimit = limitResponse!.data!.message?.fuelLimits?.quarterly.toString() ?? '';
      fuelHalfYearlyLimitController.text = limitResponse!.data!.message?.fuelLimits?.halfYearly.toString() ?? '';
      fuelHalyYearlyLimit = limitResponse!.data!.message?.fuelLimits?.halfYearly.toString() ?? '';
      fuelYearlyLimitController.text = limitResponse!.data!.message?.fuelLimits?.yearly.toString() ?? '';
      fuelYearlyLimit = limitResponse!.data!.message?.fuelLimits?.yearly.toString() ?? '';

      fuelDailyTransactionCountController.text =
          limitResponse!.data!.message?.fuelLimits?.dailyTransactionCount.toString() ?? '';
      fuelDailyTransactionCount = limitResponse!.data!.message?.fuelLimits?.dailyTransactionCount.toString() ?? '';
      fuelMonthlyTransactionCountController.text =
          limitResponse!.data!.message?.fuelLimits?.monthlyTransactionCount.toString() ?? '';
      fuelMonthlyTransactionCount = limitResponse!.data!.message?.fuelLimits?.monthlyTransactionCount.toString() ?? '';
      fuelQuarterlyTransactionCountController.text =
          limitResponse!.data!.message?.fuelLimits?.quarterlyTransactionCount.toString() ?? '';
      fuelQuarterlyTransactionCount =
          limitResponse!.data!.message?.fuelLimits?.quarterlyTransactionCount.toString() ?? '';
      fuelHalfYearlyTransactionCountController.text =
          limitResponse!.data!.message?.fuelLimits?.halfYearlyTransactionCount.toString() ?? '';
      fuelHalfYearlyTransactionCount =
          limitResponse!.data!.message?.fuelLimits?.halfYearlyTransactionCount.toString() ?? '';

      walletDailyLimitController.text = limitResponse!.data!.message?.walletLimit?.daily.toString() ?? '';
      walletMonthlyLimitController.text = limitResponse!.data!.message?.walletLimit?.monthly.toString() ?? '';
      walletQuarterlyLimitController.text = limitResponse!.data!.message?.walletLimit?.quarterly.toString() ?? '';
      walletHalfYearlyLimitController.text = limitResponse!.data!.message?.walletLimit?.halfYearly.toString() ?? '';
      walletYearlyLimitController.text = limitResponse!.data!.message?.walletLimit?.yearly.toString() ?? '';

      walletDailyTransactionCountController.text =
          limitResponse!.data!.message?.walletLimit?.dailyTransactionCount.toString() ?? '';
      walletMonthlyTransactionCountController.text =
          limitResponse!.data!.message?.walletLimit?.monthlyTransactionCount.toString() ?? '';
      walletQuarterlyTransactionCountController.text =
          limitResponse!.data!.message?.walletLimit?.quarterlyTransactionCount.toString() ?? '';
      walletHalfYearlyTransactionCountController.text =
          limitResponse!.data!.message?.walletLimit?.halfYearlyTransactionCount.toString() ?? '';

      isdailyLimitEnabled = isOpen(
          fuel: limitResponse?.data?.message?.fuelLimits?.daily,
          wallet: limitResponse?.data?.message?.walletLimit?.daily);
      ismonthlyLimitEnabled = isOpen(
          fuel: limitResponse?.data?.message?.fuelLimits?.monthly,
          wallet: limitResponse?.data?.message?.walletLimit?.monthly);
      isquarterlyLimitEnabled = isOpen(
          fuel: limitResponse?.data?.message?.fuelLimits?.quarterly,
          wallet: limitResponse?.data?.message?.walletLimit?.quarterly);
      ishalyYearlyLimitEnabled = isOpen(
          fuel: limitResponse?.data?.message?.fuelLimits?.halfYearly,
          wallet: limitResponse?.data?.message?.walletLimit?.halfYearly);
      isyearlyLimitEnabled = isOpen(
          fuel: limitResponse?.data?.message?.fuelLimits?.yearly,
          wallet: limitResponse?.data?.message?.walletLimit?.yearly);

      isdailyTransactionCountEnabled = isOpen(
          fuel: limitResponse?.data?.message?.fuelLimits?.dailyTransactionCount,
          wallet: limitResponse?.data?.message?.walletLimit?.dailyTransactionCount);
      ismonthlyTransactionCountEnabled = isOpen(
          fuel: limitResponse?.data?.message?.fuelLimits?.monthlyTransactionCount,
          wallet: limitResponse?.data?.message?.walletLimit?.monthlyTransactionCount);
      isquarterlyTransactionCountEnabled = isOpen(
          fuel: limitResponse?.data?.message?.fuelLimits?.quarterlyTransactionCount,
          wallet: limitResponse?.data?.message?.walletLimit?.quarterlyTransactionCount);
      ishalfYearlyTransactionCountEnabled = isOpen(
          fuel: limitResponse?.data?.message?.fuelLimits?.halfYearlyTransactionCount,
          wallet: limitResponse?.data?.message?.walletLimit?.halfYearlyTransactionCount);

      setState(() {});
    }
  }

  bool isOpen({int? wallet, int? fuel}) {
    try {
      if ((wallet != null && wallet > 0) || (fuel != null && fuel > 0)) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 4));
    isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: Container(
        margin: isMobile
            ? const EdgeInsets.all(defaultPadding)
            : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(HomeConstants.organizationFuelCardPreference, style: AxleTextStyle.titleMedium),
            const SizedBox(height: defaultPadding),
            Text(HomeConstants.transactionSettings, style: AxleTextStyle.titleSmall),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: availableWidth * 40 / 100,
                            child: CardServiceToggleWidget(
                              key: UniqueKey(),
                              enableSecondaryCard: false,
                              title: 'Daily',
                              // buttonValue: isdailyLimitEnabled,
                              defaultCardTitle: "Set Fuel Limit For Organization",
                              secondaryCardTitle: "Set Wallet Limit For Organization",
                              defaultLimitController: fuelDailyLimitController,
                              secondaryLimitController: walletDailyLimitController,
                              defaultMaxLimitAmount: 1000000.0,
                              secondaryMaxLimitAmount: 500.0,
                              defaultCurrentLimit: fuelDailyLimit,
                              secondaryCurrentLimit: walletDailyLimit,
                              onChange: (val) async {
                                setState(() => isdailyLimitEnabled = !isdailyLimitEnabled);
                              },
                            ),
                          ),
                          // const SizedBox(height: defaultPadding),
                          // SizedBox(
                          //   width: availableWidth * 40 / 100,
                          //   child: CardServiceToggleWidget(
                          //     key: UniqueKey(),
                          //     enableSecondaryCard: true,
                          //     title: 'Monthly',
                          //     buttonValue: ismonthlyLimitEnabled,
                          //     defaultCardTitle: "Set Wallet Limit For Organization",
                          //     secondaryCardTitle: "Set Fuel Limit For Organization",
                          //     defaultLimitController: walletMonthlyLimitController,
                          //     secondaryLimitController: fuelMonthlyLimitController,
                          //     defaultMaxLimitAmount: 10000.0,
                          //     secondaryMaxLimitAmount: 500.0,
                          //     defaultCurrentLimit: walletMonthlyLimit,
                          //     secondaryCurrentLimit: fuelMonthlyLimit,
                          //     onChange: (val) async {
                          //       setState(() {
                          //         ismonthlyLimitEnabled = !ismonthlyLimitEnabled;
                          //       });
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(height: defaultPadding),
                          // SizedBox(
                          //   width: availableWidth * 40 / 100,
                          //   child: CardServiceToggleWidget(
                          //     key: UniqueKey(),
                          //     enableSecondaryCard: true,
                          //     title: 'Quarterly',
                          //     buttonValue: isquarterlyLimitEnabled,
                          //     defaultCardTitle: "Set Wallet Limit For Organization",
                          //     secondaryCardTitle: "Set Fuel Limit For Organization",
                          //     defaultLimitController: walletQuarterlyLimitController,
                          //     secondaryLimitController: fuelQuarterlyLimitController,
                          //     defaultMaxLimitAmount: 10000.0,
                          //     secondaryMaxLimitAmount: 500.0,
                          //     defaultCurrentLimit: walletQuarterlyLimit,
                          //     secondaryCurrentLimit: fuelQuarterlyLimit,

                          //     // buttonValue: res?.data.message.ecom ?? false,
                          //     onChange: (val) async {
                          //       setState(() => isquarterlyLimitEnabled = !isquarterlyLimitEnabled);
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(height: defaultPadding),
                          // SizedBox(
                          //   width: availableWidth * 40 / 100,
                          //   child: CardServiceToggleWidget(
                          //     key: UniqueKey(),
                          //     enableSecondaryCard: true,
                          //     title: 'Haly-Yearly',
                          //     buttonValue: ishalyYearlyLimitEnabled,
                          //     defaultCardTitle: "Set Wallet Limit For Organization",
                          //     secondaryCardTitle: "Set Fuel Limit For Organization",
                          //     defaultLimitController: walletHalfYearlyLimitController,
                          //     secondaryLimitController: fuelHalfYearlyLimitController,
                          //     defaultMaxLimitAmount: 10000.0,
                          //     secondaryMaxLimitAmount: 500.0,
                          //     defaultCurrentLimit: walletHalyYearlyLimit,
                          //     secondaryCurrentLimit: fuelHalyYearlyLimit,

                          //     // buttonValue: res?.data.message.ecom ?? false,
                          //     onChange: (val) async {
                          //       setState(() => ishalyYearlyLimitEnabled = !ishalyYearlyLimitEnabled);
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(height: defaultPadding),
                          // SizedBox(
                          //   width: availableWidth * 40 / 100,
                          //   child: CardServiceToggleWidget(
                          //     key: UniqueKey(),
                          //     enableSecondaryCard: true,
                          //     title: 'Yearly',
                          //     buttonValue: isyearlyLimitEnabled,
                          //     defaultCardTitle: "Set Wallet Limit For Organization",
                          //     secondaryCardTitle: "Set Fuel Limit For Organization",
                          //     defaultLimitController: walletYearlyLimitController,
                          //     secondaryLimitController: fuelYearlyLimitController,
                          //     defaultMaxLimitAmount: 10000.0,
                          //     secondaryMaxLimitAmount: 500.0,
                          //     defaultCurrentLimit: walletYearlyLimit,
                          //     secondaryCurrentLimit: fuelYearlyLimit,

                          //     // buttonValue: res?.data.message.ecom ?? false,
                          //     onChange: (val) async {
                          //       setState(() => isyearlyLimitEnabled = !isyearlyLimitEnabled);
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(height: defaultPadding),
                        ],
                      ),
                      // const SizedBox(width: verticalPadding),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     SizedBox(
                      //       width: availableWidth * 40 / 100,
                      //       child: CardCountToggleWidget(
                      //         key: UniqueKey(),
                      //         enableSecondaryCard: true,
                      //         title: 'Daily Transaction Count',
                      //         buttonValue: isdailyTransactionCountEnabled,
                      //         defaultCardTitle: "Set Wallet Count For Organization",
                      //         secondaryCardTitle: "Set Fuel Count For Organization",
                      //         defaultLimitController: walletDailyTransactionCountController,
                      //         secondaryLimitController: fuelDailyTransactionCountController,
                      //         defaultMaxLimitAmount: 100.0,
                      //         secondaryMaxLimitAmount: 100.0,
                      //         defaultCurrentLimit: walletDailyTransactionCount,
                      //         secondaryCurrentLimit: fuelDailyTransactionCount,

                      //         // buttonValue: res?.data.message.ecom ?? false,
                      //         onChange: (val) async {
                      //           setState(() => isdailyTransactionCountEnabled = !isdailyTransactionCountEnabled);
                      //         },
                      //       ),
                      //     ),
                      //     const SizedBox(height: defaultPadding),
                      //     SizedBox(
                      //       width: availableWidth * 40 / 100,
                      //       child: CardCountToggleWidget(
                      //         key: UniqueKey(),
                      //         enableSecondaryCard: true,
                      //         title: 'Monthly Transaction Count',
                      //         buttonValue: ismonthlyTransactionCountEnabled,
                      //         defaultCardTitle: "Set Wallet Count For Organization",
                      //         secondaryCardTitle: "Set Fuel Count For Organization",
                      //         defaultLimitController: walletMonthlyTransactionCountController,
                      //         secondaryLimitController: fuelMonthlyTransactionCountController,
                      //         defaultMaxLimitAmount: 100.0,
                      //         secondaryMaxLimitAmount: 100.0,
                      //         defaultCurrentLimit: walletMonthlyTransactionCount,
                      //         secondaryCurrentLimit: fuelMonthlyTransactionCount,

                      //         // buttonValue: res?.data.message.ecom ?? false,
                      //         onChange: (val) async {
                      //           setState(() => ismonthlyTransactionCountEnabled = !ismonthlyTransactionCountEnabled);
                      //         },
                      //       ),
                      //     ),
                      //     const SizedBox(height: defaultPadding),
                      //     SizedBox(
                      //       width: availableWidth * 40 / 100,
                      //       child: CardCountToggleWidget(
                      //         key: UniqueKey(),
                      //         enableSecondaryCard: true,
                      //         title: 'Quarterly Transaction Count',
                      //         buttonValue: isquarterlyTransactionCountEnabled,
                      //         defaultCardTitle: "Set Wallet Count For Organization",
                      //         secondaryCardTitle: "Set Fuel Count For Organization",
                      //         defaultLimitController: walletQuarterlyTransactionCountController,
                      //         secondaryLimitController: fuelQuarterlyTransactionCountController,
                      //         defaultMaxLimitAmount: 100.0,
                      //         secondaryMaxLimitAmount: 100.0,
                      //         defaultCurrentLimit: walletQuarterlyTransactionCount,
                      //         secondaryCurrentLimit: fuelQuarterlyTransactionCount,

                      //         // buttonValue: res?.data.message.ecom ?? false,
                      //         onChange: (val) async {
                      //           setState(
                      //               () => isquarterlyTransactionCountEnabled = !isquarterlyTransactionCountEnabled);
                      //         },
                      //       ),
                      //     ),
                      //     const SizedBox(height: defaultPadding),
                      //     SizedBox(
                      //       width: availableWidth * 40 / 100,
                      //       child: CardCountToggleWidget(
                      //         key: UniqueKey(),
                      //         enableSecondaryCard: true,
                      //         title: 'Half-Yearly Transaction Count',
                      //         buttonValue: ishalfYearlyTransactionCountEnabled,
                      //         defaultCardTitle: "Set Wallet Count For Organization",
                      //         secondaryCardTitle: "Set Fuel Count For Organization",
                      //         defaultLimitController: walletHalfYearlyTransactionCountController,
                      //         secondaryLimitController: fuelHalfYearlyTransactionCountController,
                      //         defaultMaxLimitAmount: 100.0,
                      //         secondaryMaxLimitAmount: 100.0,
                      //         defaultCurrentLimit: walletHalfYearlyTransactionCount,
                      //         secondaryCurrentLimit: fuelHalfYearlyTransactionCount,

                      //         // buttonValue: res?.data.message.ecom ?? false,
                      //         onChange: (val) async {
                      //           setState(
                      //               () => ishalfYearlyTransactionCountEnabled = !ishalfYearlyTransactionCountEnabled);
                      //         },
                      //       ),
                      //     ),
                      //     const SizedBox(height: defaultPadding),
                      //   ],
                      // )
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AxlePrimaryButton(
                      buttonText: "Apply",
                      onPress: () async {
                        AxleLoader.show(context);
                        bool res =
                            await ref.read(logisticsControllerProvider).setLogisticsFuelLimit(formInput: getInputs());
                        AxleLoader.hide();
                        if (res && mounted) {
                          final orgEnrollId = ref
                                  .read(sharedPreferenceProvider)
                                  .getString(Storage.currentlyPickedOrgEnrollId)
                                  ?.toLowerCase() ??
                              '';
                          context.router.navigate(LogisticsOrganisationByEnrolmentId(enrolId: orgEnrollId)
                              // '/app/$orgEnrollId/customers'
                              );
                        }
                        // await fetchUserCardPreference();
                      }),
                  const SizedBox(width: 30),
                  AxleOutlineButton(
                    buttonText: "Cancel",
                    onPress: () {
                      context.router.navigate(LogisticsOrganisationByEnrolmentId(enrolId: orgEnrollId)
                          // '/app/$orgEnrollId/customers'
                          );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FuelSetInputModel getInputs() {
    return FuelSetInputModel(
      organizationEnrollmentId: widget.orgEnrollId,
      issuerName: 'HPCL',
      fuelLimit: Limit(
        daily: int.parse(fuelDailyLimitController.text).round(),
        // monthly: int.parse(fuelMonthlyLimitController.text).round(),
        // quarterly: int.parse(fuelQuarterlyLimitController.text).round(),
        // halfYearly: int.parse(fuelHalfYearlyLimitController.text).round(),
        // yearly: int.parse(fuelYearlyLimitController.text).round(),
        // dailyTransactionCount: int.parse(fuelDailyTransactionCountController.text).round(),
        // monthlyTransactionCount: int.parse(fuelMonthlyTransactionCountController.text).round(),
        // quarterlyTransactionCount: int.parse(fuelQuarterlyTransactionCountController.text).round(),
        // halfYearlyTransactionCount: int.parse(fuelHalfYearlyTransactionCountController.text).round(),
        // baseLimit: int.parse(fuelDailyLimitController.text).round(),
      ),
      // walletLimit: Limit(
      //   daily: int.parse(walletDailyLimitController.text).round(),
      //   monthly: int.parse(walletMonthlyLimitController.text).round(),
      //   quarterly: int.parse(walletQuarterlyLimitController.text).round(),
      //   halfYearly: int.parse(walletHalfYearlyLimitController.text).round(),
      //   yearly: int.parse(walletYearlyLimitController.text).round(),
      //   dailyTransactionCount: int.parse(walletDailyTransactionCountController.text).round(),
      //   monthlyTransactionCount: int.parse(walletMonthlyTransactionCountController.text).round(),
      //   quarterlyTransactionCount: int.parse(walletQuarterlyTransactionCountController.text).round(),
      //   halfYearlyTransactionCount: int.parse(walletHalfYearlyTransactionCountController.text).round(),
      // ),
    );
  }
}
