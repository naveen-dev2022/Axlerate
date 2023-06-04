import 'package:axlerate/src/utils/web_view/ui_helper.dart'
    if (dart.library.io) 'package:axlerate/src/utils/web_view/mobile_view.dart'
    if (dart.library.html) 'package:axlerate/src/utils/web_view/web_view.dart';
import 'package:flutter/material.dart';

abstract class WebViewManager {
  static WebViewManager? _instance;

  static WebViewManager get instance {
    _instance = getUISettings();
    return _instance!;
  }

  buildUiSettings({
    required BuildContext context,
    required String url,
  });
}
