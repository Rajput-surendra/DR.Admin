/*
import 'dart:math';
*/
import 'dart:math';

import 'package:doctoradmin/Home/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LocalNotificationService {
  BuildContext? context;
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() async {
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings(
            "@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings());
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage");
        if (message.notification != null) {
          print('${message.notification}_________________');
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          display(message);
          if(message.notification?.title == 'news'){
            print('__________${message.notification?.title == 'news'}_____________');
            Get.offAll(HomeScreen(name: '0',));
          }else if(message.notification?.title == 'webinar'){
            Get.offAll(HomeScreen(name: '1',));
          }else if(message.notification?.title == 'event'){
            Get.offAll(HomeScreen(name: '2',));
          }else if(message.notification?.title == 'editorial'){
            Get.offAll(HomeScreen(name: '3',));
          }else {
            Get.offAll(HomeScreen(name: '4',));
          }
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp");
        if (message.notification != null) {
          print('_____________${message.notification}_______________');
          print('_____________${message.notification?.title}_______________');
          print(message.notification!.body);
          print("message.data22 ${message.data}");
          if(message.notification?.title == 'news'){
            print('__________${message.notification?.title == 'news'}_____________');
            Get.offAll(HomeScreen(name: '0',));
          }else if(message.notification?.title == 'webinar'){
            Get.offAll(HomeScreen(name: '1',));
          }else if(message.notification?.title == 'event'){
            Get.offAll(HomeScreen(name: '2',));
          }else if(message.notification?.title == 'editorial'){
            print('__________${message.notification?.title == 'editorial'}_____________');
            Get.offAll(HomeScreen(name: '3',));
          }else {
            Get.offAll(HomeScreen(name: '4',));
          }

         // HomeScreenState().setSegmentValue(2) ;




        }
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      print("In Notification method");
      // int id = DateTime.now().microsecondsSinceEpoch ~/1000000;
      Random random = Random();
      int id = random.nextInt(1000);
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "docterApp",
            "docterApp",
            importance: Importance.max,
            priority: Priority.high,
          ));
      print("my id is ${id.toString()}");
      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['_id']);
    } on Exception catch (e) {
      print('Error>>>$e');
    }
  }


}