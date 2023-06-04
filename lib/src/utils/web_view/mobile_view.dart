import 'package:axlerate/src/utils/web_view/inapp_web_view.dart';
import 'package:axlerate/src/utils/web_view/web_view_manager.dart';
import 'package:flutter/material.dart';

WebViewManager? getUISettings() => Mobileview();

class Mobileview extends WebViewManager {
  @override
  buildUiSettings({
    required BuildContext context,
    required String url,
  }) {
    return InAppWebView(url: url);
  }
}
