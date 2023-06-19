import 'package:flutter/material.dart';

class AxleColors {
  static const axlePrimaryColor = Color(0xFF004F9F); //004F9F
  static const axleWhite = Color(0xFFFFFFFF); //004F9F
  static const axleSecondaryColor = Color(0xFFFFC62B);
  static const axleBackgroundColor = Color(0xffF2F8FF);
  static const axleBlueColor = Color(0xff0084FF);
  static const axleWhiteColor = Color(0xFFFFFAFA);
  static const axleCardColor = Color(0xffD9E5F1);
  static const axleShadowColor = Color(0xffB6DBFF);
  static const axleBlackColor = Color(0x00000000);
  static const axleGreenColor = Color(0xff1AD598);
  static const axleRedColor = Color(0xffFF6669);
  static const axleAquaBlue = Color(0xFF00BCD4);
  static const axlePurple = Color(0xFF673AB7);
  static const axleGrey = Color(0xFFF4F4F6);
  static const axleBgYellow = Color(0xFFFEF6DD);

  static const enabledStatusColor = Color(0xFF009F82);
  static const pendingStatusColor = Color(0xFFFF9162);
  static const rejectedStatusColor = Color(0xFFFF6669);
  static const disabledStatusColor = Color(0xFFD9E1E7);

  static const debitBgColor = Color(0xFFF4DFDF);
  static const creditBgColor = Color(0xFFDFF4ED);

  static const borderColor = Color(0xFFE9F3FF);
  static const iconColor = Color(0xFF809FB8);

  static const dashPurple = Color(0xFF3A36DB);
  static const dashGreen = Color(0xFF93DDA3);
  static const dashBlue = Color(0xFF53C1FF);
  static const dashPink = Color(0xFFDB5AEE);

  const AxleColors._();

  static Color getStatusColor(String status) {
    Color statusColor = Colors.white;

    if (status.toUpperCase().contains("APPROVED") ||
        status.toUpperCase().contains("ACTIVE")) {
      statusColor = AxleColors.enabledStatusColor;
    } else if (status.toUpperCase().contains("PENDING")) {
      statusColor = AxleColors.pendingStatusColor;
    } else if (status.toUpperCase().contains("INITIATED")) {
      statusColor = AxleColors.axleSecondaryColor;
    } else if (status.toUpperCase().contains("DECLINED") ||
        status.toUpperCase().contains("REJECTED")) {
      statusColor = AxleColors.rejectedStatusColor;
    } else if (status.toUpperCase().contains("DISABLED")) {
      statusColor = AxleColors.disabledStatusColor;
    } else if (status.toUpperCase().contains("TABLE")) {
      statusColor = iconColor;
    } else if (status.toUpperCase().contains("PARTNER") ||
        status.toUpperCase().contains("ENABLED")) {
      statusColor = axlePrimaryColor;
    } else if (status.toUpperCase().contains("INVITED")) {
      statusColor = AxleColors.axleBlueColor;
    }

    return statusColor;
  }

  static Color getTagStatusColor(String status) {
    Color statusColor = Colors.white;

    if (status.toUpperCase().contains("APPROVED") ||
        status.toUpperCase().contains("ACTIVE")) {
      statusColor = AxleColors.enabledStatusColor;
    } else if (status.toUpperCase().contains("LOW_BALANCE")) {
      statusColor = AxleColors.pendingStatusColor;
    } else if (status.toUpperCase().contains("BLACKLIST")) {
      statusColor = AxleColors.rejectedStatusColor;
    } else if (status.toUpperCase().contains("BLOCKLIST")) {
      statusColor = AxleColors.disabledStatusColor;
    } else if (status.toUpperCase().contains("EXEMPTION")) {
      statusColor = axlePrimaryColor;
    } else if (status.toUpperCase().contains("NON_EXEMPTION")) {
      statusColor = AxleColors.axleBlueColor;
    }

    return statusColor;
  }
}
