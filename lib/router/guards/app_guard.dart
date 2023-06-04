import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppGuard extends AutoRouteGuard {
  AppGuard(this.ref);

  Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isloggedIn = ref.read(isLoggedInProvider);
    // final authState = ref.read(authResultProvider);
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (isloggedIn) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.navigateNamed('auth');
    }
  }
}
