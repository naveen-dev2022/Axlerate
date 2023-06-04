import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/lq_tag_vehicle_widget.dart';
import 'package:axlerate/src/features/home/vehicles/domain/list_lq_tag_vehicle_model.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';

class VechicleLinkedWidget extends StatelessWidget {
  const VechicleLinkedWidget({
    Key? key,
    required this.isMobile,
    required this.availableWidth,
    required this.lqTagVehicleList,
  }) : super(key: key);

  final bool isMobile;
  final double availableWidth;
  final ListLqtagVehicles? lqTagVehicleList;

  @override
  Widget build(BuildContext context) {
    return lqTagVehicleList == null
        ? AxleLoader.axleProgressIndicator()
        : lqTagVehicleList!.data == null
            ? emptyResponse()
            : SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: lqTagVehicleList!.data?.message?.docs.isEmpty ?? true
                      ? 1
                      : lqTagVehicleList!.data?.message?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (lqTagVehicleList!.data?.message?.docs.isEmpty ?? true) {
                      return emptyResponse();
                    }
                    return Container(
                      padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
                      margin: EdgeInsets.all(isMobile ? defaultMobilePadding : defaultMobilePadding),
                      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 350),
                      decoration: CommonStyleUtil.axleListingCardDecoration,
                      width: availableWidth * 30 / 100,
                      height: 150,
                      child: LqTagVehicleDetailsWidget(
                        vehicleRegNo: lqTagVehicleList!.data?.message?.docs[index].registrationNumber ?? '',
                        lqftSerialNo: lqTagVehicleList!.data?.message?.docs[index].lqtagaccountinformation != null
                            ? lqTagVehicleList!.data?.message?.docs[index].lqtagaccountinformation!.serialNumber ?? ''
                            : '',
                        tagStatus: 'Active',
                        walletBalance: lqTagVehicleList!.data?.message?.docs[index].lqtagaccountinformation != null
                            ? lqTagVehicleList!.data?.message?.docs[index].lqtagaccountinformation!.availableBalance ??
                                0
                            : 0,
                        balanceType: lqTagVehicleList!.data?.message?.docs[index].lqtagaccountinformation != null
                            ? lqTagVehicleList!.data?.message?.docs[index].lqtagaccountinformation!.type ?? ''
                            : '',
                      ),
                    );
                  },
                ),
              );
  }

  Widget emptyResponse() {
    return const AxleErrorWidget(
      imgHeight: 250.0,
      titleStr: HomeConstants.noTxnStr,
      subtitle: HomeConstants.noTxnTrailingStr,
    );
  }
}
