import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileImageStateProvider = StateProvider<String>(
  (ref) {
    return ref.watch(sharedPreferenceProvider).getString(Storage.profileUrl) ??
        '';
  },
);
