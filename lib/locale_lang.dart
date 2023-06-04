import 'package:axlerate/src/localizations/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeLangProvider = ChangeNotifierProvider<LocaleLang>((ref) {
  return LocaleLang();
});

class LocaleLang extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  void setLocale(Locale loc) {
    if (!L10n.all.contains(loc)) return;
    _locale = loc;
    notifyListeners();
  }
}
