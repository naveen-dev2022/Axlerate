import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/values/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/features/home/dashboard/domain/chart_items_model.dart';

// ignore: must_be_immutable
class AxlePieChart extends StatefulWidget {
  AxlePieChart({
    Key? key,
    required this.items,
    this.isRow = false,
    this.isNumber = false,
  }) : super(key: key);
  final List<AxPieChartDataItem> items;
  bool isRow;
  bool isNumber;
  @override
  State<AxlePieChart> createState() => _AxlePieChartState();
}

class _AxlePieChartState extends State<AxlePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return widget.isRow
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [showAspectRatio(), showText()],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [showAspectRatio(), showText()],
          );
  }

  Widget showText() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView.builder(
          itemCount: widget.items.length,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: widget.isRow ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: showLegend(widget.items[index]),
            );
          },
        ),
      ),
    );
  }

  Widget showAspectRatio() {
    return AspectRatio(
      aspectRatio: widget.isRow ? 0.8 : 1.5,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          startDegreeOffset: 0,
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: showingSections(),
        ),
      ),
    );
  }

  Widget showLegend(AxPieChartDataItem item) {
    return Row(
      children: [
        Container(color: item.color, width: 12, height: 12),
        const SizedBox(width: defaultMobilePadding),
        Text(item.label, style: AxleTextStyle.pieChartLegendText),
        widget.isRow
            ? const SizedBox(
                width: 10,
              )
            : Expanded(child: Container()),
        widget.isNumber
            ? Text(item.value.toString(), style: AxleTextStyle.pieChartLegendValue)
            : Text(axleCurrencyFormatterwithDecimals.format(item.value).toString(),
                style: AxleTextStyle.pieChartLegendValue)
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    Color darken(Color c, [int percent = 30]) {
      assert(1 <= percent && percent <= 100);
      var f = 1 - percent / 100;
      return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(), (c.blue * f).round());
    }

    return List.generate(
      widget.items.length,
      (i) {
        final isTouched = i == touchedIndex;
        //final opacity = isTouched ? 1.0 : 0.6;
        final AxPieChartDataItem item = widget.items[i];

        return PieChartSectionData(
          color: item.color,
          value: item.value,
          title: item.label,
          radius: item.radius,
          titleStyle: item.titleStyle,
          titlePositionPercentageOffset: 0.55,
          borderSide: isTouched
              ? BorderSide(color: darken(item.color), width: 4)
              : BorderSide(color: item.color.withOpacity(0)),
        );
      },
    );
  }
}
