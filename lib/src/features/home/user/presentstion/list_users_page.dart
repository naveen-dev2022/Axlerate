import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/sort_type.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_controllers/filter_controller_provider.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_icon_button.dart';
import 'package:axlerate/src/common/common_widgets/list_with_search_filters.dart';
import 'package:axlerate/src/common/common_widgets/paginator.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_query_params.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/axle_user_card.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:go_router/go_router.dart';
@RoutePage()
class ListUsersPage extends ConsumerStatefulWidget {
  final String? userRole;

  const ListUsersPage({super.key, this.userRole});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListUsersPageState();
}

class _ListUsersPageState extends ConsumerState<ListUsersPage> {
  // late Future<ListUserResponseModel> getUsersListFuture;
  OrgsSort selectedSortVal = OrgsSort.desc;
  ListUserQueryParams params = ListUserQueryParams(pageIndex: 1, size: 15);

  String orgType = '';
  List<LabelAndValue> servicesList = [];

  @override
  void initState() {
    servicesList.add(LabelAndValue(label: "All"));
    orgType = sharedPreferences.getString(Storage.currentlyPickedOrgType) ?? '';

    // Partner Admins dosent have any of these services.
    if (orgType.toUpperCase() != 'PARTNER') {
      servicesList.add(LabelAndValue(label: "FASTag", value: "TAG"));
      servicesList.add(LabelAndValue(label: "Prepaid Card", value: "PPI"));
    }

    super.initState();
  }

  Future<void> getListOfUsers(ListUserQueryParams params) async {
    ref.read(listofUsersStateProvider.notifier).state = null;
    ref.read(listofUsersStateProvider.notifier).state =
        await ref.read(userControllerProvider).getUsersList(queryParams: params);
  }

  Future<void> getListOfUsersNew(String? searchText, List<String>? serviceType, Map<Symbol, dynamic> map,
      String sortField, String sortType, int page, List<String> selectedUser, List<String> selectedVehicles) async {
    params.serviceType = serviceType;
    //params = Function.apply(params.copyWith, [], map);
    params.userRole = map[const Symbol('userRole')];
    params = params.copyWith(sortField: sortField, sortType: sortType);
    params.searchText = searchText;
    params.pageIndex = page;

    ref.read(listofUsersStateProvider.notifier).state = null;
    ref.read(listofUsersStateProvider.notifier).state =
        await ref.read(userControllerProvider).getUsersList(queryParams: params);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    // Watching user list
    ListUserResponseModel? usersList = ref.watch(listofUsersStateProvider);

    return Scaffold(
        floatingActionButton: isMobile
            ? FloatingActionButton(
                backgroundColor: primaryColor,
                mouseCursor: SystemMouseCursors.click,
                child: const Icon(Icons.add),
                onPressed: () {
                  ref.read(filterVisibilityProviderUser.notifier).hide;

                  context.router.pushNamed(RouteUtils.getAddStaffsPath());
                })
            : const SizedBox(),
        backgroundColor: AxleColors.axleBackgroundColor,
        body: ListWithSearchAndFilter(
            title: HomeConstants.staffs,
            listFunction: getListOfUsersNew,
            searchFieldHint: "Search by Name / Mobile No.",
            serviceList: servicesList,
            createButton: AxlePrimaryIconButton(
              buttonIcon: const Icon(Icons.add, size: 20.0),
              buttonWidth: 180.0,
              onPress: () {
                context.router.pushNamed(RouteUtils.getAddStaffsPath());
              },
              buttonText: HomeConstants.createStaff,
              buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
            ),
            filterItems: [
              Filter(title: LabelAndValue(label: "Role", value: "userRole"), items: [
                FilterItem(label: "Admin", value: "ADMIN", isSelected: widget.userRole == "ADMIN"),
                FilterItem(label: "Staff", value: "STAFF", isSelected: widget.userRole == "STAFF"),
              ])
            ],
            sortItems: SortItems(items: [
              SortItem(label: "Sort By Created Date - Desc", sortField: '_id', order: OrgsSort.desc),
              SortItem(label: "Sort By Name - Asc", sortField: 'name', order: OrgsSort.asc),
              SortItem(label: "Sort By Name - Desc", sortField: 'name', order: OrgsSort.desc)
            ]),
            child: usersList == null ? AxleLoader.axleProgressIndicator() : loadListOfUsersCard(usersList)));
  }

  // * Generates List of User Cards
  Widget loadListOfUsersCard(ListUserResponseModel? usersList) {
    if (usersList != null && usersList.data != null && usersList.data!.message.docs.isNotEmpty) {
      final data = usersList.data!.message;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: defaultPadding,
            spacing: defaultPadding,
            children: data.docs.map((doc) => AxleUserCard(doc: doc)).toList(),
          ),
          const SizedBox(height: defaultPadding),
          AxleSimplePaginator(
              currentPage: params.pageIndex!,
              pageSize: params.size,
              totalItems: usersList.data!.message.count,
              onChange: (value) {
                params.pageIndex = value;
                getListOfUsers(params);
              })
          // AxlePaginator(
          //   totalCount: usersList.data!.message.count,
          //   pageSize: params.size,
          //   stateNotifier: listUserPageNotifierProvider,
          //   onChange: ((value) {
          //     getListOfUsers(params.copyWith(pageIndex: value));
          //   }),
          // )
        ],
      );
    } else {
      return emptyListResponse();
    }
  }

  Widget emptyListResponse() {
    return const AxleErrorWidget(
      titleStr: HomeConstants.noDataFoundStr,
    );
  }
}
