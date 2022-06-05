import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomodorot/library.dart';
import 'pomodoro.dart';
import 'settings.dart';
import 'timesheet.dart';
import 'landing.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    loadData();
  } on DisallowedNullValueException catch (e) {
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


