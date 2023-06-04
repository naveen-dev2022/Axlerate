// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AxleToggleMenu extends ConsumerWidget {
  AxleToggleMenu({
    super.key,
    required this.provider,
    this.title,
    required this.items,
    this.showFilter = false,
    this.toggleButtonWidth = 150,
    this.isSwitch = true,
  }) : assert(items.isNotEmpty, 'Atleast one item should be provided') {
    labels = items.map((e) => e.label).toList();
    icons = items.map((e) => e.icon).toList();
  }

  final StateProvider<int> provider;
  final String? title;
  final List<AxleToggleMenuItem> items;
  final bool showFilter;
  late List<String> labels;
  late List<IconData?>? icons;
  double toggleButtonWidth;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  final bool isSwitch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = Responsive.isMobile(context);
    int selectedIndex = ref.watch(provider);
    availableWidth = screenWidth - sideMenuWidth;

    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 3);
      if (toggleButtonWidth > availableWidth / items.length) {
        toggleButtonWidth = availableWidth / items.length;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: defaultPadding,
          runSpacing: defaultPadding,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (title != null)
              Text(
                title!,
                style: AxleTextStyle.dashboardSubHeadingText,
              ),
            if (title != null)
              const SizedBox(
                width: defaultMobilePadding,
              ),
            if (labels.isNotEmpty && labels.length > 1)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ToggleSwitch(
                  minWidth: toggleButtonWidth,
                  minHeight: 40.0,
                  fontSize: 16.0,
                  initialLabelIndex: selectedIndex,
                  activeBgColor: const [Color(0xFF004F9F)],
                  activeFgColor: Colors.white,
                  inactiveBgColor: const Color(0xffD9E1E7),
                  inactiveFgColor: const Color(0xff809FB8),
                  borderColor: const [Color(0xffD9E1E7)],
                  radiusStyle: true,
                  borderWidth: 5.0,
                  totalSwitches: items.length,
                  labels: labels,
                  icons: icons,
                  iconSize: 10.0,
                  onToggle: (index) {
                    // print('switched to: $index');
                    // setState(() {

                    ref.read(provider.notifier).state = index ?? 0;
                    // });
                  },
                ),
              ),
            if (!isMobile && showFilter)
              SvgPicture.asset(
                "assets/new_assets/icons/filter_search_icon.svg",
                width: 25,
                alignment: Alignment.topCenter,
              ),
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        child(selectedIndex)
      ],
    );
  }

  Widget child(int index) {
    return items[index].child;
  }
}
