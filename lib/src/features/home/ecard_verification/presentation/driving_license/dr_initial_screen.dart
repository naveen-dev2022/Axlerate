import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../responsive.dart';
import '../../../../../../router/route_utils.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/loading_overlay_widget.dart';
import '../../../../../utils/snackbar_util.dart';
import '../../../../../utils/verifiy_vehicle_helper.dart';
import '../common/dynamic_verification_card.dart';
import '../controller/ecard_controller.dart';
import '../home/ecard_dashboard.dart';

@RoutePage()
class DrivingLicenseInitial extends ConsumerStatefulWidget {
  const DrivingLicenseInitial({Key? key}) : super(key: key);

  @override
  ConsumerState<DrivingLicenseInitial> createState() =>
      _DrivingLicenseInitialState();
}

class _DrivingLicenseInitialState extends ConsumerState<DrivingLicenseInitial> {
  bool isMobile = false;
  final TextEditingController _textField1Controller = TextEditingController();
  final TextEditingController _textField2Controller = TextEditingController();
  final TextEditingController _textField3Controller = TextEditingController();
  final TextEditingController _textField4Controller = TextEditingController();
  final FocusNode _textField1FocusNode = FocusNode();
  final FocusNode _textField2FocusNode = FocusNode();
  final FocusNode _textField3FocusNode = FocusNode();
  final FocusNode _textField4FocusNode = FocusNode();
  final AxelOverlayLoader _loader = AxelOverlayLoader();
  final _formKey = GlobalKey<FormState>();
  bool showValidationError = false;

  String? _validateAadharField(
      {required String? value, required bool isRestrictedValue}) {
    if (value == null || value.isEmpty || isRestrictedValue) {
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
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Color.fromRGBO(0, 66, 105, 0.28)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Color.fromRGBO(0, 66, 105, 0.28)),
    ),
    errorStyle: const TextStyle(height: 0),
  );

  Widget enterOtpTextBar() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _textField1Controller,
                        keyboardType: TextInputType.text,
                        maxLength: 4,
                        decoration: _inputDecoration.copyWith(hintText: 'TN38'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[A-Z]{2}\d{2}$'),
                          ),
                        ],
                        validator: (value) {
                          return _validateAadharField(
                            value: value,
                            isRestrictedValue: value?.length != 4,
                          );
                        },
                        focusNode: _textField1FocusNode,
                        onChanged: (value) {
                          if (value.length == 4) {
                            _moveToNextField(
                                _textField1FocusNode, _textField2FocusNode);
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _textField2Controller,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: _inputDecoration.copyWith(hintText: '2019'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: (value) {
                          return _validateAadharField(
                            value: value,
                            isRestrictedValue: value?.length != 4,
                          );
                        },
                        focusNode: _textField2FocusNode,
                        onChanged: (value) {
                          if (value.length == 4) {
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
                        maxLength: 4,
                        decoration: _inputDecoration.copyWith(hintText: '0002'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: (value) {
                          return _validateAadharField(
                            value: value,
                            isRestrictedValue: value!.length != 4,
                          );
                        },
                        focusNode: _textField3FocusNode,
                        onChanged: (value) {
                          if (value.length == 4) {
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
                        maxLength: 3,
                        decoration: _inputDecoration.copyWith(hintText: '729'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: (value) {
                          return _validateAadharField(
                            value: value,
                            isRestrictedValue: value!.length != 3,
                          );
                        },
                        focusNode: _textField4FocusNode,
                      ),
                    ),
                  ),
                ],
              ),
              if (showValidationError == true) ...[
                const Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: AxleColors.axleRedColor,
                      size: 16,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text('Invalid Vehicle Registration Number'),
                  ],
                )
              ],
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
    _formKey.currentState?.dispose();
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

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          DynamicVerificationCard(
            onTap: () {
              context.router
                  .pushNamed(RouteUtils.getDrivingLicenseHistoryPath());
            },
            imageUrl: 'assets/images/driving_license_big.svg',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const Text('Enter Driving License Number'),
                      const SizedBox(
                        height: 5,
                      ),
                      enterOtpTextBar(),
                      const SizedBox(
                        height: 8,
                      ),
                      infoWidget(),
                      Expanded(child: Container()),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: navigationButton(
                          onTap: () async {
                            await validateDrivingLicense();
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

  Future validateDrivingLicense() async {
    //  if (_formKey.currentState!.validate()) {
    setState(() {
      showValidationError = false;
    });
    _loader.show(context);
    ref.read(drivingLicenseStateProvider.notifier).state = null;
    await ref
        .read(eCardControllerProvider)
        .fetchDrivingLicenseData(
          idNumber: _textField1Controller.text +
              _textField2Controller.text +
              _textField3Controller.text +
              _textField4Controller.text,
        )
        .then(
      (value) {
        ref.read(drivingLicenseStateProvider.notifier).state = value;
        final rcDataList = ref.watch(drivingLicenseStateProvider);
        _loader.hide();
        if (rcDataList?.status == true) {
          context.router.pushNamed(RouteUtils.getDrivingLicenseDetailPath());
          return null;
        } else {
          Snackbar.error("${rcDataList?.message}");
          return null;
        }
      },
    );
  }
  // }
}
