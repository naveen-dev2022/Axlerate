import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class AxleSearchDropDown extends StatefulWidget {
  final bool isRequired;
  final String fieldHint;
  final String? fieldHeading;
  final double fieldWidth;
  final List<DropDownValueModel> dropDownOptions;
  final TextEditingController fieldController;
  final String? Function(dynamic)? validator;
  final Validators? validate;
  final bool readOnly;
  final bool isEnabled;
  final String defaultName;
  final String? defaultValue;
  final Function(dynamic)? onChanged;

  const AxleSearchDropDown({
    super.key,
    this.isRequired = false,
    this.fieldHeading,
    required this.fieldHint,
    this.fieldWidth = 400,
    this.dropDownOptions = const [
      DropDownValueModel(
        name: 'No matching found!',
        value: 'No matching found!',
      )
    ],
    required this.fieldController,
    this.validator,
    this.validate,
    this.readOnly = false,
    required this.onChanged,
    this.isEnabled = true,
    this.defaultName = '',
    this.defaultValue,
  });

  @override
  State<AxleSearchDropDown> createState() => _AxleSearchDropDownState();
}

late SingleValueDropDownController fieldValueController;

class _AxleSearchDropDownState extends State<AxleSearchDropDown> {
  @override
  void initState() {
    fieldValueController = SingleValueDropDownController(
      data: DropDownValueModel(
        name: widget.defaultName,
        value: widget.defaultValue ?? widget.defaultName,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.fieldWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.fieldHeading != null)
                Text(widget.fieldHeading!, style: AxleTextStyle.titleSmall.copyWith(color: Colors.black)),
              widget.isRequired ? const Text('*', style: TextStyle(color: Colors.redAccent)) : const SizedBox(),
            ],
          ),
          if (widget.fieldHeading != null) const SizedBox(height: 10.0),
          Semantics(
            label: '${widget.fieldHeading} Field',
            child: DropDownTextField(
              listSpace: 4,
              readOnly: false,
              textFieldDecoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: const OutlineInputBorder(),
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
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                ),
                hintText: widget.fieldHint,
                hintStyle: AxleTextStyle.labelLarge.copyWith(color: Colors.grey),
              ),
              controller: fieldValueController,
              clearOption: true,
              searchAutofocus: true,
              searchDecoration: const InputDecoration(hintText: "Search here.."),
              validator: (value) {
                if (value == null) {
                  return "Required field";
                } else {
                  return null;
                }
              },
              dropDownItemCount: 6,
              dropDownList: widget.dropDownOptions,
              onChanged: widget.onChanged,
              // onChanged: (val) {
              //   widget.fieldController.text = val.value;
              //   log("onchange value ${val.name}");
              //   log("onchange value ${val.value}");
              // },
            ),
          ),
        ],
      ),
    );
  }
}
