import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/payments/domain/payment_list_model.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/payment_list_key_value_widget.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class AxlePaymentsTileWidget extends ConsumerWidget {
  const AxlePaymentsTileWidget({
    required this.doc,
    required this.onDeletePressed,
    Key? key,
  }) : super(key: key);
  final PaymentListModelDoc doc;
  final void Function()? onDeletePressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMobile = Responsive.isMobile(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2));
    double paymentsTileWidth = availableWidth - (horizontalPadding * 3);
    return isMobile
        ? mobileViewPaymentCard(doc: doc, ref: ref)
        : Container(
            margin: const EdgeInsets.symmetric(vertical: defaultMobilePadding, horizontal: 2.0),
            decoration: CommonStyleUtil.axleContainerDecoration,
            child: ExpansionTile(
              childrenPadding: const EdgeInsets.all(defaultPadding),
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: paymentsTileWidth / 4,
                    child: Text(
                      'Reference ID: ${doc.referenceId}',
                      style: AxleTextStyle.titleSmall,
                    ),
                  ),
                  SizedBox(
                    width: paymentsTileWidth / 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Client Name',
                          style: AxleTextStyle.titleSmall,
                        ),
                        if (doc.customer != null)
                          Text(
                            doc.customer!.name,
                            style: AxleTextStyle.labelMedium.copyWith(
                              color: Colors.black,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: paymentsTileWidth / 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Amount Payable',
                          style: AxleTextStyle.titleSmall,
                        ),
                        Text(
                          '₹ ${doc.amount.toString()}',
                          style: AxleTextStyle.labelMedium.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: paymentsTileWidth / 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: Random().nextInt(3) > 1
                                ? AxleColors.dashGreen
                                : Random().nextInt(3) > 1
                                    ? AxleColors.pendingStatusColor.withOpacity(0.4)
                                    : AxleColors.rejectedStatusColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            doc.status,
                            style: AxleTextStyle.labelSmall.copyWith(color: Colors.black),
                          ),
                        ),
                        if (doc.status == "DUE")
                          IconButton(
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: doc.paymentLink));
                              Snackbar.success("Copied to Clipboard.");
                            },
                            icon: const Icon(Icons.copy, size: 24, color: Color.fromRGBO(128, 159, 184, 1)),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              children: [expansionChildren(doc: doc, ref: ref)],
            ),
          );
  }

  Widget expansionChildren({required PaymentListModelDoc doc, required WidgetRef ref}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Wrap(
          runSpacing: defaultMobilePadding,
          spacing: verticalPadding,
          children: [
            PaymnetListKeyValueWidget(
              keyStr: 'Created On: ',
              value: DatePickerUtil.dateMonthYearFormatter(doc.createdAt!),
            ),
            if (doc.customer != null)
              PaymnetListKeyValueWidget(
                keyStr: 'Client Mobile No.',
                value: doc.customer!.phone,
              ),
            PaymnetListKeyValueWidget(
              keyStr: 'Payment For: ',
              value: doc.orderInfo,
            ),
            PaymnetListKeyValueWidget(
              keyStr: 'Payent Link: ',
              value: doc.paymentLink,
            ),
            PaymnetListKeyValueWidget(
              keyStr: 'Link expiry date: ',
              value: DatePickerUtil.dateMonthYearFormatter(doc.expiryDate!),
            ),
            if (doc.customer != null)
              PaymnetListKeyValueWidget(
                keyStr: 'Client Email ID: ',
                value: doc.customer!.email,
              ),
            PaymnetListKeyValueWidget(
              keyStr: 'Paymnet Date: ',
              value: DatePickerUtil.dateMonthYearFormatter(doc.date!),
            ),
          ],
        ),
        if (doc.status == "DUE") AxlePrimaryButton(buttonText: 'DELETE', onPress: onDeletePressed),
      ],
    );
  }

  Widget mobileViewPaymentCard({required PaymentListModelDoc doc, required WidgetRef ref}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultMobilePadding, horizontal: 2.0),
      decoration: CommonStyleUtil.axleContainerDecoration,
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.all(defaultPadding),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Client Name',
                      style: AxleTextStyle.titleSmall,
                    ),
                    if (doc.customer != null)
                      Text(
                        doc.customer!.name,
                        style: AxleTextStyle.labelMedium.copyWith(
                          color: Colors.black,
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Amount Payable',
                      style: AxleTextStyle.titleSmall,
                    ),
                    Text(
                      '₹ ${doc.amount.toString()}',
                      style: AxleTextStyle.labelMedium.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: defaultMobilePadding),
            Text(
              'Reference ID: ${doc.referenceId}',
              style: AxleTextStyle.titleSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Random().nextInt(3) > 1
                        ? AxleColors.dashGreen
                        : Random().nextInt(3) > 1
                            ? AxleColors.pendingStatusColor.withOpacity(0.4)
                            : AxleColors.rejectedStatusColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    doc.status,
                    style: AxleTextStyle.labelSmall.copyWith(color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    if (doc.status == "DUE")
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: doc.paymentLink));
                          Snackbar.success("Copied to Clipboard.");
                        },
                        icon: const Icon(Icons.copy, color: Color.fromRGBO(128, 159, 184, 1)),
                      ),
                    if (doc.status == "DUE")
                      IconButton(
                        onPressed: () async {
                          Share.share(doc.paymentLink);
                        },
                        icon: const Icon(Icons.share, color: Color.fromRGBO(128, 159, 184, 1)),
                      ),
                  ],
                )
              ],
            )
          ],
        ),
        children: [expansionChildren(doc: doc, ref: ref)],
      ),
    );
  }
}
