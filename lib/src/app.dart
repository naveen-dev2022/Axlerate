import 'package:axlerate/locale_lang.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/router/app_router.dart';
import 'package:axlerate/src/localizations/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appRouter = ref.watch(appRouterProvider);
    // GoRouter goRouter = appRouter.router;
    final autoRouter = ref.watch(appRouterNewProvider);

    // final autoRouter = appRouterNew;

    final localeLang = ref.watch(localeLangProvider);

    return MaterialApp.router(
      routerConfig: autoRouter.config(),
      title: "Axlerate",
      locale: localeLang.locale,
      scrollBehavior: MyCustomScrollBehavior(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: L10n.all,

      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: true,
      theme: ThemeData(fontFamily: GoogleFonts.manrope().fontFamily),

      // routerDelegate: goRouter.routerDelegate,
      // routeInformationParser: goRouter.routeInformationParser,
      // routeInformationProvider: goRouter.routeInformationProvider,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(0.9, 1.1);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
          child: child!,
        );
      },
    );
  }
}
