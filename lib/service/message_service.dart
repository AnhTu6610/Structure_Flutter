import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:structure_example/data_source/network_data/service_repository.dart';
import 'package:structure_example/main.dart';
import 'package:structure_example/utils/log_debug.dart';

Future myBackgroundMessageHandler(Map<String, dynamic> message) async {
  log("************************************************************************");
}

Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
  StateManager.navigatorKey.currentState.pushNamed("/notification");
}

class FcmService {
  static final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  ServiceRepository serviceRepository = new ServiceRepository();

  FcmService() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        log("|=> onMessage: $message", "onMessage");
        _showNotificationWithSound(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        log("|=> onLaunch: $message", "onLaunch");
        onSelectNotification("$message");
      },
      onResume: (Map<String, dynamic> message) async {
        log("|=> onResume: $message", "onResume");
        onSelectNotification("$message");
      },
    );
    updateFcmToken();
  }

  Future updateFcmToken() async {
    try {
      String fcmToken = await firebaseMessaging.getToken();
      print("Token FCM: $fcmToken");
      if (fcmToken != "") {
        serviceRepository.updateFcm(fcmToken);
      }
    } catch (e) {
      log(e);
      log("ERROR: update token error");
    }
  }

  Future _showNotificationWithSound(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description', importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(presentSound: true, presentAlert: true, presentBadge: true);
    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    String title = message["notification"]["title"];
    message["data"] = {'click_action': 'FLUTTER_NOTIFICATION_CLICK'};
    String boddy = message["notification"]["body"];
    String id = Platform.isIOS ? message["id"] : message["data"]["id"];

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      boddy,
      platformChannelSpecifics,
      payload: "ok",
    );
  }

  Future onSelectNotification(payload) async {
    StateManager.navigatorKey.currentState.pushNamed("/notification");
  }
}
