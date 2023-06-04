import 'package:flutter/material.dart';
import 'axle_loader.dart';

class AxelOverlayLoader{
  OverlayEntry? _overlay;

  void show(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_overlay == null) {
      _overlay = OverlayEntry(
        // replace with your own layout
        builder: (context) => ColoredBox(
          color: Colors.black.withOpacity(0.6),
          child: AxleLoader.axleProgressIndicator(),
        ),
      );
      if (_overlay != null) {
        Overlay.of(context).insert(_overlay!);
      }
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay?.remove();
      _overlay = null;
    }
  }

  bool isLoading() {
    return (_overlay != null);
  }
}