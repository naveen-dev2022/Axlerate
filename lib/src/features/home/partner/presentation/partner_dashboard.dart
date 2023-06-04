import 'package:auto_route/auto_route.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/org_dashboard_header.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/partner/domain/partner_dash_count_info_model.dart';
import 'package:axlerate/src/features/home/partner/presentation/controller/partner_controller.dart';
import 'package:axlerate/src/features/home/partner/presentation/widgets/partner_commission_orgwise_table.dart';
import 'package:axlerate/src/features/home/partner/presentation/widgets/recent_lists.dart';
import 'package:axlerate/src/features/home/partner/presentation/widgets/partner_dashboard_summary.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';

@RoutePage()
class PartnerDashboard extends ConsumerStatefulWidget {
  const PartnerDashboard({
    super.key,
    @PathParam('partnerId') required this.orgId,
    this.orgType,
  });

  final String orgId;
  final String? orgType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PartnerDashboardState();
}

class _PartnerDashboardState extends ConsumerState<PartnerDashboard> {
  late Future<PartnerDashCountInfoModel> dashCountFuture;

  @override
  void initState() {
    dashCountFuture = getDashCount();
    // getOrganisation();
    super.initState();
  }

  Future<PartnerDashCountInfoModel> getDashCount() async {
    return await ref.read(partnerControllerProvider).getPartnerDashCount(orgId: widget.orgId);
  }

  // getOrganisation() {
  //   Future(
  //     () async {
  //       await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(enrolId: widget.orgId.toUpperCase());
  //       setState(() {});
  //     },
  //   );
  // }

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  bool isMobile = false;
  OrgDoc? org;

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isMobile = Responsive.isMobile(context);

    return Scaffold(
        backgroundColor: AxleColors.axleBackgroundColor,
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!isMobile) OrgDashboardHeader(title: "Partner Dashboard", orgName: org?.displayName ?? ''),
                Padding(
                  padding: isMobile
                      ? const EdgeInsets.all(defaultPadding)
                      : const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PartnerDashboardSummary(orgId: widget.orgId),
                      const SizedBox(height: verticalPadding),
                      PartnerCommissionOrgwiseTable(partnerEnrolId: widget.orgId, isDash: true),
                      const SizedBox(height: verticalPadding),
                      DashboardRecentLists(partnerOrgId: org?.id ?? ''),
                      const SizedBox(height: verticalPadding),
                      // DashboardGraph(orgType: widget.orgType, orgId: widget.orgId),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
