import 'dart:convert';
import 'package:axlerate/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AxleFirebaseInitalizer {
  static late AndroidNotificationChannel defaultNotificationChannel;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> setupFCM() async {
    // log("FCM INITIALIZATION STARTED");

    if (kIsWeb) {
      // In web, dont wait until any action to be taken on permissions popup.
      FirebaseMessaging.instance.requestPermission();
    } else {
      //NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //   debugPrint('User granted permission');
      // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      //   debugPrint('User granted provisional permission');
      // } else {
      //   debugPrint('User declined or has not accepted permission');
      //   debugPrint("'Notification permission not granted'");
      // }
    }

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      defaultNotificationChannel = const AndroidNotificationChannel(
        'axlerate_default_notification_channel', // id
        'General Notifications', // name / title
        description: 'Transaction Triggred', // description,
        importance: Importance.high,
        playSound: true,
        // sound: RawResourceAndroidNotificationSound('siren'),
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      InitializationSettings initializationSettings = const InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          iOS: DarwinInitializationSettings(
              requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true));

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
        onDidReceiveNotificationResponse: onDidReceiveBackgroundNotificationResponse,
        // onSelectNotification: (payload) async {
        //   log("PAYLOAD : ${payload ?? 'NULL'}");
        //   if (payload != null) {
        //     RemoteMessage message = RemoteMessage.fromMap(jsonDecode(payload));
        //     NotificationHelper().notificationClick(message);
        //   }
        // },
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(defaultNotificationChannel);

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // log("FirebaseMessaging.onMessage : ${jsonEncode(message.toMap())}");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        if (message.notification!.android!.channelId != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  defaultNotificationChannel.id,
                  defaultNotificationChannel.name,
                  icon: 'ic_logo',
                  channelDescription: defaultNotificationChannel.description,
                  // colorized: true,
                  // color: Colors.transparent,
                  importance: Importance.high,
                  playSound: true,
                  // sound: const RawResourceAndroidNotificationSound('siren'),
                ),
                iOS: const DarwinNotificationDetails()),
            payload: jsonEncode(message.toMap()),
          );
        }
      }
      // NotificationHelper().onMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // debugPrint('A new onMessageOpenedApp event was published! : ${jsonEncode(message.toMap())}');
      // NotificationHelper().notificationClick(message);
    });

    // log("FCM INITIALIZATION COMPLETED :)");
  }
}
