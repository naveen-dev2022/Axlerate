import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateNotifierProvider<LoaderProvider, bool>((ref) {
  return LoaderProvider();
});

class LoaderProvider extends StateNotifier<bool> {
  LoaderProvider() : super(false);

  void show() => state = true;
  void hide() => state = false;
}
