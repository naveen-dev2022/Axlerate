import 'package:flutter/material.dart';

class AxleToggleMenuItem {
  String label;
  IconData? icon;
  Widget child;

  AxleToggleMenuItem({
    required this.label,
    this.icon,
    required this.child,
  });
}
