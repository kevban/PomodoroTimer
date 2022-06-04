// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timerstate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimerState _$TimerStateFromJson(Map<String, dynamic> json) => TimerState()
  ..timerStarted = json['timerStarted'] as bool
  ..timerPaused = json['timerPaused'] as bool
  ..timerType = json['timerType'] as String
  ..startTime = DateTime.parse(json['startTime'] as String)
  ..pauseTime = DateTime.parse(json['pauseTime'] as String);

Map<String, dynamic> _$TimerStateToJson(TimerState instance) =>
    <String, dynamic>{
      'timerStarted': instance.timerStarted,
      'timerPaused': instance.timerPaused,
      'timerType': instance.timerType,
      'startTime': instance.startTime.toIso8601String(),
      'pauseTime': instance.pauseTime.toIso8601String(),
    };
