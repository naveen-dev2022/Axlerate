// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/sort_type.dart';
import 'package:axlerate/src/common/common_controllers/filter_controller_provider.dart';
import 'package:axlerate/src/common/common_controllers/list_orgs_filter_controller.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/icon_text_widget.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_query_params.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleFilterWidget extends ConsumerStatefulWidget {
  VehicleFilterWidget({
    super.key,
    required this.params,
  });

  VehicleQueryParams params;

  @override
  ConsumerState<VehicleFilterWidget> createState() => _VehicleFilterWidgetState();
}

class _VehicleFilterWidgetState extends ConsumerState<VehicleFilterWidget> {
  OrgsSort _selectedSortVal = OrgsSort.desc;

  @override
  Widget build(BuildContext context) {
    final filterVisibility = ref.watch(filterVisibilityProviderVehicle);
    final tagKycStatusFilter = ref.read(tagKycStatusQueryProvider.notifier);
    final tagStatusFilter = ref.read(tagStatusQueryProvider.notifier);
    final balanceTypeFilter = ref.read(balanceTypeQueryProvider.notifier);
    final fuelTypeFilter = ref.read(fuelTypeQueryProvider.notifier);

    return Positioned(
      top: 150.0,
      right: 10.0,
      left: MediaQuery.of(context).size.width * 0.55,
      bottom: 10.0,
      child: Visibility(
        visible: filterVisibility,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 400.0,
          // height: 500.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2.0,
                blurRadius: 3.0,
                color: Colors.grey.shade200,
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      HomeConstants.filters,
                      style: AxleTextStyle.miniHeadingBlackStyle,
                    ),
                    AxlePrimaryButton(
                      buttonText: 'Go',
                      buttonWidth: 60.0,
                      buttonHeight: 40.0,
                      buttonTextStyle: AxleTextStyle.goButtonstyle,
                      onPress: () async {
                        widget.params = widget.params.copyWith(
                          pageIndex: 1,
                          sortType: getSortTypeString(_selectedSortVal),
                          kycStatus: tagKycStatusFilter.selectedFilter(),
                          tagStatus: tagStatusFilter.selectedFilter(),
                          balanceType: balanceTypeFilter.selectedFilter(),
                          fuelType: fuelTypeFilter.selectedFilter(),
                        );

                        ref.read(filterVisibilityProviderVehicle.notifier).hide();
                        ref.read(listofVehiclesStateProvider.notifier).state = null;

                        ref.read(listofVehiclesStateProvider.notifier).state =
                            await ref.read(vehicleControllerProvider).getVehiclesList(params: widget.params);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                // * Sort By Filter
                ExpansionTile(
                  title: Text(
                    HomeConstants.sortBy,
                    style: AxleTextStyle.miniHeadingBlackStyle,
                  ),
                  children: [
                    RadioListTile(
                      title: const IconTextWidget(
                        icon: Icon(Icons.arrow_upward),
                        text: 'Sort Alpha Ascending',
                      ),
                      value: OrgsSort.asc,
                      groupValue: _selectedSortVal,
                      onChanged: (value) {
                        setState(() {
                          _selectedSortVal = OrgsSort.asc;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const IconTextWidget(
                        icon: Icon(Icons.arrow_downward),
                        text: 'Sort Alpha Descending',
                      ),
                      value: OrgsSort.desc,
                      groupValue: _selectedSortVal,
                      onChanged: (value) {
                        setState(() {
                          _selectedSortVal = OrgsSort.desc;
                        });
                      },
                    ),
                  ],
                ),
                // * Tag KYC Status Filter
                ExpansionTile(
                  title: Text(
                    HomeConstants.tagKycStatus,
                    style: AxleTextStyle.miniHeadingBlackStyle,
                  ),
                  children: ref
                      .watch(tagKycStatusQueryProvider)
                      .map(
                        (item) => CheckboxListTile(
                          value: item.status,
                          onChanged: (bool? val) {
                            tagKycStatusFilter.changeStatus(item, val ?? false);
                          },
                          title: Text(item.name),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      )
                      .toList(),
                ),
                // * Tag Status Filter
                ExpansionTile(
                  title: Text(
                    HomeConstants.tagStatus,
                    style: AxleTextStyle.miniHeadingBlackStyle,
                  ),
                  children: ref
                      .watch(tagStatusQueryProvider)
                      .map(
                        (item) => CheckboxListTile(
                          value: item.status,
                          onChanged: (bool? val) {
                            tagStatusFilter.changeStatus(item, val ?? false);
                          },
                          title: Text(item.name),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      )
                      .toList(),
                ),

                // * Balance type Filter
                ExpansionTile(
                  title: Text(
                    HomeConstants.balanceType,
                    style: AxleTextStyle.miniHeadingBlackStyle,
                  ),
                  children: ref
                      .watch(balanceTypeQueryProvider)
                      .map(
                        (item) => CheckboxListTile(
                          value: item.status,
                          onChanged: (bool? val) {
                            balanceTypeFilter.changeStatus(item, val ?? false);
                          },
                          title: Text(item.name),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      )
                      .toList(),
                ),
                // * Fuel type Filter
                ExpansionTile(
                  title: Text(
                    HomeConstants.fuelType,
                    style: AxleTextStyle.miniHeadingBlackStyle,
                  ),
                  children: [
                    Wrap(
                      children: ref
                          .watch(fuelTypeQueryProvider)
                          .map(
                            (item) => CheckboxListTile(
                              value: item.status,
                              onChanged: (bool? val) {
                                fuelTypeFilter.changeStatus(item, val ?? false);
                              },
                              title: Text(item.name),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
