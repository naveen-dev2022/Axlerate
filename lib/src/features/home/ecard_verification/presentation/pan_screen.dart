import 'package:auto_route/annotations.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/rc_screen/rc_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Themes/axle_colors.dart';
import '../../../../../Themes/common_style_util.dart';
import '../../../../../Themes/text_style_config.dart';
import '../../../../../responsive.dart';
import '../../../../../values/constants.dart';
import '../../../../utils/axle_loader.dart';
import '../../../../utils/string_operations.dart';
import '../domain/pan_entity.dart';
import 'controller/ecard_controller.dart';

@RoutePage()
class PanScreen extends ConsumerStatefulWidget {
  const PanScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PanScreen> createState() => _PanScreenState();
}

class _PanScreenState extends ConsumerState<PanScreen> {
  bool isMobile = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(panStateProvider.notifier).state = null;
      ref.read(panStateProvider.notifier).state = await ref
          .read(eCardControllerProvider)
          .fetchPanDetailsData(idNumber: '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    final panDataList = ref.watch(panStateProvider);

    return Scaffold(
        backgroundColor: AxleColors.axleBackgroundColor,
        body: panDataList == null
            ? AxleLoader.axleProgressIndicator()
            : _buildRcDetail(panDataList));
  }

  Widget _buildRcDetail(PanEntity? panDataList) {
    return Padding(
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: defaultMobilePadding)
          : const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding,
              ),
              child: Text(
                "PAN",
                style: AxleTextStyle.headingPrimary,
              ),
            ),
            Container(
              decoration: CommonStyleUtil.axleListingCardDecoration,
              padding: const EdgeInsets.all(defaultPadding),
              child: Wrap(
                runSpacing: defaultPadding,
                spacing: defaultPadding,
                children: panDataList!.data!.toJson().entries.map((entry) {
                  String key = entry.key;
                  dynamic value = entry.value;
                  return UserDataCard(
                    title: StringOperations.capitalizeEachWord(
                      key,
                    ),
                    subTitle: '$value',
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
