// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';
import 'dart:developer';

import 'package:axlerate/app_util/enums/sort_type.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/filter_chip.dart';
import 'package:axlerate/src/common/common_widgets/icon_text_widget.dart';
import 'package:axlerate/src/features/home/partner/presentation/list_partners_page.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/txn_page_provider.dart';
import 'package:axlerate/src/features/home/user/domain/list_orgs_by_type_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/lqtag_admin_org_response_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/simple_vehicle_list.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_controllers/filter_controller_provider.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_icon_button.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/values/constants.dart';

class LabelAndValue {
  final String? value;
  final String label;

  LabelAndValue({
    this.value,
    required this.label,
  });
}

class Filter {
  LabelAndValue title;
  List<FilterItem> items;

  Filter({
    required this.title,
    required this.items,
  });
}

class FilterItem extends LabelAndValue {
  bool isSelected;

  FilterItem(
      {required super.label, required super.value, this.isSelected = false});
}

class SortItem {
  bool isSelected = false;
  final String label;
  final OrgsSort order;
  final String sortField;

  SortItem({required this.label, required this.sortField, required this.order});
}

class SortItems {
  List<SortItem> items;

  SortItems({required this.items}) {
    //assign by default the first one to selected
    items[0].isSelected = true;
  }

  void selectOption(int index) {
    for (int i = 0; i < items.length; i++) {
      items[i].isSelected = i == index ? true : false;
    }
  }

  SortItem getSelectedOption() {
    return items.firstWhere(
      (element) => element.isSelected,
      orElse: () => items[0],
    );
  }
}

class ListWithSearchAndFilter extends ConsumerStatefulWidget {
  ListWithSearchAndFilter(
      {this.title,
      required this.listFunction,
      // required this.params,
      this.searchFieldHint,
      // required this.toggleStateProvider,
      required this.serviceList,
      required this.createButton,
      required this.filterItems,
      required this.sortItems,
      required this.child,
      this.searchText,
      this.isUsersList = false,
      this.listOrgByTypeDoc,
      this.isVehicleLists = false,
      this.isShowSort = true,
      super.key});

  final String? title;
  final String? searchFieldHint;
  final Function(String?, List<String>?, Map<Symbol, dynamic>, String, String,
      int, List<String>, List<String>) listFunction;

  // final T params;
  // final StateProvider<int> toggleStateProvider;
  final List<LabelAndValue> serviceList;
  final Widget createButton;
  final List<Filter> filterItems;
  final SortItems sortItems;
  final Widget child;
  String? searchText;
  bool? showUser;
  final bool isShowSort;
  bool isUsersList;
  bool isVehicleLists;
  ListOrgByTypeDoc? listOrgByTypeDoc;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListWithSearchAndFilterState();
}

final filterVisibilityProvider =
    StateNotifierProvider.autoDispose<FilterVisibilityNotifier, bool>((ref) {
  return FilterVisibilityNotifier();
});

class _ListWithSearchAndFilterState
    extends ConsumerState<ListWithSearchAndFilter> {
  bool isMobile = false;
  TextEditingController searchTextController = TextEditingController();
  late List<Filter> filterItems;
  late SortItems sortItems = widget.sortItems;
  List<String>? serviceType;
  late Filter serviceFilter;
  String orgType = '';
  int selectedIndex = 0;

  LqTagAdminOrgResponseModel? usersList;
  SimpleVehicleListModel? vehicleLists;

  //
  List<DocVehicleList> selectedVehicles = [];
  List<DocVehicleList> allVehicles = [];
  List<DocVehicleList> filteredVehicles = [];
  TextEditingController vehicleInputController = TextEditingController();

  void filterSearchResults(String query) {
    List<DocVehicleList> searchList = [];
    searchList.addAll(allVehicles);
    if (query.isNotEmpty) {
      List<DocVehicleList> searchResult = [];
      for (var item in searchList) {
        if (item.registrationNumber
            .toLowerCase()
            .contains(query.toLowerCase())) {
          searchResult.add(item);
        }
      }
      setState(() {
        filteredVehicles.clear();
        filteredVehicles.addAll(searchResult);
      });
    } else {
      setState(() {
        filteredVehicles.clear();
        //filteredVehicles.addAll(allVehicles);
      });
    }
  }

  void addToSelectedItems(DocVehicleList item) {
    if (!selectedVehicles.contains(item)) {
      setState(() {
        selectedVehicles.add(item);
      });
    }
    updateListItems();
  }

  void removeFromSelectedItems(DocVehicleList item) {
    setState(() {
      selectedVehicles.remove(item);
    });
    updateListItems();
  }

  @override
  void initState() {
    //filteredVehicles.addAll(allVehicles);
    Future(
      () {
        ref.read(filterVisibilityProvider.notifier).hide();
      },
    );

    orgType = sharedPreferences.getString(Storage.currentlyPickedOrgType) ?? '';

    filterItems = widget.filterItems;
    if (!kIsWeb) {
      List<String> services = serviceFilterList();

      serviceFilter = Filter(
          title: LabelAndValue(value: 'serviceType', label: "Services"),
          items: [
            for (int i = 1; i < services.length; i++)
              FilterItem(
                  label: services[i], value: getServiceTypeFilterString(i))
          ]);

      filterItems.insert(0, serviceFilter);
    }
    if (widget.searchText != null) {
      searchTextController.text = widget.searchText!;
    }
    Future(
      () {
        updateListItems();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    try {
      // ref.read(filterVisibilityProvider.notifier).dispose();
    } catch (e) {
      log(e.toString());
    }
    super.dispose();
  }

  List<String> serviceFilterList() {
    return widget.serviceList.map((e) => e.label).toList();
  }

  String? getServiceTypeFilterString(int index) {
    return widget.serviceList[index].value;
  }

  Map<Symbol, dynamic> getSelectedFilterItems() {
    Map<Symbol, dynamic> map = {};
    for (var filter in filterItems) {
      List<String> selectedItems = filter.items
          .where((element) => element.isSelected)
          .map((e) => e.value!)
          .toList();
      // if (selectedItems.isNotEmpty) {
      map.addAll({Symbol(filter.title.value!): selectedItems});
      // }
    }
    return map;
  }

  updateListItems() {
    List<String> selectedUsersArray = [];
    if (selectedUsers.isNotEmpty) {
      for (var element in selectedUsers) {
        selectedUsersArray.add(element.value.toString());
      }
    }
    List<String> selectedVehicleArray = [];
    if (selectedVehicles.isNotEmpty) {
      for (var element in selectedVehicles) {
        selectedVehicleArray.add(element.registrationNumber.toString());
      }
    }
    // params = Function.apply(params.copyWith, [], getSelectedFilterItems());
    //add sort Params
    SortItem? sort = sortItems.getSelectedOption();
    // params = params.copyWith(sortField: sort.sortField, sortType: getSortTypeString(sort.order));
    // ref.read(filterVisibilityProvider.notifier).hide();

    // params = params.copyWith(pageIndex: 1);

    // Future(
    //   () {
    widget.listFunction(
        searchTextController.text,
        serviceType,
        getSelectedFilterItems(),
        sort.sortField,
        getSortTypeString(sort.order),
        1,
        selectedUsersArray,
        selectedVehicleArray);
    // },
    // );
  }

  List<ValueItem> selectedUsers = [];

  List<String> logisticOrgList = [];
  List<String> vehicleList = [];
  FocusNode orgInputFocusNode = FocusNode();
  TextEditingController orgInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double availableWidth = screenWidth - (defaultMobilePadding * 2);

    isMobile = Responsive.isMobile(context);
    final filterVisibility = ref.watch(filterVisibilityProvider);
    if (widget.isVehicleLists) {
      usersList = ref.watch(listofLQTagAdminOrgUserStateProvider);
    }

    if (widget.isVehicleLists) {
      vehicleLists = ref.watch(listofVehicleStateProvider);
      if (vehicleLists != null) {
        allVehicles = vehicleLists!.data!.message!.docs;
      }
    }

    return Scaffold(
      appBar:
          (widget.searchFieldHint != null && widget.searchFieldHint!.isNotEmpty)
              ? AxleAppBar(
                  child: Row(
                  children: [
                    SizedBox(
                        width: (availableWidth * 83) / 100,
                        height: 60,
                        child: vehiclesSearchBar()),
                    const SizedBox(width: defaultPadding),
                    GestureDetector(
                      onTap: (() {
                        _filtersListDialogWidget();
                      }),
                      child: SvgPicture.asset(
                        "assets/new_assets/icons/filter_search_icon.svg",
                        width: 25,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ],
                ))
              : AxleAppBar(
                  child: AxlePrimaryButton(
                    buttonText: "Choose Filters",
                    onPress: () {
                      _filtersListDialogWidget();
                    },
                  ),
                ),
      body: GestureDetector(
          onTap: () {
            ref.read(filterVisibilityProvider.notifier).hide();
          },
          child: Stack(alignment: AlignmentDirectional.centerEnd, children: [
            SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: SingleChildScrollView(
                    child: Padding(
                        padding: isMobile
                            ? const EdgeInsets.symmetric(
                                horizontal: defaultPadding)
                            : const EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                                vertical: verticalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          verticalDirection: VerticalDirection.down,
                          children: [
                            if (!isMobile)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (widget.title != null)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: defaultPadding),
                                          child: Text(
                                            widget.title!,
                                            style: AxleTextStyle.headingPrimary,
                                          ),
                                        ),
                                      // const SizedBox(width: 20.0),
                                      if (widget.searchFieldHint != null &&
                                          widget.searchFieldHint!.isNotEmpty)
                                        SizedBox(
                                            width: 500,
                                            height: 50.0,
                                            child: vehiclesSearchBar())
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  toggleAndButtonWidget(),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: Wrap(
                                spacing: defaultPadding,
                                children: [
                                  FilterChipList(
                                    items: [
                                      for (int filterIndex = 0;
                                          filterIndex < filterItems.length;
                                          filterIndex++)
                                        for (int itemIndex = 0;
                                            itemIndex <
                                                filterItems[filterIndex]
                                                    .items
                                                    .length;
                                            itemIndex++)
                                          if (filterItems[filterIndex]
                                              .items[itemIndex]
                                              .isSelected)
                                            AxleFilterChip(
                                              text: filterItems[filterIndex]
                                                  .items[itemIndex]
                                                  .label,
                                              onTap: () {
                                                setState(() {
                                                  filterItems[filterIndex]
                                                      .items[itemIndex]
                                                      .isSelected = false;
                                                });
                                                updateListItems();
                                              },
                                            ),
                                    ],
                                  ),
                                  for (int userInt = 0;
                                      userInt < selectedUsers.length;
                                      userInt++)
                                    AxleFilterChip(
                                        text: selectedUsers[userInt].label,
                                        onTap: () {
                                          selectedUsers.removeAt(userInt);
                                          setState(() {});
                                          updateListItems();
                                        }),
                                  for (int vehicleInt = 0;
                                      vehicleInt < selectedVehicles.length;
                                      vehicleInt++)
                                    AxleFilterChip(
                                        text: selectedVehicles[vehicleInt]
                                            .registrationNumber,
                                        onTap: () {
                                          selectedVehicles.removeAt(vehicleInt);
                                          setState(() {});
                                          updateListItems();
                                        }),
                                ],
                              ),
                            ),
                            if (!isMobile)
                              const SizedBox(height: defaultPadding),
                            widget.child
                          ],
                        )))),
            // Stack Second Item
            // * Filters PopUp
            if (!isMobile && filterVisibility)
              Positioned(
                top: 150.0,
                right: 10.0,
                left: MediaQuery.of(context).size.width * 0.55,
                bottom: 10.0,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: 400.0,
                    // height: 500.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2.0,
                          blurRadius: 3.0,
                          color: Colors.grey.shade200,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(HomeConstants.filters,
                                style: AxleTextStyle.miniHeadingBlackStyle)
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        if (widget.isVehicleLists && vehicleLists != null)
                          ExpansionTile(
                              title: Text("By Vehicle",
                                  style: AxleTextStyle.miniHeadingBlackStyle),
                              children: [
                                Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                          spacing: defaultPadding,
                                          runSpacing: defaultPadding,
                                          children: [
                                            for (int i = 0;
                                                i < selectedVehicles.length;
                                                i++)
                                              AxleFilterChip(
                                                  text: selectedVehicles[i]
                                                      .registrationNumber,
                                                  onTap: () {
                                                    removeFromSelectedItems(
                                                        selectedVehicles[i]);
                                                  }),
                                            SizedBox(
                                                width: 150,
                                                child: TextField(
                                                  controller:
                                                      vehicleInputController,
                                                  enableInteractiveSelection:
                                                      true,
                                                  autofocus: true,
                                                  focusNode: orgInputFocusNode,
                                                  onChanged: (value) {
                                                    filterSearchResults(value);
                                                  },
                                                )),
                                            if (filteredVehicles.isNotEmpty)
                                              SizedBox(
                                                height: 100,
                                                child: Card(
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        filteredVehicles.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final item =
                                                          filteredVehicles[
                                                              index];
                                                      return ListTile(
                                                        title: Text(item
                                                            .registrationNumber),
                                                        hoverColor: AxleColors
                                                            .axleBackgroundColor,
                                                        onTap: () {
                                                          addToSelectedItems(
                                                              item);
                                                          vehicleInputController
                                                              .clear();
                                                          filterSearchResults(
                                                              '');
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            const SizedBox(height: 10),
                                          ]),
                                    )),
                              ]),
                        filterItemsWidget(),
                        if (widget.isUsersList && usersList != null)
                          ExpansionTile(
                              title: Text("By Users",
                                  style: AxleTextStyle.miniHeadingBlackStyle),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: MultiSelectDropDown(
                                    selectedOptions: selectedUsers,
                                    onOptionSelected:
                                        (List<ValueItem> selectedOptions) {
                                      selectedUsers = selectedOptions
                                          .map((e) => e)
                                          .toList();
                                      setState(() {});
                                      updateListItems();
                                    },
                                    selectedItemBuilder: (_, item) {
                                      return FittedBox(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              defaultPadding),
                                          child: Center(
                                              child: Text(
                                            item.label,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                                        ),
                                      ));
                                    },
                                    options: usersList!.data!.message
                                        .map(
                                          (e) => ValueItem(
                                            label:
                                                '${e.userEnrollmentId} - ${e.firstName} ${e.lastName}',
                                            value: e.userEnrollmentId,
                                          ),
                                        )
                                        .toList(),
                                    selectionType: SelectionType.multi,
                                    chipConfig: const ChipConfig(
                                        wrapType: WrapType.scroll),
                                    dropdownHeight: 100,
                                    optionTextStyle:
                                        const TextStyle(fontSize: 16),
                                    selectedOptionIcon:
                                        const Icon(Icons.check_circle),
                                  ),
                                ),
                              ]),
                        if (widget.listOrgByTypeDoc != null)
                          ExpansionTile(
                              title: Text("Search Logistics",
                                  style: AxleTextStyle.miniHeadingBlackStyle),
                              children: [
                                Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                          spacing: defaultPadding,
                                          runSpacing: defaultPadding,
                                          children: [
                                            for (int i = 0;
                                                i < logisticOrgList.length;
                                                i++)
                                              AxleFilterChip(
                                                  text: logisticOrgList[i],
                                                  onTap: () {
                                                    logisticOrgList.removeAt(i);
                                                    setState(() {});
                                                  }),
                                            SizedBox(
                                                width: 50,
                                                child: TextField(
                                                  controller:
                                                      orgInputController,
                                                  enableInteractiveSelection:
                                                      true,
                                                  autofocus: true,
                                                  focusNode: orgInputFocusNode,
                                                  onSubmitted: (value) {
                                                    logisticOrgList.add(value);
                                                    orgInputController.text =
                                                        '';
                                                    setState(() {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              orgInputFocusNode);
                                                    });
                                                  },
                                                ))
                                          ]),
                                    )),
                              ]),
                      ],
                    ),
                  ),
                ),
              )
          ])

          // )

          ),
    );
  }

  Widget filterItemsWidget({Function? state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //sortItems
        if (widget.isShowSort)
          SingleChildScrollView(
            child: ExpansionTile(
              title: Text(
                HomeConstants.sortBy,
                style: AxleTextStyle.miniHeadingBlackStyle,
              ),
              children: [
                for (int i = 0; i < sortItems.items.length; i++)
                  RadioListTile(
                    title: IconTextWidget(
                      icon: sortItems.items[i].order == OrgsSort.asc
                          ? const Icon(Icons.arrow_upward)
                          : const Icon(Icons.arrow_downward),
                      text: widget.sortItems.items[i].label,
                    ),
                    value: sortItems.items[i],
                    groupValue: sortItems.getSelectedOption(),
                    onChanged: (value) {
                      if (state != null) {
                        state(() {
                          sortItems.selectOption(i);
                        });
                      } else {
                        setState(() {
                          sortItems.selectOption(i);
                        });
                      }

                      updateListItems();
                    },
                  ),
              ],
            ),
          ),

        if (orgType !=
            'PARTNER') // Partners only have Admins - No Staffs included
          for (int filterIndex = 0;
              filterIndex < filterItems.length;
              filterIndex++)
            ExpansionTile(
              title: Text(
                filterItems[filterIndex].title.label,
                style: AxleTextStyle.miniHeadingBlackStyle,
              ),
              children: [
                for (int itemIndex = 0;
                    itemIndex < filterItems[filterIndex].items.length;
                    itemIndex++)
                  CheckboxListTile(
                    value: filterItems[filterIndex].items[itemIndex].isSelected,
                    onChanged: (bool? val) {
                      if (state != null) {
                        log("State != null");
                        state(() {
                          filterItems[filterIndex].items[itemIndex].isSelected =
                              val ?? false;
                        });
                      } else {
                        setState(() {
                          filterItems[filterIndex].items[itemIndex].isSelected =
                              val ?? false;
                        });
                      }

                      updateListItems();
                    },
                    title:
                        Text(filterItems[filterIndex].items[itemIndex].label),
                    controlAffinity: ListTileControlAffinity.leading,
                  )
              ],
            ),
      ],
    );
  }

  Future<void> _filtersListDialogWidget() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(defaultMobilePadding),
          title: const Text('Select Filters'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return filterItemsWidget(state: setState);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Apply Filter'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextField vehiclesSearchBar() {
    return TextField(
      controller: searchTextController,
      onSubmitted: ((value) {
        updateListItems();
      }),
      decoration: InputDecoration(
        hintText: widget.searchFieldHint,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: searchTextController.text == ""
            ? null
            : InkWell(
                onTap: (() {
                  searchTextController.clear();
                  setState(() {
                    searchTextController.clear();
                  });
                  updateListItems();
                }),
                child: const Icon(Icons.close)),
        prefixIcon: const Icon(
          Icons.search,
          color: AxleColors.axlePrimaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget toggleAndButtonWidget() {
    selectedIndex = ref.read(txHistoryToggleSwitchIndex.notifier).state;
    int toggleSwitchLength = serviceFilterList().length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isMobile)
          MouseRegion(
              cursor: SystemMouseCursors.click,
              child: toggleSwitchLength > 1
                  ? ToggleSwitch(
                      minWidth: 120.0,
                      minHeight: 40.0,
                      fontSize: 16.0,
                      initialLabelIndex: selectedIndex,
                      //ref.watch(widget.toggleStateProvider),
                      activeBgColor: const [Color(0xFF004F9F)],
                      activeFgColor: Colors.white,
                      inactiveBgColor: const Color(0xffD9E1E7),
                      inactiveFgColor: const Color(0xff809FB8),
                      borderColor: const [Color(0xffD9E1E7)],
                      radiusStyle: true,
                      borderWidth: 4.0,
                      totalSwitches: toggleSwitchLength,
                      labels: serviceFilterList(),
                      onToggle: (index) {
                        selectedIndex = index ?? 0;
                        ref.read(txHistoryToggleSwitchIndex.notifier).state =
                            selectedIndex;
                        // ref.read(widget.toggleStateProvider.notifier).state = index ?? 0;
                        // print('switched to: $index');
                        // params = params.copyWith(
                        //   serviceType: getServiceTypeFilterString(index ?? 0),

                        // );
                        serviceType =
                            getServiceTypeFilterString(index ?? 0) == null
                                ? null
                                : [getServiceTypeFilterString(index ?? 0)!];
                        updateListItems();
                      },
                    )
                  : const SizedBox()),
        if (filterItems.isNotEmpty)
          Row(
            children: [
              AxlePrimaryIconButton(
                buttonIcon:
                    SvgPicture.asset('assets/new_assets/icons/filter_icon.svg'),
                onPress: ref.watch(filterVisibilityProvider)
                    ? ref.read(filterVisibilityProvider.notifier).hide
                    : ref.read(filterVisibilityProvider.notifier).showFilter,
                buttonText: HomeConstants.showFilters,
                buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
              ),
              const SizedBox(width: 20.0),
              widget.createButton
            ],
          ),
      ],
    );
  }
}
