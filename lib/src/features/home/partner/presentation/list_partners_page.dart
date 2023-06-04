// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/sort_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_controllers/filter_controller_provider.dart';
import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_icon_button.dart';
import 'package:axlerate/src/common/common_widgets/list_with_search_filters.dart';
import 'package:axlerate/src/common/common_widgets/paginator.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/partner/presentation/controller/parter_ui_controller.dart';
import 'package:axlerate/src/features/home/partner/presentation/controller/partner_controller.dart';
import 'package:axlerate/src/features/home/partner/presentation/widgets/axle_partner_card.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ListPartnerPage extends ConsumerStatefulWidget {
  const ListPartnerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPartnerPageState();
}

class _ListPartnerPageState extends ConsumerState<ListPartnerPage> {
  GlobalKey expansionTileKey1 = GlobalKey();
  GlobalKey expansionTileKey2 = GlobalKey();

  ListOrgsQueryParams params = ListOrgsQueryParams(organizationType: 'PARTNER', pageIndex: 1, size: 15);

  ListOrgUpdatedModel? partnersList;

  Future<void> getListOfLogistics(ListOrgsQueryParams params) async {
    ref.read(listPartnersPageNotifierProvider.notifier).setPageIndex(params.pageIndex ?? 1);
    ref.read(listofPartnersStateProvider.notifier).state = null;
    ref.read(listofPartnersStateProvider.notifier).state =
        await ref.read(partnerControllerProvider).getPartnersList(queryParams: params);
  }

  double availableWidth = 0.0;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  bool isMobile = false;

  Future<void> getListOfLogisticsNew(String? searchText, List<String>? serviceType, Map<Symbol, dynamic> map,
      String sortField, String sortType, int page, List<String> selectedUser, List<String> selectedVehicles) async {
    params.serviceType = serviceType;
    params = Function.apply(params.copyWith, [], map);
    params = params.copyWith(sortField: sortField, sortType: sortType);
    params.searchText = searchText;
    params.pageIndex = page;

    ref.read(listofPartnersStateProvider.notifier).state = null;
    ref.read(listofPartnersStateProvider.notifier).state =
        await ref.read(partnerControllerProvider).getPartnersList(queryParams: params);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    // int count = ref.watch(listofPartnersStateProvider.notifier).state?.data?.message.count ?? 0;
    // int pageCount = ref.watch(listofPartnersStateProvider.notifier).state?.data?.message.docs.length ?? 0;

    isMobile = Responsive.isMobile(context);

    availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2));
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 3);
    }

    final partnersList = ref.watch(listofPartnersStateProvider);
    // final filterVisibility = ref.watch(filterVisibilityProviderPartner);
    // // Reader
    // final natureOfBusinessFilter = ref.read(natureOfBusinessNotifierProviderPartner.notifier);
    // final registrationStatusFilter = ref.read(registrationStatusQueryProviderPartner.notifier);
    // final statesFilter = ref.read(stateFilterProvider.notifier);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      floatingActionButton: isMobile
          ? FloatingActionButton(
              backgroundColor: primaryColor,
              mouseCursor: SystemMouseCursors.click,
              child: const Icon(Icons.add),
              onPressed: () {
                ref.read(filterVisibilityProviderPartner.notifier).hide();
                // final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId);
                // context.push('/app/$orgEnrollId/partners/create');
                context.router.pushNamed(RouteUtils.getCreatePartnerPath());
              })
          : const SizedBox(),
      body: ListWithSearchAndFilter(
          // ignore: prefer_interpolation_to_compose_strings
          title: HomeConstants.partners, // + "(" + pageCount.toString() + '/' + count.toString() + ')',
          searchFieldHint: 'Search By Partners Name / ID / Mobile Number',
          listFunction: getListOfLogisticsNew,
          // params: ListOrgsQueryParams(organizationType: 'LOGISTICS'),
          // toggleStateProvider: orgServiceFilterPageIndexProvider,
          serviceList: [
            LabelAndValue(label: "All"),
            LabelAndValue(label: "FASTag", value: "TAG"),
            LabelAndValue(label: "Prepaid Card", value: "PPI"),
            LabelAndValue(label: "Fuel Card", value: "FUEL"),
            // LabelAndValue(label: "GPS", value: "GPS"),
            // DisplayAndValue(displayText: "PaymentLink", value: "TAG" ),
          ],
          createButton: AxlePrimaryIconButton(
            buttonIcon: const Icon(Icons.add, size: 20.0),
            buttonWidth: 180.0,
            onPress: () async {
              context.router.pushNamed(RouteUtils.getCreatePartnerPath());
            },
            buttonText: HomeConstants.createPartner,
            buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
          ),
          filterItems: [
            // Filter(title: LabelAndValue(label: "Status", value: 'status'), items: [
            //   FilterItem(label: "Invited", value: "Invited".toValueCase),
            //   FilterItem(label: "Active", value: "Approved".toValueCase),
            // ]),
            Filter(title: LabelAndValue(label: HomeConstants.natureOfBusiness, value: 'natureOfBusiness'), items: [
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
          child: ref.read(listofPartnersStateProvider.notifier).state == null
              ? AxleLoader.axleProgressIndicator()
              : loadListOfPartnersCard(partnersList)),
    );
  }

  Widget searchBar(double width) {
    return SizedBox(
      width: width,
      // height: 50.0,
      child: TextField(
        onChanged: (value) {
          params = params.copyWith(searchText: value);
        },
        decoration: InputDecoration(
          hintText: 'Search By Partner Org ID / Name',
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: AxleColors.axlePrimaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Row getCreatePartner(BuildContext context, bool filterVisibility) {
  //   return Row(
  //     children: [
  //       AxlePrimaryIconButton(
  //         buttonIcon: SvgPicture.asset('assets/new_assets/icons/filter_icon.svg'),
  //         onPress: filterVisibility
  //             ? ref.read(filterVisibilityProviderPartner.notifier).hide
  //             : ref.read(filterVisibilityProviderPartner.notifier).showFilter,
  //         buttonText: HomeConstants.showFilters,
  //         buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
  //       ),
  //       const SizedBox(width: 20.0),
  //       AxlePrimaryIconButton(
  //         buttonIcon: const Icon(Icons.add, size: 20.0),
  //         buttonWidth: 180.0,
  //         onPress: () {
  //           ref.read(filterVisibilityProviderPartner.notifier).hide();
  //           final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId);
  //           context.push('/app/$orgEnrollId/partners/create');
  //         },
  //         buttonText: HomeConstants.addPartner.toUpperCase(),
  //         buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
  //       ),
  //     ],
  //   );
  // }

  Widget loadListOfPartnersCard(ListOrgUpdatedModel? orgsList) {
    if (orgsList != null && orgsList.data != null && orgsList.data!.message.docs.isNotEmpty) {
      final data = orgsList.data?.message;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: isMobile ? defaultPadding : 20,
            spacing: isMobile ? defaultPadding : 20,
            children: data!.docs
                .map(
                  (doc) => AxlePartnerCard(
                    doc: doc,
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          AxleSimplePaginator(
            currentPage: params.pageIndex!,
            pageSize: params.size ?? 15,
            totalItems: orgsList.data?.message.count ?? 0,
            onChange: (value) {
              params.pageIndex = value;
              getListOfLogistics(params);
            },
          ),
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

class AxleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AxleAppBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return isMobile
        ? Container(
            decoration: BoxDecoration(
              color: appBlue,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: const Offset(2.0, 2.0),
                )
              ],
            ),
            child: PreferredSize(
                preferredSize: preferredSize,
                child: Padding(padding: const EdgeInsets.all(defaultPadding), child: child)),
          )
        : const SizedBox();
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
