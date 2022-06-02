import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'timerstate.dart';
import 'library.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  Timer _pomTimer = Timer(Duration(seconds: 1), (){});
  int secondsElapsed = 0;
  Color typeColor = Colors.black;
  Color timerColor = Colors.blue;

  void startTimer() {
    _pomTimer = Timer.periodic(Duration(seconds: 1), (timer) {setState(() {
      secondsElapsed++;
    });});
  }

  void disposeTimer() {
    _pomTimer.cancel();
  }

  void state() {
    setState(() {

    });
  }

  List<Widget> timerButtons () {
    List<Widget> buttonsToReturn = [];
    if (timerState.isTimerStarted()) {
      if (timerState.isTimerPaused()) {
        buttonsToReturn.add(ElevatedButton(onPressed: (){
          timerState.continueTimer();
          startTimer();
          setState(() {});
        }, child: Text('Resume')));
        buttonsToReturn.add(ElevatedButton(onPressed: (){
          timerState.stopTimer();
          secondsElapsed = 0;
          disposeTimer();
          changeTimerType();
          getTimerType();
          setState(() {});}, child: Text('Stop')));
      } else {
        buttonsToReturn.add(ElevatedButton(onPressed: (){
          timerState.pauseTimer();
          setState(() {});
          disposeTimer();
          setState(() {});}, child: Text('Pause')));
        buttonsToReturn.add(ElevatedButton(onPressed: (){
          timerState.stopTimer();
          secondsElapsed = 0;
          disposeTimer();
          changeTimerType();
          getTimerType();
          setState(() {});}, child: Text('Stop')));
      }
    } else {
      buttonsToReturn.add(ElevatedButton(onPressed: (){
        timerState.startTimer();
        startTimer();
        setState(() {});}, child: Text('Start')));
    }
    return buttonsToReturn;
  }

  //Change timer color scheme based on the type
  void getTimerType() {
    if (timerState.getTimerType() == "Work") {
      typeColor = Colors.blueAccent;
      timerColor = Colors.blue;
    } else {
      typeColor = Colors.green;
      timerColor = Colors.greenAccent;
    }
  }

  //swap between work and break
  void changeTimerType() {
    if (timerState.getTimerType() == "Work") {
      timerState.changeTimerType("Break");
    } else {
      timerState.changeTimerType("Work");
    }
  }

  @override
  void initState() {
    secondsElapsed = timerState.secondsElapsed();
    getTimerType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: Column(
        children: [
          SizedBox(height: 120,),
          Center(
              child: Text(
                timerState.getTimerType(),
                style: TextStyle(
                    fontSize: 30,
                    color: typeColor,
                    fontWeight: FontWeight.bold
                ),
              )
          ),
          SizedBox(height: 20,),
          Center(
            child:Text(
              secondsToString(secondsElapsed),
              style: TextStyle(
                fontSize: 56,
                color: timerColor,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          SizedBox(height: 20,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: timerButtons(),
            )
          )
        ],
      ),
    );
  }
}

String secondsToString(int secondsElapsed) {
  String secondText = '';
  String minText = '';
  if (secondsElapsed <= 0) {
    return "00:00";
  }
  else if ((secondsElapsed%60) < 10) {
    secondText = '0${(secondsElapsed%60)}';
  } else {
    secondText = '${(secondsElapsed%60)}';
  }
  if ((secondsElapsed/60) < 10) {
    minText = '0${(secondsElapsed/60).floor()}';
  } else {
    minText = '${(secondsElapsed/60).floor()}';
  }
  String timerText = '${minText}:${secondText}';
  return timerText;


}


