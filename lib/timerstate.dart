import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomodorot/library.dart';
part 'timerstate.g.dart';

@JsonSerializable()
class TimerState {
  bool timerStarted = false;
  bool timerPaused = false;
  String timerType = "Work"; //can be "Work", "Break"
  DateTime startTime = DateTime.now();
  DateTime pauseTime = DateTime.now();

  //flutter packages pub run build_runner build
  TimerState() {}


  //return if the timer is currently running
  bool isTimerStarted() {
    return timerStarted;
  }

  //return if the timer is currently paused
  bool isTimerPaused() {
    return timerPaused;
  }

  // returns the seconds elapsed using the startDate
  int secondsElapsed() {
    if (timerStarted) {
      if (timerPaused) {
        return -startTime.difference(pauseTime).inSeconds;
      } else {
        return -startTime.difference(DateTime.now()).inSeconds;
      }
    } else {
      return -1;
    }
  }

  String getTimerType() {
    return timerType;
  }

  /// Set functions

  // start the timer
  void startTimer() {
    if (!timerStarted) {
      timerStarted = true;
      startTime = DateTime.now();
      saveData();
    }
    //timerDebug();
  }

  // pause the current active timer
  void pauseTimer() {
    if (!timerPaused && timerStarted) {
      timerPaused = true;
      pauseTime = DateTime.now();
      saveData();
    }
    //timerDebug();
  }

  //continue the timer if paused
  void continueTimer() {
    if (timerPaused) {
      Duration duration = pauseTime.difference(DateTime.now());
      timerPaused = false;
      startTime = startTime.subtract(duration);
      saveData();
    }
    //timerDebug();
  }

  //stops and reinitialize the timer. Export the result to timesheet
  void stopTimer() {
    if (timerStarted) {
      timerStarted = false;
      timerPaused = false;
      startTime = DateTime.now();
      pauseTime = DateTime.now();
      saveData();
    }
  }

  void changeTimerType(String timerType) {
    this.timerType = timerType;
    print ("timer type changed to ${timerType}");
    saveData();
  }

  void timerDebug() {
    print ("-------------------------------------------");
    print ("Timer Started: ${startTime}");
    print ("Timer paused: ${pauseTime}");
    print ("Timer now: ${DateTime.now()}");
    print ("Seconds elapsed: ${secondsElapsed()}");
    print ("Timer type: ${getTimerType()}");
  }

  factory TimerState.fromJson(Map<String, dynamic> json) => _$TimerStateFromJson(json);

  Map<String, dynamic> toJson() => _$TimerStateToJson(this);


}