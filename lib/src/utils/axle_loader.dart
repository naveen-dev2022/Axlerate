import 'dart:developer';

import 'package:axlerate/Themes/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class AxleLoader {
  static void show(BuildContext context, {bool enableOverlay = true}) {
    Loader.show(
      context,
      progressIndicator: Image.asset(
        "assets/new_assets/axlerate_loader.gif",
        width: 75,
        height: 75,
      ),
      overlayColor: enableOverlay ? Colors.black.withAlpha(50) : Colors.transparent,
    );
  }

  static void showNoOverlay(BuildContext context) {
    Loader.show(
      context,
      progressIndicator: Image.asset(
        "assets/new_assets/axlerate_loader.gif",
        width: 75,
        height: 75,
      ),
      overlayColor: Colors.transparent,
    );
  }

  static void hide() {
    try {
      Loader.hide();
    } catch (e) {
      log("Hide Loader Error :: $e");
    }
  }

  static Widget axleProgressIndicator({String data = '', double width = 75.0, height = 75.0}) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (data.isNotEmpty) Text(data),
        Image.asset(
          "assets/new_assets/axlerate_loader.gif",
          width: width,
          height: height,
        ),
      ],
    ));
  }

  static Widget axleProgressIndicatorWithOverlay(
      {String data = '', double width = 75.0, height = 75.0, Color overlayColor = appBlue}) {
    return Center(
        child: Stack(
      children: [Container(color: overlayColor), axleProgressIndicator(data: data, width: width, height: height)],
    ));
  }
}
