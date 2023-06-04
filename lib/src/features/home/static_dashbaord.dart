import 'package:auto_route/annotations.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class StaticDashbaord extends ConsumerWidget {
  const StaticDashbaord({super.key});

  static final Uri _url = Uri.parse('https://staging-app.axlerate.com/auth/login');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final orgType = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgType) ?? '';
    final orgName = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgName) ?? '';
    final userRole = ref.read(sharedPreferenceProvider).getString(Storage.currentUserRole) ?? '';
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Welcome ${orgName.toUiCase} ${userRole.toUiCase},",
              style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
          Lottie.asset('assets/new_assets/images/welcome.json'),
          const SizedBox(height: defaultPadding),
          Text("Kindly use our web app for seamless flow", style: AxleTextStyle.titleMedium),
          const SizedBox(height: defaultPadding),
          AxlePrimaryButton(onPress: _launchUrl, buttonHeight: 40, buttonText: ('Go to Web App')),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }
}
