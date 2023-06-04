import 'package:axlerate/Themes/color_constants.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    Key? key,
    required this.url,
    this.width = 40.0,
    this.height = 40.0,
    this.radius = 40.0,
  }) : super(key: key);

  final String url;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: url.isEmpty
            ? const DecorationImage(
                image: AssetImage('assets/images/logo_profile.png'),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
          color: primaryColor,
          width: 1.0,
        ),
      ),
    );
  }
}
