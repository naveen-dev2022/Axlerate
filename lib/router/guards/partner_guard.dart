import 'package:auto_route/auto_route.dart';
import 'package:axlerate/router/utils/loader_provider.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnerByIdResolver extends AutoRouteGuard {
  PartnerByIdResolver(this.ref);

  Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    try {
      await Future(
        () async {
          ref.read(loadingProvider.notifier).show();
          // await Future.delayed(const Duration(seconds: 5));
          await ref
              .read(logisticsControllerProvider)
              .getOrganisationByEnrolmentId(enrolId: resolver.route.pathParams.getString('partnerId').toUpperCase());

          ref.read(loadingProvider.notifier).hide();

          resolver.next(true);
        },
      );
    } catch (e) {
      Snackbar.warn("Organisation not available");
      ref.read(loadingProvider.notifier).hide();

      router.navigateNamed('/app');
    }
  }
}
