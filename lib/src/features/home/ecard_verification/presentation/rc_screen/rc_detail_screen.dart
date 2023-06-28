import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../domain/rc_entity.dart';
import '../common/common_widgets.dart';
import '../controller/ecard_controller.dart';

@RoutePage()
class RcDetailScreen extends ConsumerStatefulWidget {
  const RcDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RcDetailScreen> createState() => _RcDetailScreenState();
}

class _RcDetailScreenState extends ConsumerState<RcDetailScreen> {
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    final rcDataList = ref.watch(rcStateProvider);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: rcDataList == null
          ? AxleLoader.axleProgressIndicator()
          : Stack(
              children: [
                ECardVerificationWidgets.drawBGStackImageWidget(
                  context: context,
                ),
                ECardVerificationWidgets.drawLogoWidget(context: context),
                _buildRcDetail(rcDataList)
              ],
            ),
    );
  }

  Widget _buildRcDetail(RcEntity? rcDataList) {
    final data = rcDataList!.data;
    return Padding(
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: defaultPadding)
          : const EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
      child: SingleChildScrollView(
        child: Column(
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
              title: 'Vehicle Registration Number',
              subTitle: data?.rcNumber,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RC Details',
                    style: AxleTextStyle.poppins14w500Blue,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'RC Number',
                    value: data?.rcNumber,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Chassis Number',
                    value: data?.vehicleChasiNumber,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Engine Number',
                    value: data?.vehicleEngineNumber,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Registered at',
                    value: data?.registeredAt,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Registration Date',
                    value: data?.registrationDate,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Manufacturing Date',
                    value: data?.manufacturingDate,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Fitness Upto',
                    value: data?.fitUpTo,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vehicle Description'),
                  const SizedBox(
                    height: 12,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Fuel Type',
                    value: data?.fuelType,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Vehicle Category',
                    value: data?.vehicleCategory,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Maker Description',
                    value: data?.makerDescription,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Model',
                    value: data?.mobileNumber,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vehicle Insurance Details'),
                  const SizedBox(
                    height: 12,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Insurance Company Name',
                    value: data?.insuranceCompany,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Insurance Policy Number',
                    value: data?.insurancePolicyNumber,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Insurance Expiry Date',
                    value: data?.insuranceUpto,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vehicle PUCC Details'),
                  const SizedBox(
                    height: 12,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'PUCC Number',
                    value: data?.puccNumber,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'PUCC Expiry Date',
                    value: data?.puccUpto,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vehicle Owner Details'),
                  const SizedBox(
                    height: 12,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Full Name of Vehicle Owner',
                    value: data?.ownerName ?? "",
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Father’s Name',
                    value: data?.fatherName ?? "",
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Mobile Number',
                    value: data?.mobileNumber ?? "",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
