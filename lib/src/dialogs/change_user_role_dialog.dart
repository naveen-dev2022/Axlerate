import 'package:axlerate/src/dialogs/dialog_constants.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_dropdown_dialog_model.dart';

class ChangeUserRoleDialog extends AxleDropdownDialogModel<String> {
  const ChangeUserRoleDialog()
      : super(
          title: DialogConst.switchUserRole,
          subTitle: DialogConst.switchRoleDescription,
          buttons: const {
            DialogConst.cancel: '',
            DialogConst.switchRole: '',
          },
          dropdownLabel: "Select Role",
          dropdownOptions: const ["Admin", "Staff"],
        );
}
