import 'package:axlerate/src/dialogs/dialog_constants.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_alert_dialog_mode.dart';

class CreateCustomerAlertDialog extends AxleAlertDialogModel<String> {
  const CreateCustomerAlertDialog()
      : super(
          title: DialogConst.confirm,
          subTitle: DialogConst.createOrInviteCustomerDesc,
          buttons: const {
            'INVITE': 'i',
            'CREATE': 'c',
          },
        );
}
