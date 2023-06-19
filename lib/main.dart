// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:axlerate/firebase_initializer.dart';
import 'package:axlerate/firebase_options.dart';
import 'package:axlerate/src/app.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/values/strings.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

late FirebaseMessaging messaging;
late SharedPreferences sharedPreferences;

final appCheck = FirebaseAppCheck.instance;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // debugPrint('Received a background message ${message.messageId}');
}

void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  // debugPrint("Receive Background Notification Response :: $details");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();

  // if (kIsWeb) {
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // } else {
  //   Platform.isAndroid || kIsWeb
  //       ? await Firebase.initializeApp(name: "Axlerate", options: DefaultFirebaseOptions.currentPlatform)
  //       : await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // }

  // messaging = FirebaseMessaging.instance;

  if (kIsWeb) {
    // debugPrint("IS DEV :: " + Flavor.I.isDevelopment.toString());
    // Flavor.I.isProduction
    //     ? await Firebase.initializeApp(options: DefaultFirebaseOptions.web)
    //     : await Firebase.initializeApp(options: DefaultFirebaseOptions.webDev);

    // Use prod config for both Staging & Production
    Flavor.I.isDevelopment
        ? await Firebase.initializeApp(options: DefaultFirebaseOptions.webDev)
        : await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  } else {
    await Firebase.initializeApp();
    // name: "axlerate", options: DefaultFirebaseOptions.currentPlatform);
  }
  // messaging = FirebaseMessaging.instance;

  await AxleFirebaseInitalizer().setupFCM();

  /* Code to get FCM Token * /
  try {
    if (kIsWeb) {
      sharedPreferences.setString(
          Strings.fcmToken, "BN94iYhERqrvf00zbr3W8PY-oxv8vdP37nYb0lPfpITY-DpqpsN11QNNswFYHbPQp85cjG3zlMX3uqhWygEKALU");
    } else {
      messaging.getToken().then((value) async {
        log("FCM TOKEN :: $value");
        sharedPreferences.setString(Strings.fcmToken, value.toString());
      });
    }
  } catch (e) {
    log("Error in initializing FCM TOKEN$e");
  }
  / * */

  try {
    if (kIsWeb) {
      // log("Site Key :: " + Strings.siteKey);
      await FirebaseAppCheck.instance.activate(
        webRecaptchaSiteKey: Strings.siteKey,
      );
    } else {
      // appCheck.activate(androidProvider: AndroidProvider.debug); // Enable during Debuging
      appCheck.activate();
    }
  } catch (e) {
    // debugPrint("Error in initializing FCM TOKEN :: $e");
  }

  usePathUrlStrategy();
  // setPathUrlStrategy();
  runApp(
    ProviderScope(
      // observers: const [StateLogger()],
      overrides: [
        sharedPreferenceProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

void setupApp() {
  main();
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
