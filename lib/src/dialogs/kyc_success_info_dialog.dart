import 'package:axlerate/src/dialogs/dialog_constants.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_info_dialog_model.dart';

class KycSuccessInfoDialog extends AxleInfoDialogModel<void> {
  const KycSuccessInfoDialog()
      : super(
          title: DialogConst.success,
          subTitle: DialogConst.kycRequestSubmitMsg,
          buttonTitle: DialogConst.done,
        );
}
