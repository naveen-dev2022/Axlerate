import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/ppi/presentation/add_fastag_to_user.dart';
import 'package:axlerate/src/features/home/ppi/presentation/add_fuel_to_user.dart';
import 'package:axlerate/src/features/home/ppi/presentation/add_ppi_card_to_user_page.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AddUserService extends ConsumerStatefulWidget {
  const AddUserService({
    super.key,
    @PathParam('staffEnrolId') required this.userEnrollmentId,
    @PathParam('custId') required this.orgenrollIdOfUser,
  });
  final String userEnrollmentId;
  final String orgenrollIdOfUser;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddUserServiceState();
}

class _AddUserServiceState extends ConsumerState<AddUserService> {
  bool isMobile = false;
  List<String> title = ["FASTag", "Prepaid Cards", "Fuel Cards"];
  List<String> description = [
    "Pay for tolls with quick recharge & track expense",
    "Unify all fleet-related payments in a single card",
    "Prevent theft & gain rewards for fuel purchases",
  ];

  int selectedIndex = 0;
  UserService? ppiService;
  UserService? lqTagService;
  UserService? fuelService;
  UpdatedUserByEnrolmentIdModel? userData;
  OrgDoc? org;
  late bool isPpiEnabledForOrg = false;
  late bool isFuelEnabledForOrg = false;

  @override
  void initState() {
    getUserData();
    // getOrgData();

    super.initState();
  }

  // getOrgData() async {
  //   await ref
  //       .read(logisticsControllerProvider)
  //       .getOrganisationByEnrolmentId(enrolId: widget.orgenrollIdOfUser.toUpperCase());
  // }

  getUserServiceList() {
    try {
      for (OrganizationUpdated e in userData!.data?.message?.organizations ?? []) {
        if (e.organizationEnrollmentId == widget.orgenrollIdOfUser.toUpperCase()) {
          ppiService = getOrgServiceFromUserEnrollId(e, "PPI",
              issuerName: "LIVQUIK", organizationEnrollmentId: widget.orgenrollIdOfUser);
          lqTagService = getOrgServiceFromUserEnrollId(e, "TAG",
              issuerName: "LIVQUIK", organizationEnrollmentId: widget.orgenrollIdOfUser);
          fuelService = getOrgServiceFromUserEnrollId(e, "FUEL",
              issuerName: "HPCL", organizationEnrollmentId: widget.orgenrollIdOfUser);
          setState(() {});
          break;
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getUserData() async {
    userData = await ref.read(userControllerProvider).getUserByEnrolmentId(userEnrolmentId: widget.userEnrollmentId);
    if (userData != null) getUserServiceList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    org = ref.watch(orgDetailsProvider);
    if (org != null) {
      isPpiEnabledForOrg = (getOrgService(org, 'PPI', issuerName: 'LIVQUIK') != null &&
              getOrgService(org, 'PPI', issuerName: 'LIVQUIK')?.kycStatus == "APPROVED")
          ? true
          : false;
      isFuelEnabledForOrg = (getOrgService(org, 'FUEL', issuerName: 'HPCL') != null &&
              getOrgService(org, 'FUEL', issuerName: 'HPCL')?.kycStatus == "APPROVED")
          ? true
          : false;
    }

    return userData == null
        ? AxleLoader.axleProgressIndicator()
        : SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: isMobile
                    ? const EdgeInsets.all(defaultPadding)
                    : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => context.router.pop(),
                            icon: const Icon(Icons.arrow_back, color: AxleColors.axlePrimaryColor)),
                        Text(" User Services", style: AxleTextStyle.headingPrimary),
                        Text(" • ${userData!.data?.message?.name}", style: AxleTextStyle.headingPrimary),
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                      decoration: CommonStyleUtil.axleContainerDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 140,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: title.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: serviceCard(title[index], description[index], index)),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Container(
                              width: double.infinity,
                              height: 2,
                              color: iconColor,
                            ),
                          ),
                          getSelectedWidget(selectedIndex, userData!)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget getSelectedWidget(int index, UpdatedUserByEnrolmentIdModel userData) {
    Widget toRet = AddFastagToUserPage(
      key: UniqueKey(),
      userEnrollmentId: widget.userEnrollmentId,
      userData: userData,
      orgenrollIdOfUser: widget.orgenrollIdOfUser,
      onPress: () {
        getUserData();
      },
    );
    switch (index) {
      case 0:
        toRet = AddFastagToUserPage(
          key: UniqueKey(),
          userEnrollmentId: widget.userEnrollmentId,
          userData: userData,
          orgenrollIdOfUser: widget.orgenrollIdOfUser,
          onPress: () {
            getUserData();
          },
        );
        break;

      case 1:
        toRet = isPpiEnabledForOrg
            ? AddPpiCardToUserPage(
                key: UniqueKey(),
                userEnrollmentId: widget.userEnrollmentId,
                userData: userData,
                orgenrollIdOfUser: widget.orgenrollIdOfUser,
                onPress: () {
                  getUserData();
                },
              )
            : serviceMsgWidget(contentMsg: "Please Ensure your Organisation is enabled with PPI Service");

        break;

      case 2:
        toRet = isFuelEnabledForOrg
            ? AddFuelToUserPage(
                key: UniqueKey(),
                userEnrollmentId: widget.userEnrollmentId,
                userData: userData,
                orgenrollIdOfUser: widget.orgenrollIdOfUser,
              )
            : toRet = serviceMsgWidget(contentMsg: "Please Ensure your Organisation is enabled with Fuel Service");

        break;

      default:
        toRet = Padding(
          padding: const EdgeInsets.all(horizontalPadding),
          child: Center(
              child: Text(
            "Coming Soon",
            style: AxleTextStyle.headingPrimary,
          )),
        );
    }

    return toRet;
  }

  Widget serviceMsgWidget({required String contentMsg}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(horizontalPadding),
        child: Text(
          contentMsg,
          style: isMobile ? AxleTextStyle.bodyMedium : AxleTextStyle.headingPrimary,
        ),
      ),
    );
  }

  Container axleServiceCard(String title, String description, int itemCount) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: selectedIndex == itemCount ? primaryColor : AxleColors.axleCardColor, width: 2.0),
      ),
      height: 100,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            selectedIndex == itemCount ? const Icon(Icons.radio_button_checked) : const Icon(Icons.radio_button_off),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Flexible(
                    child: Text(description, style: const TextStyle(fontSize: 12)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container serviceCard(
    title,
    String description,
    int index,
  ) {
    Container res = Container();
    switch (title) {
      case "FASTag":
        if (lqTagService != null) {
          res = axleServiceCardEnabled(title, description, index, status: lqTagService?.kycStatus);
        } else {
          res = axleServiceCard(title, description, index);
        }

        break;

      case "Prepaid Cards":
        if (ppiService != null) {
          res = axleServiceCardEnabled(title, description, index, status: ppiService?.kycStatus);
        } else {
          res = axleServiceCard(title, description, index);
        }
        break;

      case "Fuel Cards":
        if (fuelService != null) {
          res = axleServiceCardEnabled(title, description, index, status: fuelService?.kycStatus);
        } else {
          res = axleServiceCard(title, description, index);
        }
        break;

      default:
        res = axleServiceCard(title, description, index);
    }
    return res;
  }

  Container axleServiceCardEnabled(String title, String description, int index, {String? status}) {
    Color statusColor = AxleColors.getStatusColor(status ?? "");
    return Container(
      decoration: BoxDecoration(
        color: selectedIndex == index ? statusColor.withAlpha(35) : null,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: statusColor, width: 2),
        //  Border.all(color: AxleColors.axleGreenColor, width: 2.0),
      ),
      height: 100,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.only(left: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            selectedIndex == index
                ? Icon(Icons.radio_button_checked, color: statusColor)
                : const Icon(Icons.radio_button_off),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AxleTextStyle.bodyMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w600)),
                  Flexible(child: Text(description, style: AxleTextStyle.bodySmall.copyWith(color: Colors.black87)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                height: 135,
                width: 30,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      status != null
                          ? status == "APPROVED"
                              ? 'Enabled'
                              : status.toUiCase
                          : '',
                      style: AxleTextStyle.labelSmall.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
