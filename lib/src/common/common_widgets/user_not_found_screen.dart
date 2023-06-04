import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserNotFoundScreen extends StatelessWidget {
  const UserNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AxleErrorWidget(
          imgHeight: 250.0,
          titleStr: "User Not Found",
        ),
      ],
    );
  }
}
