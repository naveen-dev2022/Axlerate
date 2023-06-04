import 'package:auto_route/annotations.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/widgets/rc_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../Themes/axle_colors.dart';
import '../../../../../Themes/common_style_util.dart';
import '../../../../../Themes/text_style_config.dart';
import '../../../../../responsive.dart';
import '../../../../../values/constants.dart';
import '../../../../utils/axle_loader.dart';
import '../../../../utils/string_operations.dart';
import '../domain/rc_entity.dart';
import 'controller/ecard_controller.dart';

@RoutePage()
class RcDetailScreen extends ConsumerStatefulWidget {
  const RcDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RcDetailScreen> createState() => _RcDetailScreenState();
}

class _RcDetailScreenState extends ConsumerState<RcDetailScreen> {
  bool isMobile = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(rcStateProvider.notifier).state = null;
      ref.read(rcStateProvider.notifier).state =
          await ref.read(eCardControllerProvider).fetchRcDetailsData(idNumber: '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    final rcDataList = ref.watch(rcStateProvider);

    return Scaffold(
        backgroundColor: AxleColors.axleBackgroundColor,
        body: rcDataList == null
            ? AxleLoader.axleProgressIndicator()
            : _buildRcDetail(rcDataList));
  }

  Widget _buildRcDetail(RcEntity? rcDataList) {
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
                "RC",
                style: AxleTextStyle.headingPrimary,
              ),
            ),
            Container(
              decoration: CommonStyleUtil.axleListingCardDecoration,
              padding: const EdgeInsets.all(defaultPadding),
              child: Wrap(
                  runSpacing: defaultPadding,
                  spacing: defaultPadding,
                  children: rcDataList!.data!.toJson().entries.map((entry) {
                    String key = entry.key;
                    dynamic value = entry.value;
                    return UserDataCard(
                      title: StringOperations.capitalizeEachWord(
                          key.replaceAll("_", " ")),
                      subTitle: '$value',
                    );
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
