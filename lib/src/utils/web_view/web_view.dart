// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:axlerate/src/utils/web_view/web_view_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

WebViewManager? getUISettings() => Webview();

class Webview extends WebViewManager {
  @override
  buildUiSettings({
    required BuildContext context,
    required String url,
  }) {
    return WebviewWidget(url: url);
  }
}

class WebviewWidget extends ConsumerStatefulWidget {
  const WebviewWidget({
    super.key,
    required this.url,
  });

  final String url;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => WebviewState();
}

class WebviewState extends ConsumerState<WebviewWidget> {
  late String _url;
  late IFrameElement _iframeElement;
  @override
  void initState() {
    super.initState();
    debugPrint("WEB VIEW");
    _url = widget.url;
    _iframeElement = IFrameElement()
      ..src = _url
      ..allow = 'clipboard-write self $_url'
      ..id = 'iframe'
      ..style.border = 'none';
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const HtmlElementView(
      viewType: 'iframeElement',
    );
  }
}
