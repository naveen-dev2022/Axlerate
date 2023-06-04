import 'package:flutter/rendering.dart';

class AxPieChartDataItem {
  double value;
  Color color;
  String label;
  double radius;
  TextStyle? titleStyle;
  AxPieChartDataItem({
    required this.value,
    required this.color,
    required this.label,
    required this.radius,
    this.titleStyle,
  });
}

class AxBarChartData {
  String label;
  double value;
  AxBarChartData({
    required this.label,
    required this.value,
  });
}
