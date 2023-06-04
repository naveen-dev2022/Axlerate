import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AxleTextField extends StatefulWidget {
  const AxleTextField({
    Key? key,
    this.fieldHeading,
    required this.fieldHint,
    this.textType = TextInputType.text,
    this.isPasswordField = false,
    this.fieldWidth = 450,
    this.onChange,
    this.onSubmit,
    this.validate,
    this.obscure = false,
    this.fieldController,
    this.isOnlyDigits = false,
    this.lengthLimit = 256,
    this.fieldAction = TextInputAction.next,
    this.isFieldEnabled = true,
    this.enableInteractiveSelection = true,
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
  final bool enableInteractiveSelection; // false to Disable the copy/paste.

  @override
  State<AxleTextField> createState() => _AxleTextFieldState();
}

class _AxleTextFieldState extends State<AxleTextField> {
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
            Text(
              widget.fieldHeading!,
              style: AxleTextStyle.textFieldHeadingStyle,
            ),
          if (widget.fieldHeading != null) const SizedBox(height: 10.0),
          Semantics(
            label: '${widget.fieldHeading} Field',
            child: TextFormField(
              enableInteractiveSelection: widget.enableInteractiveSelection,
              enabled: widget.isFieldEnabled,
              controller: widget.fieldController,
              cursorColor: primaryColor,
              obscureText: widget.isPasswordField ? hidePasswordText : false,
              textInputAction: widget.fieldAction,
              inputFormatters: [
                widget.isOnlyDigits
                    ? FilteringTextInputFormatter.digitsOnly
                    : widget.isPasswordField
                        ? FilteringTextInputFormatter.allow(RegExp("."))
                        : FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z.@]")),
                LengthLimitingTextInputFormatter(widget.lengthLimit),
              ],
              validator: MultiValidator(
                widget.validate != null ? widget.validate!.validations : [],
              ),
              onChanged: widget.onChange,
              onFieldSubmitted: widget.onSubmit,
              keyboardType: widget.textType,
              decoration: InputDecoration(
                semanticCounterText: '${widget.fieldHeading} Field',
                filled: true,
                fillColor: textFieldFillColor,
                hintText: widget.fieldHint,
                hintStyle: AxleTextStyle.textFieldHintStyle,
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide.none,
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
