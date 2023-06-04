import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/sort_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_controllers/filter_controller_provider.dart';
import 'package:axlerate/src/common/common_controllers/list_orgs_filter_controller.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_icon_button.dart';
import 'package:axlerate/src/common/common_widgets/list_with_search_filters.dart';
import 'package:axlerate/src/common/common_widgets/listing_card.dart';
import 'package:axlerate/src/common/common_widgets/paginator.dart';
import 'package:axlerate/src/dialogs/create_customer_alert_dialog.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_alert_dialog_mode.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_ui_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

@RoutePage()
class ListLogisticsPage extends ConsumerStatefulWidget {
  const ListLogisticsPage({super.key});

  final String name = 'logisticsListPage';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListLogisticsPageState();
}

class _ListLogisticsPageState extends ConsumerState<ListLogisticsPage> {
  int currentPageIndex = 1;
  // OrgsSort _selectedSortVal = OrgsSort.desc;

  ListOrgsQueryParams params = ListOrgsQueryParams(organizationType: 'LOGISTICS');
  // final serviceFilterList = ['All', 'FASTag', 'Prepaid Card', 'Fuel Card', 'GPS'];

  @override
  void initState() {
    super.initState();
  }

  Future<void> getListOfLogistics(ListOrgsQueryParams params1) async {
    ref.read(listLogisticsPageNotifierProvider.notifier).setPageIndex(params1.pageIndex ?? 1);
    params = params.copyFrom(params1);
    ref.read(listofLogisticsStateProvider.notifier).state = null;
    ref.read(listofLogisticsStateProvider.notifier).state =
        await ref.read(logisticsControllerProvider).getLogisticsList(queryParams: params1);
  }

  Future<void> getListOfLogisticsNew(String? searchText, List<String>? serviceType, Map<Symbol, dynamic> map,
      String sortField, String sortType, int page, List<String> selectedUser, List<String> selectedVehicles) async {
    params.serviceType = serviceType;
    params = Function.apply(params.copyWith, [], map);
    //add sort Params

    params = params.copyWith(sortField: sortField, sortType: sortType);

    params.searchText = searchText;
    params.pageIndex = page;

    ref.read(listofLogisticsStateProvider.notifier).state = null;
    ref.read(listofLogisticsStateProvider.notifier).state =
        await ref.read(logisticsControllerProvider).getLogisticsList(queryParams: params);
  }

  bool isMobile = false;
  TextEditingController searchTextController = TextEditingController();
  // List<ValueItem> getSelectedItems() {
  //   if (params.state == null) return [];
  //   List<ValueItem> selectedStates = params.state!
  //       .map((e) => ValueItem(
  //             label: e,
  //             value: e,
  //           ))
  //       .toList();

  //   return selectedStates;
  // }

  @override
  Widget build(BuildContext context) {
    // int count = ref.watch(listofLogisticsStateProvider.notifier).state?.data?.message.count ?? 0;
    // int pageCount = ref.watch(listofLogisticsStateProvider.notifier).state?.data?.message.docs.length ?? 0;

    isMobile = Responsive.isMobile(context);

    final logisticsList = ref.watch(listofLogisticsStateProvider);
    //final filterVisibility =
    ref.watch(filterVisibilityProviderLogistics);
    //final lastPage = ref.watch(logsListEndPageProvider);
    // Reader
    //final natureOfBusinessFilter =
    ref.read(natureOfBusinessNotifierProviderLogistics.notifier);
    //final regStatusFilter =
    ref.read(registrationStatusQueryProviderLogistics.notifier);
    // final registrationStatusFilter =
    //     ref.read(registrationStatusQueryProvider.notifier);
    //final statesFilter =
    ref.read(stateFilterProvider.notifier);
    // Timer? _debounce;
    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      floatingActionButton: isMobile
          ? FloatingActionButton(
              backgroundColor: primaryColor,
              mouseCursor: SystemMouseCursors.click,
              child: const Icon(Icons.add),
              onPressed: () {
                context.router.pushNamed('create');
              })
          : const SizedBox(),
      body: ListWithSearchAndFilter(
        // ignore: prefer_interpolation_to_compose_strings
        title: HomeConstants.customers, // + "(" + pageCount.toString() + '/' + count.toString() + ')',

        searchFieldHint: 'Search By Customer Name / ID / Mobile Number',
        listFunction: getListOfLogisticsNew,
        // params: ListOrgsQueryParams(organizationType: 'LOGISTICS'),
        // toggleStateProvider: orgServiceFilterPageIndexProvider,
        serviceList: [
          LabelAndValue(label: "All"),
          LabelAndValue(label: "FASTag", value: "TAG"),
          LabelAndValue(label: "Prepaid Card", value: "PPI"),
          LabelAndValue(label: "Fuel Card", value: "FUEL"),
          LabelAndValue(label: "GPS", value: "GPS"),
          // DisplayAndValue(displayText: "PaymentLink", value: "TAG" ),
        ],
        createButton: AxlePrimaryIconButton(
          buttonIcon: const Icon(Icons.add, size: 20.0),
          buttonWidth: 180.0,
          onPress: () async {
            // ref.read(filterVisibilityProviderLogistics.notifier).hide();
            final val = await displayCreateAlertDialog(context);
            // final orgEnrollId =
            //     ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId)!.toLowerCase();
            if (val == 'c' && mounted) {
              context.router.pushNamed('create');
            } else if (val == 'i') {
              context.router.pushNamed(
                'invite',
              );
            }
          },
          buttonText: HomeConstants.createCustomer,
          buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
        ),
        filterItems: [
          Filter(
              title: LabelAndValue(
                label: "Status",
                value: 'status',
              ),
              items: [
                FilterItem(label: "Invited", value: "Invited".toValueCase),
                FilterItem(label: "Active", value: "Approved".toValueCase),
                // FilterItem(label: "Partnership", value: "Partnership".toValueCase),
                // FilterItem(label: "Pvt. Ltd", value: "Pvt. Ltd".toValueCase),
                // FilterItem(label: "Public. Ltd", value: "Public. Ltd".toValueCase),
                // FilterItem(label: "Govt. Body", value: "Govt. Body".toValueCase),
              ]),
          Filter(
              title: LabelAndValue(
                label: HomeConstants.natureOfBusiness,
                value: 'natureOfBusiness',
              ),
              items: [
                FilterItem(label: "Individual", value: "Individual".toValueCase),
                FilterItem(label: "Sole Proprietor", value: "Sole Proprietor".toValueCase),
                FilterItem(label: "Partnership", value: "Partnership".toValueCase),
                FilterItem(label: "Pvt. Ltd", value: "Pvt. Ltd".toValueCase),
                FilterItem(label: "Public. Ltd", value: "Public. Ltd".toValueCase),
                FilterItem(label: "Govt. Body", value: "Govt. Body".toValueCase),
                FilterItem(label: "SCHOOL_TRUST_ASSOCIATIONS".toUiCase, value: "SCHOOL_TRUST_ASSOCIATIONS".toValueCase)
              ]),
          Filter(
              title: LabelAndValue(label: HomeConstants.state, value: 'state'),
              items: listOfStates.map((state) => FilterItem(label: state, value: state)).toList()),
        ],
        sortItems: SortItems(items: [
          SortItem(label: "Sort By Created Date - Desc", sortField: '_id', order: OrgsSort.desc),
          SortItem(label: "Sort By Name - Asc", sortField: 'firstName', order: OrgsSort.asc),
          SortItem(label: "Sort By Name - Desc", sortField: 'firstName', order: OrgsSort.desc)
        ]),
        child: ref.read(listofLogisticsStateProvider.notifier).state == null
            ? AxleLoader.axleProgressIndicator()
            : loadListOfLogisticsCard(logisticsList),
      ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   mainAxisSize: MainAxisSize.min,
      //   verticalDirection: VerticalDirection.down,
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text(
      //           HomeConstants.customers,
      //           style: AxleTextStyle.headingPrimary,
      //         ),
      //         const SizedBox(width: 20.0),
      //         !isMobile
      //             ? SizedBox(
      //                 width: 500,
      //                 height: 50.0,
      //                 child: TextField(
      //                   controller: searchTextController,
      //                   onSubmitted: ((value) {
      //                     params = params.copyWith(searchText: value);
      //                     getListOfLogistics(params);
      //                   }),
      //                   onChanged: (value) {
      //                     if (_debounce?.isActive ?? false) _debounce?.cancel();
      //                     _debounce = Timer(const Duration(milliseconds: 400), () {
      //                       params = params.copyWith(searchText: value);
      //                       getListOfLogistics(params);
      //                     });
      //                   },
      //                   decoration: InputDecoration(
      //                     hintText: 'Search By Customer Name / ID / Mobile Number',
      //                     fillColor: Colors.white,
      //                     filled: true,
      //                     suffixIcon: params.searchText == null
      //                         ? null
      //                         : InkWell(
      //                             onTap: (() {
      //                               searchTextController.clear();
      //                               // setState(() {
      //                               params.searchText = null;
      //                               // });
      //                               getListOfLogistics(params);
      //                             }),
      //                             child: const Icon(Icons.close)),
      //                     prefixIcon: const Icon(
      //                       Icons.search,
      //                       color: AxleColors.axlePrimaryColor,
      //                     ),
      //                     border: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(12.0),
      //                       borderSide: BorderSide.none,
      //                     ),
      //                   ),
      //                 ),
      //               )
      //             : const SizedBox()
      //       ],
      //     ),
      //     const SizedBox(height: 20.0),
      //     if (!isMobile) toggleAndButtonWidget(),
      //     if (!isMobile) const SizedBox(height: defaultPadding),
      //     FilterChipList(items: [
      //       if (params.searchText != null && params.searchText != "")
      //         AxleFilterChip(
      //           text: params.searchText!,
      //           onTap: () {
      //             // setState(() {
      //             params = params.copyWith(searchText: null);
      //             // });
      //             getListOfLogistics(params);
      //           },
      //         ),
      //       if (params.state != null)
      //         for (String state in params.state!)
      //           AxleFilterChip(
      //             text: state,
      //             onTap: () {
      //               params.state!.removeWhere((ele) => ele == state);
      //               getListOfLogistics(params);
      //             },
      //           ),
      //       if (params.natureOfBusiness != null)
      //         for (String item in params.natureOfBusiness!)
      //           AxleFilterChip(
      //             text: item.toUiCase,
      //             onTap: () {
      //               List<NameStatusModel> natureOfBusinesses =
      //                   ref.read(natureOfBusinessNotifierProviderLogistics.notifier).state;

      //               for (int i = 0; i < natureOfBusinesses.length; i++) {
      //                 if (natureOfBusinesses[i].name == item.toUiCase) {
      //                   natureOfBusinesses[i].status = false;
      //                   break;
      //                 }
      //               }

      //               ref.read(natureOfBusinessNotifierProviderLogistics.notifier).state =
      //                   natureOfBusinesses;
      //               params.natureOfBusiness!.removeWhere((ele) => ele == item);
      //               getListOfLogistics(params);
      //             },
      //           )
      //     ]),
      //     const SizedBox(height: 20.0),

      //     // AxleToggleMenu(
      //     //   provider: orgsListPageToggleIndex,
      //     //   items: [
      //     //     AxleToggleMenuItem(
      //     //       label: 'All (${logisticsList?.data?.message.count ?? '-'})',
      //     //       child: logisticsList == null
      //     //           ? AxleLoader.axleProgressIndicator()
      //     //           : loadListOfLogisticsCard(logisticsList),
      //     //     ),
      //     //     AxleToggleMenuItem(
      //     //       label: 'FASTag (${fil ?? '-'})',
      //     //       child: logisticsList == null
      //     //           ? AxleLoader.axleProgressIndicator()
      //     //           : loadListOfLogisticsCard(logisticsList),
      //     //     )
      //     //   ],
      //     // ),
      //     ref.read(listofLogisticsStateProvider.notifier).state == null
      //         ? AxleLoader.axleProgressIndicator()
      //         : loadListOfLogisticsCard(logisticsList),
      //   ],
      // ),
      // const SizedBox(height: 20.0),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

      // Stack Second Item
      // * Filters PopUp
      // if (!isMobile)
      //   Positioned(
      //     top: 500.0,
      //     right: 10.0,
      //     left: MediaQuery.of(context).size.width * 0.55,
      //     bottom: 10.0,
      //     child: Visibility(
      //       visible: filterVisibility,
      //       child: Container(
      //         padding: const EdgeInsets.all(16.0),
      //         width: 400.0,
      //         // height: 500.0,
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(12.0),
      //           boxShadow: [
      //             BoxShadow(
      //               spreadRadius: 2.0,
      //               blurRadius: 3.0,
      //               color: Colors.grey.shade200,
      //             )
      //           ],
      //         ),
      //         child: SingleChildScrollView(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     HomeConstants.filters,
      //                     style: AxleTextStyle.miniHeadingBlackStyle,
      //                   ),
      //                   AxlePrimaryButton(
      //                     buttonText: 'Go',
      //                     buttonWidth: 60.0,
      //                     buttonHeight: 40.0,
      //                     buttonTextStyle: AxleTextStyle.goButtonstyle,
      //                     onPress: () async {
      //                       params = params.copyWith(
      //                         pageIndex: ref.read(logisticsCurrentPageProvider),
      //                         status: regStatusFilter.selectedFilter(),
      //                         natureOfBusiness: natureOfBusinessFilter.selectedFilter(),
      //                         state: ref.read(stateFilterProvider),
      //                         sortType: getSortTypeString(_selectedSortVal),
      //                       );
      //                       ref.read(filterVisibilityProviderLogistics.notifier).hide();
      //                       ref.read(listofLogisticsStateProvider.notifier).state = null;
      //                       ref.read(listofLogisticsStateProvider.notifier).state =
      //                           await ref.read(logisticsControllerProvider).getLogisticsList(queryParams: params);
      //                     },
      //                   ),
      //                 ],
      //               ),
      //               const SizedBox(height: 12.0),
      //               // * Sort By Filter
      //               ExpansionTile(
      //                 title: Text(
      //                   HomeConstants.sortBy,
      //                   style: AxleTextStyle.miniHeadingBlackStyle,
      //                 ),
      //                 children: [
      //                   RadioListTile(
      //                     title: const IconTextWidget(
      //                       icon: Icon(Icons.arrow_upward),
      //                       text: 'Sort Alpha Ascending',
      //                     ),
      //                     value: OrgsSort.asc,
      //                     groupValue: _selectedSortVal,
      //                     onChanged: (value) {
      //                       setState(() {
      //                         _selectedSortVal = OrgsSort.asc;
      //                       });
      //                     },
      //                   ),
      //                   RadioListTile(
      //                     title: const IconTextWidget(
      //                       icon: Icon(Icons.arrow_downward),
      //                       text: 'Sort Alpha Descending',
      //                     ),
      //                     value: OrgsSort.desc,
      //                     groupValue: _selectedSortVal,
      //                     onChanged: (value) {
      //                       setState(() {
      //                         _selectedSortVal = OrgsSort.desc;
      //                       });
      //                     },
      //                   ),
      //                 ],
      //               ),
      //               // * Registration Status Filter
      //               ExpansionTile(
      //                 title: Text(
      //                   HomeConstants.registrationStatus,
      //                   style: AxleTextStyle.miniHeadingBlackStyle,
      //                 ),
      //                 children: ref
      //                     .watch(registrationStatusQueryProviderLogistics)
      //                     .map(
      //                       (item) => CheckboxListTile(
      //                         value: item.status,
      //                         onChanged: (bool? val) {
      //                           regStatusFilter.changeStatus(item, val ?? false);
      //                         },
      //                         title: Text(item.name),
      //                         controlAffinity: ListTileControlAffinity.leading,
      //                       ),
      //                     )
      //                     .toList(),
      //               ),
      //               // * Nature Of Business Status Filter
      //               ExpansionTile(
      //                 title: Text(
      //                   HomeConstants.natureOfBusiness,
      //                   style: AxleTextStyle.miniHeadingBlackStyle,
      //                 ),
      //                 children: ref
      //                     .watch(natureOfBusinessNotifierProviderLogistics)
      //                     .map(
      //                       (item) => CheckboxListTile(
      //                         value: item.status,
      //                         onChanged: (bool? val) {
      //                           natureOfBusinessFilter.changeStatus(item, val!);
      //                         },
      //                         title: Text(item.name),
      //                         controlAffinity: ListTileControlAffinity.leading,
      //                       ),
      //                     )
      //                     .toList(),
      //               ),
      //               // * State Filter
      //               ExpansionTile(
      //                 title: Text(
      //                   HomeConstants.state,
      //                   style: AxleTextStyle.miniHeadingBlackStyle,
      //                 ),
      //                 children: [
      //                   SizedBox(
      //                     width: 350.0,
      //                     child: MultiSelectDropDown(
      //                       selectedOptions: getSelectedItems(),
      //                       onOptionSelected: (List<ValueItem> statess) {
      //                         debugPrint("STatoe : " + statess.length.toString());
      //                         statesFilter.state = statess.map((e) => e.value ?? '').toList();
      //                       },
      //                       options: listOfStates
      //                           .map(
      //                             (item) => ValueItem(
      //                               label: item,
      //                               value: item,
      //                             ),
      //                           )
      //                           .toList(),
      //                       selectionType: SelectionType.multi,
      //                       // chipConfig: const ChipConfig(wrapType: WrapType.scroll, ),
      //                       dropdownHeight: 200,
      //                       optionTextStyle: const TextStyle(fontSize: 16),
      //                       selectedOptionIcon: const Icon(Icons.check_circle),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 200,
      //                   )
      //                 ],
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
      // ),
      // ),
    );
  }

  // String? getServiceTypeFilterString(int index) {
  //   String name = serviceFilterList[index];

  //   switch (name) {
  //     case 'FASTag':
  //       return 'TAG';
  //     case 'Prepaid Card':
  //       return 'PPI';
  //     case 'Fuel Card':
  //       return 'FUEL';
  //     case 'GPS':
  //       return 'GPS';
  //     default:
  //       return null;
  //   }
  // }

  Widget loadListOfLogisticsCard(ListOrgUpdatedModel? orgsList) {
    if (orgsList != null && orgsList.data != null && orgsList.data!.message.docs.isNotEmpty) {
      final data = orgsList.data?.message;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
              alignment: WrapAlignment.start,
              runSpacing: defaultPadding,
              spacing: defaultPadding,
              children: data!.docs.map((doc) => ListingCard(doc: doc)).toList()),
          const SizedBox(height: defaultPadding),
          AxleSimplePaginator(
              currentPage: params.pageIndex!,
              totalItems: orgsList.data!.message.count,
              pageSize: params.size!,
              onChange: ((value) {
                setState(() {
                  params = params.copyWith(pageIndex: value);
                });
                getListOfLogistics(params);
              })),
          // AxlePaginator(
          //   totalCount: orgsList.data!.message.count,
          //   pageSize: params.size ?? 1,
          //   stateNotifier: listLogisticsPageNotifierProvider,
          //   onChange: ((value) {
          //     getListOfLogistics(params.copyWith(pageIndex: value));
          //   }),
          // )
        ],
      );
    } else {
      return emptyListResponse();
    }
  }

  // Create or Invite Dialog
  Future<String> displayCreateAlertDialog(BuildContext context) {
    return const CreateCustomerAlertDialog().present(context).then(
          (value) => value ?? '',
        );
  }

  // Widget toggleAndButtonWidget() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       !isMobile
  //           ? ToggleSwitch(
  //               minWidth: 120.0,
  //               minHeight: 40.0,
  //               fontSize: 16.0,
  //               initialLabelIndex: ref.watch(orgServiceFilterPageIndexProvider),
  //               activeBgColor: const [Color(0xFF004F9F)],
  //               activeFgColor: Colors.white,
  //               inactiveBgColor: const Color(0xffD9E1E7),
  //               inactiveFgColor: const Color(0xff809FB8),
  //               borderColor: const [Color(0xffD9E1E7)],
  //               radiusStyle: true,
  //               borderWidth: 4.0,
  //               totalSwitches: 5,
  //               labels: serviceFilterList,
  //               onToggle: (index) {
  //                 ref.read(orgServiceFilterPageIndexProvider.notifier).state = index ?? 0;
  //                 // print('switched to: $index');
  //                 params = params.copyWith(
  //                   serviceType: getServiceTypeFilterString(index ?? 0),
  //                 );
  //                 getListOfLogistics(params);
  //               },
  //             )
  //           : const SizedBox(),
  //       Row(
  //         children: [
  //           AxlePrimaryIconButton(
  //             buttonIcon: SvgPicture.asset('assets/new_assets/icons/filter_icon.svg'),
  //             onPress: ref.watch(filterVisibilityProviderLogistics)
  //                 ? ref.read(filterVisibilityProviderLogistics.notifier).hide
  //                 : ref.read(filterVisibilityProviderLogistics.notifier).showFilter,
  //             buttonText: HomeConstants.showFilters,
  //             buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
  //           ),
  //           const SizedBox(width: 20.0),
  //           AxlePrimaryIconButton(
  //             buttonIcon: const Icon(Icons.add, size: 20.0),
  //             buttonWidth: 180.0,
  //             onPress: () async {
  //               ref.read(filterVisibilityProviderLogistics.notifier).hide();
  //               final val = await displayCreateAlertDialog(context);
  //               final orgEnrollId =
  //                   ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId)!.toLowerCase();
  //               if (val == 'c' && mounted) {
  //                 context.push('/app/$orgEnrollId/customers/create');
  //               } else if (val == 'i') {
  //                 context.push(
  //                   '/app/$orgEnrollId/customers/invite',
  //                 );
  //               }
  //             },
  //             buttonText: HomeConstants.createCustomer,
  //             buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget emptyListResponse() {
    bool isFilterApplied = false;

    isFilterApplied = params.state != null && params.state!.isNotEmpty ? true : false;
    isFilterApplied = isFilterApplied
        ? true
        : params.natureOfBusiness != null && params.natureOfBusiness!.isNotEmpty
            ? true
            : false;

    isFilterApplied = isFilterApplied
        ? true
        : params.status != null && params.status!.isNotEmpty
            ? true
            : false;

    return Column(
      children: [
        // toggleAndButtonWidget(),
        const SizedBox(height: defaultPadding),
        AxleErrorWidget(
          imgPath: 'assets/images/empty_illus.svg',
          titleStr: isFilterApplied ? HomeConstants.listCustomerEmptyStrWithParams : HomeConstants.listCustomerEmptyStr,
        ),
      ],
    );
  }
}
