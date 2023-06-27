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
import '../common/dynamic_verification_card.dart';
import '../controller/ecard_controller.dart';
import '../home/ecard_dashboard.dart';

@RoutePage()
class PanInitialScreen extends ConsumerStatefulWidget {
  const PanInitialScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PanInitialScreen> createState() => _PanInitialScreenState();
}

class _PanInitialScreenState extends ConsumerState<PanInitialScreen> {
  bool isMobile = false;
  final TextEditingController _textField1Controller = TextEditingController();
  final TextEditingController _textField2Controller = TextEditingController();
  final TextEditingController _textField3Controller = TextEditingController();
  final FocusNode _textField1FocusNode = FocusNode();
  final FocusNode _textField2FocusNode = FocusNode();
  final FocusNode _textField3FocusNode = FocusNode();
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
                        maxLength: 5,
                        decoration:
                            _inputDecoration.copyWith(hintText: 'ABCDE'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                        ],
                        validator: (value) {
                          return _validateAadharField(
                            value: value,
                            isRestrictedValue: value?.length != 5,
                          );
                        },
                        focusNode: _textField1FocusNode,
                        onChanged: (value) {
                          if (value.length == 5) {
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
                        decoration: _inputDecoration.copyWith(hintText: '1234'),
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
                        keyboardType: TextInputType.text,
                        maxLength: 1,
                        decoration: _inputDecoration.copyWith(hintText: 'F'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                        ],
                        validator: (value) {
                          return _validateAadharField(
                            value: value,
                            isRestrictedValue: value?.length != 1,
                          );
                        },
                        focusNode: _textField3FocusNode,
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

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          DynamicVerificationCard(
            onTap: () {
              context.router.pushNamed(RouteUtils.getPanHistoryPath());
            },
            imageUrl: 'assets/images/pan_big.svg',
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
                      const Text('Enter PAN Card Number'),
                      const SizedBox(
                        height: 5,
                      ),
                      enterOtpTextBar(),
                      const SizedBox(
                        height: 8,
                      ),
                      infoWidget(),
                      Expanded(
                        child: Container(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: navigationButton(
                          onTap: () async {
                            await validatePan();
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

  Future validatePan() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        showValidationError = false;
      });
      _loader.show(context);
      ref.read(panStateProvider.notifier).state = null;
      await ref
          .read(eCardControllerProvider)
          .fetchPanDetailsData(
            idNumber: _textField1Controller.text +
                _textField2Controller.text +
                _textField3Controller.text,
          )
          .then(
        (value) {
          ref.read(panStateProvider.notifier).state = value;
          final panData = ref.watch(panStateProvider);
          _loader.hide();
          if (panData?.status == true) {
            context.router.pushNamed(RouteUtils.getPanDetailPath());
            return null;
          } else {
            Snackbar.error("${panData?.message}");
            return null;
          }
        },
      );
    }
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
    _textField1FocusNode.dispose();
    _textField2FocusNode.dispose();
    _textField3FocusNode.dispose();
    super.dispose();
  }
}
