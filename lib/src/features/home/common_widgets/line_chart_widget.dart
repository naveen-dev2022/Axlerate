// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:axlerate/values/strings.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/utils/currency_format.dart';

class AxleLineChartModel {
  DateTime date;
  double value;
  bool isDateTime;
  int hour;
  AxleLineChartModel({
    required this.date,
    required this.value,
    this.isDateTime = true,
    this.hour = 0,
  });
}

class AxleLineChart extends StatelessWidget {
  AxleLineChart({super.key, required this.items});

  final List<AxleLineChartModel> items;

  List<String> bottomTitles = [];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4,
      child: LineChart(LineChartData(
        lineTouchData: LineTouchData(
          getTouchedSpotIndicator: (barData, spotIndexes) => spotIndexes
              .map((e) => TouchedSpotIndicatorData(
                  FlLine(color: const Color(0xFF5D49E4)),
                  FlDotData(
                    show: true,
                    getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                      color: Colors.white,
                      radius: 6.0,
                      strokeColor: const Color(0xFF5D49E4),
                      strokeWidth: 5.0,
                    ),
                  )))
              .toList(),
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) => touchedSpots
                .map((e) => LineTooltipItem(
                    '',
                    children: [
                      TextSpan(
                          text: '${axleCurrencyFormatter.format(e.y)}\n', style: AxleTextStyle.ppiChartTooltipValue),
                      TextSpan(
                          text: Strings.dataType == "day"
                              ? "${e.x} hour"
                              : DateFormat("dd-MMM-yy").format(DateTime.fromMillisecondsSinceEpoch(e.x.toInt())),
                          style: AxleTextStyle.ppiChartTooltipDate)
                    ],
                    const TextStyle(color: Colors.white)))
                .toList(),
            tooltipBgColor: const Color(0xFF252C35),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
              top: BorderSide(
                color: Color(0xFFBCCCD9),
                width: 1,
              ),
              left: BorderSide(color: Color(0xFFBCCCD9), width: 1),
              bottom: BorderSide(color: Color(0xFFBCCCD9), width: 1),
              right: BorderSide(color: Color(0xFFBCCCD9), width: 1)),
        ),
        gridData: FlGridData(
          // verticalInterval: 2,
          verticalInterval: Duration.millisecondsPerDay.toDouble(),
          show: true,
          drawVerticalLine: true,
          checkToShowVerticalLine: (value) {
            return DateTime.fromMillisecondsSinceEpoch(value.toInt()).day == 1;
          },
          drawHorizontalLine: true,
          getDrawingVerticalLine: (value) => FlLine(color: const Color(0xFFBCCCD9), strokeWidth: 1),
          getDrawingHorizontalLine: (value) =>
              FlLine(color: const Color(0xFFE6EBEF), strokeWidth: 1, dashArray: [10, 10]),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: items
                .map((e) =>
                    FlSpot(!e.isDateTime ? e.hour.toDouble() : e.date.millisecondsSinceEpoch.toDouble(), e.value))
                .toList(),
            isCurved: false,
            curveSmoothness: 0.2,
            barWidth: 2,
            color: const Color(0xFFD72F7C),
            isStrokeCapRound: false,
            dotData: FlDotData(
              show: false,
              getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(color: Colors.amber, radius: 2),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: const LinearGradient(
                stops: [0.75, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x45D72F7C), Color(0x00D72F7C)],
              ),
            ),
          ),
        ],
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: bottomTitleWidgets,
              interval: Duration.millisecondsPerDay.toDouble(),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 42,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
      )),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    if (value == meta.min) {
      bottomTitles.clear();
    }
    String montth = Strings.dataType == "day"
        ? value.toInt().toString()
        : DateFormat("MMM").format(DateTime.fromMillisecondsSinceEpoch(
            value.toInt(),
          ));

    if (bottomTitles.contains(montth)) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text("", style: AxleTextStyle.labelSmall),
      );
    }
    bottomTitles.add(montth);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-90 / 360), child: Text(montth, style: AxleTextStyle.labelSmall)),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(meta.formattedValue, style: AxleTextStyle.labelSmall, textAlign: TextAlign.left);
  }
}
