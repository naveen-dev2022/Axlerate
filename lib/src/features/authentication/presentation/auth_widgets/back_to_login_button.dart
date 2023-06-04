import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/router/axle_route.dart';
import 'package:axlerate/values/strings.dart';
import 'package:flutter/material.dart';

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({
    Key? key,
    this.isPop = false,
  }) : super(key: key);

  final bool isPop;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => isPop ? context.router.pop() : context.router.pushNamed(AxleRoute.login),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.arrow_back_rounded,
            color: primaryColor,
            size: 18.0,
          ),
          const SizedBox(width: 6.0),
          Text(
            Strings.backToLogin,
            style: AxleTextStyle.backToLoginStyle,
          ),
        ],
      ),
    );
  }
}
