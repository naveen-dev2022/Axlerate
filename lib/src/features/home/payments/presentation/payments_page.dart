import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/app_router.gr.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_icon_button.dart';
import 'package:axlerate/src/common/common_widgets/paginator.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/partner/presentation/list_partners_page.dart';
import 'package:axlerate/src/features/home/payments/domain/payment_list_search_query_params.dart';
import 'package:axlerate/src/features/home/payments/presentation/controller/payments_controller.dart';
import 'package:axlerate/src/features/home/payments/presentation/controller/payments_ui_controller.dart';
import 'package:axlerate/src/features/home/payments/presentation/widgets/axle_payments_tile_widget.dart';
import 'package:axlerate/src/features/home/payments/presentation/widgets/no_payments_enabled_widget.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class PaymentsPage extends ConsumerStatefulWidget {
  const PaymentsPage({
    super.key,
    @PathParam('custId') required this.enrolId,
  });
  final String enrolId;
  @override
  ConsumerState<PaymentsPage> createState() => _PaymentspageState();
}

class _PaymentspageState extends ConsumerState<PaymentsPage> {
  bool isEnabled = true;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  PaymentListQueryParams params = PaymentListQueryParams(
    pageIndex: 1,
    size: 15,
  );
  double availableWidth = 0.0;
  bool isMobile = false;
  @override
  void initState() {
    Future(() {
      getPaymentsList(params);
    });
    super.initState();
  }

  Future<void> getPaymentsList(PaymentListQueryParams params) async {
    ref.read(listPaymentPageNotifierProvider.notifier).setPageIndex(params.pageIndex);

    ref.read(listPaymentStateProvider.notifier).state = null;
    ref.read(listPaymentStateProvider.notifier).state =
        await ref.read(paymentsControllerProvider).listPaymnetsLink(params: params, userOrgEnrollId: widget.enrolId);
  }

  getPaymentsListSearch(String value) async {
    params = params.copyWith(
      searchText: value,
    );
    ref.read(listPaymentStateProvider.notifier).state = null;
    ref.read(listPaymentStateProvider.notifier).state =
        await ref.read(paymentsControllerProvider).listPaymnetsLink(params: params, userOrgEnrollId: widget.enrolId);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    isMobile = Responsive.isMobile(context);

    availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2));

    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    // Watching Providers
    final paymentList = ref.watch(listPaymentStateProvider);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      appBar: AxleAppBar(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [paymentListSearchBar()]),
      ),
      body: Padding(
        padding: isMobile
            ? const EdgeInsets.all(defaultMobilePadding)
            : const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
        child: isEnabled
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          HomeConstants.payments,
                          style: AxleTextStyle.headingPrimary,
                        ),
                        const SizedBox(width: defaultPadding),
                        paymentListSearchBar()
                      ],
                    ),
                  const SizedBox(height: defaultPadding),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AxlePrimaryIconButton(
                      buttonIcon: const Icon(Icons.add, size: 20.0),
                      buttonWidth: 180.0,
                      onPress: () {
                        String orgEnrollId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? '';
                        context.router.push(CreatePaymentRoute(orgEnrollId: orgEnrollId));
                      },
                      buttonText: 'Create Payment',
                      buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  paymentList == null
                      ? AxleLoader.axleProgressIndicator()
                      : paymentList.data != null && paymentList.data!.message!.docs.isNotEmpty
                          ? SizedBox(
                              height: screenHeight - 300.0,
                              child: ListView.builder(
                                itemCount: paymentList.data!.message!.docs.length,
                                itemBuilder: (context, index) {
                                  return AxlePaymentsTileWidget(
                                    doc: paymentList.data!.message!.docs[index],
                                    onDeletePressed: () async {
                                      AxleLoader.show(context);
                                      try {
                                        await ref
                                            .read(paymentsControllerProvider)
                                            .dropPaymentLink(orderId: paymentList.data!.message!.docs[index].orderId)
                                            .then((value) async {
                                          AxleLoader.hide();
                                          ref.read(listPaymentStateProvider.notifier).state = await ref
                                              .read(paymentsControllerProvider)
                                              .listPaymnetsLink(params: params);
                                          return value;
                                        });
                                      } catch (e) {
                                        AxleLoader.hide();
                                        log(e.toString());
                                      }
                                    },
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  if (paymentList != null && paymentList.data != null && paymentList.data!.message!.docs.isNotEmpty)
                    // ignore: deprecated_member_use_from_same_package
                    AxlePaginator(
                      totalCount: paymentList.data!.message!.count,
                      pageSize: params.size,
                      stateNotifier: listPaymentPageNotifierProvider,
                      onChange: ((value) {
                        getPaymentsList(params.copyWith(pageIndex: value));
                      }),
                    ),
                ],
              )
            : const NoPaymentsEnabledWidget(),
      ),
    );
  }

  Widget paymentListSearchBar() {
    return SizedBox(
      width: isMobile ? availableWidth : 500,
      height: 50.0,
      child: TextField(
        textAlign: TextAlign.start,
        onChanged: (value) {
          if (value.length >= 3) {
            getPaymentsListSearch(value);
          }
        },
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: AxleTextStyle.labelLarge.copyWith(color: primaryColor.withOpacity(0.5)),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: AxleColors.axlePrimaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
