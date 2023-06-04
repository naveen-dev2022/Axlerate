import 'package:axlerate/src/dialogs/dialog_constants.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_alert_dialog_mode.dart';

class AxleExitAlertDialog extends AxleAlertDialogModel<bool> {
  const AxleExitAlertDialog()
      : super(
          title: DialogConst.heyWait,
          subTitle: DialogConst.exitPageDataLossMsg,
          buttons: const {
            'NO': false,
            'YES': true,
          },
        );
}
