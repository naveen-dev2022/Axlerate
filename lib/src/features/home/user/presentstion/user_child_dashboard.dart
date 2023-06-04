// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_toggle_menu.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/dashboard_controllers.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_list_model.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/transaction_controller.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/ui_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/card_not_enabled_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/empty_response_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/lq_tag_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/ppi_widget.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/features/home/user/domain/fetch_balance_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/values/constants.dart';

enum PrepaidCardTransactionType { credit, debit }

extension PrepaidCardTransactionTypeExt on PrepaidCardTransactionType {
  static const names = {
    PrepaidCardTransactionType.credit: 'Credit',
    PrepaidCardTransactionType.debit: 'Debit',
  };

  String get text => names[this]!;
}

@RoutePage()
class UserChildDashboard extends ConsumerStatefulWidget {
  const UserChildDashboard({
    super.key,
    this.isDash = false,
    @PathParam('staffEnrolId') required this.userEnrollmentId,
    @PathParam('custId') required this.orgenrollIdOfUser,
  });
  final bool isDash;
  final String userEnrollmentId;
  final String orgenrollIdOfUser;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserChildDashboardState();
}

class _UserChildDashboardState extends ConsumerState<UserChildDashboard> {
  late FetchBalanceResponseModel? userFundData;
  late FetchBalanceResponseModel? userOrgFundData;
  late String userLqPpiEntityId = '';
  late String userLqTagEntityId = '';
  late Future<String> userPpiCreditAmountfuture;
  late Future<String> userPpiDebitAmountfuture;
  late Future<FetchBalanceResponseModel> userBalance;
  OrgDoc? org;
  UpdatedUserByEnrolmentIdModel? userByEnrolmentIdData;
  late OrgType currentType;

  TagTxnQueryParams params = TagTxnQueryParams(
    pageIndex: 1,
    size: 15,
  );
  UserService? ppiService;
  UserService? lqTagService;
  String userRole = '';
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  StateProvider<UpdatedUserByEnrolmentIdModel?>? userDetailsProvider;

  bool isLoading = true;

  @override
  void initState() {
    loadInit();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   loadInit();
  //   super.didChangeDependencies();
  // }

  loadInit() {
    userRole = sharedPreferences.getString(Storage.currentUserRole) ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(userDashMainIndexProvider.notifier).state = 0;
      org = ref.read(orgDetailsProvider);
      if (org == null) {
        await ref
            .read(logisticsControllerProvider)
            .getOrganisationByEnrolmentId(enrolId: widget.orgenrollIdOfUser.toUpperCase());
        org = ref.read(orgDetailsProvider);
        setState(() {});
      }
    });
    currentType = ref.read(localStorageProvider).getOrgType();
    log("DashBoard-->${widget.isDash}");
    log("userRole---$userRole");
    log("currentType---$currentType");

    if (!widget.isDash) {
      userDetailsProvider = updateduserDetailsByEnrollmentIdStateProvider;
      Future(() {
        getOrgDetailsByEnrollmentId(widget.orgenrollIdOfUser);
        getUserDetailByEnrollmentId(widget.userEnrollmentId);
      });
    } else {
      userDetailsProvider = loggedInUserByEnrollmentIdStateProvider;
      getUserServiceList(widget.orgenrollIdOfUser);
    }
  }

  getOrgDetailsByEnrollmentId(String orgEnrollId) async {
    await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(enrolId: orgEnrollId.toUpperCase());
  }

  getUserDetailByEnrollmentId(String userEnrolmentId) async {
    ref.read(userDetailsProvider!.notifier).state = await ref.read(userControllerProvider).getUserByEnrolmentId(
          userEnrolmentId: userEnrolmentId.toUpperCase(),
        );
    getUserServiceList(widget.orgenrollIdOfUser);
  }

  getUserServiceList(String orgEnrolld) {
    log("getUserServiceList-->");
    try {
      for (OrganizationUpdated e in ref.read(userDetailsProvider!)?.data?.message?.organizations ?? []) {
        if (e.organizationEnrollmentId.toUpperCase() == orgEnrolld.toUpperCase()) {
          ppiService = getOrgServiceFromUserEnrollId(e, "PPI",
              issuerName: "LIVQUIK", organizationEnrollmentId: widget.orgenrollIdOfUser);
          lqTagService = getOrgServiceFromUserEnrollId(e, "TAG",
              issuerName: "LIVQUIK", organizationEnrollmentId: widget.orgenrollIdOfUser);
          log("ppiService-->$ppiService");
          log("lqTagService-->$lqTagService");
          // if (e.organizationEnrollmentId.toUpperCase() == widget.orgenrollIdOfUser.toUpperCase()) {
          log("break-------");
          break;
          // }
        }
      }
    } catch (e) {
      log(e.toString());
    }
    if (ppiService != null) {
      getPpiCreditDebitDetails();
    }
    if (lqTagService != null) {
      getLqTagTranactionDetails();
      getLivquikTagAccDetails();
      getLqTagVehiclesList();
    }
  }

  getLqTagTranactionDetails() {
    if (lqTagService != null) {
      userLqTagEntityId = getLqTagEntityIdFromOrgList(widget.orgenrollIdOfUser);
      log("userLqTagEntityId----->$userLqTagEntityId");
      getTransactionsList(params);
    }

    setState(() {
      isLoading = false;
    });
  }

  getLivquikTagAccDetails() async {
    ref.read(livquikTagAccDetailsProvider.notifier).state = null;
    ref.read(livquikTagAccDetailsProvider.notifier).state =
        await ref.read(logisticsControllerProvider).lqTagAccInfoByEnrollmentId(orgEnrollId: widget.orgenrollIdOfUser);
  }

  getLqTagVehiclesList() async {
    if (currentType != OrgType.logisticsStaff) {
      ref.read(listofLqTagVehiclesStateProvider.notifier).state = null;
      ref.read(listofLqTagVehiclesStateProvider.notifier).state =
          await ref.read(vehicleControllerProvider).getListLqtagVehicles();
    }
  }

  Future<void> getTransactionsList(TagTxnQueryParams params) async {
    Future(
      () async {
        if (currentType != OrgType.logisticsStaff) {
          ref.read(lqTagTransactionListStateProvider.notifier).state = null;
          ref.read(lqTagTransactionListStateProvider.notifier).state = await ref
              .read(transactionControlProvider)
              .listLqTagTxns(params: params, orgEnrollIdOfUser: widget.userEnrollmentId);
        }
      },
    );
  }

  Future<String> getUserCreditPpiTxnAmount({required String userEntityId}) =>
      ref.read(userControllerProvider).userPpiTxnAmount(
            userEntityId: userEntityId,
            dataType: 'month',
            txnType: 'credit',
          );

  Future<String> getUserDebitPpiTxnAmount({required String userEntityId}) =>
      ref.read(userControllerProvider).userPpiTxnAmount(
            userEntityId: userEntityId,
            dataType: 'month',
            txnType: 'debit',
          );

  Future<void> getPpiCreditDebitDetails() async {
    if (ppiService != null && ppiService!.kycStatus != "PENDING") {
      userLqPpiEntityId = getLqPpiEntityIdFromOrgList(widget.orgenrollIdOfUser);
      log("userLqPpiEntityId-----$userLqPpiEntityId");
      if (userLqPpiEntityId.isEmpty) {
        ref.read(userPpiTxnCreditAmountProvider.notifier).state = '0';
        ref.read(userPpiTxnDebitAmountProvider.notifier).state = '0';
        ref.read(userDashBalanceProvider.notifier).state = FetchBalanceResponseModel.unknown();
      } else {
        if (userLqPpiEntityId.isNotEmpty) {
          await getUserCreditPpiTxnAmount(userEntityId: userLqPpiEntityId);
          await getUserDebitPpiTxnAmount(userEntityId: userLqPpiEntityId);
          ref.read(userDashBalanceProvider.notifier).state =
              await ref.read(userControllerProvider).fetchUserBalance(entityId: userLqPpiEntityId);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  String getLqTagEntityIdFromOrgList(String orgEnrolld) {
    String result = '';
    try {
      for (OrganizationUpdated e in ref.read(userDetailsProvider!)?.data?.message?.organizations ?? []) {
        if (e.organizationEnrollmentId.toUpperCase() == orgEnrolld.toUpperCase()) {
          result = getOrgServiceFromUserEnrollId(e, "TAG", issuerName: "LIVQUIK")?.userEntityId ?? '';
          if (result.isNotEmpty) {
            break;
          }
          break;
        }
      }
    } catch (e) {
      return result;
    }
    return result;
  }

  String getLqPpiEntityIdFromOrgList(String orgEnrolld) {
    String result = '';
    try {
      for (OrganizationUpdated e in ref.read(userDetailsProvider!)?.data?.message?.organizations ?? []) {
        if (e.organizationEnrollmentId.toUpperCase() == orgEnrolld.toUpperCase()) {
          result = getOrgServiceFromUserEnrollId(e, "PPI", issuerName: "LIVQUIK")?.userEntityId ?? '';
          if (result.isNotEmpty) {
            break;
          }
          break;
        }
      }
    } catch (e) {
      return result;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);
    userByEnrolmentIdData = ref.watch(userDetailsProvider!);
    final txnList = ref.watch(lqTagTransactionListStateProvider);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2 + defaultPadding);

    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    if (widget.isDash) {
      return org == null || userByEnrolmentIdData?.data?.message == null
          ? AxleLoader.axleProgressIndicator(height: screenHeight)
          : userDashBody(txnList);
    }

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          loadInit();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: isMobile
                ? const EdgeInsets.all(defaultPadding)
                : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: org == null || userByEnrolmentIdData?.data?.message == null || isLoading
                ? AxleLoader.axleProgressIndicator(height: screenHeight)
                : userLqTagEntityId.isEmpty && userLqPpiEntityId.isEmpty
                    ? CardNotEnbledWidget(isDash: widget.isDash, org: org, currentType: currentType)
                    : userDashBody(txnList),
          ),
        ),
      ),
    );
  }

  Column userDashBody(TagTxnListModel? txnList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: [
        if (!isMobile && !widget.isDash)
          DashboardHeader(
            title: widget.isDash ? "PPI Dashboard" : "Staff Dashboard",
            orgName: org != null ? org!.displayName ?? '' : '',
            showBack: currentType != OrgType.logisticsStaff,
          ),
        if (isMobile)
          GestureDetector(
              onTap: () {
                context.router.pop();
              },
              child: Text('< Back', style: AxleTextStyle.labelLarge)),
        const SizedBox(height: defaultPadding),
        widget.isDash
            ? getPpiWidget()
            : ((ppiService != null && ppiService!.kycStatus != "PENDING") && userRole == 'STAFF')
                ? getPpiWidget()
                : (userRole != 'STAFF' && (ppiService != null || lqTagService != null))
                    ? (ppiService != null && ppiService!.kycStatus != "PENDING") && lqTagService != null
                        ? AxleToggleMenu(
                            provider: userDashMainIndexProvider,
                            items: [
                              AxleToggleMenuItem(label: "PPI", child: getPpiWidget()),
                              AxleToggleMenuItem(
                                label: "LQ Admin",
                                child: LqTagWidget(
                                  userEnrollmentId: widget.userEnrollmentId,
                                  orgenrollIdOfUser: widget.orgenrollIdOfUser,
                                  txnList: txnList,
                                  lqTagService: lqTagService,
                                  ppiService: ppiService,
                                ),
                              )
                            ],
                          )
                        : (ppiService != null && ppiService!.kycStatus != "PENDING")
                            ? getPpiWidget()
                            : lqTagService != null
                                ? getLqTagWidget(txnList)
                                : const EmptyResponseWidget()
                    : const EmptyResponseWidget(),
      ],
    );
  }

  Widget getLqTagWidget(TagTxnListModel? txnList) {
    return LqTagWidget(
      userEnrollmentId: widget.userEnrollmentId,
      orgenrollIdOfUser: widget.orgenrollIdOfUser,
      txnList: txnList,
      lqTagService: lqTagService,
      ppiService: ppiService,
    );
  }

  Widget getPpiWidget() {
    return PpiWidget(
      userEnrollmentId: widget.userEnrollmentId,
      orgenrollIdOfUser: widget.orgenrollIdOfUser,
      org: org,
      userByEnrolmentIdData: userByEnrolmentIdData,
      userLqPpiEntityId: userLqPpiEntityId,
      isDash: widget.isDash,
    );
  }
}
