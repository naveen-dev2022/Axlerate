import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// @Deprecated('Use [AxleServiceStatusIcon] instead')
class AxleServiceIcon extends StatelessWidget {
  const AxleServiceIcon({
    Key? key,
    this.serviceName = '',
    required this.svgPath,
    required this.status,
  }) : super(key: key);

  final String serviceName;
  final String svgPath;
  final String status;

  @override
  Widget build(BuildContext context) {
    Color statusColor = AxleColors.getStatusColor(status);
    return Tooltip(
      triggerMode: kIsWeb ? null : TooltipTriggerMode.tap,
      message: "${serviceName.toUiCase} ${status.toUiCase}",
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                width: 1, color: status.toUpperCase().contains("PARTNER") ? Colors.transparent : statusColor),
            color: statusColor.withOpacity(0.1)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              svgPath,
              colorFilter: ColorFilter.mode(statusColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}

class AxleServiceStatusIcon extends StatelessWidget {
  const AxleServiceStatusIcon({Key? key, required this.service}) : super(key: key);

  final UserService service;

  @override
  Widget build(BuildContext context) {
    return AxleServiceIcon(svgPath: service.svgPath, status: service.kycStatus);
  }
}
