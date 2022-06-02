import 'package:json_annotation/json_annotation.dart';
import 'package:pomodorot/library.dart';
part 'timerstate.g.dart';

@JsonSerializable()
class TimerState {
  bool _timerStarted = false;
  bool _timerPaused = false;
  String _timerType = "Work"; //can be "Work", "Break"
  DateTime _startTime = DateTime.now();
  DateTime _pauseTime = DateTime.now();
  int _secondsSpentPaused = 0; //tracks the number of seconds paused

  //flutter packages pub run build_runner build
  TimerState() {}


  ///Get functions
  //return if the timer is currently running
  bool isTimerStarted() {
    return _timerStarted;
  }

  //return if the timer is currently paused
  bool isTimerPaused() {
    return _timerPaused;
  }

  // returns the seconds elapsed using the startDate
  int secondsElapsed() {
    if (_timerStarted) {
      return -_startTime.difference(DateTime.now()).inSeconds - _secondsSpentPaused;
    } else {
      return -1;
    }
  }

  String getTimerType() {
    return _timerType;
  }

  /// Set functions

  // start the timer
  void startTimer() {
    if (!_timerStarted) {
      _timerStarted = true;
      _startTime = DateTime.now();
      saveData();
    }
  }

  // pause the current active timer
  void pauseTimer() {
    if (!_timerPaused && _timerStarted) {
      _timerPaused = true;
      _pauseTime = DateTime.now();
      saveData();
    }
  }

  //continue the timer if paused
  void continueTimer() {
    if (_timerPaused) {
      _timerPaused = false;
      _secondsSpentPaused = -_pauseTime.difference(DateTime.now()).inSeconds;
      saveData();
    }
  }

  //stops and reinitialize the timer. Export the result to timesheet
  void stopTimer() {
    if (_timerStarted) {
      _timerStarted = false;
      _timerPaused = false;
      _startTime = DateTime.now();
      _pauseTime = DateTime.now();
      saveData();
    }
  }

  void changeTimerType(String timerType) {
    _timerType = timerType;
    saveData();
  }

  factory TimerState.fromJson(Map<String, dynamic> json) => _$TimerStateFromJson(json);

  Map<String, dynamic> toJson() => _$TimerStateToJson(this);


}