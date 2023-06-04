import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/report_file_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/dashboard/presentation/dashboard.dart';
import 'package:axlerate/src/features/home/logistics/domain/vehicle_toll_query_params.dart';
import 'package:axlerate/src/features/home/logistics/domain/vehiclewise_usage_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/transactions/presentation/controller/transaction_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/downloads/download_file.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

@RoutePage()
class VehicleWiseUsagePage extends ConsumerStatefulWidget {
  const VehicleWiseUsagePage({@PathParam('custId') required this.orgId, super.key});
  final String orgId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleWiseUsagePageState();
}

class _VehicleWiseUsagePageState extends ConsumerState<VehicleWiseUsagePage> {
  OrgDoc? org;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (org == null) {
        await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(enrolId: widget.orgId.toUpperCase());
        org = ref.read(orgDetailsProvider);
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
        backgroundColor: AxleColors.axleBackgroundColor,
        body: SingleChildScrollView(
            child: Padding(
                padding: isMobile
                    ? const EdgeInsets.all(defaultPadding)
                    : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                child: org == null
                    ? AxleLoader.axleProgressIndicator(height: screenHeight)
                    : VehiclewiseUsage(
                        orgId: widget.orgId,
                        isDash: false,
                      ))));
  }
}

class VehiclewiseUsage extends ConsumerStatefulWidget {
  const VehiclewiseUsage({required this.orgId, this.count, this.isDash = false, super.key});
  final int? count;
  final bool isDash;
  final String orgId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehiclewiseUsageState();
}

class _VehiclewiseUsageState extends ConsumerState<VehiclewiseUsage> {
  late Future<VehiclewiseUsageRespMessage> _vehiclewiseUsageDataFuture;
  List<String> headerItems = ["Vehicle Number", "LQ Tag", "YB Tag", "Fuel Card"];
  late DateTime startDate;
  late DateTime endDate;
  late String datePeriod;
  VehicleTollQueryParams? params;

  @override
  void initState() {
    DateTime now = DateTime.now();
    startDate = DateTime(now.year, now.month, 1);
    endDate = now;
    datePeriod = '${DateFormat("dd-MMM-yy").format(startDate)}  -  ${DateFormat("dd-MMM-yy").format(endDate)}';

    _vehiclewiseUsageDataFuture = getVehiclewiseData();
    super.initState();
  }

  Future<VehiclewiseUsageRespMessage> getVehiclewiseData() async {
    params = VehicleTollQueryParams(
        organizationEnrollmentId: widget.orgId,
        fromDate: startDate.toIso8601String(),
        toDate: endDate.toIso8601String());
    return await ref.read(logisticsControllerProvider).getVehiclewiseData(params: params!);
  }

  dowloadVehiclewiseData({ReportFileType? fileType}) async {
    if (params != null) {
      if (fileType != null) {
        params = params!.copyWith(fileType: fileType.name.toUpperCase());
      } else {
        params!.fileType = null;
      }
      ref.read(isLoadingDownloadingDocument.notifier).state = true;
      final data = await ref.read(logisticsControllerProvider).getVehiclewiseData(params: params!);
      try {
        String url = data['data']['message'];
        ReportFileType typeDoc = params!.fileType!.toLowerCase() == "csv" ? ReportFileType.csv : ReportFileType.pdf;
        FileDownloadUtil.getFileFromUrl(url, typeDoc);
        log(url.toString());
      } catch (e) {
        log(e.toString());
      }
      params!.fileType = null;
      ref.read(isLoadingDownloadingDocument.notifier).state = false;
    }
  }

  List<Widget> showDateFilter() {
    return widget.isDash
        ? [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: primaryColor),
                    color: primaryColor.withOpacity(0.1)),
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultMobilePadding / 2),
                child: Text(datePeriod, style: AxleTextStyle.labelLarge))
          ]
        : [
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
                        ConstrainedBox(constraints: const BoxConstraints(maxWidth: 400), child: child!),
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
                    _vehiclewiseUsageDataFuture = getVehiclewiseData();
                  });
                }
              },
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: primaryColor),
                          color: primaryColor.withOpacity(0.1)),
                      padding:
                          const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultMobilePadding / 2),
                      child: Text(datePeriod, style: AxleTextStyle.labelLarge)),
                  const SizedBox(width: defaultMobilePadding),
                  const Icon(Icons.calendar_month_outlined, color: primaryColor),
                ],
              ),
            ),
            // Spacer(),
            Consumer(builder: (context, ref, child) {
              bool isLoading = ref.watch(isLoadingDownloadingDocument);
              return isLoading
                  ? AxleLoader.axleProgressIndicator(height: 40.0)
                  : DropdownButton<ReportFileType>(
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
                        if (value != null) dowloadVehiclewiseData(fileType: value);
                      });
            })
          ];
  }

  Widget vehiclesUsageHeader() {
    return Row(
      mainAxisAlignment: widget.isDash ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
      children: [
        Text("Vehicles - Usage", style: AxleTextStyle.dashboardSubHeadingText),
        const SizedBox(width: defaultPadding),
        ...showDateFilter(),
        if (widget.isDash) Expanded(child: Container()),
        if (widget.isDash)
          Padding(
            padding: const EdgeInsets.only(right: defaultMobilePadding),
            child: InkWell(
                onTap: () => context.router.pushNamed('vehicle-analytics'),
                child: Text("View All >", style: AxleTextStyle.labelLarge)),
          )
      ],
    );
  }

  Widget vehiclesUsageHeaderMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Vehicles - Usage", style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: defaultMobilePadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            ...showDateFilter(),
            // Expanded(child: Container()),
            if (widget.isDash)
              Padding(
                padding: const EdgeInsets.only(right: defaultMobilePadding),
                child: InkWell(
                    onTap: () => context.router.pushNamed('vehicle-analytics'),
                    child: Text("View All >", style: AxleTextStyle.labelLarge)),
              )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        isMobile ? vehiclesUsageHeaderMobile() : vehiclesUsageHeader(),
        const SizedBox(height: defaultPadding),
        if (!isMobile) transactionsHeader(),
        FutureBuilder<VehiclewiseUsageRespMessage>(
          future: _vehiclewiseUsageDataFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<VehiclewiseUsageModel> data = snapshot.data!.docs;
              return data.isNotEmpty
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.count != null
                          ? (widget.count! < data.length ? widget.count : data.length)
                          : data.length,
                      itemBuilder: (context, index) {
                        return isMobile ? listItemMobile(data[index]) : listItem(data[index]);
                      })
                  : const Center(
                      child: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Text("No Usage during this period. Try with different dates.")));
            } else if (snapshot.hasError) {
              return const Center(
                  child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Text("Unable to Load Data. Please try after some time.")));
            } else {
              return AxleLoader.axleProgressIndicator();
            }
          },
        )
      ],
    );
  }

  Card listItem(VehiclewiseUsageModel vehicle) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
              child: Center(child: Text(vehicle.vehicleRegistrationNumber)),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(vehicle.lqtag != null ? axleCurrencyFormatterwithDecimals.format(vehicle.lqtag) : "-")),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(vehicle.ybtag != null ? axleCurrencyFormatterwithDecimals.format(vehicle.ybtag) : "-")),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(vehicle.fuel != null ? axleCurrencyFormatterwithDecimals.format(vehicle.fuel) : "-")),
            ),
          )
        ],
      ),
    );
  }

  Card listItemMobile(VehiclewiseUsageModel vehicle) {
    return Card(
      color: widget.isDash ? appBlue : Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: Center(
                child: Text(
              '${vehicle.vehicleRegistrationNumber}     |     ${axleCurrencyFormatterwithDecimals.format(vehicle.total)}',
              style: AxleTextStyle.titleMedium,
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/lq_fastag_icon.svg',
                        colorFilter: const ColorFilter.mode(Colors.deepPurpleAccent, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 4),
                      Text(vehicle.lqtag != null ? axleCurrencyFormatterwithDecimals.format(vehicle.lqtag) : "-",
                          style: AxleTextStyle.labelLarge.copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(defaultMobilePadding),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/yb_fastag_icon.svg',
                        colorFilter: const ColorFilter.mode(Colors.redAccent, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 4),
                      Text(vehicle.ybtag != null ? axleCurrencyFormatterwithDecimals.format(vehicle.ybtag) : "-",
                          style: AxleTextStyle.labelLarge.copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/new_assets/icons/fuel_icon.svg',
                        colorFilter: const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 4),
                      Text(vehicle.fuel != null ? axleCurrencyFormatterwithDecimals.format(vehicle.fuel) : "-",
                          style: AxleTextStyle.labelLarge.copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget transactionsHeader() {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for (int i = 0; i < headerItems.length; i++)
          headerItem(headerItems[i], align: i == 0 ? Alignment.center : Alignment.centerRight),
      ],
    ));
  }

  Widget headerItem(String text, {required Alignment align}) {
    return Flexible(
      flex: 1,
      // width: contentWidth,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Align(
            alignment: align,
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: AxleTextStyle.dashboardSubHeadingText.copyWith(fontSize: 16),
            )),
      ),
    );
  }
}
