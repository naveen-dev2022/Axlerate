import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/common/dynamic_verification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../responsive.dart';
import '../../../../../../router/route_utils.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/loading_overlay_widget.dart';
import '../../../../../utils/snackbar_util.dart';
import '../../../../../utils/verifiy_vehicle_helper.dart';
import '../controller/ecard_controller.dart';
import '../home/ecard_dashboard.dart';

@RoutePage()
class RcScreen extends ConsumerStatefulWidget {
  const RcScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RcScreen> createState() => _RcScreenState();
}

class _RcScreenState extends ConsumerState<RcScreen> {
  bool isMobile = false;
  final TextEditingController _controller = TextEditingController();
  final AxelOverlayLoader _loader = AxelOverlayLoader();

  Widget enterOtpTextBar() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextField(
          controller: _controller,
          onChanged: (v) {},
          decoration: InputDecoration(
            hintText: '',
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  const BorderSide(color: Color.fromRGBO(0, 66, 105, 0.28)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  const BorderSide(color: Color.fromRGBO(0, 66, 105, 0.28)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          DynamicVerificationCard(
            onTap: () {
              context.router.pushNamed(RouteUtils.getRcHistoryPath());
            },
            imageUrl: 'assets/images/rental_vehicle_1.svg',
          ),
          Expanded(
              child: Container(
            color: Colors.grey.shade50,
            padding: isMobile
                ? const EdgeInsets.symmetric(horizontal: defaultPadding)
                : const EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SvgPicture.asset(
                      'assets/images/bg_stack.svg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text('1 Attempt left'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('Enter Vehicle Registration Number'),
                    const SizedBox(
                      height: 8,
                    ),
                    enterOtpTextBar(),
                    Expanded(child: Container()),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: navigationButton(
                        onTap: () async {
                          await _validateVehicleNumber();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 105,
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Future _validateVehicleNumber() async {
    if (VehicleValidator.validateVehicleNumber(_controller.text) == false) {
      _loader.show(context);
      ref.read(rcStateProvider.notifier).state = null;
      await ref
          .read(eCardControllerProvider)
          .fetchRcDetailsData(
            idNumber: _controller.text,
          )
          .then(
        (value) {
          ref.read(rcStateProvider.notifier).state = value;
          final rcDataList = ref.watch(rcStateProvider);
          _loader.hide();
          if (rcDataList?.status == true) {
            context.router.pushNamed(RouteUtils.getRcDetailPath());
            return null;
          } else {
            Snackbar.error("${rcDataList?.message}");
            return null;
          }
        },
      );
    } else {
      Snackbar.warn("Please enter valid vehicle number");
    }
  }
}
