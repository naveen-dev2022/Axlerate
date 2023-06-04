import 'dart:developer';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_toggle_menu.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/org_dashboard_header.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/domain/logistics_dash_count_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/dashboard_controllers.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/logistics_dashboard_services.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/vehiclewise_split.dart';
import 'package:axlerate/src/features/home/profile/domain/user_profile_model.dart';
import 'package:axlerate/src/features/home/profile/presentation/profile_page_controller.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/user_child_dashboard.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_list_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_query_params.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/widgets/vehicle_card.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/summary/logistics_dashboard_summary.dart';
// import 'package:go_router/go_router.dart';

class LogisticsDashboard extends ConsumerStatefulWidget {
  const LogisticsDashboard({
    super.key,
    required this.orgEnrollId,
  });

  final String orgEnrollId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogisticsDashboardState();
}

class _LogisticsDashboardState extends ConsumerState<LogisticsDashboard> {
  Future<OrgDashCountModel>? dashCountFuture;
  late Future<UserProfileModel> userProfileDateFuture;
  Future<ListVehicleUpdatedModel>? recentVehiclesFuture;
  bool isPPIEnabled = false;
  UserService? ppiService;
  OrgType? orgType;

  String orgId = '';
  // String orgEnrollId = '';
  OrgDoc? org;

  @override
  void initState() {
    loadInit();
    super.initState();
  }

  loadInit() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orgDashMainIndexProvider.notifier).state = 0;
    });
    org = ref.read(orgDetailsProvider);
    if (org == null) {
      await ref
          .read(logisticsControllerProvider)
          .getOrganisationByEnrolmentId(enrolId: widget.orgEnrollId.toUpperCase());
      org = ref.read(orgDetailsProvider);
      setState(() {});
    }
    orgId = org!.id;
    orgType = ref.read(localStorageProvider).getOrgType();
    dashCountFuture = getDashCount();
    recentVehiclesFuture = getVehiclesforOrg(org!.enrollmentId);
    Future(() {
      getUserByEnrolId(widget.orgEnrollId);
    });
  }

  Future<void> getUserByEnrolId(String userEnrolmentId) async {
    UserProfileModel? userData = ref.watch(profileDataStateProvider);
    if (userData != null) {
      ref.read(loggedInUserByEnrollmentIdStateProvider.notifier).state = await ref
          .read(userControllerProvider)
          .getUserByEnrolmentId(userEnrolmentId: userData.data!.message!.enrollmentId);
      getUserServiceList();
    }
  }

  getUserServiceList() {
    try {
      for (OrganizationUpdated e
          in ref.read(loggedInUserByEnrollmentIdStateProvider)?.data?.message?.organizations ?? []) {
        ppiService = getOrgServiceFromUserEnrollId(e, "PPI", issuerName: "LIVQUIK");
        //log("message" + ppiService.toString());
        if (ppiService != null && ppiService!.kycStatus != "PENDING") {
          isPPIEnabled = true;
          setState(() {});
          break;
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<ListVehicleUpdatedModel> getVehiclesforOrg(String orgEnrolId) {
    return ref
        .read(vehicleControllerProvider)
        .getVehiclesList(params: VehicleQueryParams(size: 5, pageIndex: 1, searchText: orgEnrolId));
  }

  Future<OrgDashCountModel> getDashCount() async {
    return await ref.read(logisticsControllerProvider).getOrgDashCount(userOrgEnrollmentId: widget.orgEnrollId);
  }

  // double screenWidth = 0.0;
  // double screenHeight = 0.0;
  // bool isMobile = false;

  bool isAnyServiceEnabled = false;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    //org = ref.watch(orgDetailsProvider);

    // log('PPI REGISTERD STATUS -> $isPpiEnabled');
    // log('PPI REGISTERD STATUS Long -> ${ref.read(sharedPreferenceProvider).getBool(Storage.isPpiEnabledForCurrentUser)}');

    // isPpiEnabled = true;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    isMobile = Responsive.isMobile(context);

    // debugPrint('Org Doc -> ! -> $org');

    isAnyServiceEnabled = org?.organizationServices.isNotEmpty ?? false;
    //getOrgService(org, 'GPS') != null || getOrgService(org, 'TAG') != null || getOrgService(org, 'PPI') != null;
    // if (org == null) {
    //   return AxleLoader.axleProgressIndicator();
    // }

    return kIsWeb
        ? Scaffold(
            backgroundColor: AxleColors.axleBackgroundColor,
            body: FutureBuilder<OrgDashCountModel>(
              future: dashCountFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return AxleLoader.axleProgressIndicator();
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      if (snapshot.data?.data == null) {
                        //isPPIEnabled = false;
                      }
                      return SizedBox(
                        width: screenWidth,
                        height: screenHeight,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              OrgDashboardHeader(
                                title: "Dashboard",
                                orgName: org?.displayName ?? "",
                                enrollmentId: org?.enrollmentId ?? '',
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? defaultPadding : horizontalPadding,
                                    vertical: isMobile ? defaultPadding : 0),
                                child: org != null
                                    ? isPPIEnabled && (orgType != null && orgType == OrgType.logisticsAdmin)
                                        ? AxleToggleMenu(
                                            provider: orgDashMainIndexProvider,
                                            items: [
                                              AxleToggleMenuItem(
                                                label: 'Dashboard',
                                                child: getDashboardView(snapshot, org: org!),
                                              ),
                                              AxleToggleMenuItem(
                                                label: 'PPI Dashboard',
                                                child: UserChildDashboard(
                                                  isDash: true,
                                                  userEnrollmentId: ref
                                                          .read(sharedPreferenceProvider)
                                                          .getString(Storage.userEnrollmentId) ??
                                                      '',
                                                  orgenrollIdOfUser: ref
                                                          .read(sharedPreferenceProvider)
                                                          .getString(Storage.currentlyPickedOrgEnrollId) ??
                                                      '',
                                                ),
                                              )
                                            ],
                                          )
                                        : getDashboardView(snapshot, org: org!)
                                    : AxleLoader.axleProgressIndicator(),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return AxleLoader.axleProgressIndicator();
                    }
                }
              },
            ),
          )
        : const SizedBox();
  }

  Column getDashboardView(AsyncSnapshot<OrgDashCountModel> snapshot, {required OrgDoc org}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile)
          const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Text("Dashboard", style: AxleTextStyle.titleMedium),
                  // AxlePrimaryButton(
                  //   buttonText: "Services",
                  //   onPress: () {
                  //     context.router.pushNamed(RouteUtils.getCustomerServicesPath(custEnrollId: org.enrollmentId));
                  //   },
                  // ),
                  // AxlePrimaryButton(
                  //   buttonText: "Detailed View",
                  //   onPress: () {
                  //     context.go(RouteUtils.getCustomerDetailsPath(custEnrollId: org.enrollmentId));
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        LogisticsDashboardSummary(
          orgId: orgId,
          orgEnrollId: widget.orgEnrollId,
          count: snapshot.data!,
        ),
        const SizedBox(height: verticalPadding),
        VehiclewiseUsage(count: 5, orgId: widget.orgEnrollId, isDash: true),
        const SizedBox(height: verticalPadding),
        Text("Services", style: AxleTextStyle.dashboardSubHeadingText),
        const SizedBox(height: defaultPadding),
        isAnyServiceEnabled
            ? LogisticsDashboardServices(
                orgId: orgId,
                count: snapshot.data!,
                orgEnrollId: widget.orgEnrollId,
              )
            : noServiceResponse(),
        const SizedBox(height: verticalPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Vehicles", style: AxleTextStyle.dashboardSubHeadingText),
            InkWell(
                onTap: () {
                  context.router.pushNamed('vehicles');
                },
                child: Text("View All >", style: AxleTextStyle.labelLarge))
          ],
        ),
        FutureBuilder<ListVehicleUpdatedModel>(
          future: recentVehiclesFuture, // getVehiclesforOrg(org.enrollmentId), //
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return AxleLoader.axleProgressIndicator();
              case ConnectionState.done:
                return snapshot.data!.data!.message!.docs.isEmpty
                    ? const Text("No Vehicles Found!")
                    : SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.data!.message!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: VehicleCard(doc: snapshot.data!.data!.message!.docs[index]),
                            );
                          },
                        ),
                      );
              default:
                return const Text("Dont know");
            }
          },
        )
      ],
    );
  }

  Widget noServiceResponse() {
    return const Column(
      children: [
        SizedBox(height: defaultPadding),
        AxleErrorWidget(
          imgPath: 'assets/images/welcome_illus.svg',
          titleStr: HomeConstants.welcome,
          subtitle: HomeConstants.logisticStaffDashEmptyStr,
        ),
      ],
    );
  }
}
