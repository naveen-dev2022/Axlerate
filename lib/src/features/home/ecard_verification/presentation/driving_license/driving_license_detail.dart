import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/rc_screen/rc_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../Themes/common_style_util.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../domain/driving_license_entity.dart';
import '../common/common_widgets.dart';
import '../controller/ecard_controller.dart';

import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/rc_screen/rc_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../Themes/common_style_util.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../domain/driving_license_entity.dart';
import '../controller/ecard_controller.dart';

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
      ref.read(drivingLicenseStateProvider.notifier).state =
          await ref.read(eCardControllerProvider).fetchDrivingLicenseData(
                idNumber: 'TN3820190002729',
              );
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
          : Stack(
              children: [
                ECardVerificationWidgets.drawBGStackImageWidget(
                  context: context,
                ),
                ECardVerificationWidgets.drawLogoWidget(context: context),
                _buildRcDetail(drivingLicenseEntity)
              ],
            ),
    );
  }

  Widget _buildRcDetail(DrivingLicenseEntity? drivingLicenseEntity) {
    final data = drivingLicenseEntity!.data;
    return Padding(
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: defaultPadding)
          : const EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
      child: SingleChildScrollView(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              IconButton(
                onPressed: () {
                  context.router.pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: AxleColors.axlePrimaryColor,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ECardVerificationWidgets.detailHeadingCard(
                icon: 'assets/images/rc_detail.svg',
                title: 'Driving License Number',
                subTitle: data?.licenseNumber,
              ),
              const SizedBox(
                height: 120,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 10),
                      blurRadius: 25,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${data?.name}',
                        style: AxleTextStyle.poppins16w400.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff252525)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Gender',
                      value: data?.gender ?? "",
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Date of Birth',
                      value: data?.dob,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Citizenship',
                      value: data?.citizenship,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Father/Husband’s Name',
                      value: data?.fatherOrHusbandName,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Blood Group',
                      value: data?.bloodGroup,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 10),
                      blurRadius: 25,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address Details of Owner',
                      style: AxleTextStyle.poppins14w500Blue,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Permanent Address',
                      value: data?.permanentAddress,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Temporary Address',
                      value: data?.temporaryAddress,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 10),
                      blurRadius: 25,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Driving License Details',
                      style: AxleTextStyle.poppins14w500Blue,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Driving License Number',
                      value: data?.licenseNumber,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'State',
                      value: data?.state,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Issued on',
                      value: data?.doe,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Expires on',
                      value: data?.doi,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Licensing Authority',
                      value: data?.doi,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Vehicle Class',
                      value: data?.vehicleClasses.toString(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 150,
              ),
            ],
          ),
          if (drivingLicenseEntity.data?.hasImage ?? false) ...[
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 120 / 2,
              top: 160,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(
                    base64Decode("${drivingLicenseEntity.data?.profileImage}")),
              ),
            ),
          ] else ...[
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 120 / 2,
              top: 160,
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://www.sarojhospital.com/images/testimonials/dummy-profile.png'),
              ),
            ),
          ],
        ],
      )),
    );
  }
}
