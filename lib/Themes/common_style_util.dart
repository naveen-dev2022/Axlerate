import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:flutter/material.dart';

class CommonStyleUtil {
  static final axleContainerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: AxleColors.axleWhiteColor,
    boxShadow: const [
      BoxShadow(
        color: Color(0xffCFE8FF),
        blurRadius: 2.0,
        spreadRadius: 1.0,
        offset: Offset(1, 2),
      ),
      BoxShadow(
        color: Color(0xffCFE8FF),
        blurRadius: 2.0,
        spreadRadius: 1.0,
        offset: Offset(-1, -2),
      )
    ],
  );

  static const cardTileIconDecoration = ShapeDecoration(
    shape: CircleBorder(
      // borderRadius: BorderRadius.circular(50.0), // CHANGE BORDER RADIUS HERE
      side: BorderSide(width: 2, color: iconBorderColor),
    ),
    color: Colors.white,
    shadows: [
      BoxShadow(
        color: iconBorderColor,
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
  );

  static final axleListingCardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        blurRadius: 5.0,
        spreadRadius: 2.0,
        color: Color.fromARGB(50, 149, 198, 247),
        offset: Offset(2, 2),
      ),
      // BoxShadow(
      //   blurRadius: 5.0,
      //   spreadRadius: 2.0,
      //   color: Colors.grey.shade200,
      //   offset: Offset(-2, -3),
      // ),
      // BoxShadow(
      //   blurRadius: 5.0,
      //   spreadRadius: 10.0,
      //   color: AxleColors.axleShadowColor,
      //   offset: Offset(1, -1),
      // )
    ],
  );

  static final axleDashboardCardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    // border: ,
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        blurRadius: 5.0,
        spreadRadius: 2.0,
        color: Color.fromARGB(50, 149, 198, 247),
        offset: Offset(2, 2),
      ),
    ],
  );

  static BoxDecoration getAxleDashboardCardDecoration({required Color borderColor}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      border: Border.all(color: borderColor, width: 1),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 5.0,
          spreadRadius: 2.0,
          color: borderColor,
          offset: const Offset(0, 7),
        ),
      ],
    );
  }

  static final accountActivationcardStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    border: Border.all(color: const Color(0xffCFE8FF), width: 1.4),
    color: const Color(0xeeffffff),
  );

  static final createUserFormCardStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: const Color(0xffCFE8FF), width: 1.4),
    color: Colors.white,
  );
}
