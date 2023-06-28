import 'package:auto_route/auto_route.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../router/route_utils.dart';
import '../../../../../utils/loading_overlay_widget.dart';
import '../../../../../utils/snackbar_util.dart';
import '../../domain/aadhaar_otp_verified_model.dart';
import '../common/common_widgets.dart';
import '../controller/ecard_controller.dart';
import '../home/ecard_dashboard.dart';

@RoutePage()
class AadharOtpScreen extends ConsumerStatefulWidget {
  const AadharOtpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AadharOtpScreen> createState() => _AadharOtpScreenState();
}

class _AadharOtpScreenState extends ConsumerState<AadharOtpScreen> {
  bool isMobile = false;
  final TextEditingController _textField1Controller = TextEditingController();
  final TextEditingController _textField2Controller = TextEditingController();
  final TextEditingController _textField3Controller = TextEditingController();
  final TextEditingController _textField4Controller = TextEditingController();
  final FocusNode _textField1FocusNode = FocusNode();
  final FocusNode _textField2FocusNode = FocusNode();
  final FocusNode _textField3FocusNode = FocusNode();
  final FocusNode _textField4FocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final AxelOverlayLoader _loader = AxelOverlayLoader();
  String? clientId;
  bool showValidationError = false;
  AadhaarOtpVerifiedModel? aadhaarOtpVerifiedModel;

  String? _validateAadharField(String? value) {
    if (value == null || value.isEmpty || value.length != 1) {
      setState(() {
        showValidationError = true;
      });
      return '';
    }
    return null;
  }

  final InputDecoration _inputDecoration = InputDecoration(
    hintText: '',
    counterText: '',
    hintStyle: TextStyle(color: Colors.grey.shade300),
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color.fromRGBO(0, 66, 105, 0.28)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color.fromRGBO(0, 66, 105, 0.28)),
    ),
    errorStyle: const TextStyle(height: 0),
  );

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          DynamicVerificationCard(
            onTap: () {},
            imageUrl: 'assets/images/aadhar_history.svg',
            showHistoryIcon: false,
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              padding: isMobile
                  ? const EdgeInsets.symmetric(horizontal: defaultPadding)
                  : const EdgeInsets.symmetric(
                      horizontal: horizontalPadding, vertical: verticalPadding),
              child: Stack(
                fit: StackFit.expand,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (showValidationError == false) ...[
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Enter OTP',
                          style: AxleTextStyle.poppins18w600,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'An OTP has been sent to\n',
                                style: AxleTextStyle.poppins12w400.copyWith(
                                  color: const Color(0xff8B9197),
                                ),
                              ),
                              TextSpan(
                                text: '8220055432',
                                style: AxleTextStyle.poppins12w400.copyWith(
                                  color: const Color(0xff00499B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ] else ...[
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Incorrect OTP',
                          style: AxleTextStyle.poppins18w600,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Please enter the correct OTP sent to\n',
                                style: AxleTextStyle.poppins12w400.copyWith(
                                  color: const Color(0xff8B9197),
                                ),
                              ),
                              TextSpan(
                                text: '91234 54321',
                                style: AxleTextStyle.poppins12w400.copyWith(
                                  color: const Color(0xff00499B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ],
                      enterOtpTextBar(),
                      Expanded(
                        child: Container(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: navigationButton(
                          onTap: () async {
                            await verifyOtp();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 105,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      _loader.show(context);
      ref.read(verifyAadhaarOtpStateProvider.notifier).state = null;
      ref.read(verifyAadhaarOtpStateProvider.notifier).state = await ref
          .read(eCardControllerProvider)
          .fetchVerifyAadhaarOtp(
            otp: '',
            clientId: clientId,
          )
          .then((AadhaarOtpVerifiedModel value) {
        ref.read(verifyAadhaarOtpStateProvider.notifier).state = value;
        final aadharDataList = ref.watch(verifyAadhaarOtpStateProvider);
        _loader.hide();
        if (aadharDataList?.status == true) {
          context.router.pushNamed(RouteUtils.getAadhaarDetailPath());
          return null;
        } else {
          Snackbar.error("${aadharDataList?.message}");
          return null;
        }
      });
      aadhaarOtpVerifiedModel = ref.watch(verifyAadhaarOtpStateProvider);
    }
  }

  Widget enterOtpTextBar() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextFormField(
                          controller: _textField1Controller,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: _inputDecoration.copyWith(hintText: '0'),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          validator: _validateAadharField,
                          focusNode: _textField1FocusNode,
                          onChanged: (value) {
                            if (value.length == 1) {
                              _moveToNextField(
                                  _textField1FocusNode, _textField2FocusNode);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _textField2Controller,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: _inputDecoration.copyWith(hintText: '0'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: _validateAadharField,
                        focusNode: _textField2FocusNode,
                        onChanged: (value) {
                          if (value.length == 1) {
                            _moveToNextField(
                                _textField2FocusNode, _textField3FocusNode);
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _textField3Controller,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: _inputDecoration.copyWith(hintText: '0'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: _validateAadharField,
                        focusNode: _textField3FocusNode,
                        onChanged: (value) {
                          if (value.length == 1) {
                            _moveToNextField(
                                _textField3FocusNode, _textField4FocusNode);
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _textField4Controller,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: _inputDecoration.copyWith(hintText: '0'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: _validateAadharField,
                        focusNode: _textField4FocusNode,
                      ),
                    ),
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Resend OTP? ',
                      style: AxleTextStyle.poppins12w400.copyWith(
                        color: const Color(0xff8B9197),
                      ),
                    ),
                    TextSpan(
                      text: '00:30',
                      style: AxleTextStyle.poppins12w400.copyWith(
                        color: const Color(0xff00499B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _moveToNextField(FocusNode currentFocusNode, FocusNode nextFocusNode) {
    currentFocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  @override
  void dispose() {
    _textField1Controller.dispose();
    _textField2Controller.dispose();
    _textField3Controller.dispose();
    _textField4Controller.dispose();
    _textField1FocusNode.dispose();
    _textField2FocusNode.dispose();
    _textField3FocusNode.dispose();
    _textField4FocusNode.dispose();
    super.dispose();
  }
}
