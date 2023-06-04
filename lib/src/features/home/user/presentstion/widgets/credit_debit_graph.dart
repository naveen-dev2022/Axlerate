import 'dart:developer';

import 'package:axlerate/src/features/home/common_widgets/line_chart_widget.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CreditWidget extends ConsumerWidget {
  const CreditWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creditItems = ref.watch(userPpiCreditGraphStateProvider);
    List<AxleLineChartModel> items = [];
    items.clear();
    log("dataType--->${Strings.dataType}");
    if (creditItems != null && creditItems.data!.message.isNotEmpty) {
      for (int i = 0; i < creditItems.data!.message.length; i++) {
        try {
          bool isDateTime = true;
          DateTime? date;
          if (Strings.dataType == "year") {
            date = DateFormat.yMMM().parse(creditItems.data!.message[i].label);
          }
          if (Strings.dataType == "month") {
            date = DateFormat.yMMMd().parse(creditItems.data!.message[i].label);
          }
          if (Strings.dataType == "week") {
            date = DateFormat.yMMMd().parse(creditItems.data!.message[i].label);
          }
          if (Strings.dataType == "day") {
            isDateTime = false;
          }
          items.add(AxleLineChartModel(
              date: isDateTime ? date! : DateTime.now(),
              value: creditItems.data!.message[i].value.toDouble(),
              hour: isDateTime ? 0 : int.parse(creditItems.data!.message[i].label),
              isDateTime: isDateTime));
        } catch (e) {
          log("Credit graph value set error-->${e.toString()}");
        }
      }
    }
    log("Total items credit-->${items.length}");
    return Expanded(
        child: items.isEmpty
            ? AxleLoader.axleProgressIndicator(
                height: 30.0,
                width: 30.0,
              )
            : AxleLineChart(
                items: items,
                key: UniqueKey(),
              ));
  }
}

class DebitWidget extends ConsumerWidget {
  const DebitWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debitItems = ref.watch(userPpiDebitGraphStateProvider);
    List<AxleLineChartModel> items = [];
    if (debitItems != null && debitItems.data!.message.isNotEmpty) {
      for (int i = 0; i < debitItems.data!.message.length; i++) {
        try {
          bool isDateTime = true;
          DateTime? date;
          if (Strings.dataType == "year") {
            date = DateFormat.yMMM().parse(debitItems.data!.message[i].label);
          }
          if (Strings.dataType == "month") {
            date = DateFormat.yMMMd().parse(debitItems.data!.message[i].label);
          }
          if (Strings.dataType == "week") {
            date = DateFormat.yMMMd().parse(debitItems.data!.message[i].label);
          }
          if (Strings.dataType == "day") {
            isDateTime = false;
          }
          items.add(AxleLineChartModel(
              date: isDateTime ? date! : DateTime.now(),
              value: debitItems.data!.message[i].value.toDouble(),
              hour: isDateTime ? 0 : int.parse(debitItems.data!.message[i].label),
              isDateTime: isDateTime));
        } catch (e) {
          log("Debit graph value set error-->${e.toString()}");
        }
      }
    }

    log("Total items Debit-->${items.length}");
    return Expanded(
        child: items.isEmpty
            ? AxleLoader.axleProgressIndicator(
                height: 30.0,
                width: 30.0,
              )
            : AxleLineChart(items: items, key: UniqueKey()));
  }
}
