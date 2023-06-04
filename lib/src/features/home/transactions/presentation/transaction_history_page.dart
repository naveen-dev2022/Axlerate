import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/enums/report_file_type.dart';
import 'package:axlerate/app_util/enums/sort_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_toggle_menu.dart';
import 'package:axlerate/src/common/common_widgets/list_with_search_filters.dart';
import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/domain/ppi_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/domain/tag_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/transaction_controller.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/txn_page_provider.dart';
// import 'package:axlerate/src/features/home/transactions/presentation/controller/txn_page_provider.dart';
import 'package:axlerate/src/features/home/transactions/presentation/fuel_txn_table.dart';
import 'package:axlerate/src/features/home/transactions/presentation/lq_txn_table_widget.dart';
import 'package:axlerate/src/features/home/transactions/presentation/ppi_txn_table.dart';
import 'package:axlerate/src/features/home/transactions/presentation/tag_txn_table.dart';
import 'package:axlerate/src/features/home/user/domain/list_orgs_by_type_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/simple_vehicle_list_query_params.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/debounce_search.dart';
import 'package:axlerate/src/utils/downloads/download_file.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';

final transactionsToggleSwitchIndex = StateProvider<int>((ref) {
  return 0;
});

@RoutePage()
class TransactionHistoryPage extends ConsumerStatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends ConsumerState<TransactionHistoryPage> {
  bool isMobile = false;
  TagTxnQueryParams lqTxnParams = TagTxnQueryParams(size: 15, pageIndex: 1);
  SimpleVehicleListQueryParams simpleVehicleListQueryParams =
      SimpleVehicleListQueryParams(serviceType: ["TAG"], issuerName: ["LIVQUIK"]);
  late Debouncer debouncer;
  // String datePeriod = 'Choose Date Range';
  DateTime? startDate;
  DateTime? endDate;
  // LqTagAdminOrgResponseModel? userData;
  // SimpleVehicleListModel? vehicleLists;
  ListOrgByTypeDoc? listOrgByTypeDoc;
  @override
  void initState() {
    debouncer = Debouncer(milliseconds: 700);
    loadInit();
    super.initState();
  }

  loadInit() async {
    String userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
    ref.read(listofLQTagAdminOrgUserStateProvider.notifier).state =
        await ref.read(vehicleControllerProvider).getLQTagAdminOrgUser(orgEnrolId: userOrgId);
    ref.read(listofVehicleStateProvider.notifier).state =
        await ref.read(vehicleControllerProvider).getSimpleListOfVehicles(qParams: simpleVehicleListQueryParams);
  }

  getListOfLogisticsNew(String? searchText, List<String>? serviceType, Map<Symbol, dynamic> map, String sortField,
      String sortType, int page, List<String> selectedUser, List<String> selectedVehicles) async {
    debouncer.run(() {
      lqTxnParams = Function.apply(lqTxnParams.copyWith, [], map);
      print(map.toString());
      //add sort Params
      // lqTxnParams = lqTxnParams.copyWith(sortType: sortType);
      // if (selectedUser.isNotEmpty) {
      lqTxnParams = lqTxnParams.copyWith(selectedUser: selectedUser);
      // }
      // if (selectedVehicles.isNotEmpty) {
      lqTxnParams = lqTxnParams.copyWith(vehicleRegistrationNumber: selectedVehicles);
      // }
      // lqTxnParams.searchText = searchText;
      lqTxnParams.pageIndex = page;
      getLqTransactionHistory();
    });
  }

  getLqTransactionHistory() async {
    String? userOrgEnrollId;
    final OrgType type = ref.read(localStorageProvider).getOrgType();
    if (type == OrgType.axlerate) {
      userOrgEnrollId = userOrgEnrollId;
    }

    if (lqTxnParams.fileType != null) {
      ref.read(isLoadingDownloadingDocument.notifier).state = true;
      final data = await ref
          .read(transactionControlProvider)
          .listLqTagTxns(params: lqTxnParams, orgEnrollIdOfUser: userOrgEnrollId);
      try {
        String url = data['data']['message'];
        ReportFileType typeDoc = lqTxnParams.fileType!.toLowerCase() == "csv" ? ReportFileType.csv : ReportFileType.pdf;
        FileDownloadUtil.getFileFromUrl(url, typeDoc);
        log(url.toString());
      } catch (e) {
        log(e.toString());
      }
      lqTxnParams.fileType = null;
      ref.read(isLoadingDownloadingDocument.notifier).state = false;
    } else {
      ref.read(lqTagTransactionListStateProvider.notifier).state = null;
      ref.read(lqTagTransactionListStateProvider.notifier).state = await ref
          .read(transactionControlProvider)
          .listLqTagTxns(params: lqTxnParams, orgEnrollIdOfUser: userOrgEnrollId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrgType type = ref.read(localStorageProvider).getOrgType();
    final currentEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.userEnrollmentId) ?? '';

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    ref.watch(txHistoryToggleSwitchIndex);
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
        backgroundColor: AxleColors.axleBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
              padding: isMobile
                  ? const EdgeInsets.all(defaultPadding)
                  : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: type == OrgType.logisticsStaff
                  ? Column(
                      children: [
                        if (!isMobile)
                          const DashboardHeader(
                            title: "Transactions",
                            showBack: false,
                          ),
                        PpiTxnTableWidget(
                            showPagination: true,
                            // stateNotifier: ppiTxnpageNotifierNewProvider,
                            showDateFilter: true,
                            txnParams: PpiTxnQueryParams(
                              pageIndex: 1,
                              size: 15,
                              userEnrollmentId: type == OrgType.logisticsStaff ? currentEnrollId : '',
                            ))
                      ],
                    )
                  : AxleToggleMenu(title: "Transactions", provider: transactionsToggleSwitchIndex, items: [
                      AxleToggleMenuItem(
                          label: "LQ Tag",
                          child: SizedBox(
                            height: screenHeight,
                            width: screenWidth,
                            child: ListWithSearchAndFilter(
                                title: "",
                                listFunction: getListOfLogisticsNew,
                                serviceList: const [],
                                createButton: const SizedBox(),
                                isUsersList: type == OrgType.logisticsAdmin ? true : false,
                                listOrgByTypeDoc: type == OrgType.axlerate ? listOrgByTypeDoc : null,
                                isVehicleLists: type == OrgType.logisticsAdmin ? true : false,
                                filterItems: [
                                  Filter(
                                      title: LabelAndValue(
                                        label: "Type",
                                        value: 'type',
                                      ),
                                      items: [
                                        FilterItem(label: "Credit", value: "CREDIT"),
                                        FilterItem(label: "Debit", value: "DEBIT"),
                                        // FilterItem(label: "Wallet", value: "wallet"),
                                        // FilterItem(label: "Toll", value: "toll"),
                                      ]),
                                  Filter(
                                      title: LabelAndValue(
                                        label: 'Transaction Type',
                                        value: 'transactionType',
                                      ),
                                      items: [
                                        // FilterItem(label: "UPI Collect Credit", value: "UPI_COLLECT_CREDIT"),
                                        FilterItem(label: "Toll Transactions", value: "NETC_CORPORATE_DEBIT"),
                                        //  FilterItem(label: "NETC Retail Debit", value: "NETC_RETAIL_DEBIT"),
                                        FilterItem(label: "Recharges", value: "VIRTUAL_ACCOUNT_CREDIT"),
                                        FilterItem(label: "Fund Load", value: "M2C"),
                                      ]),
                                  // Filter(
                                  //     title: LabelAndValue(
                                  //       label: 'Transaction Status',
                                  //       value: 'transactionStatus',
                                  //     ),
                                  //     items: [
                                  //       FilterItem(label: "Completed", value: "COMPLETED"),
                                  //       FilterItem(label: "Payment Success", value: "PAYMENT_SUCCESS"),
                                  //     ]),
                                ],
                                sortItems: SortItems(items: [
                                  SortItem(
                                      label: "Sort By Created Date - Desc", sortField: '_id', order: OrgsSort.desc),
                                  SortItem(label: "Sort By Name - Asc", sortField: 'firstName', order: OrgsSort.asc),
                                  SortItem(label: "Sort By Name - Desc", sortField: 'firstName', order: OrgsSort.desc)
                                ]),
                                isShowSort: false,
                                child: LQTxnTableWidget(
                                  showDateFilter: true,
                                  showPaginator: true,
                                  isLoad: false,
                                  listStateProvider: lqTagTransactionListStateProvider,
                                  txnParams: lqTxnParams,
                                  dateFilter: ({DateTime? end, DateTime? start}) {
                                    startDate = start;
                                    endDate = end;
                                    if (startDate != null && endDate != null) {
                                      lqTxnParams = lqTxnParams.copyWith(
                                          fromDate: DatePickerUtil.yearMonthDateFormatter(startDate!),
                                          toDate: DatePickerUtil.yearMonthDateFormatter(endDate!));
                                    } else {
                                      lqTxnParams.fromDate = null;
                                      lqTxnParams.toDate = null;
                                      lqTxnParams.fileType = null;
                                    }
                                    getLqTransactionHistory();
                                  },
                                  downLoad: ({fileType}) {
                                    if (fileType != null) {
                                      lqTxnParams = lqTxnParams.copyWith(fileType: fileType.name.toUpperCase());
                                    } else {
                                      lqTxnParams.fileType = null;
                                    }
                                    getLqTransactionHistory();
                                  },
                                )),
                          )),
                      AxleToggleMenuItem(
                          label: "YB Tag",
                          child: TagTxnTableWidget(
                            showDateFilter: true,
                            showPaginator: true,
                            listStateProvider: tagTransactionListStateProvider,
                          )),
                      AxleToggleMenuItem(
                          label: "PPI",
                          child: PpiTxnTableWidget(
                            showPagination: true,
                            // stateNotifier: ppiTxnpageNotifierNewProvider,
                            showDateFilter: true,
                            txnParams: PpiTxnQueryParams(
                              pageIndex: 1,
                              size: 15,
                              userEnrollmentId: type == OrgType.logisticsStaff ? currentEnrollId : '',
                            ),
                          )),
                      AxleToggleMenuItem(
                        label: "FUEL",
                        child: FuelTxnTableWidget(
                          showPagination: true,
                          // stateNotifier: ppiTxnpageNotifierNewProvider,
                          showDateFilter: true,
                          txnParams: FuelTxnQueryParams(
                            pageIndex: 1,
                            size: 15,
                            transactionType: "FUEL",
                          ),
                        ),
                      )
                    ])),
        ));
  }
}
