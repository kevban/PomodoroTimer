import 'package:flutter/material.dart';
import 'package:pomodorot/main.dart';
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

  void addTime(int minutes) {
    if (timerState.getTimerType() == "Work") {
      setting.minutesPerDay.update(dateTimeToInt(DateTime.now()), (value) => value + minutes, ifAbsent: ()=> minutes);
    }
    print (minutes);
    setting.lastTimerMinute = minutes;
  }

  List<Widget> timerButtons () {
    List<Widget> buttonsToReturn = [];
    if (timerState.isTimerStarted()) {
      if (timerState.isTimerPaused()) {
        buttonsToReturn.add(ElevatedButton(onPressed: (){
          timerState.continueTimer();
          startTimer();
          setState(() {});
        }, child: const Text('Resume')));
        buttonsToReturn.add(ElevatedButton(onPressed: (){
          addTime((timerState.secondsElapsed()/60).floor());
          timerState.stopTimer();
          secondsElapsed = 0;
          disposeTimer();
          changeTimerType();
          getTimerType();
          setState(() {});}, child: const Text('Stop')));
      } else {
        buttonsToReturn.add(ElevatedButton(onPressed: (){
          timerState.pauseTimer();
          setState(() {});
          disposeTimer();
          setState(() {});}, child: const Text('Pause')));
        buttonsToReturn.add(ElevatedButton(onPressed: (){
          addTime((timerState.secondsElapsed()/60).floor());
          timerState.stopTimer();
          secondsElapsed = 0;
          disposeTimer();
          changeTimerType();
          getTimerType();
          setState(() {});}, child: const Text('Stop')));
      }
    } else {
      buttonsToReturn.add(ElevatedButton(onPressed: (){
        timerState.startTimer();
        scheduleAlarm();
        startTimer();
        setState(() {});}, child: const Text('Start')));
    }
    return buttonsToReturn;
  }

  Widget timeSuggestion() {
    if (setting.suggestionEnabled) {
      if (setting.lastTimerMinute >= 0) {
        if (timerState.getTimerType() == "Work") {
          return Text("Suggested work time: ${setting.lastTimerMinute * setting.getWorkBreakRatio(-1)} min");
        } else {
          return Text("Suggested break time: ${(setting.lastTimerMinute / setting.getWorkBreakRatio(-1)).round()} min");
        }
      } else {
        return const Text("This is your first work timer of the day. Fight on!");
      }
    }
    return const SizedBox();
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
    getTimerType();
    if (timerState.isTimerStarted()) {
      secondsElapsed = timerState.secondsElapsed();
      if (!timerState.isTimerPaused()) {
        startTimer();
      }
    } else {
      secondsElapsed = 0;
    }
    timerState.timerDebug();
    super.initState();
  }

  @override
  void dispose() {
    disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: Column(
        children: [
          const SizedBox(height: 120,),
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
          const SizedBox(height: 20,),
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
          const SizedBox(height: 20,),
          timeSuggestion(),
          const SizedBox(height: 20,),
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


