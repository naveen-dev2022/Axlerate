import 'package:flutter_riverpod/flutter_riverpod.dart';

// Add PPI - Date provider
// final ppiSelectedDateProvider = StateProvider<DateTime?>((ref) {
//   return null;
// });

// final tqSelectedDateProvider = StateProvider<DateTime?>((ref) {
//   return null;
// });

//------------------------------------------------------------------------------------

// Fill communication address state provider

final fillAddressStateProvider = StateProvider<bool>((ref) {
  return false;
});

//------------------------------------------------------------------------------------

// PPI visibility

final ppiOtpVisibilityProvider = StateNotifierProvider.autoDispose<PpiOtpVisibility, bool>((ref) {
  return PpiOtpVisibility();
});

final tagOtpVisibilityProvider = StateNotifierProvider.autoDispose<PpiOtpVisibility, bool>((ref) {
  return PpiOtpVisibility();
});

class PpiOtpVisibility extends StateNotifier<bool> {
  PpiOtpVisibility() : super(false);

  void toggle() {
    state = !state;
  }

  void setToTrue() => state = true;

  void setToFalse() => state = false;
}

//------------------------------------------------------------------------------------

