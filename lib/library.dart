import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'timerstate.dart';
import 'pomodoro.dart';
import 'settings.dart';
import 'package:flutter/material.dart';

TimerState timerState = TimerState();
Setting setting = Setting();

Drawer buildDrawer (BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: Icon(Icons.timer),
          title: Text("Timer"),
          onTap: () {Navigator.pushReplacement(context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Pomodoro(),
              ));},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
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
  String json = jsonEncode(TimerState);
  prefs.setString('timer', json);
}

void loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("timer") != null)  {
    String json = prefs.getString("timer")!;
    Map<String, dynamic> map = jsonDecode(json);
    timerState = TimerState.fromJson(map);
  }
}