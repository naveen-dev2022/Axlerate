import 'package:auto_route/annotations.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../../../../utils/date_time_helper.dart';
import '../../domain/challan_entity.dart';
import '../common/common_widgets.dart';
import '../controller/ecard_controller.dart';

@RoutePage()
class ChallanScreen extends ConsumerStatefulWidget {
  const ChallanScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChallanScreen> createState() => _ChallanScreenState();
}

class _ChallanScreenState extends ConsumerState<ChallanScreen> {
  // late EmployeeDataSource employeeDataSource;
  bool isMobile = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(challanStateProvider.notifier).state = null;
      ref.read(challanStateProvider.notifier).state =
          await ref.read(eCardControllerProvider).fetchChallanData('', '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);

    final challanList = ref.watch(challanStateProvider);
    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: challanList == null
          ? AxleLoader.axleProgressIndicator()
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  ECardVerificationWidgets.drawBGStackImageWidget(
                    context: context,
                  ),
                  ECardVerificationWidgets.drawLogoWidget(context: context),
                  _buildChallanDetail(challanList)
                ],
              ),
            ),
    );
  }

  Widget _buildChallanDetail(ChallanEntity? challanList) {
    final data = challanList!.data;
    return Padding(
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: defaultPadding)
          : const EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 10),
                    blurRadius: 25,
                    spreadRadius: 0,
                  ),
                ],
                color: Colors.white,
                border: Border.all(
                  color: AxleColors.axleSecondaryColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 12),
                    child: Text(
                      'Owner Name',
                      style: AxleTextStyle.poppins12w400,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(
                      data?.challans?[0].ownerName ?? "",
                      style: AxleTextStyle.poppins16w400
                          .copyWith(color: const Color(0xff252525)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 12),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: SvgPicture.asset('assets/images/rc_detail.svg'),
                    title: Text(
                      'Vehicle Number',
                      style: AxleTextStyle.poppins12w400,
                    ),
                    subtitle: Text(
                      "${data?.challans?[0].challanNo}",
                      style: AxleTextStyle.poppins16w400
                          .copyWith(color: const Color(0xff252525)),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Recent Violations',
              style: AxleTextStyle.poppins14w500Blue,
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              leading: SvgPicture.asset('assets/images/paid.svg'),
              title: Text(
                "${data?.challans?[0].rcDlNo}",
                style: AxleTextStyle.poppins16w500Black,
              ),
              subtitle: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Johann George | TN 22 CZ 1248\n',
                      style: AxleTextStyle.poppins14w300Grey,
                    ),
                    TextSpan(
                        text: '19 Mar 2023, 19:08:22',
                        style: AxleTextStyle.poppins14w300Grey.copyWith(
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
              trailing: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '1,000.00\n',
                      style: AxleTextStyle.poppins14w300Grey.copyWith(
                        color: AxleColors.axleGreenColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Paid',
                      style: AxleTextStyle.poppins14w300Grey.copyWith(
                          color: AxleColors.axleGreenColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              leading: SvgPicture.asset('assets/images/pending_payment.svg'),
              title: Text(
                "${data?.challans?[0].rcDlNo}",
                style: AxleTextStyle.poppins16w500Black,
              ),
              subtitle: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Johann George | TN 22 CZ 1248\n',
                      style: AxleTextStyle.poppins14w300Grey,
                    ),
                    TextSpan(
                        text: '19 Mar 2023, 19:08:22',
                        style: AxleTextStyle.poppins14w300Grey.copyWith(
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
              trailing: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '1,000.00\n',
                      style: AxleTextStyle.poppins14w300Grey.copyWith(
                        color: AxleColors.axleRedColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Pending',
                      style: AxleTextStyle.poppins14w300Grey.copyWith(
                          color: AxleColors.axleRedColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
