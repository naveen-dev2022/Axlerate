import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/widgets/ListViewBuilderSpacer.dart';
import '../../domain/ecard_category_model.dart';

@RoutePage()
class SearchDashboardHome extends StatefulWidget {
  const SearchDashboardHome({Key? key}) : super(key: key);

  @override
  State<SearchDashboardHome> createState() => _SearchDashboardHomeState();
}

class _SearchDashboardHomeState extends State<SearchDashboardHome> {
  TextEditingController searchTextController = TextEditingController();
  bool isMobile = false;

  final menuList = [
    ECardCategoryModel(
      title: 'Vehicle RC Verification',
      imageUrl: 'assets/images/rc.svg',
    ),
    ECardCategoryModel(
      title: 'Driver License Verification',
      imageUrl: 'assets/images/license.svg',
    ),
    ECardCategoryModel(
      title: 'Aadhar Verification',
      imageUrl: 'assets/images/aadhar.svg',
    ),
    ECardCategoryModel(
      title: 'PAN Verification',
      imageUrl: 'assets/images/pan.svg',
    ),
    ECardCategoryModel(
      title: 'Challan Information',
      imageUrl: 'assets/images/challan_icon.svg',
    ),
    ECardCategoryModel(
      title: 'Credit Score',
      imageUrl: 'assets/images/ccs.svg',
    ),
  ];

  Widget enterOtpTextBar() {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x0F000000),
          offset: Offset(0, 10),
          blurRadius: 22,
          spreadRadius: 0,
        ),
      ]),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return TextField(
            controller: searchTextController,
            onSubmitted: ((value) {}),
            onChanged: (v) {},
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0x5c3a3a3a),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: isMobile
            ? const EdgeInsets.symmetric(horizontal: defaultPadding)
            : const EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 22,
              ),
              enterOtpTextBar(),
              const SizedBox(
                height: 18,
              ),
              Text(
                "Recommended",
                style: AxleTextStyle.headingPrimary,
              ),
              const SizedBox(
                height: 23,
              ),
              ListViewBuilderSpacer(
                  scrollDirection: Axis.vertical,
                  itemCount: menuList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _buildListItem(
                      menuList[index].imageUrl,
                      menuList[index].title,
                    );
                  },
                  spacerWidget: const SizedBox(
                    height: 25,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(
    String img,
    String title,
  ) {
    return Row(
      children: [
        SvgPicture.asset(
          img,
          width: 25,
          height: 20,
        ),
        const SizedBox(
          width: 18,
        ),
        Text(title),
        Expanded(child: Container()),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AxleColors.axlePrimaryColor, width: 1.5),
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_forward,
              color: AxleColors.axleSecondaryColor,
              size: 18,
            ),
          ),
        )
      ],
    );
  }
}
