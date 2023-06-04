import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/features/authentication/domain/user_decode_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';

class AuthorizeUserForOrg extends AutoRouteGuard {
  AuthorizeUserForOrg(this.ref);
  Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    String orgId = resolver.route.pathParams.getString('selOrg');
    List<dynamic> organisations =
        jsonDecode(ref.read(sharedPreferenceProvider).getString(Storage.userOrganisations) ?? "");

    List<UserDecodedOrganization> orgs = organisations.getOrgsList;

    try {
      orgs.firstWhere((element) => element.organizationEnrollmentId.toLowerCase() == orgId.toLowerCase());
      resolver.next(true);
    } catch (e) {
      if (orgId != "app") {
        Snackbar.error("You dont have access to this organisation.");
        debugPrint("AuthorizeUserForOrg Failed");
      }
      router.navigateNamed('/app');
    }
  }
}
