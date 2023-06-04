import 'dart:developer';

import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/ui_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/web_view/web_view_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/typedefs/typedefs.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/user/domain/fetch_balance_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/fund_load_dialog.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PpiCard extends ConsumerStatefulWidget {
  const PpiCard({
    required this.org,
    required this.user,
    required this.entityId,
    this.isDash = false,
    required this.userEnrolData,
    super.key,
  });

  final OrgDoc org;
  final UpdatedMessageUser? user;
  final String? entityId;
  final bool isDash;
  final UpdatedUserByEnrolmentIdModel userEnrolData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PpiCardState();
}

class _PpiCardState extends ConsumerState<PpiCard> {
  late FetchBalanceResponseModel? userFundData;
  late FetchBalanceResponseModel? userOrgFundData;
  late OrgType orgType;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  String userEntityId = '';
  late final String userEnrollId = widget.user?.enrollmentId ?? '';
  late final String userName = widget.user?.name ?? '';
  late final String userOrgName = widget.org.displayName;
  // late final String userOrgEntityId = org.entityId;
  late final OrganizationID orgId = widget.org.id;
  bool isFullKycCompleted = false;
  double maxLimit = minKycLimitPpi;

  @override
  void initState() {
    orgType = ref.read(localStorageProvider).getOrgType();
    UserService? userService;

    if (widget.isDash) {
      // userEntityId = ref.read(sharedPreferenceProvider).getString(Storage.selectedUserEntityId) ?? '';
      log('userEntityId from dash $userEntityId');
      userService = getLqPpiServiceFromOrgList(loggedInUserByEnrollmentIdStateProvider);
      userEntityId = userService?.userEntityId ?? '';
    } else {
      userEntityId = widget.entityId ?? '';
      userService = getLqPpiServiceFromOrgList(updateduserDetailsByEnrollmentIdStateProvider);
    }

    isFullKycCompleted = userService?.kycType.contains('FULL_KYC') ?? false;

    maxLimit = isFullKycCompleted ? fullKycLimitPpi : minKycLimitPpi;

    Future(
      () {
        getUserBalanceDetails();
      },
    );
    super.initState();
  }

  UserService? getLqPpiServiceFromOrgList(
      StateProvider<UpdatedUserByEnrolmentIdModel?> updateduserDetailsByEnrollmentIdStateProvider) {
    UserService? result;
    try {
      for (OrganizationUpdated e
          in ref.read(updateduserDetailsByEnrollmentIdStateProvider)?.data?.message?.organizations ?? []) {
        result = getOrgServiceFromUserEnrollId(e, "PPI", issuerName: "LIVQUIK");
        if (result != null) {
          break;
        }
      }
    } catch (e) {
      return result;
    }
    // log('The Result Entity ID is -> $result');
    return result;
  }

  Future<void> getUserBalanceDetails() async {
    if (userEntityId.isNotEmpty) {
      ref.read(userBalanceProvider.notifier).state =
          await ref.read(userControllerProvider).fetchUserBalance(entityId: userEntityId);
    } else {
      ref.read(userBalanceProvider.notifier).state = FetchBalanceResponseModel.unknown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userBalance = ref.watch(userBalanceProvider);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2 + defaultPadding);

    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    return Container(
        constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 350),
        height: isMobile ? null : 300,
        width: isMobile ? availableWidth : availableWidth * 35 / 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.blue.shade600),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Positioned(bottom: -10, right: -10, child: Image.asset("assets/new_assets/images/purse.png", width: 200)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(HomeConstants.cardBalance,
                              style: AxleTextStyle.titleMedium.copyWith(color: Colors.white)),
                          // ref.read(sharedPreferenceProvider).getString(Storage.userEnrollmentId) ==
                          //         widget.user!.enrollmentId
                          // ? const SizedBox()
                          // : orgType == OrgType.logisticsAdmin
                          isFullKycCompleted
                              ? AxlePrimaryButton(
                                  buttonText: 'KYC Completed',
                                  buttonTextStyle: AxleTextStyle.bodySmall.copyWith(color: Colors.white),
                                  buttonColor: AxleColors.axleGreenColor,
                                  buttonHeight: 30.0,
                                  onPress: () {},
                                )
                              : OutlinedButton(
                                  onPressed: () async {
                                    AxleLoader.show(context);
                                    String? link = await ref
                                        .read(userControllerProvider)
                                        .getVKycLink(userEntityId: userEntityId, orgId: orgId);
                                    AxleLoader.hide();
                                    if (link != null && mounted) {
                                      _launchUrl(Uri.parse(link));
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(width: 1.2, color: Colors.white),
                                  ),
                                  child: const Text(
                                    'Complete V-KYC',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                )
                          // : const SizedBox(),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(6.0),
                          //     border: Border.all(
                          //       width: 1.6,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          //   child: const Text(
                          //     'Complete V-KYC',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 14.0,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      const SizedBox(height: 20.0),

                      // ? AxleLoader.axleProgressIndicator(height: 50.0, width: 50.0)
                      (userBalance == null || userBalance.data == null)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '--',
                                  // ,
                                  style: AxleTextStyle.ppiCardBalance,
                                ),
                              ],
                            )
                          : getBalanceAmountFromResponse(
                              userBalance.data!.message,
                            ),
                      //  ref.watch(fetchBalanceProvider(userEntityId)).when(
                      //       data: (balance) {
                      //         if (balance != null) {
                      //           final msg = balance.data!.message;
                      //           setState(() {
                      //             // avlBalance = double.parse(msg.result[0].balance);
                      //           });
                      //           double availableBalance = 0.0;
                      //           if (msg.result.isNotEmpty) {
                      //             try {
                      //               availableBalance = double.parse(msg.result[0].balance);
                      //             } catch (e) {
                      //             }
                      //           }
                      //           return Row(
                      //             crossAxisAlignment: CrossAxisAlignment.end,
                      //             children: [
                      //               Text(
                      //                   msg.result.isNotEmpty
                      //                       ? axleCurrencyFormatterwithDecimals.format(availableBalance)
                      //                       : 'N/A',
                      //                   // ,
                      //                   style: AxleTextStyle.ppiCardBalance),
                      //               Text(
                      //                 "Available",
                      //                 style: AxleTextStyle.pieChartText,
                      //               )
                      //             ],
                      //           );
                      //         } else {
                      //           return Row(
                      //             crossAxisAlignment: CrossAxisAlignment.end,
                      //             children: [
                      //               Text(
                      //                 '-',
                      //                 style: AxleTextStyle.ppiCardBalance,
                      //               ),
                      //             ],
                      //           );
                      //         }
                      //       },
                      //       error: (error, stackTrace) {
                      //         return const Text('Error');
                      //       },
                      //       loading: () => AxleLoader.axleProgressIndicator(height: 50.0, width: 50.0),
                      //     ),
                      const SizedBox(height: 10.0),
                      widget.isDash
                          ? const SizedBox()
                          : SizedBox(
                              width: 200,
                              child: Column(
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text(
                                      "Limit",
                                      style: AxleTextStyle.pieChartText,
                                    ),
                                    Text(
                                      axleCurrencyFormatter.format(maxLimit).toString(),
                                      style: AxleTextStyle.pieChartText,
                                    )
                                  ]),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  if (userBalance != null &&
                                      userBalance.data != null &&
                                      userBalance.data!.message.result.isNotEmpty)
                                    LinearProgressIndicator(
                                      value:
                                          double.parse(userBalance.data?.message.result[0].balance ?? '0') / maxLimit,
                                      color: sideMenuBgColor,
                                      backgroundColor: Colors.white.withOpacity(0.19),
                                      minHeight: 7,
                                    )
                                ],
                              ),
                            ),

                      const SizedBox(
                        height: defaultPadding,
                      ),
                      // * Add Money Button
                      widget.isDash
                          ? const SizedBox()
                          : orgType == OrgType.logisticsAdmin || orgType == OrgType.axlerate
                              ? Align(
                                  alignment: Alignment.bottomLeft,
                                  child: GestureDetector(
                                    onTap: () async {
                                      AxleLoader.show(context);
                                      await getFundLoadData();
                                      AxleLoader.hide();
                                      fundLoadDialog();
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.0),
                                            color: AxleColors.axleWhiteColor),
                                        width: isMobile ? availableWidth / 2 : 200,
                                        child: Text('Add Money',
                                            textAlign: TextAlign.center,
                                            style: AxleTextStyle.bodyMedium.copyWith(color: AxleColors.axleBlueColor)),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget getBalanceAmountFromResponse(FetchUSerBalanceMessage msg) {
    double availabelAmount = msg.result.isNotEmpty ? double.parse(msg.result[0].balance) : 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(msg.result.isNotEmpty ? axleCurrencyFormatterwithDecimals.format(availabelAmount) : 'N/A',
            style: AxleTextStyle.displaySmall.copyWith(color: Colors.white)),
        Padding(
          padding: const EdgeInsets.all(defaultMobilePadding / 2),
          child: Text("Available", style: AxleTextStyle.labelSmall.copyWith(color: Colors.white)),
        )
      ],
    );
  }

  void showVkycDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text('V-KYC', style: AxleTextStyle.subtitle1BlackBold),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
          content: SizedBox(
            height: screenHeight * 90 / 100,
            width: screenWidth * 90 / 100,
            child: WebViewManager.instance.buildUiSettings(
              context: context,
              url: url,
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(Uri link) async {
    if (!await launchUrl(link, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $link');
    }
  }

  Future<void> getFundLoadData() async {
    FetchBalanceResponseModel? userData =
        await ref.read(userControllerProvider).fetchUserBalance(entityId: userEntityId);
    FetchBalanceResponseModel? orgData = await ref
        .read(userControllerProvider)
        .fetchUserBalance(entityId: getOrgService(widget.org, 'PPI')?.organizationEntityId ?? "");
    // widget.org.services?.ppi?.issuer![0].entityId ?? "");
    userFundData = userData;
    userOrgFundData = orgData;
  }

  void fundLoadDialog() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return FundLoadDialog(
          userFundData: userFundData,
          userOrgFundData: userOrgFundData,
          orgId: orgId,
          userEntityId: userEntityId,
          userEnrollmentId: userEnrollId,
          name: userName,
        );
      },
    );
  }
}
