// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_service_icon.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/common/common_widgets/paginator.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_list_model.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/transaction_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/values/constants.dart';

class TagTxnTableWidget extends ConsumerStatefulWidget {
  TagTxnTableWidget(
      {super.key,
      this.showDateFilter = true,
      this.txnParams,
      this.showPaginator = true,
      this.userOrgEnrollId = '',
      // this.stateNotifier,
      required this.listStateProvider});
  bool showDateFilter;
  final bool showPaginator;
  // final StateNotifierProvider<PageNotifierNew, PaginatorModel>? stateNotifier;
  final StateProvider<TagTxnListModel?> listStateProvider;
  String userOrgEnrollId;
  late TagTxnQueryParams? txnParams;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TagTxnTableWidgetState();
}

class _TagTxnTableWidgetState extends ConsumerState<TagTxnTableWidget> {
  @override
  void initState() {
    widget.txnParams ??= TagTxnQueryParams(size: 15, pageIndex: 1);
    getTransactionsList(widget.txnParams!);
    super.initState();
  }

  // PpiTxnQueryParams txnParams = PpiTxnQueryParams(size: 15);

  Future<void> getTransactionsList(TagTxnQueryParams params) async {
    // log('Call 1 - $loca');
    // debugPrint(widget.txnParams.toString());
    Future(
      () async {
        // if (widget.stateNotifier != null) {
        //   ref.read(widget.stateNotifier!.notifier).setPageIndex(params.pageIndex ?? 1);
        //   if (params.pageIndex == 1) {
        //     ref.read(widget.stateNotifier!.notifier).backToFirst();
        //   }
        // }

        // ref.read(tagTransactionListStateProvider.notifier).state = null;
        String? userOrgEnrollId;
        final OrgType type = ref.read(localStorageProvider).getOrgType();

        if (type == OrgType.axlerate) {
          userOrgEnrollId = widget.userOrgEnrollId;
        }
        ref.read(widget.listStateProvider.notifier).state = null;

        ref.read(widget.listStateProvider.notifier).state =
            await ref.read(transactionControlProvider).listTagTxns(params: params, orgEnrollIdOfUser: userOrgEnrollId);
      },
    );
  }

  List<String> headerItems = ["Date", "Vehicle", "Description", "Amount"];

  // late double contentWidth;

  String datePeriod = 'Choose Date Range';
  DateTime? startDate;
  DateTime? endDate;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isMobile = Responsive.isMobile(context);
    availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * headerItems.length));
    if (widget.txnParams != null && widget.txnParams!.fromDate != null) {
      startDate = DateTime.parse(widget.txnParams!.fromDate!);
      endDate = DateTime.parse(widget.txnParams!.toDate!);
      datePeriod = '${DateFormat("dd-MMM-yy").format(startDate!)}  -  ${DateFormat("dd-MMM-yy").format(endDate!)}';
    }
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    // contentWidth = availableWidth / headerItems.length;
    final txnList = ref.watch(widget.listStateProvider);

    return tagTxnTableWidget(txnList, screenHeight);
  }

  Widget tagTxnTableWidget(TagTxnListModel? txnList, double screenHeight) {
    return Column(
      children: [
        if (widget.showDateFilter)
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            AxlePrimaryButton(
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

                // debugPrint(range.toString());
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
              buttonText: datePeriod,
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
                    getTransactionsList(widget.txnParams!.copyWith(pageIndex: 1));
                  },
                  icon: const Icon(Icons.clear_rounded)),
          ]),
        const SizedBox(
          height: defaultMobilePadding,
        ),
        if (!isMobile) transactionsHeader(),
        const SizedBox(
          height: defaultMobilePadding,
        ),
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

                              TagTxnDoc item = txnList.data!.message!.docs[index];

                              List<String> itemRowData = [
                                isMobile
                                    ? DatePickerUtil.dateLongMonthYearWithNewLineTimeFormatterIsd(item.transactionTime!)
                                    : DatePickerUtil.dateLongMonthYearWithTimeFormatterIsd(item.transactionTime!),
                                item.vehicleInfo?.vehicleEntityId ?? '-',
                                item.description, //item.tollPlazaName,
                                item.metadata?.type.toString() ?? '',
                                axleCurrencyFormatterwithDecimals.format(item.amount),
                              ];
                              return isMobile ? listItemMobile(context, itemRowData) : listItem(context, itemRowData);
                            },
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        if (widget.showPaginator && widget.txnParams != null)
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
                        //   totalCount: txnList.data!.message!.count,
                        //   pageSize: widget.txnParams!.size!,
                        //   stateNotifier: widget.stateNotifier!,
                        //   onChange: (val) {
                        //     getTransactionsList(widget.txnParams!.copyWith(pageIndex: val), 'Paginator');
                        //   },
                        // ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     PageIndicatorCard(
                        //       value: '<',
                        //       onPress: ref.read(tagTxnPageNotifierProvider.notifier).prevPage,
                        //       onLongPressed: ref.read(tagTxnPageNotifierProvider.notifier).backToFirst,
                        //     ),
                        //     Align(
                        //       alignment: Alignment.center,
                        //       child: SizedBox(
                        //         width: 130,
                        //         height: 40.0,
                        //         child: ListView.builder(
                        //           itemCount: 3,
                        //           shrinkWrap: true,
                        //           scrollDirection: Axis.horizontal,
                        //           itemBuilder: (context, index) {
                        //             final value = ref.watch(tagTxnPageNotifierProvider);
                        //             return PageIndicatorCard(
                        //               value: value[index].toString(),
                        //               onPress: () async {
                        //                 widget.txnParams = widget.txnParams!.copyWith(pageIndex: value[index]);
                        //                 ref.read(tagTransactionListStateProvider.notifier).state = null;
                        //                 ref.read(tagTransactionListStateProvider.notifier).state =
                        //                     await ref.read(transactionControlProvider).listTagTxns(widget.txnParams);
                        //               },
                        //             );
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //     PageIndicatorCard(
                        //       value: '>',
                        //       onPress: ref.read(tagTxnPageNotifierProvider.notifier).nextPage,
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
      ],
    );
  }

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
      // decoration:
      //     BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
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
          // width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            child: Center(child: Text(rowItem[0])),
          ),
        ),
        Flexible(
          flex: 1,
          // width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            child: Center(child: Text(rowItem[1])),
          ),
        ),
        Flexible(
          flex: 1,
          // width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            child: Center(child: Text(rowItem[2])),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          // width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 40,
                width: 140,
                child: AxleTextWithBg(
                  text: "${rowItem[4]} ${rowItem[3] == 'DEBIT' ? 'Dr' : 'Cr'}",
                  textColor:
                      rowItem[3].contains('DEBIT') ? AxleColors.rejectedStatusColor : AxleColors.enabledStatusColor,
                ),
              ),
            ),
          ),
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
              width: 50,
              child: AxleServiceIcon(svgPath: "assets/icons/yb_fastag_icon.svg", status: "TABLE"),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rowItem[1], style: AxleTextStyle.subtitle1BlackBold, maxLines: 2),
                AxleTextWithBg(
                  text: rowItem[2],
                  textColor: AxleColors.dashGreen,
                  maxLines: 2,
                  wrapText: true,
                )
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(
                    rowItem[3] == 'DEBIT' ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                    size: 15,
                    color: rowItem[3] == 'DEBIT' ? AxleColors.rejectedStatusColor : AxleColors.enabledStatusColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rowItem[4],
                    maxLines: 2,
                    style: AxleTextStyle.textFieldHeadingStyle.copyWith(
                      color: (rowItem[3] == 'DEBIT' ? AxleColors.rejectedStatusColor : AxleColors.enabledStatusColor),
                    ),
                  ),
                ]),
                Text(rowItem[0], textAlign: TextAlign.right, style: AxleTextStyle.subtitle2IconGrey)
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
