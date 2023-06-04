import 'package:axlerate/locale_lang.dart';
import 'package:axlerate/src/localizations/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeLanguageButton extends ConsumerWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeLang = ref.watch(localeLangProvider);
    return DropdownButton(
      value: localeLang.locale,
      items: L10n.dropDownLocaleList,
      onChanged: (value) {
        ref.read(localeLangProvider.notifier).setLocale(value as Locale);
      },
    );
  }
}
