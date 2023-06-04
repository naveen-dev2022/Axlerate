import 'package:auto_route/auto_route.dart';
import 'package:axlerate/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class AuthBackground extends StatelessWidget {
  const AuthBackground({
    Key? key,
    this.screenForm,
  }) : super(key: key);

  final Widget? screenForm;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            if (!(Responsive.isMobile(context)))
              Container(
                height: screenHeight,
                width: screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/new_assets/auth_truck_image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: SvgPicture.asset(
                Responsive.isMobile(context) ? 'assets/new_assets/only_curve.svg' : 'assets/new_assets/curve_bg.svg',
                fit: BoxFit.fill,
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Responsive.isMobile(context)
                    ? const SizedBox()
                    : SizedBox(
                        width: screenWidth * 50 / 100,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 50,
                            width: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/new_assets/axlerate_text_logo_white.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  width: Responsive.isMobile(context) ? screenWidth : screenWidth * 50 / 100,
                  // child: screenForm
                  child: const AutoRouter(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
