import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imagePicker = StateProvider<Image?>((ref) {
  return null;
});

final showBrandOrDisplayName = StateProvider<bool>((ref) {
  return false;
});

final stepCompleted = StateProvider<List<int>>((ref) {
  return [];
});

final youBestRadio = StateProvider<String>((ref) {
  return "Individual/Freelancer";
});
