import 'package:auto_route/auto_route.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/src/features/home/dashboard/presentation/dashboard.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_dashboard.dart';
import 'package:axlerate/src/features/home/partner/presentation/partner_dashboard.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class OrgDashboardScreen extends ConsumerStatefulWidget {
  const OrgDashboardScreen({@PathParam('selOrg') required this.selOrgId, super.key});
  final String selOrgId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrgDashboardScreenState();
}

class _OrgDashboardScreenState extends ConsumerState<OrgDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    String orgType = sharedPreferences.getString(Storage.currentlyPickedOrgType) ?? '';
    String orgId = widget.selOrgId;

    // log("orgType -----> $orgType");

    if (orgType.contains("AXLERATE")) {
      return const SuperAdminDashboard();
    } else if (orgType.contains("PARTNER")) {
      return PartnerDashboard(
        orgId: orgId,
        orgType: orgType,
      );
    } else {
      return LogisticsDashboard(
        // orgId: orgId,
        orgEnrollId: orgId,
      );
    }
  }
}
