import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/gps/widgets/gps_details_card.dart';

class GpsOverviewWidget extends ConsumerStatefulWidget {
  const GpsOverviewWidget({
    super.key,
    required this.vehicleRegistrationNumber,
  });
  final String vehicleRegistrationNumber;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GpsOverviewWidgetState();
}

class _GpsOverviewWidgetState extends ConsumerState<GpsOverviewWidget> {
  @override
  Widget build(BuildContext context) {
    // const String svgPath = "assets/new_assets/icons/vehicle_moving.svg";
    // const String title = "Top Speed";
    const String value = "30";
    // const String unit = "km/hr";
    return Container(
      width: double.maxFinite,
      // height: 480,
      decoration: CommonStyleUtil.axleContainerDecoration,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Wrap(
          children: [
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/engine_cut_icon.svg",
                title: "Engine Cut",
                value: value,
                unit: ""),
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/anti_theft_icon.svg",
                title: "Anti Theft",
                value: value,
                unit: ""),
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/ac_status_icon.svg",
                title: "AC Status",
                value: value,
                unit: ""),
            Expanded(child: Container()),
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/fuel_avg.svg", title: "Fuel", value: value, unit: ""),
            const GpsDetailCard(
                svgPath: "assets/new_assets/icons/gps_details/temperature_icon.svg",
                title: "Temperature",
                value: value,
                unit: "C"),
          ],
        ),
      ),
    );
  }
}
