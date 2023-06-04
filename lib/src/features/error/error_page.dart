import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorPage extends StatelessWidget {
  final String? error;
  const ErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Wrap(
        alignment: !(Responsive.isMobile(context)) ? WrapAlignment.center : WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 40.0,
        children: [
          SizedBox(
            height: !(Responsive.isMobile(context)) ? screenHeight * 85 / 100 : screenHeight * 40 / 100,
            width: !(Responsive.isMobile(context)) ? screenWidth * 40 / 100 : screenWidth * 80 / 100,
            child: Image.asset(
              "assets/images/error.png",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            // child: Wrap(
            //   alignment: WrapAlignment.center,
            //   verticalDirection: VerticalDirection.up,
            //   runSpacing: 30.0,
            //   // mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  //'Something\'s wrong here...',
                  'Coming Soon',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  //'We can\'t find the page you are looking for. Check out our \nhelp center or head back to home.',
                  'This page is under construction. Please come back later.',
                  style: GoogleFonts.inter(
                    fontSize: 20.0,
                    color: secondaryColor,
                  ),
                ),
                const SizedBox(height: 18.0),
                // AxleAppButton(
                //   buttonColor: primaryColor,
                //   buttonText: "Back to Home",
                //   width: 200,
                //   onSubmit: () {
                //     GoRouter.of(context).go(Pages.home);
                //   },
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
