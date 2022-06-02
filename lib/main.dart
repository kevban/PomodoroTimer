import 'package:flutter/material.dart';
import 'package:pomodorot/library.dart';
import 'pomodoro.dart';
import 'settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loadData();
  runApp(MaterialApp(
    initialRoute: '/pomodoro',
    routes: {
      '/pomodoro': (context) => const Pomodoro(),
      '/settings': (context) => const Settings(),
    }
  ));
}

