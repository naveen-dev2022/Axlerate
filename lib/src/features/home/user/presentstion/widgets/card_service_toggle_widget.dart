import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_field.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';

class CardServiceToggleWidget extends StatefulWidget {
  const CardServiceToggleWidget({
    super.key,
    required this.title,
    this.defaultCardTitle,
    required this.onChange,
    required this.enableSecondaryCard,
    this.secondaryCardTitle,
    this.buttonValue = true, //changed for UI
    // this.buttonValue = false,
    required this.defaultLimitController,
    this.secondaryLimitController,
    this.defaultCurrentLimit = '101',
    this.secondaryCurrentLimit = '101',
    required this.defaultMaxLimitAmount,
    this.secondaryMaxLimitAmount,
  });

  final String title;
  final String? defaultCardTitle;
  final void Function(bool) onChange;
  final bool enableSecondaryCard;
  final String? secondaryCardTitle;
  final bool buttonValue;
  final TextEditingController defaultLimitController;
  final TextEditingController? secondaryLimitController;
  final String defaultCurrentLimit;
  final String? secondaryCurrentLimit;
  final num defaultMaxLimitAmount;
  final num? secondaryMaxLimitAmount;

  @override
  State<CardServiceToggleWidget> createState() => _CardServiceToggleWidgetState();
}

class _CardServiceToggleWidgetState extends State<CardServiceToggleWidget> {
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;
  double _animatedHeight = 500.0;
  double sliderValue = 5000;
  bool isToggleEnabled = true;
  double _walletCurrentSliderValue = 5000;

  @override
  void initState() {
    isToggleEnabled = widget.buttonValue;
    widget.defaultLimitController.text = widget.defaultCurrentLimit;
    // axleCurrencyFormatterwithDecimals.format(int.parse(widget.defaultCurrentLimit));
    sliderValue = num.parse(widget.defaultCurrentLimit).toDouble();

    if (widget.secondaryLimitController?.text != null) {
      widget.secondaryLimitController!.text = widget.secondaryCurrentLimit ?? '';
    }
    _walletCurrentSliderValue = double.parse(widget.secondaryCurrentLimit ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _animatedHeight = widget.buttonValue == true
        ? (widget.enableSecondaryCard == true)
            ? _animatedHeight
            : 400
        : 0;

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2 + defaultPadding);

    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }
    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 400),
      width: isMobile ? availableWidth : availableWidth * 35 / 100,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: CommonStyleUtil.axleContainerDecoration,
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.title,
                  style: AxleTextStyle.axleFormFieldHintStyle,
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(width: 30.0),
              // MouseRegion(
              //   cursor: SystemMouseCursors.click,
              //   child: FlutterSwitch(
              //     width: 45,
              //     height: 25,
              //     toggleSize: 18,
              //     value: widget.buttonValue,
              //     showOnOff: false,
              //     onToggle: (value) {
              //       setState(() {
              //         _animatedHeight != 0.0 ? _animatedHeight = 0.0 : _animatedHeight = 450.0;
              //         isToggleEnabled = value;
              //       });
              //       widget.onChange(value);
              //     },
              //   ),
              // ),
            ],
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 80),
            height: widget.enableSecondaryCard == true ? _animatedHeight * 0.9 : _animatedHeight * 0.6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: defaultPadding),
                  Container(
                    constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 400),
                    decoration: widget.enableSecondaryCard == true
                        ? BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              width: 1.6,
                              color: const Color(0xffEBEBFB),
                            ),
                          )
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(defaultMobilePadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.defaultCardTitle != null)
                            Text(widget.defaultCardTitle!, style: AxleTextStyle.textFieldHeadingStyle),
                          if (widget.defaultCardTitle != null) const SizedBox(height: defaultPadding),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Current Limit  ", style: AxleTextStyle.subtitle2),
                              const SizedBox(width: defaultMobilePadding),
                              Text(
                                axleCurrencyFormatterwithDecimals.format(num.parse(widget.defaultCurrentLimit)),
                                style: AxleTextStyle.subtitle2.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultPadding),
                          const Text("Set new Limit"),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Stack(
                                  children: [
                                    Slider(
                                      value: sliderValue <= widget.defaultMaxLimitAmount.toDouble() ? sliderValue : 0,
                                      min: 0,
                                      max: widget.defaultMaxLimitAmount.toDouble(),
                                      label: sliderValue.round().toString(),
                                      divisions: widget.defaultMaxLimitAmount.toInt(),
                                      onChanged: (double value) {
                                        setState(
                                          () {
                                            widget.defaultLimitController.text = num.parse(value.toString()).toString();
                                            sliderValue = value;
                                          },
                                        );
                                      },
                                    ),
                                    Positioned(
                                      right: 16,
                                      bottom: -3,
                                      child: Text(
                                        axleCurrencyFormatter.format(widget.defaultMaxLimitAmount),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: defaultPadding),
                              AxleTextField(
                                isFieldEnabled: isToggleEnabled,
                                fieldWidth: 140,
                                // fieldHeading: "Set Fuel Limit",
                                fieldHint: "Limit",
                                fieldController: widget.defaultLimitController,
                                isOnlyDigits: true,
                                lengthLimit: 6,
                                validate: isToggleEnabled
                                    ? Validators("Amount")
                                        .range(0, num.parse(widget.defaultMaxLimitAmount.toString()).toInt())
                                    : null,
                                onChange: (val) {
                                  if (num.parse(val) <= widget.defaultMaxLimitAmount) {
                                    sliderValue = num.parse(widget.defaultLimitController.text.toString()).toDouble();
                                    setState(() {});
                                  } else {
                                    Snackbar.warn("Actual limit is ${widget.defaultMaxLimitAmount}");
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  if (widget.enableSecondaryCard == true)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          width: 1.6,
                          color: const Color(0xffEBEBFB),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.secondaryCardTitle ?? '',
                              style: AxleTextStyle.textFieldHeadingStyle,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Limit  ",
                                  style: AxleTextStyle.subtitle2,
                                ),
                                const SizedBox(width: defaultMobilePadding),
                                Text(
                                  "Litres ${widget.secondaryCurrentLimit}",
                                  style: AxleTextStyle.subtitle2.copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text("Set Limit"),
                            Wrap(
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: Stack(
                                    children: [
                                      Slider(
                                        value: _walletCurrentSliderValue <= widget.secondaryMaxLimitAmount!
                                            ? _walletCurrentSliderValue
                                            : 0,
                                        min: 0,
                                        max: widget.secondaryMaxLimitAmount?.toDouble() ?? 0,
                                        label: _walletCurrentSliderValue.round().toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            widget.secondaryLimitController?.text = value.toInt().toString();
                                            _walletCurrentSliderValue = value;
                                          });
                                        },
                                      ),
                                      Positioned(
                                        right: 16,
                                        bottom: -3,
                                        child: Text(
                                          widget.secondaryMaxLimitAmount.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AxleTextField(
                                  fieldWidth: 90,
                                  // fieldHeading: "Set Fuel Limit",
                                  fieldHint: "Limit",
                                  fieldController: widget.secondaryLimitController,
                                  isOnlyDigits: true,
                                  lengthLimit: 6,
                                  validate: isToggleEnabled
                                      ? Validators("Amount")
                                          .range(0, num.parse(widget.secondaryMaxLimitAmount.toString()).toInt())
                                      : null,
                                  onChange: (val) {
                                    if (num.parse(val) <= widget.secondaryMaxLimitAmount!) {
                                      _walletCurrentSliderValue =
                                          num.parse(widget.secondaryLimitController!.text.toString()).toDouble();
                                      setState(() {});
                                    } else {
                                      Snackbar.warn("Actual limit is ${widget.secondaryMaxLimitAmount}");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
