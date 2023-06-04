// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/features/home/dashboard/presentation/dashboard.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/account_info_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/account_info_widget_mobile.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_account_info_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/web_view/web_view_manager.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CardInformation extends ConsumerWidget {
  CardInformation(
      {Key? key, required this.org, required this.user, required this.userEnrollId, required this.ppiAccountFuture})
      : super(key: key);

  final OrgDoc? org;
  final UpdatedMessageUser? user;
  final String userEnrollId;
  Future<UserAccountInfoModel> ppiAccountFuture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    double availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2);

    bool isMobile = Responsive.isMobile(context);

    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    return Container(
      margin: EdgeInsets.all(isMobile ? 0 : defaultMobilePadding),
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 600),
      height: isMobile ? null : 300,
      width: isMobile ? availableWidth : availableWidth * 63 / 100,
      // padding: const EdgeInsets.all(10.0),
      decoration: CommonStyleUtil.axleListingCardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Card Information', style: AxleTextStyle.titleMedium),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      AxleLoader.show(context);

                      Future.delayed(const Duration(seconds: 1), () async {
                        String url = await ref
                            .read(userControllerProvider)
                            .getCardPciWidget(userEnrollId: userEnrollId, orgId: org?.id ?? '');
                        if (url.isNotEmpty) {
                          // ignore: use_build_context_synchronously
                          showCardDetailsDialog(context, url);
                        }

                        AxleLoader.hide();
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Show', style: AxleTextStyle.labelMedium.copyWith(color: AxleColors.iconColor)),
                        const SizedBox(width: 4.0),
                        const Icon(Icons.visibility_off, color: AxleColors.iconColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(height: defaultPadding),
            isMobile
                ? SingleChildScrollView(
                    child: SizedBox(
                      child: FutureBuilder<UserAccountInfoModel>(
                          future: ppiAccountFuture,
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: defaultPadding),
                                if (snapshot.hasData) getAxleDebitCard(snapshot, context),
                                const SizedBox(height: defaultPadding),
                                if (snapshot.hasData) getAxleDebitCardDetails(snapshot, context),
                                const SizedBox(height: defaultPadding),
                                getManageCardButton(context),
                                const SizedBox(height: defaultPadding),
                              ],
                            );
                          }),
                    ),
                  )
                : FutureBuilder<UserAccountInfoModel>(
                    future: ppiAccountFuture,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(top: defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(children: [
                              if (snapshot.hasData) getAxleDebitCard(snapshot, context),
                              const SizedBox(height: defaultPadding),
                              getManageCardButton(context),
                            ]),
                            const SizedBox(width: defaultPadding),
                            if (snapshot.hasData) getAxleDebitCardDetails(snapshot, context),
                          ],
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  void showCardDetailsDialog(BuildContext context, String url) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = Responsive.isMobile(context);

    isMobile
        ? _launchUrl(Uri.parse(url))
        : showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text('Card Details', style: AxleTextStyle.subtitle1BlackBold),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                  ],
                ),
                content: SizedBox(
                  height: screenHeight * 90 / 100,
                  width: screenWidth * 90 / 100,
                  child: WebViewManager.instance.buildUiSettings(
                    context: context,
                    url: url,
                  ),
                ),
              );
            },
          );
  }

  Widget getAxleDebitCardDetails(AsyncSnapshot<UserAccountInfoModel> snapshot, BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return snapshot.data != null && snapshot.data!.data != null
        ? isMobile
            ? AccountInfoWidgetMobile(
                accountNumber: snapshot.data!.data!.message.accountNumber ?? '',
                ifscCode: snapshot.data!.data!.message.ifsc ?? '',
                upiId: '',
              )
            : AccountInfoWidget(
                accountNumber: snapshot.data!.data!.message.accountNumber ?? '',
                ifscCode: snapshot.data!.data!.message.ifsc ?? '',
                upiId: '',
              )
        //  Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       LabelValueWidget(heading: 'Name on Card', value: user?.name ?? "***** *"),

        //       LabelValueWidget(heading: 'Card Number', value: snapshot.data!.data!.message.maskedCard),
        //       // const LabelValueWidget(heading: 'Valid From', value: '**/****'),
        //       LabelValueWidget(
        //           heading: 'Valid To',
        //           value: DateFormat('MM/yyyy').format(snapshot.data!.data!.message.cardExpiryDate)),
        //     ],
        //   )
        : const SizedBox();
  }

  Widget getAxleDebitCard(AsyncSnapshot<UserAccountInfoModel> snapshot, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2);
    bool isMobile = Responsive.isMobile(context);

    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    return Container(
        width: isMobile ? availableWidth : 250.0,
        decoration: BoxDecoration(color: AxleColors.axleBackgroundColor, borderRadius: BorderRadius.circular(10.0)),
        child: Stack(alignment: AlignmentDirectional.bottomStart, children: [
          Image.asset(width: availableWidth, 'assets/images/axle-ppi-card.png', fit: BoxFit.fitWidth),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (snapshot.data != null && snapshot.data!.data != null)
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding, bottom: defaultMobilePadding),
                  child: Text(addSpaces(snapshot.data!.data!.message.maskedCard),
                      style: AxleTextStyle.subtitle1Card.copyWith(fontWeight: FontWeight.normal)),
                ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding, bottom: defaultMobilePadding),
                    child: Text((user?.name ?? "***** *").toUpperCase(), style: AxleTextStyle.subtitle1Card),
                  ),
                  if (snapshot.data != null && snapshot.data!.data != null)
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding, bottom: defaultMobilePadding),
                      child: Text(DateFormat('MM/yyyy').format(snapshot.data!.data!.message.cardExpiryDate),
                          style: AxleTextStyle.subtitle1Card),
                    )
                ],
              ),
            ],
          )
        ]));
  }

  String addSpaces(String input) {
    return input.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
  }

  Widget getManageCardButton(BuildContext context) {
    return AxleOutlineButton(
      buttonText: 'Manage Card',
      outlineColor: AxleColors.axleBlueColor,
      buttonWidth: 250.0,
      buttonHeight: isMobile ? 40 : 50,
      onPress: () {
        //   context.push(RouteUtils.getStaffManageCardPath(org!.enrollmentId, userEnrollId));
        context.router.pushNamed(RouteUtils.getStaffManageCardPath(org!.enrollmentId, userEnrollId));
      },
    );
  }
}
