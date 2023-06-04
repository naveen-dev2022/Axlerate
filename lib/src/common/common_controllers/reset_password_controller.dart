//===============Reset Password Seconds=======================

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final resetSecondsProvider = StateNotifierProvider.autoDispose<ResetSeconds, int>((ref) {
  return ResetSeconds();
});

final tagResetSecondsProvider = StateNotifierProvider.autoDispose<ResetSeconds, int>((ref) {
  return ResetSeconds();
});

class ResetSeconds extends StateNotifier<int> {
  ResetSeconds() : super(0);

  bool _isTriggeredFirstTime = false;
  bool get isTimerTriggered => _isTriggeredFirstTime;

  void timerTriggered() {
    _isTriggeredFirstTime = true;
  }

  Timer? _timer;

  void startTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      state = 0;
    }
    state = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state > 0 ? state - 1 : 0;
    });
  }

  void resetTimer() {
    if (state > 0) {
      _timer!.cancel();
      state = 0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    state = 0;
    super.dispose();
  }
}
