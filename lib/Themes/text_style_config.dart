import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AxleTextStyle {
  static final bodySmall = GoogleFonts.manrope(
      fontSize: 12,
      letterSpacing: 0.40,
      fontWeight: FontWeight.w400,
      color: primaryColor);
  static final bodyMedium = GoogleFonts.manrope(
      fontSize: 14,
      letterSpacing: 0.25,
      fontWeight: FontWeight.w400,
      color: primaryColor);
  static final bodyLarge = GoogleFonts.manrope(
      fontSize: 16,
      letterSpacing: 0.50,
      fontWeight: FontWeight.w400,
      color: primaryColor);

  static final labelSmall = GoogleFonts.manrope(
      fontSize: 11,
      letterSpacing: 0.50,
      fontWeight: FontWeight.w500,
      color: primaryColor);
  static final labelMedium = GoogleFonts.manrope(
      fontSize: 12,
      letterSpacing: 0.50,
      fontWeight: FontWeight.w500,
      color: primaryColor);
  static final labelLarge = GoogleFonts.manrope(
      fontSize: 14,
      letterSpacing: 0.10,
      fontWeight: FontWeight.w500,
      color: primaryColor);

  static final titleSmall = GoogleFonts.manrope(
      fontSize: 14,
      letterSpacing: 0.10,
      fontWeight: FontWeight.w500,
      color: primaryColor);
  static final titleMedium = GoogleFonts.manrope(
      fontSize: 16,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w500,
      color: primaryColor);
  static final titleLarge = GoogleFonts.manrope(
      fontSize: 22,
      letterSpacing: 0.00,
      fontWeight: FontWeight.w400,
      color: primaryColor);

  static final headlineSmall = GoogleFonts.manrope(
      fontSize: 24,
      letterSpacing: 0.00,
      fontWeight: FontWeight.w400,
      color: primaryColor);
  static final headlineMedium = GoogleFonts.manrope(
      fontSize: 28,
      letterSpacing: 0.00,
      fontWeight: FontWeight.w400,
      color: primaryColor);
  static final headlineLarge = GoogleFonts.manrope(
      fontSize: 32,
      letterSpacing: 0.00,
      fontWeight: FontWeight.w400,
      color: primaryColor);

  static final displaySmall = GoogleFonts.manrope(
      fontSize: 36,
      letterSpacing: 0.00,
      fontWeight: FontWeight.w400,
      color: primaryColor);
  static final displayMedium = GoogleFonts.manrope(
      fontSize: 45,
      letterSpacing: 0.00,
      fontWeight: FontWeight.w400,
      color: primaryColor);
  static final displayLarge = GoogleFonts.manrope(
      fontSize: 57,
      letterSpacing: 0.00,
      fontWeight: FontWeight.w400,
      color: primaryColor);

  static final subtitle1BlackBold = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static final subtitle1WhiteBold = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static final subtitle1Card = GoogleFonts.sairaCondensed(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static final subtitle1IconGreyBold = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: AxleColors.iconColor,
  );

  static final subtitle1IconGrey = GoogleFonts.manrope(
    fontSize: 16.0,
    color: AxleColors.iconColor,
  );

  static final subtitle2IconGrey = GoogleFonts.manrope(
    fontSize: 14.0,
    color: AxleColors.iconColor,
  );

  static final subtitle2 = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: iconColor,
  );

  static final subtitle2White = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final mainBigHeading = GoogleFonts.manrope(
    color: primaryColor,
    fontWeight: FontWeight.w700,
    fontSize: 24.0,
  );

  static final headingPrimary = GoogleFonts.manrope(
    textStyle: const TextStyle(
      color: primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );

  static final headingBlack = GoogleFonts.manrope(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );

  static final subHeadingPrimary = GoogleFonts.manrope(
    textStyle: const TextStyle(
      color: primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
  static final subHeadingBlack = GoogleFonts.manrope(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static final miniTextHighLightBlack = GoogleFonts.manrope(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static final textFieldLabelStyle = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static final textFiledHintStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: const Color(0xff5C90C5),
  );

  static final authTextNavigationStyle = GoogleFonts.manrope(
    color: primaryColor,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
  );

  static final tableTextBlack = GoogleFonts.manrope(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
  static final tableTextGreen = GoogleFonts.manrope(
    textStyle: const TextStyle(
      color: Colors.green,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
  static final tableTextRed = GoogleFonts.manrope(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 214, 21, 7),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );

  static final tableTextAmber = GoogleFonts.manrope(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 156, 64),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );

  // ================================== New App TextStyles===========================================

  static final primaryButtonTextStyle = GoogleFonts.manrope(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: snowColor,
  );

  static final outlineButtontextStyle = GoogleFonts.manrope(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static final forgotPassTextStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
    decoration: TextDecoration.underline,
  );

  static final activateAccountTitleStyle = GoogleFonts.manrope(
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: const Color(0xff023874),
  );
  static final activateAccountNumberStyle = GoogleFonts.manrope(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  );

  static final imageUploadTextStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static final primaryMiniHintStyle = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  );

  static final backToLoginStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static final textFieldHeadingStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static final textFieldHintStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: primaryColor.withOpacity(0.6),
  );

  static final axleFormFieldHeadingStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static final axleFormFieldHintStyle = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  static final fieldErrorTextStyle = GoogleFonts.manrope(
    fontWeight: FontWeight.w400,
    color: fieldErrorColor,
  );

  static final authScreenHeadingStyle = GoogleFonts.manrope(
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );

  static final authScreenMessageStyle = GoogleFonts.manrope(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  );

  static final orDividerStyle = GoogleFonts.manrope(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static final resendOTPQuestionStyle = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: const Color(0xff5C91C5),
  );

  static final phoneNuberStyle = GoogleFonts.manrope(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static final resendOTPStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static final accountActivationTitleStyle = GoogleFonts.manrope(
    fontWeight: FontWeight.w800,
    fontSize: 42,
    height: 1.2,
    color: Colors.black,
  );

  static final accountActivationSemiTitleStyle = GoogleFonts.manrope(
    fontWeight: FontWeight.w600,
    fontSize: 34,
    height: 1.2,
    color: Colors.black,
  );
  static final accountActivationSubTitleStyle = GoogleFonts.manrope(
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.4,
    color: Colors.black,
  );

  static final axleCardTextStyle = GoogleFonts.manrope(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: primaryColor,
  );

  static final formSectionHeadingStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static final formSectionHintStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: const Color(0xff787878),
  );

  static final saveAndContinueStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: snowColor,
  );

  static final goButtonstyle = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AxleColors.axleWhiteColor,
  );

  static final saveAndContinuePrimaryStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AxleColors.axlePrimaryColor,
  );

  static final outLineButtonStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  );

  static final iconButtonTextStyle = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: snowColor,
  );

  static final miniHeadingBlackStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static final body2BlackNormalStyle = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final headline6BlackStyle = GoogleFonts.manrope(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static final headline5BlackStyle = GoogleFonts.manrope(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static final headline4BlackStyle = GoogleFonts.manrope(
    fontSize: 34.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static final headline3BlackStyle = GoogleFonts.manrope(
    fontSize: 48.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static final subtitle2GreyStyle = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: const Color(0xff8A8C8F),
  );

  static final bodyText1BlackStyle = GoogleFonts.manrope(
    fontSize: 16.0,
    color: Colors.black,
  );

  static final dashboardCardTitle = GoogleFonts.manrope(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static final dashboardCardSubTitle = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: const Color.fromRGBO(128, 159, 184, 1),
  );

  static final dashboardCardCrDrTitle = GoogleFonts.manrope(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  );

  static final dashboardCardCrDrValue = GoogleFonts.manrope(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static final dashboardCardTitle1 = GoogleFonts.manrope(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static final walletBalanceText = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: const Color.fromRGBO(0, 0, 0, 1),
  );

  static final walletBalance = GoogleFonts.manrope(
    fontSize: 38.0,
    fontWeight: FontWeight.w800,
    color: const Color.fromRGBO(0, 0, 0, 1),
  );

  static final walletBalanceType = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: const Color.fromRGBO(128, 159, 184, 1),
  );

  static final upiIdText = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: const Color.fromRGBO(128, 159, 184, 1),
  );

  static final kitsAvailableText = GoogleFonts.manrope(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static final kitsAvailableValue = GoogleFonts.manrope(
    fontSize: 36.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static final dashboardHeadingText = GoogleFonts.manrope(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );

  static final dashboardSubHeadingText = GoogleFonts.manrope(
    textStyle: const TextStyle(
      color: primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );

  static final pieChartText = GoogleFonts.manrope(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ));

  static final pieChartLegendText = GoogleFonts.manrope(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF050708),
  ));

  static final pieChartLegendValue = GoogleFonts.manrope(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF809FB8),
  ));

  static final barChartAxisText = GoogleFonts.manrope(
      textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF809FB8),
  ));

  static final gpsCardValueText = GoogleFonts.manrope(
      textStyle: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          height: 0));

  static final gpsCardUnitText = GoogleFonts.manrope(
      textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Color(0xFF809FB8),
          height: 1));

  static final someTitlew50016black = GoogleFonts.manrope(
      textStyle: const TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black));

  static final thresholdLimitValue = GoogleFonts.manrope(
      textStyle: const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    color: Color(0xFF809FB8),
  ));

  static final ppiCardTitle = GoogleFonts.manrope(
      textStyle: const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white));

  static final ppiCardBalance = GoogleFonts.manrope(
      textStyle: const TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          height: 0.9));

  static final ppiOverviewCardValueText = GoogleFonts.manrope(
      textStyle: const TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w800, color: Colors.white));

  static final ppiChartTooltipValue = GoogleFonts.manrope(
      textStyle: const TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w800, color: Colors.white));

  static final ppiChartTooltipDate = GoogleFonts.manrope(
      textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w800,
          color: Color(0xFF94989C)));

  ///  E-CARD STYLES
  static final poppins14w500 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff8892A9),
    ),
  );

  static final poppins12w500 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff252525),
    ),
  );

  static final poppins12w500liteGrey = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff8892A9),
    ),
  );

  static final poppins16w400 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Color(0xff8892A9),
    ),
  );

  static final poppins12w400 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: Color(0xff8892A9),
    ),
  );

  static final sfPro13w400 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    ),
  );

  static final poppins18w600 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
  );

  static final poppins14w500Blue = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff00499B),
    ),
  );

  static final poppins16w500Black = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff252525),
    ),
  );

  static final poppins14w300Grey = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: Color(0xff8B9197),
    ),
  );
}
