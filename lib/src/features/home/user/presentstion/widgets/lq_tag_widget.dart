import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/features/home/partner/presentation/widgets/recent_lists.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_list_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/empty_response_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/lq_account_info_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/lq_wallet_widget.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';

// ignore: must_be_immutable
class LqTagWidget extends StatelessWidget {
  LqTagWidget({
    Key? key,
    required this.userEnrollmentId,
    required this.orgenrollIdOfUser,
    required this.txnList,
    this.lqTagService,
    this.ppiService,
  }) : super(key: key);

  final TagTxnListModel? txnList;
  UserService? ppiService;
  UserService? lqTagService;
  final String userEnrollmentId;
  final String orgenrollIdOfUser;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return isMobile
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (lqTagService != null)
              LqTagWallet(
                userEnrollmentId: userEnrollmentId,
                kycType: lqTagService!.kycType,
                kycStatus: lqTagService!.kycStatus,
                orgenrollIdOfUser: orgenrollIdOfUser,
              ),
            const SizedBox(height: defaultPadding),
            LqTagAdminAccountInfo(orgEnrollId: orgenrollIdOfUser, userEnrollmentId: userEnrollmentId),
            const SizedBox(height: defaultPadding),
            Text("Recent Transactions", style: AxleTextStyle.headingPrimary),
            const SizedBox(height: defaultMobilePadding),
            txnList == null
                ? AxleLoader.axleProgressIndicator()
                : txnList!.data == null
                    ? const EmptyResponseWidget()
                    : LqTagRecentTransactionsList(txnList: txnList)
          ])
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (lqTagService != null)
                      LqTagWallet(
                        userEnrollmentId: userEnrollmentId,
                        kycType: lqTagService!.kycType,
                        kycStatus: lqTagService!.kycStatus,
                        orgenrollIdOfUser: orgenrollIdOfUser,
                      ),
                    const SizedBox(width: defaultPadding),
                    LqTagAdminAccountInfo(orgEnrollId: orgenrollIdOfUser, userEnrollmentId: userEnrollmentId)
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding),
              const SizedBox(height: defaultPadding),
              Text("Recent Transactions", style: AxleTextStyle.headingPrimary),
              const SizedBox(height: defaultMobilePadding),
              Column(
                children: [
                  transactionsHeader(isMobile, screenWidth, recentTransactionsHeaderItems),
                  const SizedBox(
                    height: 4,
                  ),
                  txnList == null
                      ? AxleLoader.axleProgressIndicator()
                      : txnList != null && txnList!.data == null
                          ? const EmptyResponseWidget()
                          : LqTagRecentTransactionsList(txnList: txnList),
                ],
              )
            ],
          );
  }
}

// ignore: must_be_immutable
class LqTagRecentTransactionsList extends StatelessWidget {
  const LqTagRecentTransactionsList({
    Key? key,
    required this.txnList,
  }) : super(key: key);

  final TagTxnListModel? txnList;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        if (txnList != null)
          SizedBox(
            height: screenHeight * 80 / 100,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: txnList!.data?.message?.docs.isEmpty ?? true ? 1 : txnList!.data?.message?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                if (txnList!.data?.message?.docs.isEmpty ?? true) {
                  return const EmptyResponseWidget();
                }

                TagTxnDoc item = txnList!.data!.message!.docs[index];
                List<String> itemRowData = [
                  isMobile
                      ? DatePickerUtil.dateLongMonthYearWithNewLineTimeFormatter(item.transactionTime!)
                      : DatePickerUtil.dateLongMonthFormatter(item.transactionTime!),
                  item.vehicleInfo?.vehicleEntityId ?? '-',
                  item.tollPlazaName,
                  item.transactionType,
                  axleCurrencyFormatterwithDecimals.format(item.amount),
                  item.type
                ];

                return isMobile
                    ? listItemMobile(context, itemRowData)
                    : listItem(context, isMobile, screenWidth, itemRowData);
              },
            ),
          ),
      ],
    );
  }
}
