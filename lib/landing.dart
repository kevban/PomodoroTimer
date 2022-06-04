import 'dart:async';

import 'package:flutter/material.dart';
import 'library.dart';
import 'pomodoro.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      print ('checking');
      if (setting.loaded) {
        timer.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute<void>(
          builder: (BuildContext context) => const Pomodoro(),
        ));
      }
    });
    return Container();
  }
}
