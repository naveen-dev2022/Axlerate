import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AxleFormTextField extends StatefulWidget {
  const AxleFormTextField({
    Key? key,
    this.fieldHeading,
    required this.fieldHint,
    this.textType = TextInputType.text,
    this.isPasswordField = false,
    this.fieldWidth = 400,
    this.onChange,
    this.onSubmit,
    this.validate,
    this.obscure = false,
    this.fieldController,
    this.isOnlyDigits = false,
    this.lengthLimit = 256,
    this.fieldAction = TextInputAction.next,
    this.isFieldEnabled = true,
    this.isRequiredField = false,
    this.inputformatters,
    this.trailingIcon,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.words,
    this.isShowPrefixAmount = false,
    //this.isEnabled = true,
  }) : super(key: key);

  final String fieldHint;
  final String? fieldHeading;
  final Validators? validate;
  final void Function(String)? onChange;
  final Function(String)? onSubmit;
  final TextInputType textType;
  final bool isPasswordField;
  final double fieldWidth;
  final bool obscure;
  final TextEditingController? fieldController;
  final bool isOnlyDigits;
  final int lengthLimit;
  final TextInputAction fieldAction;
  final bool isFieldEnabled;
  final bool isRequiredField;
  final List<TextInputFormatter>? inputformatters;
  final Widget? trailingIcon;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final bool isShowPrefixAmount;
  //final bool isEnabled;

  @override
  State<AxleFormTextField> createState() => _AxleFormTextFieldState();
}

class _AxleFormTextFieldState extends State<AxleFormTextField> {
  bool hidePasswordText = true;

  void _togglePassword() {
    setState(() {
      hidePasswordText = !hidePasswordText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.fieldWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.fieldHeading != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.fieldHeading!, style: AxleTextStyle.titleSmall.copyWith(color: Colors.black)),
                widget.isRequiredField ? const Text('*', style: TextStyle(color: Colors.redAccent)) : const SizedBox(),
              ],
            ),
          if (widget.fieldHeading != null) const SizedBox(height: 10.0),
          Semantics(
            label: '${widget.fieldHeading} Field',
            child: TextFormField(
              textCapitalization: widget.textCapitalization,
              autofocus: widget.autofocus,
              enabled: widget.isFieldEnabled,
              controller: widget.fieldController,
              cursorColor: primaryColor,
              obscureText: widget.isPasswordField ? hidePasswordText : false,
              textInputAction: widget.fieldAction,
              maxLength: widget.lengthLimit != 256 ? widget.lengthLimit : null,
              inputFormatters: widget.inputformatters ??
                  [
                    widget.isOnlyDigits ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.deny(''),
                    // widget.isPasswordField
                    //     ? FilteringTextInputFormatter.allow(RegExp("."))
                    //     : FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z.@'s']")),
                    LengthLimitingTextInputFormatter(widget.lengthLimit),
                  ],
              validator: MultiValidator(
                widget.validate != null ? widget.validate!.validations : [],
              ),
              onChanged: widget.onChange,
              onFieldSubmitted: widget.onSubmit,
              keyboardType: widget.textType,
              decoration: InputDecoration(
                enabled: widget.isFieldEnabled,
                semanticCounterText: '${widget.fieldHeading} Field',
                filled: true,
                fillColor: AxleColors.axleWhiteColor,
                hintText: widget.fieldHint,
                hintStyle: AxleTextStyle.labelLarge.copyWith(color: Colors.grey),
                errorStyle: AxleTextStyle.fieldErrorTextStyle,
                suffixIcon: widget.isPasswordField
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _togglePassword,
                          child: hidePasswordText ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                        ),
                      )
                    : null,
                suffix: widget.trailingIcon,
                prefixIcon: widget.isShowPrefixAmount
                    ? const SizedBox(
                        child: Center(
                          widthFactor: 0.0,
                          child: Text(
                            '\u20B9',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: primaryColor, width: 1.7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: Color(0xffDCE9F6), width: 1.6),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: Color(0xffDCE9F6), width: 1.6),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
