import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/vehicles/domain/gps_value_model.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/gps/widgets/gps_details_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gauges/gauges.dart';

class GpsSafetyWidget extends ConsumerStatefulWidget {
  const GpsSafetyWidget({
    super.key,
    required this.gpsValueData,
  });
  final GPSValueResponseModelItem gpsValueData;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GpsSafetyWidgetState();
}

bool isMobile = false;
double screenWidth = 0.0;
double screenHeight = 0.0;
double availableWidth = 0.0;

class _GpsSafetyWidgetState extends ConsumerState<GpsSafetyWidget> {
  @override
  Widget build(BuildContext context) {
    // const String svgPath = "assets/new_assets/icons/vehicle_moving.svg";
    // const String title = "Top Speed";
    // const String value = "30";
    // const String unit = "km/hr";

    isMobile = Responsive.isMobile(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (horizontalPadding * 2 + defaultPadding * 2);

    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    return isMobile
        ? Container(
            decoration: CommonStyleUtil.axleContainerDecoration,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(children: [
                timePeriodHeader(),
                const SizedBox(height: defaultPadding),
                safetyScoreWidget(),
                const SizedBox(height: defaultPadding),
                gpsCards()
              ]),
            ),
          )
        : Container(
            width: double.maxFinite,
            height: 780,
            decoration: CommonStyleUtil.axleContainerDecoration,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  timePeriodHeader(),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [safetyScoreWidget(), const SizedBox(width: 40), Expanded(child: gpsCards())],
                  ),
                ],
              ),
            ),
          );
  }

  Row timePeriodHeader() {
    return Row(
      children: [
        Text("Time Period", style: AxleTextStyle.labelLarge),
        const SizedBox(width: defaultPadding),
        AxleTextWithBg(
          text: "${widget.gpsValueData.timeFrom} - ${widget.gpsValueData.timeTo}",
          textColor: Colors.black,
          backgroundColor: const Color(0xFFE4EBF0),
        ),
      ],
    );
  }

  Wrap gpsCards() {
    return Wrap(
      runSpacing: defaultPadding,
      spacing: defaultPadding,
      children: [
        GpsDetailCard(
            svgPath: "assets/new_assets/icons/gps_details/avg_speed_icon.svg",
            title: "Avg Speed",
            value: widget.gpsValueData.avgSpeed.toString(),
            unit: "km/hr"),
        GpsDetailCard(
            svgPath: "assets/new_assets/icons/gps_details/top_speed_icon.svg",
            title: "Top Speed",
            value: widget.gpsValueData.maxSpeed.toString(),
            unit: "km/hr"),
        GpsDetailCard(
            svgPath: "assets/new_assets/icons/gps_details/total_distance_icon.svg",
            title: "Total Dist",
            value: widget.gpsValueData.distance.toString(),
            unit: "kms"),
        GpsDetailCard(
            svgPath: "assets/new_assets/icons/gps_details/ignition_on_icon.svg",
            title: "Ignition On",
            value: getDuration(widget.gpsValueData.engOnTime),
            unit: "hr"),
        GpsDetailCard(
            svgPath: "assets/new_assets/icons/gps_details/stop_time_icon.svg",
            title: "Stop Time",
            value: getDuration(widget.gpsValueData.avgStopTimeInMin),
            unit: "hr"),
        GpsDetailCard(
            svgPath: "assets/new_assets/icons/gps_details/stops_icon.svg",
            title: "Stops",
            value: widget.gpsValueData.totalStops.toString(),
            unit: ""),
        // GpsDetailCard(
        //     svgPath:
        //         "assets/new_assets/icons/gps_details/engine_cut_icon.svg",
        //     title: "Engine Cut",
        //     value: value,
        //     unit: ""),
      ],
    );
  }

  Container safetyScoreWidget() {
    return Container(
      width: isMobile ? availableWidth - (defaultPadding * 2) : 338,
      height: 584,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), border: Border.all(width: 2, color: AxleColors.borderColor)),
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            SafetyScoreGuageWidget(value: widget.gpsValueData.DrivingScore.toDouble()),
            SizedBox(
              height: 300,
              width: 240,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 32),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  safetyScoreItem(
                      svgPath: "assets/new_assets/icons/gps_details/top_speed_icon.svg",
                      title: "Sudden Acceleration",
                      value: widget.gpsValueData.SuddenAccelCount),
                  safetyScoreItem(
                      svgPath: "assets/new_assets/icons/gps_details/top_speed_icon.svg",
                      title: "Sudden Deceleration",
                      value: widget.gpsValueData.SuddenDeAccelCount),
                  safetyScoreItem(
                      svgPath: "assets/new_assets/icons/gps_details/top_speed_icon.svg",
                      title: "Sharp Turns",
                      value: widget.gpsValueData.SharpTurnCount),
                  safetyScoreItem(
                      svgPath: "assets/new_assets/icons/gps_details/top_speed_icon.svg",
                      title: "Overspeed",
                      value: widget.gpsValueData.OverSpeedCount)
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getDuration(int mins) {
    // return mins.toString();

    Duration d = Duration(minutes: mins);
    return d.toString().split(':').sublist(0, 2).map((e) => e.toString().padLeft(2, '0')).join(':');
  }

  Widget safetyScoreItem({required String title, required int value, required String svgPath}) {
    return Row(
      children: [
        SvgPicture.asset(
          svgPath,
          width: 28,
          height: 28,
        ),
        const SizedBox(
          width: defaultMobilePadding,
        ),
        Text(
          title,
          style: AxleTextStyle.miniTextHighLightBlack,
        ),
        Expanded(child: Container()),
        AxleTextWithBg(
          text: value.toString(),
          textColor: Colors.black,
          backgroundColor: const Color(0xFFE4EBF0),
          titleStyle: AxleTextStyle.miniHeadingBlackStyle,
        )
      ],
    );
  }
}

class SafetyScoreGuageWidget extends StatelessWidget {
  const SafetyScoreGuageWidget({
    Key? key,
    required this.value,
  }) : super(key: key);
  final double value;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          // color: Colors.amber,
          width: 240,
          height: 240,
          decoration: const BoxDecoration(
              // color: Colors.amber,
              // borderRadius: BorderRadius.circular(300),
              border: Border(
            bottom: BorderSide(color: AxleColors.borderColor, width: 1),
          )),
          child: RadialGauge(axes: [
            RadialGaugeAxis(
                minValue: 0,
                maxValue: 1000,
                minAngle: -90,
                maxAngle: 90,
                color: Colors.amber,
                // width: 0.3,
                widthAbsolute: 45,
                // radius: 0.7,
                radiusAbsolute: 75,
                segments: const [
                  RadialGaugeSegment(
                    minValue: 0,
                    maxValue: 0,
                    minAngle: -90,
                    maxAngle: -45,
                    color: Colors.red,
                  ),
                  RadialGaugeSegment(
                    minValue: 0,
                    maxValue: 0,
                    minAngle: -45,
                    maxAngle: 45,
                    color: Colors.yellowAccent,
                  ),
                  RadialGaugeSegment(
                    minValue: 0,
                    maxValue: 0,
                    minAngle: 45,
                    maxAngle: 90,
                    color: Colors.greenAccent,
                  ),
                ],
                pointers: [
                  RadialNeedlePointer(
                    value: value,
                    thicknessEnd: 0,
                    thicknessStart: 20,
                    knobRadiusAbsolute: 10,
                    // centerOffset: 0.1,
                    length: 1.0,
                  )
                ])
          ]),
        ),
        Positioned(
            bottom: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Safety Score",
                  style: AxleTextStyle.someTitlew50016black,
                ),
                const SizedBox(
                  width: 12,
                ),
                AxleTextWithBg(
                  text: '${value.toInt()} / 999',
                  textColor: Colors.black,
                  backgroundColor: const Color(0xFFE4EBF0),
                  titleStyle: AxleTextStyle.miniHeadingBlackStyle,
                )
              ],
            ))
      ],
    );
  }
}
