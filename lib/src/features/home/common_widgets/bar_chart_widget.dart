import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/values/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/features/home/dashboard/domain/chart_items_model.dart';

enum BarChartAxisType { week, month, year }

class AxleBarChart extends StatelessWidget {
  const AxleBarChart({
    super.key,
    required this.items,
    this.barColor = AxleColors.dashGreen,
  });
  final List<AxBarChartData> items;
  final Color barColor;

  double getMaxYVal() {
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(width: 1, color: Color(0x66D9E1E7)),
                top: BorderSide(width: 1, color: Color(0x66D9E1E7)),
                // left: BorderSide(width: 1, color: Color(0x66D9E1E7)),
                // right: BorderSide(width: 1, color: Color(0x66D9E1E7)),
              )),
          titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) => Text(
                  meta.formattedValue,
                  style: AxleTextStyle.barChartAxisText,
                ),
              )),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              bottomTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getTitles, reservedSize: 120))),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(strokeWidth: 1, color: const Color(0x66D9E1E7)),
          ),

          // read about it in the BarChartData section
          barGroups: [
            for (int i = 0; i < items.length; i++)
              BarChartGroupData(
                x: i,
                // barsSpace: 500,
                barRods: [
                  BarChartRodData(
                      // backDrawRodData: BackgroundBarChartRodData(
                      //   show: true,
                      //   toY: getMaxYVal(),
                      //   color: axleGray.withAlpha(150),
                      // ),
                      toY: items[i].value,
                      color: barColor),
                ],
              ),
            // BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10)])
          ]),
      swapAnimationDuration: const Duration(milliseconds: 500), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    Widget text = RotatedBox(
        quarterTurns: -1,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            items[value.toInt()].label,
            style: AxleTextStyle.barChartAxisText,
          ),
        ));
    // switch (value.toInt()) {
    //   case 0:
    //     text = const Text('M');
    //     break;
    //   case 1:
    //     text = const Text('T');
    //     break;
    //   case 2:
    //     text = const Text('W');
    //     break;
    //   case 3:
    //     text = const Text('T');
    //     break;
    //   case 4:
    //     text = const Text('F');
    //     break;
    //   case 5:
    //     text = const Text('S');
    //     break;
    //   case 6:
    //     text = const Text('S');
    //     break;
    //   default:
    //     text = const Text('');
    //     break;
    // }
    return SideTitleWidget(
      // angle: 270 * pi / 180,
      axisSide: meta.axisSide,
      space: defaultPadding,
      child: text,
    );
  }
}
