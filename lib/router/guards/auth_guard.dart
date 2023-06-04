import 'package:auto_route/auto_route.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
import 'package:axlerate/src/utils/device/device_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.ref);

  Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isloggedIn = ref.read(isLoggedInProvider);
    // final authState = ref.read(authResultProvider);
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation

    bool isSafeDevice = await UserDevice.detectSafeDevice();
    if (!isSafeDevice) {
      // Go To Error Screen
      debugPrint('Device is not safe');
      router.navigateNamed(RouteUtils.getErrorDashbaord());
      return;
    }

    if (!isloggedIn) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.navigateNamed('app');
    }
  }
}
