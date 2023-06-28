import 'dart:convert';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../domain/aadhaar_otp_verified_model.dart';
import '../common/common_widgets.dart';
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
                ECardVerificationWidgets.drawBGStackImageWidget(
                  context: context,
                ),
                ECardVerificationWidgets.drawLogoWidget(context: context),
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
              ECardVerificationWidgets.detailHeadingCard(
                icon: 'assets/images/rc_detail.svg',
                title: 'Aadhar Card Number',
                subTitle: data?.aadhaarNumber,
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
                        '${data?.fullName}',
                        style: AxleTextStyle.poppins16w400.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff252525)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Gender',
                      value: data?.gender,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Date of Birth',
                      value: data?.dob,
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
                      key: 'Address Line 1',
                      value: data?.address?.house,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Address Line 1',
                      value: data?.address?.street,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'District',
                      value: data?.address?.dist,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'State',
                      value: data?.address?.state,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'PIN Code',
                      value: data?.address?.po,
                    ),
                    ECardVerificationWidgets.buildKeyValue(
                      key: 'Country',
                      value: data?.address?.country,
                    ),
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
}
