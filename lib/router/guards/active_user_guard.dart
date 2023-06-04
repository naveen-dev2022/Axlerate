import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/router/axle_route_path.dart';
import 'package:axlerate/src/features/authentication/domain/auth_result.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveUserGuard extends AutoRouteGuard {
  ActiveUserGuard(this.ref);

  Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isloggedIn = ref.read(isLoggedInProvider);
    final authState = ref.read(authResultProvider);
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (isloggedIn && authState == AuthResult.success) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      log("Redirecting to Account Activation Page");
      // we redirect the user to our login page
      router
          .pushNamed('${AxleRoutePath.auth}/${AxleRoutePath.accountActivation}'); //redirect to account activation page
    }
  }
}
