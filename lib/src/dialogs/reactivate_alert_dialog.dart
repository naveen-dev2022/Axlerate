import 'package:axlerate/src/dialogs/dialog_constants.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_alert_dialog_mode.dart';

class ReactivateUserAlertDialog extends AxleAlertDialogModel<bool> {
  const ReactivateUserAlertDialog()
      : super(
          title: DialogConst.reactivateUser,
          subTitle: DialogConst.reactivateUserMsg,
          buttons: const {
            'NO': false,
            'YES': true,
          },
        );
}
