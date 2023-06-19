import 'package:axlerate/Themes/axle_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ecard_dashboard.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {Key? key, this.title, this.image, this.bgColor, this.borderColor})
      : super(key: key);

  final String? title;
  final String? image;
  final Color? borderColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        findRoute(
          value: title!,
          context: context,
        );
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: const [0, 1],
            colors: [
              Colors.white,
              bgColor!,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              offset: Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(
            color: borderColor!,
            width: 0.5,
          ),
        ),
        padding:
            const EdgeInsets.only(left: 10, top: 12, right: 20, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              image!,
              height: 40,
              width: 35,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title!),
                const Icon(
                  Icons.arrow_forward,
                  color: AxleColors.axlePrimaryColor,
                  size: 18,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
