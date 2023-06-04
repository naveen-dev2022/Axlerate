import 'package:flutter_riverpod/flutter_riverpod.dart';

final activateAccountEmailEditableNotifierProvider =
    StateNotifierProvider<ActivateAccountEmailEditableNotifier, bool>((ref) {
  return ActivateAccountEmailEditableNotifier();
});

class ActivateAccountEmailEditableNotifier extends StateNotifier<bool> {
  ActivateAccountEmailEditableNotifier() : super(true);

  void makeEditable() {
    state = true;
  }

  void makeUnEditable() {
    state = false;
  }
}
