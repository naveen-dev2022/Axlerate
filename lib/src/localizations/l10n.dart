import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}

class L10n {
  static const all = [
    Locale('en'),
    Locale('hi'),
    Locale('ta'),
    // Locale('te'),
  ];

  static const dropDownLocaleList = [
    DropdownMenuItem(
      value: Locale('en'),
      child: Text('English'),
    ),
    DropdownMenuItem(
      value: Locale('ta'),
      child: Text('Tamil'),
    ),
    // DropdownMenuItem(
    //   value: Locale('te'),
    //   child: Text('Telugu'),
    // ),
    DropdownMenuItem(
      value: Locale('hi'),
      child: Text('Hindi'),
    ),
  ];
}
