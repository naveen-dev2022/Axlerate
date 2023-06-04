import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/dialogs/dialog_models/card_lock_dialog_model.dart';
import 'package:axlerate/src/dialogs/lock_user_card_dialog.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/user/domain/set_user_ppi_preference_model.dart' as setuser;
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_account_info_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/card_blocked_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/card_service_toggle_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/card_service_widget.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/src/utils/web_view/web_view_manager.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ManageCardPage extends ConsumerStatefulWidget {
  const ManageCardPage({
    super.key,
    // required this.userName,
    // required this.userOrgName,
    // required this.userEntityId,
    @PathParam('custId') required this.userOrgId,
    @PathParam('staffEnrolId') required this.userEnrolmentId,
  });

  // final String userName;
  // final String userOrgName;
  // final String userEntityId;
  final String userOrgId;
  final String userEnrolmentId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ManageCardPageState();
}

class _ManageCardPageState extends ConsumerState<ManageCardPage> {
  late Future<UserAccountInfoModel?> getUserCardPreferenceFuture;
  late String userEntityId = '';
  late String orgEnrollId;

  final TextEditingController merchantLimitController = TextEditingController(text: '100');
  final TextEditingController atmLimit = TextEditingController(text: '100');
  final TextEditingController onlineLimit = TextEditingController();
  final TextEditingController contactLess = TextEditingController();
  bool isPosEnabled = false;
  bool isAtmEnabled = false;
  bool isEcomEnabled = false;
  bool isContactlessEnabled = false;

  UpdatedUserByEnrolmentIdModel? userData;
  String kycStatus = '';
  String kycType = '';
  UserService? userServices;

  @override
  void initState() {
    log("Manage Card Page");
    Future(() {
      getEntityIdFromOrgList(widget.userEnrolmentId);
    });
    super.initState();
  }

  void getEntityIdFromOrgList(String userEnrolmentId) async {
    log("message asjdhfioashif ${widget.userOrgId}");
    userData = await ref.read(userControllerProvider).getUserByEnrolmentId(
          userEnrolmentId: userEnrolmentId.toUpperCase(),
        );
    print(userData?.data?.message?.organizations.toString());
    try {
      for (OrganizationUpdated e in userData?.data?.message?.organizations ?? []) {
        // int index = -1;
        // index = e.userServices.indexWhere((element) {
        //   return element.issuerName == "LIVQUIK" && element.serviceType == "PPI";
        // });
        if (e.organizationEnrollmentId.toUpperCase() == widget.userOrgId.toUpperCase()) {
          for (UserService user in e.userServices) {
            if (user.issuerName == 'LIVQUIK' && user.serviceType == 'PPI') {
              userServices = user;
              userEntityId = userServices!.userEntityId;
              kycStatus = userServices!.kycStatus;
              kycType = userServices!.kycType;
              log('The Result Success -> $userEntityId');
              break;
            }
          }
          break;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    log('The Result Entity ID is -> $userEntityId');
    if (userEntityId.isNotEmpty) {
      fetchUserCardPreference(userEntityId);
    }
  }

  Future<void> fetchUserCardPreference(String? userEntityId) async {
    // log('I Got Called');
    ref.read(userAccountInfoStateProvider.notifier).state = null;
    if (userEntityId != null && userEntityId.isNotEmpty) {
      ref.read(userAccountInfoStateProvider.notifier).state = await ref.read(userControllerProvider).getUserAccountInfo(
            userEntityId: userEntityId,
          );
    }
    final response = ref.read(userAccountInfoStateProvider.notifier).state;
    if (response != null && response.data != null) {
      setState(() {
        isPosEnabled = response.data?.message.cardPreference.pos ?? false;
        isAtmEnabled = response.data?.message.cardPreference.atm ?? false;
        isEcomEnabled = response.data?.message.cardPreference.ecom ?? false;
        isContactlessEnabled = response.data?.message.cardPreference.contactless ?? false;
      });
      // log('Limit is ATM ===> ${response.data?.message.cardPreference?.limitConfig?.atm}');
      // log('Limit is POS ===> ${response.data?.message.cardPreference?.limitConfig?.pos}');
      // log('Limit is Ecom ===> ${response.data?.message.cardPreference?.limitConfig?.ecom}');
    }
  }

  late BuildContext pageContext;

  // UserDoc? user;
  OrgDoc? org;
  bool isMobile = false;
  double screenWidth = 0.0;
  double availableWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);

    availableWidth = screenWidth - (defaultPadding * 2);
    if (!isMobile) {
      availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2 + defaultPadding);
    }
    org = ref.watch(orgDetailsProvider);

    pageContext = context;

    final accountInfo = ref.watch(userAccountInfoStateProvider);
    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(defaultPadding),
          child: org == null || userData?.data?.message == null
              ? AxleLoader.axleProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    isMobile
                        ? Column(
                            children: [
                              Row(children: [
                                GestureDetector(
                                    onTap: () {
                                      context.router.pop();
                                    },
                                    child: Text('< Back', style: AxleTextStyle.labelLarge)),
                              ]),
                              const SizedBox(height: defaultPadding)
                            ],
                          )
                        : Column(
                            children: [
                              DashboardHeader(
                                title: HomeConstants.manageCard,
                                vehicleId: userData?.data?.message?.name,
                                orgName: org!.displayName,
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),

                    // * Card Services
                    Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: CommonStyleUtil.axleListingCardDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            HomeConstants.cardServices,
                            style: AxleTextStyle.headingPrimary.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          if (accountInfo != null && accountInfo.data?.message.status == "BLOCKED")
                            const CardBlockedWidget(),
                          if (accountInfo != null && accountInfo.data?.message.status != "BLOCKED")
                            Wrap(
                              runSpacing: defaultPadding,
                              spacing: defaultPadding,
                              children: [
                                CardServiceWidget(
                                  title: 'Generate/Reset PIN',
                                  onPress: () async {
                                    AxleLoader.show(context);
                                    String? res = await ref.read(userControllerProvider).setPinPciWidget(
                                          entityId: userEntityId,
                                          userEnrollmentId: widget.userEnrolmentId,
                                          // entityId: 'AXLEKOP1',
                                          orgId: org!.id,
                                        );
                                    AxleLoader.hide();

                                    if (res != null) {
                                      // pinChangeDialog(res);
                                      _launchUrl(Uri.parse(res));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => TestWebview(url: res),
                                      //     ));
                                    }
                                  },
                                ),

                                CardServiceWidget(
                                  title: 'Card Lock/Block',
                                  onPress: () async {
                                    AxleLoader.show(context);
                                    // WidgetsBinding.instance.addPostFrameCallback((_) async {
                                    String status = await ref
                                        .read(userControllerProvider)
                                        .getUserCardStatus(userEntityId: userEntityId, orgId: org!.id);
                                    AxleLoader.hide();

                                    if (status.isNotEmpty) {
                                      if (status == 'BLOCKED') {
                                        Snackbar.warn('Card is blocked');
                                        return;
                                      } else {
                                        bool isCardLocked = status == 'LOCKED';
                                        // ignore: use_build_context_synchronously
                                        bool? result = await displayLockCardDialog(
                                          isLocked: isCardLocked,
                                          context: context,
                                        );
                                        log(result.toString());
                                        if (result != null && mounted) {
                                          AxleLoader.show(context);
                                          await ref.read(userControllerProvider).lockUnlockCard(
                                              entityId: userEntityId,
                                              orgId: org!.id,
                                              flag: result == false
                                                  ? 'BL'
                                                  : isCardLocked
                                                      ? 'UL'
                                                      : 'L');
                                          AxleLoader.hide();
                                        }
                                      }
                                    }
                                    // });
                                  },
                                ),

                                // * No replace card feature as of 04/01/2023 (17:09)
                                // const SizedBox(height: 6.0),
                                // CardServiceWidget(
                                //   title: 'Replace Card',
                                //   onPress: () {},
                                // )
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    if (accountInfo != null && accountInfo.data?.message.status != "BLOCKED")

                      // * Transaction Settings
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: CommonStyleUtil.axleListingCardDecoration,
                        child:
                            // FutureBuilder<UserAccountInfoModel?>(
                            //   future: getUserCardPreferenceFuture,
                            //   builder: (context, snapshot) {
                            //     switch (snapshot.connectionState) {
                            //       case ConnectionState.waiting:
                            //         return AxleLoader.axleProgressIndicator(height: 50, width: 50.0);
                            //       case ConnectionState.done:
                            //       default:
                            //         if (snapshot.hasError) {
                            //           return const Text('Error Loading');
                            //         } else if (snapshot.hasData) {
                            //           final res = snapshot.data;
                            //           isAtmEnabled = res?.data?.message.cardPreference?.pos ?? false;
                            //           isContactlessEnabled = res?.data?.message.cardPreference?.pos ?? false;
                            //           isPosEnabled = res?.data?.message.cardPreference?.pos ?? false;
                            //           isEcomEnabled = res?.data?.message.cardPreference?.pos ?? false;
                            //res?.data.message.ecom ?? false;
                            // return
                            accountInfo.data == null
                                ? AxleLoader.axleProgressIndicator()
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            HomeConstants.transactionSettings,
                                            style: AxleTextStyle.headingPrimary.copyWith(fontWeight: FontWeight.w500),
                                          ),
                                          Text("(Daily Limits)", style: AxleTextStyle.bodyMedium),
                                        ],
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Wrap(
                                        spacing: defaultPadding,
                                        runSpacing: defaultPadding,
                                        children: [
                                          // * Merchant Outlet Button (POS)
                                          CardServiceToggleWidget(
                                            enableSecondaryCard: false,
                                            title: 'Merchant Outlet',
                                            //defaultCardTitle: 'Set Limit',
                                            buttonValue: isPosEnabled,
                                            defaultLimitController: merchantLimitController,
                                            defaultMaxLimitAmount:
                                                kycStatus == "VKYC_APPROVED" ? fullKycLimitPpi : minKycLimitPpi,
                                            defaultCurrentLimit:
                                                accountInfo.data?.message.cardPreference.limitConfig?.pos ?? '0',
                                            onChange: (val) async {
                                              // log(val.toString());
                                              setState(() => isPosEnabled = !isPosEnabled);
                                              // if (val == false) {
                                              //   AxleLoader.show(context);
                                              //   await ref.read(userControllerProvider).setUserCardPreference(
                                              //         entityId: widget.userEntityId,
                                              //         orgId: widget.userOrgId,
                                              //         status: val ? 'ALLOWED' : 'NOTALLOWED',
                                              //         type: 'POS',
                                              //       );
                                              //   setState(() {
                                              //     getUserCardPreferenceFuture = fetchUserCardPreference();
                                              //   });
                                              //   AxleLoader.hide();
                                              // } else {}
                                            },
                                          ),

                                          const SizedBox(height: defaultPadding),
                                          // * Online Button (ECOMM)
                                          CardServiceToggleWidget(
                                            enableSecondaryCard: false,
                                            title: 'Online',
                                            //defaultCardTitle: 'Set Limit',
                                            buttonValue: isEcomEnabled,
                                            defaultLimitController: onlineLimit,
                                            defaultMaxLimitAmount:
                                                kycStatus == "VKYC_APPROVED" ? fullKycLimitPpi : minKycLimitPpi,
                                            defaultCurrentLimit:
                                                accountInfo.data?.message.cardPreference.limitConfig?.ecom ?? '0',
                                            onChange: (val) async {
                                              setState(() => isEcomEnabled = !isEcomEnabled);

                                              // if (val == false) {
                                              //   AxleLoader.show(context);
                                              //   await ref.read(userControllerProvider).setUserCardPreference(
                                              //         entityId: widget.userEntityId,
                                              //         orgId: widget.userOrgId,
                                              //         status: val ? 'ALLOWED' : 'NOTALLOWED',
                                              //         type: 'ECOM',
                                              //       );
                                              //   setState(() {
                                              //     getUserCardPreferenceFuture = fetchUserCardPreference();
                                              //   });
                                              //   AxleLoader.hide();
                                              // }
                                            },
                                          ),
                                          const SizedBox(height: defaultPadding),
                                          // * ATM Withdrawal button (ATM)
                                          CardServiceToggleWidget(
                                            enableSecondaryCard: false,
                                            title: 'ATM Withdrawal',
                                            // defaultCardTitle: 'Set Limit',
                                            defaultLimitController: atmLimit,
                                            buttonValue: isAtmEnabled,
                                            defaultMaxLimitAmount: minKycLimitPpi, // Only 10k when Full Kyc Completed.
                                            defaultCurrentLimit:
                                                accountInfo.data?.message.cardPreference.limitConfig?.atm ?? '0',
                                            onChange: (val) async {
                                              if (kycType == "FULL_KYC" && kycStatus == "VKYC_APPROVED") {
                                                setState(() => isAtmEnabled = !isAtmEnabled);
                                              } else {
                                                Snackbar.warn("Please complete V-KYC to enable ATM withdrawal.");
                                              }

                                              // if(kycStatus=="FULL_KYC" && kycStatus=="VKYC_APPROVED")

                                              // if (val == false) {
                                              //   AxleLoader.show(context);
                                              //   await ref.read(userControllerProvider).setUserCardPreference(
                                              //         entityId: widget.userEntityId,
                                              //         orgId: widget.userOrgId,
                                              //         status: val ? 'ALLOWED' : 'NOTALLOWED',
                                              //         type: 'ATM',
                                              //       );
                                              //   setState(() {
                                              //     getUserCardPreferenceFuture = fetchUserCardPreference();
                                              //   });
                                              //   AxleLoader.hide();
                                              // }
                                            },
                                          ),
                                          const SizedBox(height: defaultPadding),
                                          //* Contactless button
                                          Container(
                                            constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 400),
                                            width: isMobile ? availableWidth : availableWidth * 35 / 100,
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                            decoration: CommonStyleUtil.axleContainerDecoration,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "Enable Contactless Payment",
                                                    style: AxleTextStyle.axleFormFieldHintStyle,
                                                    overflow: TextOverflow.visible,
                                                  ),
                                                ),
                                                const SizedBox(width: 30.0),
                                                MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: FlutterSwitch(
                                                    width: 45,
                                                    height: 25,
                                                    toggleSize: 18,
                                                    value: isContactlessEnabled,
                                                    showOnOff: false,
                                                    onToggle: (value) {
                                                      setState(() {
                                                        // _animatedHeight != 0.0 ? _animatedHeight = 0.0 : _animatedHeight = 450.0;
                                                        isContactlessEnabled = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 30.0),
                                          // * Apply Button
                                          Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                AxlePrimaryButton(
                                                    buttonWidth: isMobile ? availableWidth * 40 / 100 : 200,
                                                    buttonText: "Apply",
                                                    onPress: () async {
                                                      AxleLoader.show(context);
                                                      await ref
                                                          .read(userControllerProvider)
                                                          .setUserPPIPreference(preference: getPreferences());
                                                      AxleLoader.hide();
                                                      await fetchUserCardPreference(userEntityId);
                                                    }),
                                                const SizedBox(width: defaultPadding),
                                                AxleOutlineButton(
                                                    buttonWidth: isMobile ? availableWidth * 40 / 100 : 200,
                                                    buttonText: "Cancel",
                                                    onPress: () {
                                                      context.router.pushNamed(RouteUtils.getStaffDashboard(
                                                          widget.userOrgId, widget.userEnrolmentId));
                                                    })
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                      )
                  ],
                ),
        ),
      ),
    );
  }

  setuser.SetUserPpiPreferenceModel getPreferences() {
    return setuser.SetUserPpiPreferenceModel(
      entityId: userEntityId,
      organizationId: org!.id,
      cardSettings: setuser.CardSettings(
        atm: isAtmEnabled,
        pos: isPosEnabled,
        ecom: isEcomEnabled,
        contactless: isContactlessEnabled,
      ),
      limitConfig: setuser.LimitConfig(
        atm: atmLimit.text,
        pos: merchantLimitController.text,
        ecom: onlineLimit.text,
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  // * Generate / Reset pin dialog
  void pinChangeDialog(String res) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                'Generate/Reset PIN',
                textAlign: TextAlign.center,
                style: AxleTextStyle.headline6BlackStyle,
              ),
              IconButton(
                splashRadius: 15.0,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          content: WebViewManager.instance.buildUiSettings(
            context: context,
            url: res,
          ),
        );
      },
    );
  }

  // * Lock / UnLock / Block Card Dialog
  Future<bool?> displayLockCardDialog({bool isLocked = false, BuildContext? context}) async {
    return await const LockUserCardDialog().present(context!, isLocked: isLocked).then((value) {
      // debugPrint('Future Va; -> $value');
      return value;
    });
  }
}
