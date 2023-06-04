// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/sort_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_controllers/filter_controller_provider.dart';
import 'package:axlerate/src/common/common_controllers/list_orgs_filter_controller.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_icon_button.dart';
import 'package:axlerate/src/common/common_widgets/list_with_search_filters.dart';
import 'package:axlerate/src/common/common_widgets/paginator.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_list_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_query_params.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/widgets/vehicle_card.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:axlerate/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

@RoutePage()
class ListVehiclesPage extends ConsumerStatefulWidget {
  ListVehiclesPage({this.text, super.key});
  String? text;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListVehiclesPageState();
}

class _ListVehiclesPageState extends ConsumerState<ListVehiclesPage> {
  // final OrgsSort _selectedSortVal = OrgsSort.desc;
  VehicleQueryParams params = VehicleQueryParams(
    pageIndex: 1,
    size: 20,
  );

  TextEditingController searchFieldController = TextEditingController();

  @override
  void initState() {
    params = params.copyWith(searchText: (widget.text ?? "").toUpperCase());
    // getListOfVehicles(params);
    // getVehicleList();

    super.initState();
  }

  @override
  void didUpdateWidget(ow) {
    getVehicleList();
    super.didUpdateWidget(ow);
  }

  getVehicleList() async {
    // params = params.copyWith(
    //   searchText: searchFieldController.text,
    // );
    // ref.read(listVehiclesPageNotifierProvider.notifier).setPageIndex(params.pageIndex);
    ref.read(listofVehiclesStateProvider.notifier).state = null;
    ref.read(listofVehiclesStateProvider.notifier).state =
        await ref.read(vehicleControllerProvider).getVehiclesList(params: params);
  }

  Future<void> getVehicleListNew(String? searchText, List<String>? serviceType, Map<Symbol, dynamic> map,
      String sortField, String sortType, int page, List<String> selectedUser, List<String> selectedVehicles) async {
    params.serviceType = serviceType != null && serviceType[0] != "ALL" ? serviceType : null;

    // params = Function.apply(params.copyWith, [], map);

    params.fuelType = map[const Symbol('fuelType')];

    //add sort Params

    params = params.copyWith(sortField: sortField, sortType: sortType);

    params.searchText = searchText;
    params.pageIndex = page;
    // if (!getVehiclesListApiCancelToken.isCancelled) {
    //   getVehiclesListApiCancelToken.cancel();
    //   getVehiclesListApiCancelToken = CancelToken();
    // }

    ref.read(listofVehiclesStateProvider.notifier).state = null;
    ref.read(listofVehiclesStateProvider.notifier).state =
        await ref.read(vehicleControllerProvider).getVehiclesList(params: params);
  }

  int totalTagCount = 0;

  // List<String> vehicleFiltersList = [];

  // double availableWidth = 0.0;
  // bool isMobile = false;

  // double toggleSwitchBorderWidth = 4.0;

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // isMobile = Responsive.isMobile(context);

    // availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2));

    // if (isMobile) {
    //   availableWidth = screenWidth - (defaultPadding * 2);
    // }

    // Watching Providers
    final vehiclesList = ref.watch(listofVehiclesStateProvider);

    return Scaffold(
        // appBar: AxleAppBar(
        //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //     vehicleSearchBar(),
        //     const SizedBox(width: defaultPadding),
        //     SvgPicture.asset(
        //       "assets/new_assets/icons/filter_search_icon.svg",
        //       width: 25,
        //       alignment: Alignment.topCenter,
        //     ),
        //   ]),
        // ),
        backgroundColor: AxleColors.axleBackgroundColor,
        floatingActionButton: isMobile
            ? FloatingActionButton(
                backgroundColor: primaryColor,
                mouseCursor: SystemMouseCursors.click,
                child: const Icon(Icons.add),
                onPressed: () {
                  final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId);
                  context.router.pushNamed('/app/$orgEnrollId/vehicles/create');
                })
            : const SizedBox(),
        body: ListWithSearchAndFilter(
          title: HomeConstants.vehicles,
          searchFieldHint: "Search By Vehicle Reg No.",
          searchText: params.searchText,
          listFunction: getVehicleListNew,
          serviceList: [
            LabelAndValue(label: "All", value: "ALL"),
            LabelAndValue(label: "FASTag", value: "TAG"),
            LabelAndValue(label: "Fuel Card", value: "FUEL"),
            LabelAndValue(label: "GPS", value: "GPS"),
            // DisplayAndValue(displayText: "PaymentLink", value: "TAG" ),
          ],
          createButton: AxlePrimaryIconButton(
            buttonIcon: const Icon(Icons.add, size: 20.0),
            buttonWidth: 180.0,
            onPress: () {
              ref.read(filterVisibilityProviderVehicle.notifier).hide();
              final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId);
              context.router.pushNamed('/app/$orgEnrollId/vehicles/create');
            },
            buttonText: Strings.addVehicle.toUpperCase(),
            buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
          ),
          filterItems: [
            Filter(
              title: LabelAndValue(
                label: "Fuel Type",
                value: 'fuelType',
              ),
              items: vehicleFuelType
                  .map<FilterItem>((fuelType) => FilterItem(label: fuelType, value: fuelType.toValueCase))
                  .toList(),
            ),
          ],
          sortItems: SortItems(items: [
            SortItem(label: 'Sort By Created - Desc', sortField: '_id', order: OrgsSort.desc),
            SortItem(label: 'Sort By Reg No - Desc', sortField: 'registrationNumber', order: OrgsSort.desc),
            SortItem(label: 'Sort By Reg No - Asc', sortField: 'registrationNumber', order: OrgsSort.asc),
          ]),
          child: vehiclesList == null ? AxleLoader.axleProgressIndicator() : loadListOfVehiclesCard(vehiclesList),
        ));
  }

  //Timer? _debounce;

  // Widget vehicleSearchBar() {
  //   return SizedBox(
  //     width: isMobile ? availableWidth : 500,
  //     height: 50.0,
  //     child: TextField(
  //       controller: searchFieldController,
  //       textAlign: TextAlign.start,
  //       onChanged: (value) {
  //         if (value.length >= 3 || value.isEmpty) {
  //           // getVehicleList();
  //           if (_debounce?.isActive ?? false) _debounce?.cancel();
  //           _debounce = Timer(const Duration(milliseconds: 400), () {
  //             // do something with query
  //             params = params.copyWith(
  //               searchText: searchFieldController.text,
  //             );
  //             getVehicleList();
  //           });
  //         }
  //       },
  //       decoration: InputDecoration(
  //         hintText: 'Search By Vehicle Reg. No.',
  //         hintStyle: AxleTextStyle.labelLarge.copyWith(color: primaryColor.withOpacity(0.5)),
  //         fillColor: Colors.white,
  //         filled: true,
  //         prefixIcon: const Icon(
  //           Icons.search,
  //           color: AxleColors.axlePrimaryColor,
  //         ),
  //         suffixIcon: InkWell(
  //             onTap: (() {
  //               searchFieldController.clear();
  //               setState(() {
  //                 params.searchText = null;
  //               });
  //               getVehicleList();
  //             }),
  //             child: const Icon(Icons.close)),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12.0),
  //           borderSide: BorderSide.none,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget loadListOfVehiclesCard(ListVehicleUpdatedModel? vehiclesList) {
    // final fuelTypeFilter =
    ref.read(fuelTypeQueryProvider.notifier);
    if (vehiclesList != null && vehiclesList.data != null && vehiclesList.data!.message!.docs.isNotEmpty) {
      final data = vehiclesList.data!.message;
      // log(params.toString());
      return Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: defaultPadding),
          Wrap(
            runSpacing: defaultPadding,
            spacing: defaultPadding,
            children: data!.docs.map((doc) => VehicleCard(doc: doc)).toList(),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          AxleSimplePaginator(
              currentPage: params.pageIndex,
              pageSize: params.size,
              totalItems: vehiclesList.data!.message!.count,
              onChange: ((value) {
                setState(() {
                  params = params.copyWith(pageIndex: value);
                });
                getVehicleList();
              }))
        ],
      );
    } else {
      return emptyListResponse();
    }
  }

  Widget emptyListResponse() {
    bool isFilterApplied = false;

    isFilterApplied = params.serviceType != null && params.serviceType!.isNotEmpty ? true : false;
    isFilterApplied = isFilterApplied
        ? true
        : params.fuelType != null && params.fuelType!.isNotEmpty
            ? true
            : false;

    return Column(children: [
      AxleErrorWidget(
        imgPath: 'assets/images/empty_illus.svg',
        titleStr: isFilterApplied ? HomeConstants.listCustomerEmptyStrWithParams : HomeConstants.listVehiclesStr,
      )
    ]);
  }
}
