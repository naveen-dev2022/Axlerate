import 'package:axlerate/src/dialogs/dialog_constants.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_alert_dialog_mode.dart';

class DeactivateUserAlertDialog extends AxleAlertDialogModel<bool> {
  const DeactivateUserAlertDialog()
      : super(
          title: DialogConst.deactivateUser,
          subTitle: DialogConst.deactivateUserMsg,
          buttons: const {
            'NO': false,
            'YES': true,
          },
        );
}
