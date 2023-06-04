import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/report_file_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/features/home/common_widgets/pie_chart_widget.dart';
import 'package:axlerate/src/features/home/dashboard/domain/chart_items_model.dart';
import 'package:axlerate/src/features/home/partner/domain/orgwise_commission_model.dart';
import 'package:axlerate/src/features/home/partner/presentation/controller/partner_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PartnerCommissionOrgwiseTable extends ConsumerStatefulWidget {
  const PartnerCommissionOrgwiseTable({required this.partnerEnrolId, super.key, this.isDash = false});
  final String partnerEnrolId;
  final bool isDash;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PartnerCommissionOrgwiseTableState();
}

class _PartnerCommissionOrgwiseTableState extends ConsumerState<PartnerCommissionOrgwiseTable> {
  late Future<OrgwiseCommissionResponseMessage> _getData;
  @override
  void initState() {
    DateTime now = DateTime.now();
    startDate = DateTime(now.year, now.month, 1);
    endDate = DateTime(now.year, now.month + 1, 0);
    datePeriod = '${DateFormat("dd-MMM-yy").format(startDate)}  -  ${DateFormat("dd-MMM-yy").format(endDate)}';

    _getData = getCommission();

    super.initState();
  }

  Future<OrgwiseCommissionResponseMessage> getCommission() async {
    return await ref.read(partnerControllerProvider).getCommissionData(
          partnerEnrolId: widget.partnerEnrolId,
          startDate: startDate.toIso8601String(),
          endDate: endDate.toIso8601String(),
        );
  }

  Future downloadFile({ReportFileType fileType = ReportFileType.csv}) async {
    if (!kIsWeb) {
// final permissionStatus = await Permission.storage.status;
      // bool isShown = await Permission.storage.shouldShowRequestRationale;
      // PermissionStatus permissions = await Permission.storage.request();

      // if (!permissions.isGranted) {
      //   Snackbar.warn("Storage Permission Denied ");
      //   await openAppSettings();
      //   return;
      // }
    }

    AxleLoader.show(context);
    try {
      await ref.read(partnerControllerProvider).downloadCommissionData(
          partnerEnrolId: widget.partnerEnrolId.toUpperCase(),
          startDate: startDate.toIso8601String(),
          endDate: endDate.toIso8601String(),
          fileType: fileType);
    } catch (e) {
      Snackbar.error("Error Downloading File");
    } finally {
      AxleLoader.hide();
    }
  }

  late DateTime startDate;
  late DateTime endDate;
  late String datePeriod;

  bool _isMobile = false;

  @override
  Widget build(BuildContext context) {
    _isMobile = Responsive.isMobile(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      widget.isDash ? commisssionHeaderMobile() : commisssionHeader(),
      const SizedBox(height: defaultPadding),
      FutureBuilder<OrgwiseCommissionResponseMessage>(
        future: _getData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrgwiseCommission?> data = snapshot.data!.docs;
            int tableLength = 0;
            if (data.isNotEmpty) {
              tableLength = widget.isDash
                  ? data.length >= 10
                      ? 10
                      : data.length
                  : data.length;
            }
            return data.isNotEmpty
                ? _isMobile
                    ? Column(
                        children: [
                          commissionTable(tableLength, data),
                          const SizedBox(height: defaultPadding),
                          CommissionChart(data: data),
                          const SizedBox(height: defaultPadding)
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [commissionTable(tableLength, data), CommissionChart(data: data)],
                      )
                : const AxleErrorWidget(
                    imgHeight: 200,
                    showTitle: false,
                    subtitle: "No Cashback was accurred during this period. Please try with different dates.",
                  );
          } else {
            return AxleLoader.axleProgressIndicator();
          }
        },
      )
    ]);
  }

  Widget showDateFilter() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      InkWell(
        onTap: () async {
          DateTimeRange? range = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2023, 1, 1),
            lastDate: DateTime.now(),
            saveText: "Filter",
            confirmText: "Confirm",
            cancelText: "Cancel",
            initialEntryMode: DatePickerEntryMode.calendar,
            builder: (context, child) {
              return Column(
                children: [
                  ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 400,
                      ),
                      child: child!),
                ],
              );
            },
            helpText: "Choose Date Range to Filter Transactions",
            // anchorPoint: Offset(350, 350)
          );

          // debugPrint(range.toString());
          if (range != null) {
            // debugPrint(range.start.toIso8601String());
            // debugPrint(range.start.to);

            setState(() {
              startDate = range.start;
              endDate = range.end;
              datePeriod =
                  '${DateFormat("dd-MMM-yy").format(startDate)}  -  ${DateFormat("dd-MMM-yy").format(endDate)}';
              _getData = getCommission();
            });
          }
        },
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.grey),
                    color: Colors.grey[300]),
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultMobilePadding / 2),
                child: Text(
                  datePeriod,
                )),
            const Icon(Icons.calendar_month_outlined)
          ],
        ),
      ),
    ]);
  }

  Table commissionTable(int tableLength, List<OrgwiseCommission?> data) {
    return Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: IntrinsicColumnWidth(),
          2: IntrinsicColumnWidth(),
          3: IntrinsicColumnWidth(),
        }, children: [
      const TableRow(
        decoration: BoxDecoration(color: Colors.white),
        children: [
          TableHeading(title: "Organisation Name"),
          TableHeading(title: "LQ FASTag"),
          TableHeading(title: "YB FASTag"),
          TableHeading(title: "Prepaid Cards"),
        ],
      ),
      for (int i = 0; i < tableLength; i++)
        TableRow(
          decoration: BoxDecoration(
            color: i % 2 != 0 ? Colors.white : null,
          ),
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8.0),
                child: Text(data[i]!.logisticsOrg.firstName)),
            TableCellValue(value: double.parse(data[i]!.lqTag.toString())),
            TableCellValue(value: double.parse(data[i]!.ybTag.toString())),
            TableCellValue(value: double.parse(data[i]!.ppi.toString())),
          ],
        ),
    ]);
  }

  Wrap commisssionHeader() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text("Organization Wise Commission Split", style: AxleTextStyle.dashboardSubHeadingText),
        const SizedBox(width: defaultPadding),
        if (!widget.isDash) showDateFilter(),
        const SizedBox(width: defaultPadding),
        if (!widget.isDash)
          DropdownButton<ReportFileType>(
              itemHeight: 49,
              elevation: 4,
              // alignment: Alignment.topCenter,
              underline: const SizedBox(),
              hint: const Text("Download"),
              icon: const Icon(Icons.download_for_offline_outlined),
              items: const [
                // DropdownMenuItem(value: ReportFileType.pdf, child: Text("PDF")),
                DropdownMenuItem(value: ReportFileType.csv, child: Text("CSV"))
              ],
              onChanged: (ReportFileType? value) {
                if (value != null) downloadFile(fileType: value);
              }),
        if (widget.isDash)
          InkWell(
              onTap: () {
                context.router.pushNamed(RouteUtils.getCommissionsPath());
              },
              child: Text("View All >", style: AxleTextStyle.labelLarge))
      ],
    );
  }

  Widget commisssionHeaderMobile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Commission Split", style: AxleTextStyle.dashboardSubHeadingText),
        if (widget.isDash)
          InkWell(
              onTap: () {
                context.router.pushNamed(RouteUtils.getCommissionsPath());
              },
              child: Text("View All >", style: AxleTextStyle.labelLarge))
      ],
    );
  }
}

class CommissionChart extends StatelessWidget {
  const CommissionChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<OrgwiseCommission?> data;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    double screenWidth = MediaQuery.of(context).size.width;

    double availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2);
    if (isMobile) {
      availableWidth = (screenWidth - (defaultPadding * 2 + defaultMobilePadding));
    }

    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 300),
      width: isMobile ? availableWidth : availableWidth * 30 / 100,
      height: isMobile ? availableWidth : 380,
      decoration: CommonStyleUtil.axleContainerDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding,
        ),
        child: AxlePieChart(
            items: data
                .map((e) => AxPieChartDataItem(
                    value: double.parse(e!.total.toString()),
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    label: e.logisticsOrg.firstName,
                    radius: 100))
                .toList()),
      ),
    );
  }
}

class TableCellValue extends StatelessWidget {
  const TableCellValue({
    Key? key,
    this.value,
  }) : super(key: key);

  final double? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8.0),
        child: Align(
            alignment: value != null ? Alignment.centerRight : Alignment.center,
            child: Text(value != null ? axleCurrencyFormatterwithDecimals.format(value) : '-')));
  }
}

class TableHeading extends StatelessWidget {
  const TableHeading({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ));
  }
}
