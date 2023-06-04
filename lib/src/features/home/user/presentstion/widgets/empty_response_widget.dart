import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:flutter/material.dart';

class EmptyResponseWidget extends StatelessWidget {
  const EmptyResponseWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AxleErrorWidget(
      imgHeight: 250.0,
      titleStr: HomeConstants.noTxnStr,
      subtitle: HomeConstants.noTxnTrailingStr,
    );
  }
}
