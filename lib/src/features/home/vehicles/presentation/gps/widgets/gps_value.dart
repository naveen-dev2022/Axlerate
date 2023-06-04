import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/gps/widgets/gps_details_card.dart';

class GpsValueWidget extends ConsumerStatefulWidget {
  const GpsValueWidget({
    super.key,
    required this.vehicleRegistrationNumber,
  });
  final String vehicleRegistrationNumber;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GpsValueWidgetState();
}

class _GpsValueWidgetState extends ConsumerState<GpsValueWidget> {
  @override
  Widget build(BuildContext context) {
    // const String svgPath = "assets/new_assets/icons/vehicle_moving.svg";
    // const String title = "Top Speed";
    const String value = "30";
    //const String unit = "km/hr";
    return Container(
      width: double.maxFinite,
      // height: 480,
      decoration: CommonStyleUtil.axleContainerDecoration,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Wrap(
          children: [
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/avg_speed_icon.svg",
                title: "Avg Speed",
                value: value,
                unit: "km/hr"),
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/top_speed_icon.svg",
                title: "Top Speed",
                value: value,
                unit: "km/hr"),
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/total_distance_icon.svg",
                title: "Total Dist",
                value: value,
                unit: "kms"),
            Expanded(child: Container()),
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/ignition_on_icon.svg",
                title: "Ignition On",
                value: value,
                unit: "hr"),
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/stop_time_icon.svg",
                title: "Stop Time",
                value: value,
                unit: "hr"),
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/stops_icon.svg", title: "Stops", value: value, unit: ""),
          ],
        ),
      ),
    );
  }
}
