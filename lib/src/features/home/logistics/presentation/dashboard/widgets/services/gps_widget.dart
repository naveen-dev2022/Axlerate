// ignore_for_file: must_be_immutable

import 'package:axlerate/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class GpsWidget extends StatelessWidget {
  GpsWidget({
    Key? key,
    required this.markers,
    required this.size,
    this.lat,
    this.lng,
  }) : super(key: key);

  final List<LatLng> markers;
  final Size size;
  bool isMobile = false;
  final double? lat;
  final double? lng;

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? size.width : 500),
      width: size.width,
      height: isMobile ? size.height * 75 / 100 : size.height,
      child: FlutterMap(
        options: MapOptions(
            keepAlive: true,
            // maxBounds: LatLngBounds(
            //   LatLng(
            //     (lat != null ? (lat! - 10) : -90),
            //     (lng != null ? (lng! - 10) : -180),
            //   ),
            //   LatLng(
            //     (lat != null ? (lat! + 10) : 90),
            //     (lng != null ? (lng! + 10) : 180),
            //   ),
            // ),
            center: LatLng(
              lat ?? 12.995758,
              lng ?? 80.195320,
            ),
            zoom: 13,
            maxZoom: 18),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'Axlerate',
          ),
          MarkerLayer(
            markers: markers.map((e) => AxleMarker(point: e).marker).toList(),
          ),
        ],
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
