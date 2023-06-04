import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class ErrorDashbaord extends ConsumerWidget {
  const ErrorDashbaord({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = ref.read(sharedPreferenceProvider).getString("errorMessage") ?? '';
    final orgName = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgName) ?? '';
    final userRole = ref.read(sharedPreferenceProvider).getString(Storage.currentUserRole) ?? '';

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Hi ${orgName.toUiCase} ${userRole.toUiCase},",
              style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
          Lottie.asset('assets/new_assets/images/stop.json'),
          const SizedBox(height: defaultPadding),
          Text(errorMessage, style: AxleTextStyle.titleMedium),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
