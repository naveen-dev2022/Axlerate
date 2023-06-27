import 'dart:convert';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../domain/aadhaar_otp_verified_model.dart';
import '../controller/ecard_controller.dart';

@RoutePage()
class AadhaarScreen extends ConsumerStatefulWidget {
  const AadhaarScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AadhaarScreen> createState() => _AadhaarScreenState();
}

class _AadhaarScreenState extends ConsumerState<AadhaarScreen> {
  double screenWidth = 0.0;
  bool isMobile = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(verifyAadhaarOtpStateProvider.notifier).state = null;
      ref.read(verifyAadhaarOtpStateProvider.notifier).state =
          await ref.read(eCardControllerProvider).fetchVerifyAadhaarOtp(
                otp: '',
                clientId: '',
              );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);

    final aadharDataList = ref.watch(verifyAadhaarOtpStateProvider);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: aadharDataList == null
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
                _buildRcDetail(aadharDataList)
              ],
            ),
    );
  }

  Widget _buildRcDetail(AadhaarOtpVerifiedModel? drivingLicenseEntity) {
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
                  title: const Text('Aadhar Card Number'),
                  subtitle: Text("${data?.aadhaarNumber}"),
                ),
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
                      child: Text('${data?.fullName}'),
                    ),
                    const SizedBox(height: 12),
                    _buildKeyValue(key: 'Gender', value: data?.gender ?? ""),
                    _buildKeyValue(
                        key: 'Date of Birth', value: data?.dob ?? ""),
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
                        key: 'Address Line 1',
                        value: data?.address?.house ?? ""),
                    _buildKeyValue(
                        key: 'Address Line 1',
                        value: data?.address?.street ?? ""),
                    _buildKeyValue(
                        key: 'District', value: data?.address?.dist ?? ""),
                    _buildKeyValue(
                        key: 'State', value: data?.address?.state ?? ""),
                    _buildKeyValue(
                        key: 'PIN Code', value: data?.address?.po ?? ""),
                    _buildKeyValue(
                        key: 'Country', value: data?.address?.country ?? ""),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
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
