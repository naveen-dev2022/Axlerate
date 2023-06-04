import 'package:axlerate/src/utils/web_view/web_view_manager.dart';
import 'package:flutter/material.dart';

WebViewManager? getUISettings() => WebViewUiHelper();

class WebViewUiHelper extends WebViewManager {
  @override
  buildUiSettings({
    required BuildContext context,
    required String url,
  }) {
    throw UnimplementedError();
  }
}
