import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'timerstate.dart';
import 'pomodoro.dart';
import 'timeentry.dart';
import 'timesheet.dart';
import 'settings.dart';
import 'package:flutter/material.dart';

TimerState timerState = TimerState(); // the timer characteristics
Setting setting = Setting(); // the app characteristics


Drawer buildDrawer (BuildContext context) {
  if (setting.today != dateTimeToInt(DateTime.now())) {
    setting.today = dateTimeToInt(DateTime.now());
    setting.lastTimerMinute = -1;
  }

  return Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.timer),
          title: const Text("Timer"),
          onTap: () {Navigator.pushReplacement(context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Pomodoro(),
              ));},
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text("Calendar"),
          onTap: () {Navigator.pushReplacement(context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const TimeSheet(),
              ));},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () {Navigator.pushReplacement(context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Settings(),
              ));},
        )
      ],
    )
  );
}

void saveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String json = jsonEncode(timerState);
  prefs.setString('timer', json);
  json = jsonEncode(setting);
  prefs.setString('setting', json);
}

void loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("timer") != null)  {
    String json = prefs.getString("timer")!;
    Map<String, dynamic> map = jsonDecode(json);
    timerState = TimerState.fromJson(map);
  }
  if (prefs.getString("setting") != null)  {
    String json = prefs.getString("setting")!;
    Map<String, dynamic> map = jsonDecode(json);
    setting = Setting.fromJson(map);
  }
}

int dateTimeToInt (DateTime dateTime) {
  return dateTime.year * 10000 + dateTime.month*100 + dateTime.day;
}