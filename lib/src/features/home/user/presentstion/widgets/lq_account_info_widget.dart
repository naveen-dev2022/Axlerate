// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/logistics/domain/lq_user_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/account_info_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/account_info_widget_mobile.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LqTagAdminAccountInfo extends ConsumerWidget {
  LqTagAdminAccountInfo({
    Key? key,
    required this.orgEnrollId,
    required this.userEnrollmentId,
  }) : super(key: key);

  final String orgEnrollId;
  final String userEnrollmentId;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2);

    isMobile = Responsive.isMobile(context);

    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    final lqTagAccountInfo = ref.watch(livquikTagAccDetailsProvider);
    String accountNumber = '';
    String ifscCode = '';
    String upiId = '';
    if (lqTagAccountInfo != null && lqTagAccountInfo.data != null && lqTagAccountInfo.data!.message.isNotEmpty) {
      for (LqUserAccInfoModelMessage e in lqTagAccountInfo.data!.message) {
        if (e.userEnrollmentId.toLowerCase() == userEnrollmentId.toLowerCase()) {
          accountNumber = e.accountNumber;
          ifscCode = e.ifsc;
          upiId = e.upiId;
          break;
        }
      }
    }

    return Container(
      margin: EdgeInsets.all(isMobile ? 0 : defaultMobilePadding),
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 600),
      height: isMobile ? null : 300,
      width: isMobile ? availableWidth : availableWidth * 63 / 100,
      decoration: CommonStyleUtil.axleListingCardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: lqTagAccountInfo == null
            ? AxleLoader.axleProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isMobile
                      ? AccountInfoWidgetMobile(
                          accountNumber: accountNumber,
                          ifscCode: ifscCode,
                          upiId: upiId,
                        )
                      : AccountInfoWidget(
                          accountNumber: accountNumber,
                          ifscCode: ifscCode,
                          upiId: upiId,
                        ),
                  AxlePrimaryButton(
                      buttonText: "Load Wallet",
                      onPress: () {
                        log(orgEnrollId);
                        context.router.pushNamed(RouteUtils.getFundTransferPath(
                          custEnrollId: orgEnrollId,
                        ));
                      })
                ],
              ),
      ),
    );
  }
}
