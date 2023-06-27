import 'dart:convert';

import 'package:auto_route/annotations.dart';
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
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SvgPicture.asset(
                      'assets/images/bg_stack.svg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: MediaQuery.of(context).size.width / 2 - 120 / 2,
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 100,
                    height: 25,
                  ),
                ),
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
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 10),
                      blurRadius: 25,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: AxleColors.axleSecondaryColor,
                    width: 1.5,
                  ),
                ),
                child: ListTile(
                  leading: SvgPicture.asset('assets/images/rc_detail.svg'),
                  title: const Text('Driving License Number'),
                  subtitle: Text("${data?.licenseNumber}"),
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              /* if (drivingLicenseEntity.data?.hasImage ?? false) ...[
              Transform.translate(
                offset: Offset(0, 20),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: MemoryImage(base64Decode(
                      "${drivingLicenseEntity.data?.profileImage}")),
                ),
              ),
            ] else ...[
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://www.sarojhospital.com/images/testimonials/dummy-profile.png'),
              ),
            ],*/
              /*   Transform.translate(
              offset: Offset(0, -20),
              child:
            ),*/
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
                      child: Text('${data?.name}'),
                    ),
                    const SizedBox(height: 12),
                    _buildKeyValue(key: 'Gender', value: data?.gender ?? ""),
                    _buildKeyValue(
                        key: 'Date of Birth', value: data?.dob ?? ""),
                    _buildKeyValue(
                        key: 'Citizenship', value: data?.citizenship ?? ""),
                    _buildKeyValue(
                        key: 'Father/Husband’s Name',
                        value: data?.fatherOrHusbandName ?? ""),
                    _buildKeyValue(
                        key: 'Blood Group', value: data?.bloodGroup ?? ""),
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
                    const Text('Address Details of Owner'),
                    const SizedBox(
                      height: 12,
                    ),
                    _buildKeyValue(
                        key: 'Permanent Address',
                        value: data?.permanentAddress ?? ""),
                    _buildKeyValue(
                        key: 'Temporary Address',
                        value: data?.temporaryAddress ?? ""),
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
                    const Text('Driving License Details'),
                    const SizedBox(
                      height: 12,
                    ),
                    _buildKeyValue(
                        key: 'Driving License Number',
                        value: data?.licenseNumber ?? ""),
                    _buildKeyValue(key: 'State', value: data?.state ?? ""),
                    _buildKeyValue(key: 'Issued on', value: data?.doe ?? ""),
                    _buildKeyValue(key: 'Expires on', value: data?.doi ?? ""),
                    _buildKeyValue(
                        key: 'Licensing Authority', value: data?.doi ?? ""),
                    _buildKeyValue(
                        key: 'Vehicle Class',
                        value: data?.vehicleClasses.toString() ?? ""),
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
              top: 120,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(
                    base64Decode("${drivingLicenseEntity.data?.profileImage}")),
              ),
            ),
          ] else ...[
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 120 / 2,
              top: 120,
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

  Widget _buildKeyValue({required String key, required String value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(key),
            const SizedBox(
              width: 25,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                value,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
