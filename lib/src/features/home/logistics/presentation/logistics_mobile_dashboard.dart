import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/router/app_router.gr.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_tab_view.dart';
import 'package:axlerate/src/common/common_widgets/profile_widget.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/domain/lq_user_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_dash_ppi_account_info.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_dash_tag_account_info.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_ui_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/gps_dash_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/upi_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/vehiclewise_split.dart';
import 'package:axlerate/src/features/home/logistics/presentation/widgets/mobile_wallet_card.dart';
import 'package:axlerate/src/features/home/profile/domain/user_profile_model.dart';
import 'package:axlerate/src/features/home/profile/presentation/profile_page_controller.dart';
import 'package:axlerate/src/features/home/transactions/domain/ppi_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/transaction_controller.dart';
import 'package:axlerate/src/features/home/transactions/presentation/lq_txn_table_widget.dart';
import 'package:axlerate/src/features/home/transactions/presentation/ppi_txn_table.dart';
import 'package:axlerate/src/features/home/transactions/presentation/tag_txn_table.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

enum WalletType { user, vehicle, logistics }

extension WalletTypeExtension on WalletType {
  static const names = {
    WalletType.user: 'User',
    WalletType.vehicle: 'Vehicle',
    WalletType.logistics: 'Corporate',
  };

  static const apiNames = {WalletType.user: 'USER', WalletType.vehicle: 'VEHICLE', WalletType.logistics: "LOGISTICS"};

  String get text => names[this]!;
  String get apiText => apiNames[this]!;
}

class WalletDisplayModel {
  String id;
  final String kitNo;
  final double balance;
  final String upiId;
  final WalletType type;
  int? customerLevelCount;
  int? vehicleLevelCount;
  String? serviceType;
  String? issuerName;
  String walletName;
  Color walletColor;
  final String accountNumber;
  final String ifscCode;
  final String organizationEnrollmentId;
  late String icon;
  late String issuerLogo;
  String userEnrollmentId;
  String userEntityId;

  WalletDisplayModel({
    this.id = '',
    required this.kitNo,
    required this.balance,
    required this.upiId,
    required this.accountNumber,
    required this.ifscCode,
    required this.type,
    this.customerLevelCount = 0,
    this.vehicleLevelCount = 0,
    this.serviceType,
    this.issuerName,
    required this.walletName,
    this.organizationEnrollmentId = '',
    this.walletColor = Colors.black,
    this.userEnrollmentId = '',
    this.userEntityId = '',
  }) {
    icon = getIconPath();
    issuerLogo = getIssuerLogo();
  }

  String getIconPath() {
    switch (serviceType) {
      case "PPI":
        return "assets/new_assets/icons/card_icon.svg";
      case "FUEL":
        return "assets/new_assets/icons/fuel_icon.svg";
      case "TAG":
        return "assets/new_assets/icons/tag_icon.svg";

      default:
        return "assets/new_assets/icons/tag_icon.svg";
    }
  }

  String getIssuerLogo() {
    switch (issuerName) {
      case "LQ":
        return "assets/new_assets/logos/livquik_logo.png";
      case "YB":
        return "assets/new_assets/logos/yesbank_logo.png";
      default:
        return "assets/new_assets/logos/yesbank_logo.png";
    }
  }

  static List<WalletDisplayModel> addtoWalletsList(List<WalletDisplayModel> wallets, WalletDisplayModel wallet) {
    List<Color> colors = [
      Colors.blue.shade800,
      Colors.red.shade800,
      Colors.amber.shade800,
      Colors.green.shade800,
      Colors.cyan.shade800
    ];
    wallets.removeWhere((element) => element.kitNo == wallet.kitNo);
    wallets.add(wallet);

    //assignColors
    for (int index = 0; index < wallets.length; index++) {
      wallets[index].walletColor = colors[index % colors.length];
    }
    return wallets;
  }
}

class LogisticsMobileDashboard extends ConsumerStatefulWidget {
  const LogisticsMobileDashboard({super.key, required this.orgEnrollId});

  final String orgEnrollId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogisticsMobileDashboardState();
}

class _LogisticsMobileDashboardState extends ConsumerState<LogisticsMobileDashboard> with WidgetsBindingObserver {
  OrgDoc? org;
  bool isLoading = true;
  CarouselController buttonCarouselController = CarouselController();
  int currentIndex = 0;
  List<AxleToggleMenuItem> menuItems = [];

  bool isPPIEnabled = false;
  UserService? ppiService;

  @override
  void initState() {
    log("App- init---");
    loadInit();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      loadInit();
      log('App- resumed');
    }
  }

  loadInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOrgData();
    });

    Future(() {
      getUserByEnrolId(widget.orgEnrollId);
    });
  }

  void getOrgData() async {
    menuItems = [];
    getOrgDashCountDataMobile();
    org = ref.read(orgDetailsProvider);
    if (org == null) {
      await ref
          .read(logisticsControllerProvider)
          .getOrganisationByEnrolmentId(enrolId: widget.orgEnrollId.toUpperCase());
      org = ref.read(orgDetailsProvider);
    }
    if (org != null) {
      if (getOrgService(org, 'TAG', issuerName: 'YESBANK') != null) {
        menuItems.add(AxleToggleMenuItem(
          label: 'YB TAG',
          child: TagTxnTableWidget(
            showDateFilter: false,
            showPaginator: false,
            txnParams: TagTxnQueryParams(size: 10, pageIndex: 1),
            listStateProvider: tagTransactionListStateProvider,
            userOrgEnrollId: widget.orgEnrollId,
          ),
        ));
        getOrgDashTagAccDataMobile();
      }
      if (getOrgService(org, 'TAG', issuerName: 'LIVQUIK') != null) {
        menuItems.add(AxleToggleMenuItem(
          label: 'LQ TAG',
          child: LQTxnTableWidget(
            showDateFilter: false,
            showPaginator: false,
            txnParams: TagTxnQueryParams(size: 10, pageIndex: 1),
            listStateProvider: tagTransactionListStateProvider,
            userOrgEnrollId: widget.orgEnrollId,
          ),
        ));
        getOrgDashLqTagAccDataMobile();
      }
      if (getOrgService(org, 'PPI', issuerName: 'LIVQUIK') != null) {
        menuItems.add(AxleToggleMenuItem(
          label: 'PPI',
          child: PpiTxnTableWidget(
            showDateFilter: false,
            showPagination: false,
            txnParams: PpiTxnQueryParams(size: 10, pageIndex: 1),
            userOrgEnrollId: widget.orgEnrollId,
          ),
        ));
        getOrgDashPpiAccDataMobile();
      }
      if (getOrgService(org, 'GPS') != null) {
        getOrgDashGpsInfoDataMobile();
      }
    }
  }

  getOrgDashLqTagAccDataMobile() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //String orgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      ref.read(logisticsDashLqTagAccInfoMobileController.notifier).state = null;
      ref.read(logisticsDashLqTagAccInfoMobileController.notifier).state =
          await ref.read(logisticsControllerProvider).lqTagAccInfoforOrg(orgEnrollId: widget.orgEnrollId);
      setState(() {
        isLoading = false;
      });
    });
  }

  getOrgDashCountDataMobile() async {
    //String orgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    ref.read(logisticsDashCountMobileController.notifier).state = null;

    ref.read(logisticsDashCountMobileController.notifier).state =
        await ref.read(logisticsControllerProvider).getOrgDashCount(userOrgEnrollmentId: widget.orgEnrollId);
  }

  getOrgDashTagAccDataMobile() async {
    //String orgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    ref.read(logisticsDashTagAccInfoMobileController.notifier).state = null;
    ref.read(logisticsDashTagAccInfoMobileController.notifier).state =
        await ref.read(logisticsControllerProvider).getOrgDashTagAccountInfo(userOrgEnrollId: widget.orgEnrollId);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getUserByEnrolId(String userEnrolmentId) async {
    UserProfileModel? userData = ref.watch(profileDataStateProvider);
    if (userData != null) {
      ref.read(loggedInUserByEnrollmentIdStateProvider.notifier).state = await ref
          .read(userControllerProvider)
          .getUserByEnrolmentId(userEnrolmentId: userData.data!.message!.enrollmentId);
      getUserServiceList();
    }
  }

  getUserServiceList() {
    try {
      for (OrganizationUpdated e
          in ref.read(loggedInUserByEnrollmentIdStateProvider)?.data?.message?.organizations ?? []) {
        ppiService = getOrgServiceFromUserEnrollId(e, "PPI", issuerName: "LIVQUIK");
        //log("message" + ppiService.toString());
        if (ppiService != null && ppiService!.kycStatus != "PENDING") {
          isPPIEnabled = true;
          setState(() {});
          break;
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getOrgDashPpiAccDataMobile() async {
    //String orgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    ref.read(logisticsDashPPIAccInfoMobileController.notifier).state = null;
    ref.read(logisticsDashPPIAccInfoMobileController.notifier).state =
        await ref.read(logisticsControllerProvider).getOrgDashPpiAccountInfo(userOrgEnrollId: widget.orgEnrollId);
    setState(() {
      isLoading = false;
    });
  }

  getOrgDashGpsInfoDataMobile() async {
    String orgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    ref.read(logisticsDashGpsInfoMobileController.notifier).state = null;
    ref.read(logisticsDashGpsInfoMobileController.notifier).state =
        await ref.read(logisticsControllerProvider).getLogisticsGpsInfo(orgId: orgId);
  }

  double displayWidth = 0.0;
  double displayHeight = 0.0;
  double availableWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    late List<WalletDisplayModel> wallets;
    final orgCounts = ref.watch(logisticsDashCountMobileController);
    final tagAccInfo = ref.watch(logisticsDashTagAccInfoMobileController);
    final ppiAccInfo = ref.watch(logisticsDashPPIAccInfoMobileController);
    final gpsInfo = ref.watch(logisticsDashGpsInfoMobileController);
    final lqUserAccInfo = ref.watch(logisticsDashLqTagAccInfoMobileController);
    org = ref.watch(orgDetailsProvider);

    setState(() {
      wallets = [];

      for (LqUserAccInfoModelMessage wallet in lqUserAccInfo?.data?.message ?? []) {
        wallets = WalletDisplayModel.addtoWalletsList(
            wallets,
            WalletDisplayModel(
                kitNo: wallet.kitNumber,
                type: WalletType.values.byName((wallet.type).toString().toLowerCase()),
                balance: double.parse(wallet.availableBalance.toString()),
                upiId: wallet.upiId,
                serviceType: "TAG",
                issuerName: "LQ",
                walletName: wallet.name,
                accountNumber: wallet.accountNumber,
                ifscCode: wallet.ifsc));
      }

      PpiAccountInfoMessage? ppiWallet = ppiAccInfo?.data?.message;

      if (ppiWallet != null) {
        wallets = WalletDisplayModel.addtoWalletsList(
            wallets,
            WalletDisplayModel(
                kitNo: "LQPPIW",
                type: WalletType.values.byName((ppiWallet.type ?? "USER").toString().toLowerCase()),
                balance: double.parse(ppiWallet.availableBalance.toString()),
                upiId: ppiWallet.upiId,
                serviceType: "PPI",
                issuerName: "LQ",
                walletName: "PPI Corporate",
                accountNumber: ppiWallet.accountNumber,
                ifscCode: ppiWallet.ifsc));
      }

      YbTagAccountInfo? fastagWallet = tagAccInfo?.data?.message;

      if (fastagWallet != null) {
        wallets = WalletDisplayModel.addtoWalletsList(
            wallets,
            WalletDisplayModel(
                kitNo: "YBFTW",
                type: WalletType.values.byName((fastagWallet.type).toString().toLowerCase()),
                balance: double.parse(fastagWallet.availableBalance.toString()),
                upiId: fastagWallet.upiId,
                serviceType: "TAG",
                walletName: "Yes Bank",
                accountNumber: fastagWallet.accountNumber ?? '',
                ifscCode: fastagWallet.ifsc ?? ''));
      }
    });

    displayWidth = MediaQuery.of(context).size.width;
    displayHeight = MediaQuery.of(context).size.height;
    availableWidth = displayWidth - (defaultPadding * 2);

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            getOrgData();
          },
          child: SingleChildScrollView(
            child: org == null
                ? AxleLoader.axleProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final user = ref.watch(profileDataStateProvider);
                            return GestureDetector(
                              onTap: !isPPIEnabled
                                  ? null
                                  : () {
                                      context.router.pushNamed(RouteUtils.getStaffDashboard(
                                          widget.orgEnrollId, user!.data!.message!.enrollmentId));
                                    },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      ProfileImageWidget(
                                          url: user!.data!.message!.profilePic, width: 50, height: 50, radius: 50),
                                      const SizedBox(width: defaultPadding),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Welcome,',
                                              style: AxleTextStyle.labelMedium.copyWith(color: Colors.black54)),
                                          Text(user.data!.message!.name,
                                              style: AxleTextStyle.headingPrimary.copyWith(color: Colors.black87)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (isPPIEnabled)
                                    SizedBox(
                                        height: 40,
                                        width: 65,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          child: Image.asset(
                                              width: availableWidth,
                                              'assets/images/axle-ppi-card.png',
                                              fit: BoxFit.fitWidth),
                                        ))
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        Container(height: 1, color: Colors.grey.shade300),
                        const SizedBox(height: defaultMobilePadding),

                        // SUMMARY SECTION
                        Text('Summary', style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 70,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: orgCounts == null
                                ? summarySectionShimmerLoader()
                                : [
                                    GestureDetector(
                                      onTap: () {
                                        context.router.pushNamed(RouteUtils.getVehiclesPath());
                                      },
                                      child: axleCountCardWidget(
                                        label: 'Vehicle',
                                        value: orgCounts.data?.message?.vehicle.toString() ?? '0',
                                        bgColor: const Color(0xFFffecf1),
                                      ),
                                    ),
                                    const SizedBox(width: defaultMobilePadding),
                                    GestureDetector(
                                      onTap: () {
                                        context.router.push(ListUsersRoute(
                                          userRole: 'STAFF',
                                        ));
                                      },
                                      child: axleCountCardWidget(
                                        label: 'Staff',
                                        value: orgCounts.data?.message?.staffUsers.toString() ?? '0',
                                        bgColor: const Color(0xFFf0faf9),
                                      ),
                                    ),
                                    const SizedBox(width: defaultMobilePadding),
                                    GestureDetector(
                                      onTap: () {
                                        context.router.push(ListUsersRoute(
                                          userRole: 'ADMIN',
                                        ));
                                      },
                                      child: axleCountCardWidget(
                                        label: 'Admin',
                                        value: orgCounts.data?.message?.adminUsers.toString() ?? '0',
                                        bgColor: const Color(0xFFf7f3ff),
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        Container(height: 1, color: Colors.grey.shade300),

                        // WALLET BALANCE SECTION
                        const SizedBox(height: defaultMobilePadding),
                        Text('Wallet Balance', style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),

                        SizedBox(
                          width: displayWidth,
                          child: isLoading
                              ? Center(child: AxleLoader.axleProgressIndicator())
                              : wallets.isEmpty
                                  ? const Center(child: Text("No Wallets Available"))
                                  : CarouselSlider.builder(
                                      itemCount: wallets.length,
                                      options: CarouselOptions(
                                        disableCenter: false,
                                        height: 180,
                                        // aspectRatio: 3.0,
                                        viewportFraction: 0.7,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayInterval: const Duration(seconds: 3),
                                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 0.3,
                                        scrollDirection: Axis.horizontal,
                                        enlargeStrategy: CenterPageEnlargeStrategy.height,

                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        },
                                        // enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                                      ),
                                      // options: CarouselOptions(height: 400.0),
                                      itemBuilder: (context, index, realIndex) {
                                        int prevIndex = (currentIndex - 1) % wallets.length;
                                        return index == currentIndex
                                            ? MobileWalletCard(wallet: wallets[index])
                                            : MobileWalletCard(
                                                wallet: wallets[index],
                                                direction: index == prevIndex ? TextDirection.rtl : TextDirection.ltr);
                                      }),
                        ),

                        const SizedBox(height: defaultMobilePadding),
                        Container(height: 1, color: Colors.grey.shade300),
                        const SizedBox(height: defaultMobilePadding),

                        const SizedBox(height: defaultMobilePadding),
                        VehiclewiseUsage(count: 5, orgId: widget.orgEnrollId, isDash: true),
                        const SizedBox(height: defaultMobilePadding),

                        Container(height: 1, color: Colors.grey.shade300),
                        const SizedBox(height: defaultMobilePadding),

                        // SERVICES SECTION
                        Text('Services', style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        // * Services Section
                        SizedBox(
                          // color: AxleColors.axleBgYellow,
                          width: MediaQuery.of(context).size.width,
                          height: 80.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                dashIconCardWidget(
                                  value: orgCounts == null ? null : orgCounts.data?.message?.totalTag.toString() ?? '0',
                                  svgPath: "assets/new_assets/icons/dashboard_card_fastag.svg",
                                  label: 'FASTag',
                                ),
                                dashIconCardWidget(
                                  value: orgCounts == null ? null : orgCounts.data?.message?.totalPpi.toString() ?? '0',
                                  svgPath: "assets/new_assets/icons/fuel_card_icon.svg",
                                  label: 'Prepaid Cards',
                                ),
                                dashIconCardWidget(
                                  value: orgCounts == null
                                      ? null
                                      : orgCounts.data?.message?.gpsDeviceCount.toString() ?? '0',
                                  svgPath: "assets/new_assets/icons/dashboard_card_gps.svg",
                                  label: 'GPS',
                                ),
                                dashIconCardWidget(
                                  value: 'Coming Soon',
                                  svgPath: "assets/new_assets/icons/fuel_card_icon.svg",
                                  label: 'Fuel Card',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(height: 1, color: Colors.grey.shade300),
                        const SizedBox(height: defaultMobilePadding),

                        // GPS LOCATION SECTION
                        Text('GPS Locations', style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 180.0,
                          width: double.maxFinite,
                          child: gpsInfo == null
                              ? AxleLoader.axleProgressIndicator()
                              : Stack(
                                  children: [
                                    getOrgService(org, 'GPS') != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(12.0),
                                            child: Stack(children: [
                                              GpsDashWidget(
                                                orgId: org!.id,
                                                size: MediaQuery.of(context).size,
                                              ),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            useSafeArea: true,
                                                            context: context,
                                                            builder: (context) => AlertDialog(
                                                                  insetPadding: EdgeInsets.zero,
                                                                  contentPadding: EdgeInsets.zero,
                                                                  content: Stack(
                                                                    children: [
                                                                      GpsDashWidget(
                                                                        orgId: org!.id,
                                                                        size: MediaQuery.of(context).size,
                                                                      ),
                                                                      Align(
                                                                          alignment: Alignment.topRight,
                                                                          child: IconButton(
                                                                              onPressed: () {
                                                                                context.router.pop();
                                                                              },
                                                                              icon: const Icon(Icons.close)))
                                                                    ],
                                                                  ),
                                                                ));
                                                      },
                                                      icon: const Icon(Icons.fullscreen)))
                                            ]),
                                          )
                                        : const SizedBox(),
                                    getOrgService(org, 'GPS') != null
                                        ? const SizedBox()
                                        : Container(
                                            height: 180.0,
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12.0),
                                              color: Colors.white.withOpacity(0.3),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'GPS Service not enabled',
                                                style: AxleTextStyle.bodyLarge.copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),

                        Container(height: 1, color: Colors.grey.shade300),
                        const SizedBox(height: defaultMobilePadding),

                        // RECENT TRANSCATIONS SECTION
                        Text('Recent Transactions', style: AxleTextStyle.subHeadingPrimary),
                        const SizedBox(height: defaultMobilePadding),
                        if (menuItems.isNotEmpty)
                          AxleTabMenu(
                            provider: txnTabIndexProviderMobile,
                            items: menuItems,
                          ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  buildCardsList(BuildContext context, int size, OrgDashTagAccountInfo? tagAccInfo) {
    //final double containerWidth = MediaQuery.of(context).size.width - 16;

    var list = <CardModel>[];
    for (int i = 0; i < size; i++) {
      // var color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);

      list.add(
        CardModel(
          // border: Border.all(width: 1, color: color),
          // backgroundColor: color,
          radius: const Radius.circular(16),
          // shadowColor: Colors.black.withOpacity(0.2),
          child: SizedBox(
            // height: 310,
            width: availableWidth - defaultPadding,
            child: lqftCardWidget(
              label: 'Wallet Balance ',
              value: tagAccInfo == null
                  ? null
                  : tagAccInfo.data == null
                      ? axleCurrencyFormatterwithDecimals.format(0)
                      : axleCurrencyFormatterwithDecimals.format(tagAccInfo.data?.message?.availableBalance ?? 0),
              upi: tagAccInfo == null
                  ? '-'
                  : tagAccInfo.tagNotEnabled == true
                      ? 'FASTag Service is not enabled for your Organization'
                      : tagAccInfo.data?.message?.upiId ?? '',
              svgPath: 'assets/new_assets/icons/dashboard_card_fastag.svg',
            ), // Whatever you want
          ),
        ),
      );
    }

    return list;
  }

  Widget noTxnsWidget() {
    return Column(
      children: [
        const SizedBox(height: defaultPadding),
        Center(
            child: SvgPicture.asset(
          'assets/images/no_txn_illus.svg',
          height: 400.0,
        )
            // Text(
            //   'No Items Found',
            //   style: TextStyle(
            //     fontSize: 22.0,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            ),
        const SizedBox(height: defaultPadding),
        Text(
          HomeConstants.noTxnStr,
          style: AxleTextStyle.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          HomeConstants.noTxnTrailingStr,
          textAlign: TextAlign.center,
          style: AxleTextStyle.titleMedium.copyWith(
            color: Colors.black,
          ),
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text('No transactions found?', style: AxleTextStyle.titleMedium),
    //         Text('Perform transactions to see the most recent ones here.', style: AxleTextStyle.bodyMedium),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget dashBalanceCardWidget({
    required String label,
    String? value,
    required String upi,
    required String svgPath,
  }) {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width * 78 / 100,
      margin: const EdgeInsets.symmetric(horizontal: defaultMobilePadding, vertical: 10.0),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2), blurRadius: 5.0, spreadRadius: 0.4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AxleTextStyle.labelMedium.copyWith(color: Colors.black)),
          value == null
              ? AxleLoader.axleProgressIndicator(height: 60.0, width: 60.0)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value, style: AxleTextStyle.headlineMedium.copyWith(fontWeight: FontWeight.bold)),
                        // const SizedBox(width: 70.0),
                        SvgPicture.asset(svgPath, alignment: Alignment.center, width: 60),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(child: Text(upi, style: AxleTextStyle.labelSmall)),
                        upi.contains('FASTag') || upi.contains('Prepaid')
                            ? const SizedBox()
                            : IconButton(
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.copy, color: AxleColors.axlePrimaryColor),
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(text: upi));
                                  Snackbar.success("Copied to Clipboard.");
                                },
                              ),
                        // const SizedBox(width: 1.0),
                        upi.contains('FASTag') || upi.contains('Prepaid')
                            ? const SizedBox()
                            : IconButton(
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.qr_code, color: AxleColors.axlePrimaryColor),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => QRPopUpWidget(
                                      upiId: upi,
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget dashBalanceSquareCardWidget({
    required String label,
    String? value,
    required String upi,
    required String svgPath,
  }) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width * 78 / 100,
      margin: const EdgeInsets.symmetric(horizontal: defaultMobilePadding, vertical: 10.0),
      padding: const EdgeInsets.all(defaultMobilePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2), blurRadius: 5.0, spreadRadius: 0.4, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          RotatedBox(
              quarterTurns: 3,
              child: Row(
                children: [
                  SvgPicture.asset(svgPath, alignment: Alignment.center, width: 20),
                  const SizedBox(width: defaultPadding),
                  Text(label, style: AxleTextStyle.labelMedium.copyWith(color: Colors.black)),
                ],
              )),
          const SizedBox(width: defaultPadding),
          value == null
              ? AxleLoader.axleProgressIndicator(height: 60.0, width: 60.0)
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(value, style: AxleTextStyle.headlineMedium.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: defaultPadding * 2),
                      Text(upi, style: AxleTextStyle.labelSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          upi.contains('FASTag') || upi.contains('Prepaid')
                              ? const SizedBox()
                              : IconButton(
                                  padding: const EdgeInsets.all(0.0),
                                  icon: const Icon(Icons.copy, color: AxleColors.axlePrimaryColor),
                                  onPressed: () async {
                                    await Clipboard.setData(ClipboardData(text: upi));
                                    Snackbar.success("Copied to Clipboard.");
                                  },
                                ),
                          // const SizedBox(width: 1.0),
                          upi.contains('FASTag') || upi.contains('Prepaid')
                              ? const SizedBox()
                              : IconButton(
                                  padding: const EdgeInsets.all(0.0),
                                  icon: const Icon(Icons.qr_code, color: AxleColors.axlePrimaryColor),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => QRPopUpWidget(
                                        upiId: upi,
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget lqftCardWidget({
    required String label,
    String? value,
    required String upi,
    required String svgPath,
  }) {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width * 78 / 100,
      // margin: const EdgeInsets.symmetric(horizontal: defaultMobilePadding, vertical: 10.0),
      padding: const EdgeInsets.all(defaultPadding),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12.0),
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5.0, spreadRadius: 0.4, offset: Offset(0, 2)),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AxleTextStyle.labelMedium.copyWith(color: Colors.black)),
          value == null
              ? AxleLoader.axleProgressIndicator(height: 60.0, width: 60.0)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value, style: AxleTextStyle.headlineMedium.copyWith(fontWeight: FontWeight.bold)),
                        // const SizedBox(width: 70.0),
                        SvgPicture.asset(svgPath, alignment: Alignment.center, width: 60),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(child: Text(upi, style: AxleTextStyle.labelSmall)),
                        upi.contains('FASTag') || upi.contains('Prepaid')
                            ? const SizedBox()
                            : IconButton(
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.copy, color: AxleColors.axlePrimaryColor),
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(text: upi));
                                  Snackbar.success("Copied to Clipboard.");
                                },
                              ),
                        // const SizedBox(width: 1.0),
                        upi.contains('FASTag') || upi.contains('Prepaid')
                            ? const SizedBox()
                            : IconButton(
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.qr_code, color: AxleColors.axlePrimaryColor),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => QRPopUpWidget(
                                      upiId: upi,
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Container axleCountCardWidget({required String label, required String value, required Color bgColor}) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 100.0,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2.0,
            spreadRadius: 0.4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: AxleTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          Text(
            label + (value == '1' ? '' : 's'),
            style: AxleTextStyle.bodyMedium.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget dashIconCardWidget({
    String? value,
    required String svgPath,
    required String label,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              value == null
                  ? Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 204, 203, 203).withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                          topLeft: Radius.circular(12.0),
                        ),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: iconGrey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child:
                              Text('         ', style: AxleTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 204, 203, 203).withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                          topLeft: Radius.circular(12.0),
                        ),
                      ),
                      child: Text('  $value', style: AxleTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                    ),
              const SizedBox(height: 4.0),
              Positioned(
                left: -22,
                top: 0.0,
                child: SvgPicture.asset(svgPath, alignment: Alignment.center, width: 30),
              ),
            ],
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Container(
    //         height: 40,
    //         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    //         decoration: BoxDecoration(
    //           color: Color.fromARGB(255, 217, 216, 216).withOpacity(0.4),
    //           borderRadius: BorderRadius.circular(8.0),
    //         ),
    //         child: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             SvgPicture.asset(
    //               svgPath,
    //               alignment: Alignment.center,
    //               width: 20,
    //             ),
    //             const SizedBox(width: 6.0),
    //             Text(
    //               value,
    //               style: value.toLowerCase().contains('coming soon')
    //                   ? AxleTextStyle.subHeadingPrimary.copyWith(fontSize: 12)
    //                   : AxleTextStyle.subHeadingPrimary,
    //             ),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(height: 2.0),
    //       Text(
    //         label,
    //         style: const TextStyle(
    //           fontSize: 10,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  // * Summary Section Shimmers
  List<Widget> summarySectionShimmerLoader() {
    List<int> list = [1, 2, 3];
    return list
        .map(
          (e) => Container(
            height: 65,
            width: 100,
            margin: const EdgeInsets.all(4),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: const BoxDecoration(
                  color: iconGrey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
