import 'package:auto_route/auto_route.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_dashboard.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LogisticsOrganisationByEnrolmentId extends ConsumerStatefulWidget {
  const LogisticsOrganisationByEnrolmentId({@PathParam('custId') required this.enrolId, super.key});
  final String enrolId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogisticsOrganisationByEnrolmentIdState();
}

class _LogisticsOrganisationByEnrolmentIdState extends ConsumerState<LogisticsOrganisationByEnrolmentId> {
  late OrgType orgType;

  OrgDoc? org;
  @override
  void initState() {
    orgType = ref.read(localStorageProvider).getOrgType();
    getOrganisation();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   getOrganisation();
  //   super.didChangeDependencies();
  // }

  // @override
  // void didUpdateWidget(oldWidget) {
  //   // getOrganisation();
  //   super.didUpdateWidget(oldWidget);
  // }

  getOrganisation() {
    Future(
      () async {
        await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(enrolId: widget.enrolId.toUpperCase());
        org = ref.read(orgDetailsProvider);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // org = ref.watch(orgDetailsProvider);
    if (org == null) {
      return AxleLoader.axleProgressIndicator();
    } else {
      // return kIsWeb ? LogisticsDashboard(orgId: org!.id) : const LogisticsMobileDashboard();
      return (!kIsWeb && (orgType == OrgType.logisticsAdmin || orgType == OrgType.logisticsStaff))
          ? LogisticsMobileDashboard(
              orgEnrollId: widget.enrolId,
            )
          : LogisticsDashboard(orgEnrollId: widget.enrolId);
    }
  }
}
