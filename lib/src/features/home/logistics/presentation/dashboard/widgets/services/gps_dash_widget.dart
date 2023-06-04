// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:developer';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/features/home/logistics/domain/logistic_gps_info_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

class GpsDashWidget extends ConsumerStatefulWidget {
  const GpsDashWidget({
    Key? key,
    // required this.markers,
    required this.size,
    required this.orgId,
  }) : super(key: key);

  // final List<LatLng> markers;
  final String orgId;

  final Size size;

  @override
  ConsumerState<GpsDashWidget> createState() => _GpsDashWidgetState();
}

class _GpsDashWidgetState extends ConsumerState<GpsDashWidget> with TickerProviderStateMixin {
  late final _mapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
  bool isMobile = false;

  Timer? timer;
  // late Future<LogisticsGpsInfoModel> gpsInfoFuture;

  @override
  void initState() {
    getGpsInfoData();
    timer = Timer.periodic(const Duration(minutes: 1), (Timer t) => getGpsInfoData());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;

    _mapController.dispose();
    super.dispose();
  }

  Future<LogisticsGpsInfoModel> getGpsInfoData() async {
    OrgType? orgType = ref.read(localStorageProvider).getOrgType();
    if (orgType != OrgType.partner) {
      return await ref.read(logisticsControllerProvider).getLogisticsGpsInfo(orgId: widget.orgId);
    }
    return LogisticsGpsInfoModel.unknown();
  }

  @override
  Widget build(BuildContext context) {
    LogisticsGpsInfoModel? vehicleGpsData = ref.watch(gpsLocStateProvider)?.data;
    FitBoundsOptions boundsOptions = const FitBoundsOptions(padding: EdgeInsets.all(horizontalPadding));
    isMobile = Responsive.isMobile(context);
    if (vehicleGpsData == null) {
      return AxleLoader.axleProgressIndicator();
    } else {
      final data = vehicleGpsData.data;

      List<LatLng> latLngList = data!.message.map(
        (e) {
          // log('The Value is -> ${e.latitude} - ${e.longitude}');
          return LatLng(double.parse(e.latitude), double.parse(e.longitude));
        },
      ).toList();

      getMapBounds() {
        double? x0;
        double? x1;
        double? y0;
        double? y1;

        for (LatLng latLng in latLngList) {
          if (x0 == null) {
            x0 = x1 = latLng.latitude;
            y0 = y1 = latLng.longitude;
          } else {
            if (latLng.latitude > x1!) x1 = latLng.latitude;
            if (latLng.latitude < x0) x0 = latLng.latitude;
            if (latLng.longitude > y1!) y1 = latLng.longitude;
            if (latLng.longitude < y0!) y0 = latLng.longitude;
          }
        }

        // log('value of x0 is -> $x0');
        // log('value of x1 is -> $x0');
        // log('value of y0 is -> $x0');
        // log('value of y0 is -> $x0');

        LatLngBounds bounds = LatLngBounds(LatLng(x1 ?? 20.5937, y1 ?? 78.9629), LatLng(x0 ?? 20.5937, y0 ?? 78.9629));
        try {
          _mapController.animatedFitBounds(bounds, options: boundsOptions);
        } catch (e) {
          log(e.toString());
        }
        return bounds;
      }

      return ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
              constraints: BoxConstraints(minWidth: isMobile ? widget.size.width : 500),
              width: widget.size.width,
              height: widget.size.height,
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    // nonRotatedChildren: [
                    //   Text("Updated at ${DateFormat("hh:mm:ss:a").format(ref.read(gpsLocStateProvider)!.modifiedAt)}")
                    // ],
                    options: MapOptions(
                      keepAlive: false,
                      boundsOptions: boundsOptions,
                      // maxBounds: getMapBounds(),
                      bounds: getMapBounds(),

                      // center: LatLng(
                      //   latLngList.isNotEmpty ? latLngList.first.latitude : 20.5937,
                      //   latLngList.isNotEmpty ? latLngList.first.longitude : 78.9629,
                      // ),
                      zoom: 13,
                      maxZoom: 18,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'Axlerate',
                      ),
                      MarkerLayer(
                        markers: latLngList.map((e) => AxleMarker(point: e).marker).toList(),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                        "Updated at ${DateFormat("hh:mm:ss:a").format(ref.read(gpsLocStateProvider)!.modifiedAt)}"),
                  )
                ],
              )));
    }
  }

  Widget emptyGpsDataWidget() {
    return const Center(
      child: Text(
        'No GPS Data Found',
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class AxleMarker {
  const AxleMarker({required this.point});

  final LatLng point;

  Marker get marker {
    return Marker(
      point: point,
      width: 50,
      height: 50,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      builder: (context) => SvgPicture.asset("assets/new_assets/icons/map_icon.svg"),
    );
  }
}

// class GpsMapWidegt extends StatelessWidget {
//   bool isMobile = false;

//   GpsMapWidegt({super.key});

//   @override
//   Widget build(BuildContext context) {
//     isMobile = Responsive.isMobile(context);
//     return FlutterMap(
//       options: MapOptions(
//         keepAlive: true,
//         // maxBounds: LatLngBounds(),
//         center: LatLng(
//           13.0827,
//           80.2707,
//         ),
//         zoom: 13,
//         maxZoom: 18,
//       ),
//       children: [
//         TileLayer(
//           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//           userAgentPackageName: 'Axlerate',
//         ),
//       ],
//     );
//   }
// }
