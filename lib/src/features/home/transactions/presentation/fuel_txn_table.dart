// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_service_icon.dart';
import 'package:axlerate/src/common/common_widgets/paginator.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_list_model.dart';
import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_query_params.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/selected_organisation_controller.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/transaction_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/values/constants.dart';

class FuelTxnTableWidget extends ConsumerStatefulWidget {
  FuelTxnTableWidget({
    super.key,
    this.showDateFilter = true,
    this.txnParams,
    this.showPagination = false,
    this.userOrgEnrollId = '',
    // this.stateNotifier,
  });
  bool showDateFilter;
  late FuelTxnQueryParams? txnParams;
  final bool showPagination;
  String userOrgEnrollId;
  // final StateNotifierProvider<PageNotifierNew, PaginatorModel>? stateNotifier;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FuelTxnTableWidgetState();
}

class _FuelTxnTableWidgetState extends ConsumerState<FuelTxnTableWidget> {
  @override
  void initState() {
    // widget.txnParams ??= FuelTxnQueryParams(
    //   size: 15,
    //   pageIndex: 1,
    // );
    getTransactionsList(widget.txnParams!);
    super.initState();
  }

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  Future<void> getTransactionsList(FuelTxnQueryParams params) async {
    Future(
      () async {
        // if (widget.stateNotifier != null) {
        //   ref.read(widget.stateNotifier!.notifier).setPageIndex(params.pageIndex ?? 1);
        //   if (params.pageIndex == 1) {
        //     ref.read(widget.stateNotifier!.notifier).backToFirst();
        //   }
        // }
        String? userOrgEnrollId;
        final OrgType type = ref.read(localStorageProvider).getOrgType();

        if (type == OrgType.axlerate) {
          userOrgEnrollId = widget.userOrgEnrollId;
        }
        ref.read(fuelTransactionListStateProvider.notifier).state = null;
        ref.read(fuelTransactionListStateProvider.notifier).state =
            await ref.read(transactionControlProvider).listFuelTxns(params: params, orgEnrollIdOfUser: userOrgEnrollId);
      },
    );
  }

  List<String> headerItems = ["Date", "Description", "Amount", "Type", "TXN Type"];

  // late double contentWidth;

  String datePeriod = 'Choose Date Range';
  DateTime? startDate;
  DateTime? endDate;

  late SelectedOrganizationModel selOrg;
  int pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    selOrg = ref.watch(selectedOrganizationStateProvider);

    if (widget.txnParams!.fromDate != null) {
      startDate = DateTime.parse(widget.txnParams!.fromDate!);
      endDate = DateTime.parse(widget.txnParams!.toDate!);
      datePeriod = '${DateFormat("dd-MMM-yy").format(startDate!)}  -  ${DateFormat("dd-MMM-yy").format(endDate!)}';
    }

    // if (selOrg.type == 'AXLERATE') {
    //   headerItems = ["Date", "Description", "Amount", "User"];
    //   headerItems.addAll(["Org", "Partner"]);
    // }

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isMobile = Responsive.isMobile(context);

    availableWidth = screenWidth - sideMenuWidth - (defaultPadding * 3);

    if (isMobile) {
      // widget.showDateFilter = false;
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    // contentWidth = availableWidth / headerItems.length;
    final txnList = ref.watch(fuelTransactionListStateProvider);

    return fuelTxnTableWidget(txnList, screenHeight);
  }

  Widget fuelTxnTableWidget(FuelTxnListModel? txnList, double screenHeight) {
    return Column(
      children: [
        if (widget.showDateFilter && txnList != null && (txnList.data?.message?.count ?? 0) > 15)
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            AxlePrimaryButton(
              buttonText: datePeriod,
              buttonWidth: isMobile
                  ? startDate == null
                      ? availableWidth
                      : availableWidth - 48
                  : 350,
              onPress: () async {
                DateTimeRange? range = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2023, 1, 1),
                  lastDate: DateTime.now(),
                  saveText: "Filter",
                  confirmText: "Confirm",
                  cancelText: "Cancel",
                  initialEntryMode: DatePickerEntryMode.calendar,
                  builder: (context, child) {
                    return Column(
                      children: [
                        ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 400,
                            ),
                            child: child!),
                      ],
                    );
                  },
                  helpText: "Choose Date Range to Filter Transactions",
                  // anchorPoint: Offset(350, 350)
                );

                if (range != null) {
                  // debugPrint(range.start.toIso8601String());
                  // debugPrint(range.start.to);

                  setState(() {
                    startDate = range.start;
                    endDate = range.end;
                    datePeriod =
                        '${DateFormat("dd-MMM-yy").format(startDate!)}  -  ${DateFormat("dd-MMM-yy").format(endDate!)}';
                    widget.txnParams = widget.txnParams!.copyWith(
                        fromDate: range.start.toIso8601String(), toDate: range.end.toIso8601String(), pageIndex: 1);
                  });

                  getTransactionsList(widget.txnParams!);
                }
              },
            ),
            if (startDate != null)
              IconButton(
                  onPressed: () {
                    setState(() {
                      startDate = null;
                      endDate = null;
                      datePeriod = 'Choose Date Range';
                      widget.txnParams!.pageIndex = 1;
                      widget.txnParams!.fromDate = null;
                      widget.txnParams!.toDate = null;
                    });
                    getTransactionsList(widget.txnParams!);
                  },
                  icon: const Icon(Icons.clear_rounded)),
          ]),
        const SizedBox(height: defaultMobilePadding),
        if (!isMobile) transactionsHeader(),
        const SizedBox(height: defaultMobilePadding),
        txnList == null
            ? AxleLoader.axleProgressIndicator()
            : txnList.data == null
                ? emptyResponse()
                : SingleChildScrollView(
                    // physics: const ScrollPhysics(),
                    // reverse: true,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 56 / 100,
                          child: ListView.builder(
                            primary: false,
                            // shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                txnList.data?.message?.docs.isEmpty ?? true ? 1 : txnList.data?.message?.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (txnList.data?.message?.docs.isEmpty ?? true) return emptyResponse();

                              DocFuel item = txnList.data!.message!.docs[index];

                              List<String> itemRowData = [
                                isMobile
                                    ? DatePickerUtil.dateLongMonthYearWithNewLineTimeFormatterIsd(item.transactionTime!)
                                    : DatePickerUtil.dateLongMonthYearWithTimeFormatterIsd(item.transactionTime!),
                                item.description,
                                axleCurrencyFormatterwithDecimals.format(item.amount),
                                item.metadata?.type.toString() ?? '',
                                item.transactionType,
                                item.metadata?.type.toString() ?? '',
                              ];
                              return isMobile ? listItemMobile(context, itemRowData) : listItem(context, itemRowData);
                            },
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        if (widget.showPagination)
                          // showPaginator(txnList.data!.message!.count!),
                          AxleSimplePaginator(
                            currentPage: widget.txnParams!.pageIndex!,
                            pageSize: widget.txnParams!.size!,
                            totalItems: txnList.data!.message!.count,
                            onChange: (val) {
                              widget.txnParams = widget.txnParams!.copyWith(pageIndex: val);
                              getTransactionsList(widget.txnParams!);
                            },
                          )
                        // AxlePaginator(
                        //     totalCount: txnList.data!.message!.count!,
                        //     pageSize: widget.txnParams!.size!,
                        //     stateNotifier: widget.stateNotifier!,
                        //     onChange: ((value) {
                        //       getTransactionsList(widget.txnParams!.copyWith(pageIndex: value));
                        //       // debugPrint(widget.txnParams.toString());
                        //     }))
                      ],
                    ),
                  ),
      ],
    );
  }

  // String getDescription(Doc item) {
  //   if (item.transactionType != "B2C") {
  //     return item.to!;
  //   }

  //   // if (item.metadata!.accountInfoEntity ==
  //   //     item.metadata!.organizationEntityId) {
  //   if (item.type == "CREDIT") {
  //     return "Wallet Reload from Admin - ${item.organization!.firstName}";
  //   }
  //   return "Wallet Transfer to User - ${item.user!.name}";
  //   // }

  //   // if (item.metadata!.accountInfoEntity == item.metadata!.userEntityId) {
  //   //   if (item.type == "CREDIT") {
  //   //     return "Wallet Transfer from Org - ${item.organization!.firstName}";
  //   //   }
  //   //   return "Wallet Transfer to User - ${item.user!.name}";
  //   // }
  // }

  // Widget showPaginator(int totalCount) {
  //   int maxPage = totalCount ~/ widget.txnParams!.size! + 1;
  //   final value = ref.watch(widget.stateNotifier!(maxPage));
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       PageIndicatorCard(
  //         value: '<',
  //         onPress: ref.read(widget.stateNotifier!(maxPage).notifier).prevPage,
  //         onLongPressed:
  //             ref.read(widget.stateNotifier!(maxPage).notifier).backToFirst,
  //       ),
  //       Align(
  //         alignment: Alignment.center,
  //         child: SizedBox(
  //           width: 130,
  //           height: 40.0,
  //           child: ListView.builder(
  //             itemCount: value.length,
  //             shrinkWrap: true,
  //             scrollDirection: Axis.horizontal,
  //             itemBuilder: (context, index) {
  //               return PageIndicatorCard(
  //                 value: value[index].toString(),
  //                 isSelected: value[index] == pageIndex,
  //                 onPress: () async {
  //                   setState(() {
  //                     pageIndex = value[index];
  //                   });
  //                   getTransactionsList(
  //                       widget.txnParams!.copyWith(pageIndex: value[index]));
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //       ),
  //       PageIndicatorCard(
  //         value: '>',
  //         onPress: ref.read(pageNotifierNewProvider(maxPage).notifier).nextPage,
  //       ),
  //     ],
  //   );
  // }

  Widget transactionsHeader() {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for (int i = 0; i < headerItems.length; i++) headerItem(headerItems[i]),
      ],
    ));
  }

  Widget headerItem(String text) {
    return Flexible(
      flex: 1,
      // width: contentWidth,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(child: Text(text)),
      ),
    );
  }

  Widget emptyResponse() {
    return const AxleErrorWidget(
      imgHeight: 250.0,
      titleStr: HomeConstants.noTxnStr,
      subtitle: HomeConstants.noTxnTrailingStr,
    );
  }

  Widget listItem(BuildContext context, List<String> rowItem) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // SizedBox(
        //   width: contentWidth,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //         vertical: defaultMobilePadding,
        //         horizontal: defaultMobilePadding),
        //     child: Wrap(
        //       crossAxisAlignment: WrapCrossAlignment.center,
        //       children: [
        //         const AxleServiceIcon(
        //             svgPath: "assets/new_assets/icons/card_icon.svg",
        //             status: "TABLE"),
        //         const SizedBox(
        //           width: defaultPadding,
        //         ),
        //         Text(rowItem[0]),
        //       ],
        //     ),
        //   ),
        // ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            child: Center(child: Text(rowItem[0])),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            child: Center(child: Text(rowItem[1])),
          ),
        ),
        // SizedBox(
        //   width: contentWidth,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //         vertical: defaultPadding, horizontal: defaultPadding),
        //     child: Text(rowItem[2]),
        //   ),
        // ),
        // SizedBox(
        //   width: contentWidth,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //         vertical: defaultPadding, horizontal: defaultPadding),
        //     child: Text(rowItem[3]),
        //   ),
        // ),
        Flexible(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
              child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 40,
                    width: 140,
                    child: AxleTextWithBg(
                      text: "${rowItem[2]} ${(rowItem[3] == "DEBIT" ? 'Dr' : 'Cr').toTitleCase().substring(0, 2)}",
                      textColor: rowItem[3] == 'DEBIT' ? AxleColors.rejectedStatusColor : AxleColors.enabledStatusColor,
                    ),
                  ))),
        ),
        // SizedBox(
        //   width: contentWidth,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //         vertical: defaultPadding, horizontal: defaultPadding),
        //     child: Align(
        //         alignment: Alignment.centerLeft,
        //         child: SizedBox(
        //           height: 40,
        //           width: 100,
        //           child: AxleTextWithBg(
        //             text: rowItem[5].toTitleCase(),
        //             textColor: rowItem[5] == 'DEBIT'
        //                 ? AxleColors.rejectedStatusColor
        //                 : AxleColors.enabledStatusColor,
        //           ),
        //         )
        //         // Container(
        //         //     height: 40,
        //         //     width: 100,
        //         //     decoration: BoxDecoration(
        //         //       color: rowItem[4] == 'DEBIT'
        //         //           ? AxleColors.debitBgColor
        //         //           : AxleColors.creditBgColor,
        //         //       borderRadius: BorderRadius.circular(10),
        //         //     ),
        //         //     child: Center(
        //         //         child: Text(
        //         //       rowItem[4].toTitleCase(),
        //         //       style: TextStyle(
        //         //         color: rowItem[4] == 'DEBIT'
        //         //             ? AxleColors.rejectedStatusColor
        //         //             : AxleColors.enabledStatusColor,
        //         //       ),
        //         //     ))),
        //         ),
        //   ),
        // ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            child: Center(child: Text(rowItem[4])),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            child: Center(child: Text(rowItem[5])),
          ),
        ),
        // if (selOrg.type == "AXLERATE")
        //   Flexible(
        //     flex: 1,
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
        //       child: Center(child: Text(rowItem[6])),
        //     ),
        //   ),
      ],
    ));
  }

  Widget listItemMobile(BuildContext context, List<String> rowItem) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(defaultMobilePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Flexible(
            flex: 1,
            child: SizedBox(
              width: 40,
              child: AxleServiceIcon(svgPath: "assets/new_assets/icons/card_icon.svg", status: "TABLE"),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rowItem[4],
                    style: AxleTextStyle.bodyMedium.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                    maxLines: 2),
                const SizedBox(height: 2),
                AxleTextWithBg(text: rowItem[1], textColor: AxleColors.dashPink, maxLines: 2, wrapText: true)
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(
                    rowItem[3] == 'DEBIT' ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                    size: 15,
                    color: rowItem[3] == 'DEBIT' ? AxleColors.rejectedStatusColor : AxleColors.enabledStatusColor,
                  ),
                  //const SizedBox(width: 4),
                  Text(rowItem[2],
                      style: AxleTextStyle.labelLarge.copyWith(
                          color: (rowItem[3] == 'DEBIT'
                              ? AxleColors.rejectedStatusColor
                              : AxleColors.enabledStatusColor))),
                ]),
                Text(rowItem[0],
                    textAlign: TextAlign.right, style: AxleTextStyle.labelMedium.copyWith(color: Colors.grey))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
