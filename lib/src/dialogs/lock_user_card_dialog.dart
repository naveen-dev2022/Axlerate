import 'package:axlerate/src/dialogs/dialog_models/card_lock_dialog_model.dart';

class LockUserCardDialog extends CardLockDialogModel<bool?> {
  const LockUserCardDialog()
      : super(
          heading: 'Card Lock/Block',
          title1: '',
          title2: 'Block Card',
          subtitle1:
              '\'Card Lock\' is a security feature which allows you to block the card temporarily. If you misplace your card, locking it prevents any new transactions. If you find your card, you can unlock it and start using it.',
          subtitle2:
              '\'Card Block\' is a permanent action. Once blocked, it cannot be reactivated & you have to apply for a new card.',
        );
}
