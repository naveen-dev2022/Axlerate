import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/rc_screen/rc_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../Themes/common_style_util.dart';
import '../../../../../Themes/text_style_config.dart';
import '../../../../../responsive.dart';
import '../../../../../values/constants.dart';
import '../../../../utils/axle_loader.dart';
import '../domain/driving_license_entity.dart';
import 'controller/ecard_controller.dart';

@RoutePage()
class DrivingLicenseScreen extends ConsumerStatefulWidget {
  const DrivingLicenseScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DrivingLicenseScreen> createState() =>
      _DrivingLicenseScreenState();
}

class _DrivingLicenseScreenState extends ConsumerState<DrivingLicenseScreen> {
  double screenWidth = 0.0;
  bool isMobile = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(drivingLicenseStateProvider.notifier).state = null;
      ref.read(drivingLicenseStateProvider.notifier).state = await ref
          .read(eCardControllerProvider)
          .fetchDrivingLicenseData(idNumber: '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);

    final DrivingLicenseEntity? drivingLicenseEntity =
        ref.watch(drivingLicenseStateProvider);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: drivingLicenseEntity == null
          ? AxleLoader.axleProgressIndicator()
          : Padding(
              padding: isMobile
                  ? const EdgeInsets.symmetric(horizontal: defaultMobilePadding)
                  : const EdgeInsets.all(defaultPadding),
              child: _renderApiData(drivingLicenseEntity)),
    );
  }

  Widget _renderApiData(DrivingLicenseEntity? drivingLicenseEntity) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding,
            ),
            child: Text(
              "Driving License",
              style: AxleTextStyle.headingPrimary,
            ),
          ),
          Container(
            decoration: CommonStyleUtil.axleListingCardDecoration,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (drivingLicenseEntity?.data?.hasImage ?? false) ...[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: MemoryImage(base64Decode(
                        "${drivingLicenseEntity?.data?.profileImage}")),
                  ),
                ] else ...[
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://www.sarojhospital.com/images/testimonials/dummy-profile.png'),
                  ),
                ],
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drivingLicenseEntity?.data?.name ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AxleColors.dashPurple,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Gender - ${drivingLicenseEntity?.data?.gender}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Dob - ${drivingLicenseEntity?.data?.dob}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: CommonStyleUtil.axleListingCardDecoration,
            padding: const EdgeInsets.all(16),
            child: Wrap(
                runSpacing: defaultPadding,
                spacing: defaultPadding,
                children: [
                  UserDataCard(
                      title: "License Number",
                      subTitle:
                          drivingLicenseEntity?.data?.licenseNumber ?? ""),
                  UserDataCard(
                      title: "State",
                      subTitle: drivingLicenseEntity?.data?.state ?? ""),
                  UserDataCard(
                      title: "Permanent Address",
                      subTitle:
                          drivingLicenseEntity?.data?.permanentAddress ?? ""),
                  UserDataCard(
                      title: "Permanent Zip",
                      subTitle: drivingLicenseEntity?.data?.permanentZip ?? ""),
                  UserDataCard(
                      title: "Temporary Address",
                      subTitle:
                          drivingLicenseEntity?.data?.temporaryAddress ?? ""),
                  UserDataCard(
                      title: "Temporary Zip",
                      subTitle: drivingLicenseEntity?.data?.temporaryZip ?? ""),
                  UserDataCard(
                      title: "Citizenship",
                      subTitle: drivingLicenseEntity?.data?.citizenship ?? ""),
                  UserDataCard(
                      title: "Ola Name",
                      subTitle: drivingLicenseEntity?.data?.olaName ?? ""),
                  UserDataCard(
                      title: "Ola Code",
                      subTitle: drivingLicenseEntity?.data?.olaCode ?? ""),
                  UserDataCard(
                      title: "Father Or Husband Name",
                      subTitle:
                          drivingLicenseEntity?.data?.fatherOrHusbandName ??
                              ""),
                  UserDataCard(
                      title: "doe",
                      subTitle: drivingLicenseEntity?.data?.doe ?? ""),
                  UserDataCard(
                      title: "Transport Doe",
                      subTitle: drivingLicenseEntity?.data?.transportDoe ?? ""),
                  UserDataCard(
                      title: "doi",
                      subTitle: drivingLicenseEntity?.data?.transportDoi ?? ""),
                  UserDataCard(
                      title: "Transport Doi",
                      subTitle: drivingLicenseEntity?.data?.transportDoi ?? ""),
                  UserDataCard(
                      title: "Blood Group",
                      subTitle: drivingLicenseEntity?.data?.bloodGroup ?? ""),
                ]),
          ),
        ],
      ),
    );
  }
}
