import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpVisibilityProvider = StateNotifierProvider.autoDispose<OtpVisibility, bool>((ref) {
  return OtpVisibility();
});

class OtpVisibility extends StateNotifier<bool> {
  OtpVisibility() : super(false);

  void toggle() {
    state = !state;
  }

  void setToTrue() => state = true;

  void setToFalse() => state = false;
}
