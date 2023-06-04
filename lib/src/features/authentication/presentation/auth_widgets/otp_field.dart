import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

// class OTPField extends StatelessWidget {
//   const OTPField({
//     super.key,
//     required this.otpLabel,
//     this.onFieldSubmit,
//     this.labelStyle,
//     this.autofocus = true,
//     this.onChange,
//     this.fieldWidth,
//     this.mainAlignment,
//   });

//   final String otpLabel;
//   final Function(String)? onFieldSubmit;
//   final TextStyle? labelStyle;
//   final bool autofocus;
//   final Function(String)? onChange;
//   final double? fieldWidth;
//   final MainAxisAlignment? mainAlignment;

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     bool isMobile = Responsive.isMobile(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           otpLabel,
//           style: labelStyle ?? AxleTextStyle.textFieldHeadingStyle,
//         ),
//         const SizedBox(height: 6.0),
//         OtpTextField(
//           mainAxisAlignment: mainAlignment ?? MainAxisAlignment.center,
//           fieldWidth: fieldWidth ?? (isMobile ? screenWidth * 10 / 100 : screenWidth * 4.3 / 100),
//           inputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//           ],
//           numberOfFields: 6,
//           autoFocus: autofocus,
//           keyboardType: TextInputType.number,
//           borderColor: primaryColor,
//           enabledBorderColor: primaryColor,
//           focusedBorderColor: iconGrey,
//           showFieldAsBox: false,
//           onCodeChanged: onChange,
//           onSubmit: onFieldSubmit,
//         ),
//       ],
//     );
//   }
// }

class OTPField extends StatelessWidget {
  const OTPField({
    super.key,
    required this.otpLabel,
    this.onFieldSubmit,
    this.labelStyle,
    this.autofocus = true,
    this.onChange,
    this.fieldWidth,
    this.mainAlignment,
  });

  final String otpLabel;
  final Function(String)? onFieldSubmit;
  final TextStyle? labelStyle;
  final bool autofocus;
  final Function(String)? onChange;
  final double? fieldWidth;
  final MainAxisAlignment? mainAlignment;

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // bool isMobile = Responsive.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          otpLabel,
          style: labelStyle ?? AxleTextStyle.textFieldHeadingStyle,
        ),
        const SizedBox(height: 6.0),
        VerificationCode(
          textStyle: const TextStyle(fontSize: 20.0, color: AxleColors.axlePrimaryColor),
          keyboardType: TextInputType.number,
          underlineColor:
              AxleColors.axlePrimaryColor, // If this is null it will use primaryColor: Colors.red from Theme
          underlineWidth: 2.0,
          underlineUnfocusedColor: AxleColors.axlePrimaryColor,
          length: 6,
          cursorColor: AxleColors.axlePrimaryColor, // If this is null it will default to the ambient
          // clearAll is NOT required, you can delete it
          // takes any widget, so you can implement your design
          // clearAll: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'clear all',
          //     style: TextStyle(fontSize: 14.0, decoration: TextDecoration.underline, color: Colors.blue[700]),
          //   ),
          // ),
          onCompleted: onFieldSubmit ?? (String val) {},
          onEditing: (bool value) {},
        ),
        // OTPTextField(
        //   length: 6,
        //   width: MediaQuery.of(context).size.width,
        //   fieldWidth: 30,
        //   style: const TextStyle(fontSize: 17),
        //   textFieldAlignment: MainAxisAlignment.spaceEvenly,
        //   fieldStyle: FieldStyle.underline,
        //   onCompleted: onFieldSubmit,
        // ),
      ],
    );
  }
}
