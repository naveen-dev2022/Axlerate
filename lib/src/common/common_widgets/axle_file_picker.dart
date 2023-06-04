import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AxleFilePicker extends StatelessWidget {
  const AxleFilePicker({
    super.key,
    required this.labelText,
    required this.onPress,
    this.isRequiredField = false,
    this.customWidth = 320.0,
    required this.controller,
    this.validate,
    this.isEnabled = true,
    this.hintText = 'Upload Proof',
    this.showToolTip = false,
    this.toolTipText = '',
  });

  final double customWidth;
  final String labelText;
  final void Function()? onPress;
  final bool isRequiredField;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  final bool isEnabled;
  final String hintText;
  final bool showToolTip;
  final String toolTipText;

  @override
  Widget build(BuildContext context) {
    // log('isDisabled => ${!isEnabled}');
    // log('Enabled => ${isEnabled}');

    return SizedBox(
      width: customWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    labelText,
                    style: AxleTextStyle.axleFormFieldHeadingStyle,
                  ),
                  isRequiredField
                      ? const Text(
                          '*',
                          style: TextStyle(color: Colors.redAccent),
                        )
                      : const SizedBox(),
                ],
              ),
              if (showToolTip)
                Tooltip(
                  margin: const EdgeInsets.all(defaultPadding),
                  triggerMode: kIsWeb ? null : TooltipTriggerMode.tap,
                  message: toolTipText,
                  child: const Icon(Icons.info_outline),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Responsive.isDesktop(context) ? 10 : 4),
            child: TextFormField(
              enabled: isEnabled,
              controller: controller,
              cursorColor: Colors.transparent,
              cursorWidth: 0.0,
              validator: validate,

              // readOnly: widget.readOnly,
              // controller: widget.controller,
              // textInputAction: widget.textInputAction,
              onTap: isEnabled ? onPress : null,
              decoration: InputDecoration(
                filled: true,
                fillColor: AxleColors.axleBackgroundColor,
                isDense: true,
                // contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    color: primaryColor,
                    width: 1.7,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    color: Color(0xffDCE9F6),
                    width: 1.6,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    color: Color(0xffDCE9F6),
                    width: 1.6,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                ),
                hintText: hintText,

                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: SvgPicture.asset('assets/new_assets/icons/image_upload_icon.svg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
