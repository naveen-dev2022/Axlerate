import 'package:axlerate/src/dialogs/dialog_constants.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_info_dialog_model.dart';

class ServiceInfoDialog extends AxleInfoDialogModel<void> {
  const ServiceInfoDialog()
      : super(
          title: DialogConst.success,
          subTitle: DialogConst.kycRequestSubmitMsg,
          buttonTitle: DialogConst.done,
        );
}
