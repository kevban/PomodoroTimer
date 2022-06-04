import 'package:flutter/material.dart';
import 'package:pomodorot/library.dart';
import 'pomodoro.dart';
import 'settings.dart';
import 'timesheet.dart';
import 'landing.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  var initializationSettingAndroid = AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(android: initializationSettingAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
    if (payload != null) {
      print('notifiaction payload: ' + payload);
    }
  });
  try {
    loadData();
  } on Exception catch (exception) {
    setting.loaded = true;
  } catch (error) {
    setting.loaded = true;
  }

  runApp(MaterialApp(
    initialRoute: '/landing',
    routes: {
      '/landing': (context) => const Landing(),
      '/pomodoro': (context) => const Pomodoro(),
      '/settings': (context) => const Settings(),
      '/timesheet': (context) => const TimeSheet(),
    }
  ));
}

void scheduleAlarm() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime);
}

