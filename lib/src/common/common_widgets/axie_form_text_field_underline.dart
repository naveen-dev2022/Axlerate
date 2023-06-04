import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../utils/date_picker_util.dart';

class AxleFormTextFieldUnderline extends StatefulWidget {
  const AxleFormTextFieldUnderline({
    Key? key,
    this.fieldHeading,
    required this.fieldHint,
    this.textType = TextInputType.text,
    this.isShowSuffixIcon = false,
    this.fieldWidth = 400,
    this.onChange,
    this.onSubmit,
    this.validate,
    this.fieldController,
    this.isOnlyDigits = false,
    this.lengthLimit = 256,
    this.fieldAction = TextInputAction.next,
    this.isFieldEnabled = true,
    this.inputformatters,
    this.trailingIcon,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.words,
    this.isShowPrefixAmount = false,
    this.prefixIcon,
  }) : super(key: key);

  final String fieldHint;
  final String? fieldHeading;
  final Validators? validate;
  final void Function(String)? onChange;
  final Function(String)? onSubmit;
  final TextInputType textType;
  final bool isShowSuffixIcon;
  final double fieldWidth;
  final TextEditingController? fieldController;
  final bool isOnlyDigits;
  final int lengthLimit;
  final TextInputAction fieldAction;
  final bool isFieldEnabled;
  final List<TextInputFormatter>? inputformatters;
  final Widget? trailingIcon;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final bool isShowPrefixAmount;
  final Widget? prefixIcon;

  @override
  State<AxleFormTextFieldUnderline> createState() => _AxleFormTextFieldUnderlineState();
}

class _AxleFormTextFieldUnderlineState extends State<AxleFormTextFieldUnderline> {
  DateTime? pickedDateValue;

  void _selectDate() async {
    DateTime? date = await DatePickerUtil.pickDate(context, showRecentPicked: pickedDateValue);
    pickedDateValue = date;
    if (date != null) {
      widget.fieldController!.text = DatePickerUtil.dateMonthYearFormatter(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.fieldWidth,
      child: Semantics(
        label: '${widget.fieldHeading} Field',
        child: TextFormField(
          maxLines: 1,
          textCapitalization: widget.textCapitalization,
          autofocus: widget.autofocus,
          enabled: widget.isFieldEnabled,
          controller: widget.fieldController,
          cursorColor: primaryColor,
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
            hintText: widget.fieldHint,
            hintStyle: AxleTextStyle.labelLarge.copyWith(color: Colors.grey),
            errorStyle: AxleTextStyle.fieldErrorTextStyle,
            suffixIcon: widget.isShowSuffixIcon
                ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _selectDate,
                      child: const Icon(Icons.calendar_month, color: AxleColors.iconColor),
                    ),
                  )
                : null,
            suffix: widget.trailingIcon,
            prefixIcon: widget.isShowPrefixAmount
                ? SizedBox(
                    child: Center(
                      widthFactor: 0.0,
                      child: widget.prefixIcon,
                    ),
                  )
                : null,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1.7),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDCE9F6), width: 1.6),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDCE9F6), width: 1.6),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: fieldErrorColor, width: 1.2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffF02E65)),
            ),
          ),
        ),
      ),
    );
  }
}
