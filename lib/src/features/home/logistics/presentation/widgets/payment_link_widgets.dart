import 'dart:core';
import 'dart:developer';
import 'package:axlerate/src/features/home/payments/domain/payment_list_model.dart';
import 'package:axlerate/src/features/home/payments/domain/payment_list_search_query_params.dart';
import 'package:axlerate/src/features/home/payments/presentation/controller/payments_controller.dart';
import 'package:axlerate/src/features/home/payments/presentation/widgets/axle_payments_tile_widget.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/text_style_config.dart';

// ignore: must_be_immutable
class PaymentListWidgets extends ConsumerWidget {
  PaymentListWidgets({super.key, this.paymentList, this.status, this.userOrgEnrollId = ''});
  PaymentListModel? paymentList;
  String? status;
  String userOrgEnrollId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return paymentList == null
        ? AxleLoader.axleProgressIndicator()
        : paymentList != null && paymentList!.data != null && paymentList!.data!.message!.docs.isNotEmpty
            ? Column(children: [
                const SizedBox(height: defaultPadding),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    status == "DUE" ? "Payment Links - Newly Created" : "Payment Links - About to Expire",
                    style: AxleTextStyle.headingPrimary,
                  ),
                ),
                const SizedBox(height: defaultMobilePadding),
                SizedBox(
                  // height: screenHeight - 300.0,
                  child: ListView.builder(
                    itemCount: paymentList!.data!.message!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AxlePaymentsTileWidget(
                        doc: paymentList!.data!.message!.docs[index],
                        onDeletePressed: () async {
                          AxleLoader.show(context);
                          try {
                            await ref
                                .read(paymentsControllerProvider)
                                .dropPaymentLink(orderId: paymentList!.data!.message!.docs[index].orderId)
                                .then((value) async {
                              AxleLoader.hide();
                              if (status == "DUE") {
                                PaymentListQueryParams params = PaymentListQueryParams(
                                  pageIndex: 1,
                                  size: 15,
                                );
                                params = params.copyWith(status: "DUE");
                                ref.read(dueListPaymentStateProvider.notifier).state = await ref
                                    .read(paymentsControllerProvider)
                                    .listPaymnetsLink(params: params, userOrgEnrollId: userOrgEnrollId);
                                return value;
                              } else {
                                PaymentListQueryParams params = PaymentListQueryParams(
                                  pageIndex: 1,
                                  size: 15,
                                );
                                params = params.copyWith(status: "DROPPED");
                                ref.read(droppedListPaymentStateProvider.notifier).state = await ref
                                    .read(paymentsControllerProvider)
                                    .listPaymnetsLink(params: params, userOrgEnrollId: userOrgEnrollId);
                                return value;
                              }
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
              ])
            : const SizedBox();
  }
}
