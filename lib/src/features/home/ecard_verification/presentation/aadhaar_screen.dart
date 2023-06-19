import 'package:auto_route/annotations.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/rc_screen/rc_card_item.dart';
import 'package:axlerate/src/utils/loading_overlay_widget.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Themes/axle_colors.dart';
import '../../../../../Themes/common_style_util.dart';
import '../../../../../Themes/text_style_config.dart';
import '../../../../../responsive.dart';
import '../../../../../values/constants.dart';
import '../domain/aadhaar_otp_verified_model.dart';
import 'controller/ecard_controller.dart';

@RoutePage()
class AadhaarScreen extends ConsumerStatefulWidget {
  const AadhaarScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AadhaarScreen> createState() => _AadhaarScreenState();
}

class _AadhaarScreenState extends ConsumerState<AadhaarScreen> {
  TextEditingController otpTextController = TextEditingController();
  TextEditingController verifyOtpTextController = TextEditingController();
  double screenWidth = 0.0;
  bool isMobile = false;
  String? clientId;
  AadhaarOtpVerifiedModel? aadhaarOtpVerifiedModel;
  final AxelOverlayLoader _loader = AxelOverlayLoader();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double availableWidth = screenWidth - (defaultMobilePadding * 2);
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: Padding(
        padding: isMobile
            ? const EdgeInsets.symmetric(horizontal: defaultMobilePadding)
            : const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding,
                ),
                child: Text(
                  "Aadhaar",
                  style: AxleTextStyle.headingPrimary,
                ),
              ),
              Wrap(
                runSpacing: defaultPadding,
                spacing: defaultPadding,
                children: [
                  SizedBox(
                    width: isMobile ? availableWidth : 250,
                    height: 60,
                    child: enterOtpTextBar(),
                  ),
                  SizedBox(
                    width: isMobile ? availableWidth : 250,
                    height: 60,
                    child: verifyOtpTextBar(),
                  ),
                ],
              ),
              _minSpace(),
              if (aadhaarOtpVerifiedModel == null) ...[
                const SizedBox.shrink()
              ] else ...[
                Container(
                  decoration: CommonStyleUtil.axleListingCardDecoration,
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Wrap(
                      runSpacing: defaultPadding,
                      spacing: defaultPadding,
                      children: [
                        UserDataCard(
                          title: "Full Name",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.fullName ?? "",
                        ),
                        UserDataCard(
                          title: "Aadhaar Number",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.aadhaarNumber ??
                                  "",
                        ),
                        UserDataCard(
                          title: "DOB",
                          subTitle: aadhaarOtpVerifiedModel?.data?.dob ?? "",
                        ),
                        UserDataCard(
                          title: "Gender",
                          subTitle: aadhaarOtpVerifiedModel?.data?.gender ?? "",
                        ),
                        UserDataCard(
                          title: "Care Of",
                          subTitle: aadhaarOtpVerifiedModel?.data?.careOf ?? "",
                        ),
                        UserDataCard(
                          title: "Face Score",
                          subTitle: aadhaarOtpVerifiedModel?.data?.faceScore
                              .toString(),
                        ),
                        UserDataCard(
                          title: "Reference Id",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.referenceId ?? "",
                        ),
                      ]),
                ),
                _minSpace(),
                const Text(
                  'Address Section',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _minSpace(),
                Container(
                  decoration: CommonStyleUtil.axleListingCardDecoration,
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Wrap(
                      runSpacing: defaultPadding,
                      spacing: defaultPadding,
                      children: [
                        UserDataCard(
                          title: "Country",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.address?.country ??
                                  "",
                        ),
                        UserDataCard(
                          title: "District",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.address?.dist ??
                                  "",
                        ),
                        UserDataCard(
                          title: "State",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.address?.state ??
                                  "",
                        ),
                        UserDataCard(
                          title: "Post",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.address?.po ?? "",
                        ),
                        UserDataCard(
                          title: "Location",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.address?.loc ?? "",
                        ),
                        UserDataCard(
                          title: "Vtc",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.address?.vtc ?? "",
                        ),
                        UserDataCard(
                          title: "Sub District",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.address?.dist ??
                                  "",
                        ),
                        UserDataCard(
                          title: "Street",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.address?.street ??
                                  "",
                        ),
                        UserDataCard(
                          title: "House",
                          subTitle:
                              aadhaarOtpVerifiedModel?.data?.address?.house ??
                                  "",
                        ),
                        UserDataCard(
                          title: "Landmark",
                          subTitle: aadhaarOtpVerifiedModel
                                  ?.data?.address?.landmark ??
                              "",
                        ),
                        UserDataCard(
                          title: "ZipCode",
                          subTitle: aadhaarOtpVerifiedModel?.data?.zip ?? "",
                        ),
                      ]),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _minSpace() {
    return const SizedBox(
      height: 16,
    );
  }

  Future fetchOtp() async {
    _loader.show(context);
    await ref
        .read(eCardControllerProvider)
        .fetchAadhaarOtp(idNumber: '')
        .then((value) {
      _loader.hide();
      if (value.status == true) {
        clientId = value.data?.clientId;
        Snackbar.success("OTP sent Successfully");
        return;
      } else {
        Snackbar.error("OTP has not sent");
        return;
      }
    });
  }

  Future verifyOtp() async {
    _loader.show(context);
    ref.read(verifyAadhaarOtpStateProvider.notifier).state = null;
    ref.read(verifyAadhaarOtpStateProvider.notifier).state = await ref
        .read(eCardControllerProvider)
        .fetchVerifyAadhaarOtp(
          otp: '',
          clientId: clientId,
        )
        .then((AadhaarOtpVerifiedModel value) {
      _loader.hide();
      return value;
    });
    aadhaarOtpVerifiedModel = ref.watch(verifyAadhaarOtpStateProvider);
    setState(() {});
  }

  Widget enterOtpTextBar() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextField(
          controller: otpTextController,
          onSubmitted: ((value) async {
            if (value.length >= 5) {
              await fetchOtp();
            }
          }),
          onChanged: (v) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Enter Id Number',
            fillColor: Colors.white,
            filled: true,
            suffixIcon: otpTextController.text == ""
                ? null
                : InkWell(
                    onTap: (() {
                      otpTextController.clear();
                      setState(() {
                        otpTextController.clear();
                      });
                    }),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
            prefixIcon: const Icon(
              Icons.search,
              color: AxleColors.axlePrimaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }

  Widget verifyOtpTextBar() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextField(
          controller: verifyOtpTextController,
          onSubmitted: ((value) async {
            if (value.length >= 5) {
              await verifyOtp();
            }
          }),
          onChanged: (v) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Verify OTP',
            fillColor: Colors.white,
            filled: true,
            suffixIcon: verifyOtpTextController.text == ""
                ? null
                : InkWell(
                    onTap: (() {
                      verifyOtpTextController.clear();
                      setState(() {
                        verifyOtpTextController.clear();
                      });
                    }),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
            prefixIcon: const Icon(
              Icons.search,
              color: AxleColors.axlePrimaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}
