import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../domain/rc_entity.dart';
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
                title: const Text('Vehicle Registration Number'),
                subtitle: Text("${data?.rcNumber}"),
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
                  const Text('RC Details'),
                  const SizedBox(
                    height: 12,
                  ),
                  _buildKeyValue(key: 'RC Number', value: data?.rcNumber ?? ""),
                  _buildKeyValue(
                      key: 'Chassis Number',
                      value: data?.vehicleChasiNumber ?? ""),
                  _buildKeyValue(
                      key: 'Engine Number',
                      value: data?.vehicleEngineNumber ?? ""),
                  _buildKeyValue(
                      key: 'Registered at', value: data?.registeredAt ?? ""),
                  _buildKeyValue(
                      key: 'Registration Date',
                      value: data?.registrationDate ?? ""),
                  _buildKeyValue(
                      key: 'Manufacturing Date',
                      value: data?.manufacturingDate ?? ""),
                  _buildKeyValue(
                      key: 'Fitness Upto', value: data?.fitUpTo ?? ""),
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
                  _buildKeyValue(key: 'Fuel Type', value: data?.fuelType ?? ""),
                  _buildKeyValue(
                      key: 'Vehicle Category',
                      value: data?.vehicleCategory ?? ""),
                  _buildKeyValue(
                      key: 'Maker Description',
                      value: data?.makerDescription ?? ""),
                  _buildKeyValue(key: 'Model', value: data?.mobileNumber ?? ""),
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
                  _buildKeyValue(
                      key: 'Insurance Company Name',
                      value: data?.insuranceCompany ?? ""),
                  _buildKeyValue(
                      key: 'Insurance Policy Number',
                      value: data?.insurancePolicyNumber ?? ""),
                  _buildKeyValue(
                      key: 'Insurance Expiry Date',
                      value: data?.insuranceUpto ?? ""),
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
                  _buildKeyValue(
                      key: 'PUCC Number', value: data?.puccNumber ?? ""),
                  _buildKeyValue(
                      key: 'PUCC Expiry Date', value: data?.puccUpto ?? ""),
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
                  _buildKeyValue(
                      key: 'Full Name of Vehicle Owner',
                      value: data?.ownerName ?? ""),
                  _buildKeyValue(
                      key: 'Father’s Name', value: data?.fatherName ?? ""),
                  _buildKeyValue(
                      key: 'Mobile Number', value: data?.mobileNumber ?? ""),
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
                overflow: TextOverflow.fade,
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
