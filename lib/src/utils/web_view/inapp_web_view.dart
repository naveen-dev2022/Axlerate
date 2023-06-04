// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebView extends StatefulWidget {
  const InAppWebView({
    required this.url,
    Key? key,
  }) : super(key: key);

  final String url;

  @override
  State<InAppWebView> createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView> {
  WebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AxleColors.axleAquaBlue,
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              backgroundColor: AxleColors.axleAquaBlue,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.url,
              onWebViewCreated: (controller) {
                setState(() {
                  webViewController = controller;
                });
              },
              navigationDelegate: (NavigationRequest request) async {
                if (request.url.contains("mailto:")) {
                  try {
                    if (!await launchUrl(Uri.parse(request.url), mode: LaunchMode.externalApplication)) {
                      throw 'Could not launch ${request.url}';
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                  return NavigationDecision.prevent;
                } else {
                  return NavigationDecision.navigate;
                }
              },
            ),
            // Positioned(
            //   top: 16,
            //   left: 16,
            //   child: BackIconButton(
            //     onPressed: () {
            //       Routemaster.of(context).pop();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
