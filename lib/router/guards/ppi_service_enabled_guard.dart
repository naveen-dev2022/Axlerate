import 'package:auto_route/auto_route.dart';
import 'package:axlerate/router/app_router.gr.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PPIServiceEnabledGuard extends AutoRouteGuard {
  PPIServiceEnabledGuard(this.ref);

  Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (getOrgService(ref.read(orgDetailsProvider), 'PPI', issuerName: 'LIVQUIK')?.kycStatus == 'APPROVED') {
      resolver.next(true);
    } else {
      Snackbar.error("PPI Service is not enabled for this organisation");
      // String path = router.currentPath;
      // List<String> parts = path.split('/');
      // parts.removeLast();
      // path = parts.join('/') + '/dashboard';
      router.navigate(LogisticsOrganisationByEnrolmentId(enrolId: router.routeData.pathParams.getString('custId')));
    }
  }
}
