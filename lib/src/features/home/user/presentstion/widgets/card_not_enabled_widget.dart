import 'package:auto_route/auto_route.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';

class CardNotEnbledWidget extends StatelessWidget {
  const CardNotEnbledWidget({
    Key? key,
    required this.isDash,
    required this.org,
    required this.currentType,
  }) : super(key: key);

  final bool isDash;
  final OrgDoc? org;
  final OrgType currentType;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        !isMobile
            ? DashboardHeader(
                title: isDash ? "PPI Dashboard" : "Staff Dashboard",
                orgName: org!.displayName,
                showBack: false,
                onButtonPressed: currentType != OrgType.logisticsStaff
                    ? () {
                        // log('Entering My Call Back');
                        context.router.pushNamed(RouteUtils.getStaffsPath());
                      }
                    : null,
              )
            : const SizedBox(),
        const SizedBox(height: verticalPadding),
        const AxleErrorWidget(
          imgPath: 'assets/images/welcome_illus.svg',
          titleStr: HomeConstants.welcome,
          subtitle: HomeConstants.welcomeToAxlerateStr,
        ),
      ],
    );
  }
}
