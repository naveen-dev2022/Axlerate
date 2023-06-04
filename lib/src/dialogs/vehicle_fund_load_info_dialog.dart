import 'package:axlerate/src/dialogs/dialog_constants.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_info_dialog_model.dart';

class VehicleFundLoadInfoDialog extends AxleInfoDialogModel<void> {
  const VehicleFundLoadInfoDialog()
      : super(
          title: DialogConst.success,
          subTitle: DialogConst.amountAddedMsg,
          buttonTitle: DialogConst.done,
        );
}
