// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_icon_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_service_icon.dart';
import 'package:axlerate/src/common/common_widgets/bottom_status_card.dart';
import 'package:axlerate/src/common/common_widgets/icon_info_widget.dart';
import 'package:axlerate/src/dialogs/change_user_role_dialog.dart';
import 'package:axlerate/src/dialogs/deactive_alert_dialog.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_alert_dialog_mode.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_dropdown_dialog_model.dart';
import 'package:axlerate/src/dialogs/reactivate_alert_dialog.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AxleUserCard extends ConsumerWidget {
  AxleUserCard({
    Key? key,
    required this.doc,
  }) : super(key: key);

  final UserDoc doc;
  double screenWidth = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OrgType orgType = ref.read(localStorageProvider).getOrgType();

    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    availableWidth = screenWidth - (defaultPadding * 2);
    // final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId)!.toLowerCase();

    return GestureDetector(
      onTap: orgType == OrgType.partner
          ? null
          : () async {
              final sharedPref = ref.read(sharedPreferenceProvider);
              await sharedPref.setString(Storage.currentLqAdminEnrollmentId, doc.enrollmentId);
              if (doc.status == 'ACTIVE' && doc.organizations!.userServices.isNotEmpty) {
                // context.go(RouteUtils.getStaffDashboard(doc.organizations!.organizationEnrollmentId, doc.enrollmentId));
                // ignore: use_build_context_synchronously
                context.router.pushNamed(
                    RouteUtils.getStaffDashboard(doc.organizations!.organizationEnrollmentId, doc.enrollmentId));
              } else {
                if (doc.status != 'ACTIVE') {
                  Snackbar.warn('User is not active');
                } else {
                  if (doc.organizations?.organizationType == 'PARTNER') {
                    Snackbar.warn('Service cannot be enabled for a Partner Admin');
                  }
                }
              }
            },
      child: SizedBox(
        width: isMobile ? availableWidth : 250,
        // height: isMobile ? null : 250,
        child: Container(
          decoration: CommonStyleUtil.axleListingCardDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      leading: Container(
                        decoration: CommonStyleUtil.cardTileIconDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            "assets/new_assets/icons/staff_profile_icon.svg",
                            colorFilter: const ColorFilter.mode(sideMenuBgColor, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      title: Text(doc.name, style: AxleTextStyle.subtitle1BlackBold),
                      subtitle: Text(doc.organizations!.role.first.toUiCase, style: AxleTextStyle.subtitle2),
                      trailing: doc.status == "PENDING"
                          ? const SizedBox()
                          : PopupMenuButton(
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(Icons.more_vert_rounded, color: iconColor),
                              itemBuilder: (context) {
                                return getUserPopUpItems(context, ref, doc);
                              },
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: IconInfoWidget(
                        title:
                            '${doc.organizations!.organizationDetails?.firstName} ${doc.organizations!.organizationDetails?.lastName} '
                                .toTitleCase(),
                        iconPath: 'assets/new_assets/icons/user_org_logo.svg'),
                  ),
                  SizedBox(height: isMobile ? 4.0 : defaultMobilePadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: IconInfoWidget(title: doc.contactNumber, iconPath: 'assets/new_assets/icons/user_phone.svg'),
                  ),
                  // SizedBox(height: isMobile ? 10.0 : 20.0),
                  showButtonOrServices(context, ref, doc),
                ],
              ),
              // bottomCard(doc),
              // if (isMobile) const SizedBox(height: defaultPadding)
            ],
          ),
        ),
      ),
    );
  }
}

// * PopUp Menu Function
List<PopupMenuItem> getUserPopUpItems(BuildContext context, WidgetRef ref, UserDoc doc) {
  List<PopupMenuItem> items = [];
  //* Switch user Role
  if (doc.organizations?.organizationType != 'PARTNER') {
    items.addAll([
      PopupMenuItem(
        child: Text(
          'Switch Role',
          style: AxleTextStyle.body2BlackNormalStyle,
        ),
        onTap: () async {
          String status = await displayChangeUserRoleDialog(context);
          if (status.isNotEmpty) {
            if (status.toTitleCase() == doc.organizations!.role.first.toTitleCase()) {
              Snackbar.warn('You picked an existing role');
              return;
            }
            // ignore: use_build_context_synchronously
            AxleLoader.show(context);
            await ref.read(userControllerProvider).changeUserRole(
                  userId: doc.id,
                  orgId: doc.organizations!.organizationId,
                  role: status.toValueCase,
                );
            AxleLoader.hide();
            ref.read(listofUsersStateProvider.notifier).state = null;
            ref.read(listofUsersStateProvider.notifier).state = await ref.read(userControllerProvider).getUsersList();
            // ref.read(listofUsersStateProvider.notifier).state = await ref.read(userControllerProvider).getUsersList();
          } else {
            Snackbar.warn("Please pick a role to switch");
          }
        },
      )
    ]);
  }

  if (!doc.organizations!.isDeactivated) {
    items.addAll(
      [
        PopupMenuItem(
          child: Text(
            HomeConstants.deactivateUser,
            style: AxleTextStyle.body2BlackNormalStyle,
          ),
          onTap: () async {
            bool status = await displayDeactivateDialog(context);
            if (status) {
              // ignore: use_build_context_synchronously
              AxleLoader.show(context);
              await ref.read(userControllerProvider).deactivateUser(
                    userId: doc.id,
                    orgId: doc.organizations!.organizationId,
                  );
              AxleLoader.hide();
              ref.read(listofUsersStateProvider.notifier).state = null;
              ref.read(listofUsersStateProvider.notifier).state = await ref.read(userControllerProvider).getUsersList();

              // await ref.refresh(getUsersListFutureProvider(context));
            }
          },
        )
      ],
    );
  } else {
    items.addAll([
      PopupMenuItem(
        child: Text(
          HomeConstants.reactivateUser,
          style: AxleTextStyle.body2BlackNormalStyle,
        ),
        onTap: () async {
          bool status = await displayReactivateDialog(context);
          if (status) {
            // ignore: use_build_context_synchronously
            AxleLoader.show(context);
            await ref.read(userControllerProvider).reactivateUser(
                  userId: doc.id,
                  orgId: doc.organizations!.organizationId,
                );
            AxleLoader.hide();
            ref.read(listofUsersStateProvider.notifier).state = null;
            ref.read(listofUsersStateProvider.notifier).state = await ref.read(userControllerProvider).getUsersList();

            // await ref.refresh(getUsersListFutureProvider(context));
          }
        },
      )
    ]);
  }

  return items;
}

// * Show button or PPI Service Status
Widget showButtonOrServices(BuildContext context, WidgetRef ref, UserDoc doc) {
  //final orgDetails = doc.organizations!.organizationDetails;

  if (doc.organizations?.organizationType == 'PARTNER') {
    return const Column(
      children: [
        SizedBox(
          height: defaultPadding,
        ),
        BottomStatusCard(text: 'PARTNER', textColor: Colors.white, cardColor: AxleColors.axleGreenColor),
      ],
    );
  }

  if (doc.status == 'ACTIVE') {
    if (doc.organizations!.userServices.isEmpty) {
      // final ppi = orgDetails?.services?.ppi;
      // if (ppi != null && doc.organizations.isPpiRegistered == false && doc.status == 'ACTIVE') {
      //   if (doc.organizations.role!.first!.toLowerCase() == 'admin') {
      return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          child: AxlePrimaryIconButton(
            buttonHeight: 40.0,
            buttonIcon: const Icon(Icons.add, size: 16.0),
            buttonText: HomeConstants.addServicesBT,
            buttonTextStyle: AxleTextStyle.saveAndContinueStyle.copyWith(
              fontSize: 14.0,
            ),
            onPress: () {
              // log('! print -> ${doc?.organizations?.organizationEntityId}');
              // context.go(RouteUtils.staffEnablePpi(doc.organizations.organizationEnrollmentId!, doc.enrollmentId!));
              context.router.pushNamed(
                  RouteUtils.getStaffServices(doc.organizations!.organizationEnrollmentId, doc.enrollmentId));
            },
          ),
        ),
      );

      //   } else {
      //     return Center(
      //       child: AxlePrimaryIconButton(
      //         buttonHeight: 40.0,
      //         buttonIcon: const Icon(Icons.add, size: 16.0),
      //         buttonText: HomeConstants.addPrepaidCardBT,
      //         buttonTextStyle: AxleTextStyle.saveAndContinueStyle.copyWith(
      //           fontSize: 14.0,
      //         ),
      //         onPress: () {
      //           final orgEnrollId =
      //               ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId)!.toLowerCase();
      //           log('! print -> ${doc.organizations.organizationEntityId}');
      //           context.go(RouteUtils.staffEnablePpi(doc.organizations.organizationEnrollmentId!, doc.enrollmentId!));
      //         },
      //       ),
      //     );
      //   }
      // }
      // // else if (ppi != null && doc.organizations.userEntityId.isNotEmpty) {
      // else if (ppi != null && doc.organizations.isPpiRegistered!) {
      //   final bool isApproved = doc.organizations.kycStatus == 'MIN_KYC_APPROVED';
      //   return Container(
      //       margin: const EdgeInsets.symmetric(horizontal: 2.0),
      //       child: Center(
      //         child: AxleServiceIcon(
      //           status: doc.organizations.kycStatus!,
      //           svgPath: "assets/new_assets/icons/card_icon.svg",
      //         ),
      //       )
      //       // CircleAvatar(
      //       //   radius: 16.0,
      //       //   backgroundColor: isApproved ? Colors.greenAccent.shade100 : Colors.redAccent.shade100,
      //       //   child: Icon(
      //       //     Icons.card_membership_rounded,
      //       //     size: 16.0,
      //       //     color: isApproved ? Colors.greenAccent : Colors.redAccent,
      //       //   ),
      //       // ),
      //       );
      // }
    } else {
      return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Row(
          children: [
            for (UserService service in doc.organizations!.userServices)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Center(
                  child: AxleServiceStatusIcon(
                    service: service,
                  ),
                ),
              ),
            if ((doc.organizations?.userServices.length ?? 0) < 3)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CircleAvatar(
                  backgroundColor: AxleColors.axlePrimaryColor,
                  child: IconButton(
                    onPressed: () {
                      // final orgEnrollId =
                      //     ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId)!.toLowerCase();

                      context.router.pushNamed(
                          RouteUtils.getStaffServices(doc.organizations!.organizationEnrollmentId, doc.enrollmentId));
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              )
          ],
        ),
      );
    }
  } else {
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: bottomCard(doc),
    );
    // return const Center(
    //   child: Text(
    //     '',
    //     style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // );
  }
}

// * KYC Status Indicator Card
Widget bottomCard(UserDoc doc) {
  final isInvited = doc.status == 'PENDING';
  // final isDeclined = doc.organizations.kycStatus == 'DECLINED';
  if (isInvited) {
    return BottomStatusCard(
        text: 'PENDING'.toUpperCase(), textColor: Colors.white, cardColor: AxleColors.axleSecondaryColor);
  }
  // if (isDeclined) {
  //   return BottomStatusCard(text: 'KYC Rejected', cardColor: Colors.redAccent.shade400);
  // }
  return const BottomStatusCard(text: '', cardColor: Colors.transparent);
}

// * Deactivate Popup Dialog
Future<bool> displayDeactivateDialog(BuildContext context) {
  return const DeactivateUserAlertDialog().present(context).then(
        (value) => value ?? false,
      );
}

// * Reactivate Popup Dialog
Future<bool> displayReactivateDialog(BuildContext context) {
  return const ReactivateUserAlertDialog().present(context).then(
        (value) => value ?? false,
      );
}

// * Switch User Role Popup Dialog
Future<String> displayChangeUserRoleDialog(BuildContext context) {
  return const ChangeUserRoleDialog().present(context).then(
        (value) => value ?? '',
      );
}
