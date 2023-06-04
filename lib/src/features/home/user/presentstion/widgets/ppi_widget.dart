import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_toggle_menu.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_account_info_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_ppi_graph_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/ui_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/user_child_dashboard.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/card_blocked_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/card_information_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/credit_debit_graph.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/card_widget.dart';
import 'package:axlerate/values/constants.dart';

// ignore: must_be_immutable
class PpiWidget extends ConsumerStatefulWidget {
  PpiWidget({
    super.key,
    required this.userEnrollmentId,
    required this.orgenrollIdOfUser,
    required this.org,
    required this.userByEnrolmentIdData,
    required this.userLqPpiEntityId,
    required this.isDash,
  });
  final String userEnrollmentId;
  final String orgenrollIdOfUser;
  OrgDoc? org;
  UpdatedUserByEnrolmentIdModel? userByEnrolmentIdData;
  String? userLqPpiEntityId;
  final bool isDash;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PpiWidgetState();
}

class _PpiWidgetState extends ConsumerState<PpiWidget> {
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;
  Future<UserAccountInfoModel>? userAccountInfoModel;
  @override
  void initState() {
    Future(() {
      if (widget.userLqPpiEntityId != null && widget.userLqPpiEntityId!.isNotEmpty) {
        getUserCreditPpiTxnGraph(userEntityId: widget.userLqPpiEntityId!);
        getUserDebitPpiTxnGraph(userEntityId: widget.userLqPpiEntityId!);
        getUserAccount();
      }
    });

    super.initState();
  }

  getUserAccount() {
    userAccountInfoModel = ref.read(userControllerProvider).getUserAccountInfo(userEntityId: widget.userLqPpiEntityId!);
    setState(() {});
  }

  Future<UserPpiGraphResponseModel> getUserCreditPpiTxnGraph({required String userEntityId}) =>
      ref.read(userControllerProvider).userPpiTxnGraph(
            userEntityId: userEntityId,
            dataType: Strings.dataType,
            txnType: 'credit',
          );

  Future<UserPpiGraphResponseModel> getUserDebitPpiTxnGraph({required String userEntityId}) =>
      ref.read(userControllerProvider).userPpiTxnGraph(
            userEntityId: userEntityId,
            dataType: Strings.dataType,
            txnType: 'debit',
          );
  @override
  Widget build(BuildContext context) {
    final creditAmount = ref.watch(userPpiTxnCreditAmountProvider);
    final debitAmount = ref.watch(userPpiTxnDebitAmountProvider);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2 + defaultPadding);

    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    return isMobile
        ? FutureBuilder<UserAccountInfoModel>(
            future: userAccountInfoModel,
            builder: (context, snapshot) {
              return Column(
                children: [
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.data != null &&
                      snapshot.data!.data!.message.status == "BLOCKED")
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: CardBlockedWidget(),
                    ),
                  if (userAccountInfoModel != null)
                    PpiCard(
                      org: widget.org!,
                      user: widget.userByEnrolmentIdData?.data?.message,
                      entityId: widget.userLqPpiEntityId,
                      isDash: widget.isDash,
                      userEnrolData: widget.userByEnrolmentIdData!,
                    ),
                  const SizedBox(height: defaultPadding),
                  if (userAccountInfoModel != null)
                    CardInformation(
                      org: widget.org,
                      ppiAccountFuture: userAccountInfoModel!,
                      user: widget.userByEnrolmentIdData?.data?.message,
                      userEnrollId: widget.userEnrollmentId,
                    ),
                  const SizedBox(height: defaultPadding),
                  Container(
                      decoration: CommonStyleUtil.axleListingCardDecoration,
                      width: availableWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 332,
                            child: cardTransactionsOverview(
                              debitAmount,
                              creditAmount,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: AxleSearchDropDownField(
                              fieldHint: '',
                              fieldController: TextEditingController(text: "Year"),
                              fieldWidth: 200,
                              dropDownOptions: graphDataType,
                              onChanged: (String val) async {
                                Strings.dataType = val.toLowerCase();
                                // log("selected datatype-->${Strings.dataType}");
                                ref.read(userPpiCreditGraphStateProvider.notifier).state = null;
                                ref.read(userPpiDebitGraphStateProvider.notifier).state = null;
                                await getUserCreditPpiTxnGraph(userEntityId: widget.userLqPpiEntityId!);
                                await getUserDebitPpiTxnGraph(userEntityId: widget.userLqPpiEntityId!);
                              },
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: defaultPadding, left: defaultPadding, right: defaultPadding),
                            child: SizedBox(height: 300, child: creditDebitGraph()),
                          )
                        ],
                      )),
                ],
              );
            })
        : FutureBuilder<UserAccountInfoModel>(
            future: userAccountInfoModel,
            builder: (context, snapshot) {
              return Column(
                children: [
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.data != null &&
                      snapshot.data!.data!.message.status == "BLOCKED")
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: CardBlockedWidget(),
                    ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (userAccountInfoModel != null)
                          PpiCard(
                            org: widget.org!,
                            user: widget.userByEnrolmentIdData?.data?.message,
                            entityId: widget.userLqPpiEntityId,
                            isDash: widget.isDash,
                            userEnrolData: widget.userByEnrolmentIdData!,
                          ),
                        const SizedBox(width: defaultPadding),
                        if (userAccountInfoModel != null)
                          CardInformation(
                            org: widget.org,
                            ppiAccountFuture: userAccountInfoModel!,
                            user: widget.userByEnrolmentIdData?.data?.message,
                            userEnrollId: widget.userEnrollmentId,
                          )
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: isMobile ? const EdgeInsets.all(0) : const EdgeInsets.all(defaultMobilePadding),
                      // width: availableWidth,
                      height: 400,
                      decoration: CommonStyleUtil.axleListingCardDecoration,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            cardTransactionsOverview(
                              debitAmount,
                              creditAmount,
                            ),
                            creditDebitGraph(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
  }

  Widget checkUserCardStatus() {
    return FutureBuilder<UserAccountInfoModel>(
        future: userAccountInfoModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data != null &&
                    snapshot.data!.data != null &&
                    snapshot.data!.data!.message.status == "BLOCKED"
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: CardBlockedWidget(),
                  )
                : const SizedBox();
          } else {
            return const SizedBox();
          }
        });
  }

  Widget creditDebitGraph() {
    return Container(
      width: isMobile ? null : availableWidth * 68 / 100,
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 500),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          AxleToggleMenu(
              provider: staffPpiTransChart,
              toggleButtonWidth: isMobile ? (availableWidth - (defaultPadding * 3)) / 2 : 150,
              items: [
                AxleToggleMenuItem(
                  label: "Credit",
                  child: CreditWidget(
                    key: UniqueKey(),
                  ),
                ),
                AxleToggleMenuItem(
                  label: "Debit",
                  child: Expanded(
                    child: DebitWidget(
                      key: UniqueKey(),
                    ),
                  ),
                ),
              ]),
          if (!isMobile)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: AxleSearchDropDownField(
                fieldHint: '',
                fieldController: TextEditingController(text: "Year"),
                fieldWidth: 150,
                dropDownOptions: graphDataType,
                onChanged: (String val) async {
                  Strings.dataType = val.toLowerCase();
                  // log("selected datatype-->${Strings.dataType}");
                  ref.read(userPpiCreditGraphStateProvider.notifier).state = null;
                  ref.read(userPpiDebitGraphStateProvider.notifier).state = null;
                  await getUserCreditPpiTxnGraph(userEntityId: widget.userLqPpiEntityId!);
                  await getUserDebitPpiTxnGraph(userEntityId: widget.userLqPpiEntityId!);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget cardTransactionsOverview(String? debitAmount, String? creditAmount) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Overview -  Prepaid Card Transactions",
            style: AxleTextStyle.dashboardCardTitle,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 0 : defaultPadding),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                debitAmount == null
                    ? AxleLoader.axleProgressIndicator(
                        height: 30.0,
                        width: 30.0,
                      )
                    : ppiCardOverview(
                        type: PrepaidCardTransactionType.debit,
                        value: debitAmount,
                      ),
                creditAmount == null
                    ? AxleLoader.axleProgressIndicator(
                        height: 30.0,
                        width: 30.0,
                      )
                    : ppiCardOverview(
                        type: PrepaidCardTransactionType.credit,
                        value: creditAmount,
                      ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Container ppiCardOverview(
      {PrepaidCardTransactionType type = PrepaidCardTransactionType.debit, required String value}) {
    String svgPath = type == PrepaidCardTransactionType.credit
        ? "assets/new_assets/icons/ppi_credit_icon.svg"
        : "assets/new_assets/icons/ppi_debit_icon.svg";

    // String balance = axleCurrencyFormatterwithDecimals.format(0.00);

    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 250),
      width: isMobile ? availableWidth : availableWidth * 25 / 100,
      decoration: BoxDecoration(
          color: type == PrepaidCardTransactionType.credit ? const Color(0xFF638795) : const Color(0xFF714FD8),
          image: const DecorationImage(image: AssetImage("assets/new_assets/staff_card_bg.png"))),
      height: 124,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Value of ${type.text} Transactions",
              style: AxleTextStyle.pieChartText,
            ),
            Expanded(
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset(svgPath),
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
}
