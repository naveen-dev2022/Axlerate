// import 'dart:html';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';

// // ignore: camel_case_types
// class platformViewRegistry {
//   static registerViewFactory(String viewId, dynamic cb) {
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(viewId, cb);
//   }
// }

// class IFrameUi extends StatelessWidget {
//   const IFrameUi({required this.url, super.key});

//   final String url;

//   @override
//   Widget build(BuildContext context) {
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory('iframeElement', (int viewId) {
//       IFrameElement _iframeElement = IFrameElement()
//         ..src = url
//         ..allow = 'clipboard-write self $url'
//         ..id = 'iframe'
//         ..style.border = 'none';

//       return _iframeElement;
//     });
//     return const HtmlElementView(
//       viewType: 'iframeElement',
//     );
//   }
// }
