import 'package:flutter/material.dart';
import '../../../../../../Themes/axle_colors.dart';

class UserDataCard extends StatelessWidget {
  const UserDataCard({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AxleColors.axleShadowColor,
            // border: Border.all(
            //   color: AxleColors.axleShadowColor,
            // ),
          ),
          padding: const EdgeInsets.all(12),
          child: Text('$subTitle',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.black54,
              )),
        )
      ],
    );
  }
}
