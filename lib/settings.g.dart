// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting()
  ..dailyEnabled = json['dailyEnabled'] as bool
  ..suggestionEnabled = json['suggestionEnabled'] as bool
  ..targetMinPerPoint = json['targetMinPerPoint'] as int
  ..workBreakRatio = json['workBreakRatio'] as int
  ..targetScrollIndex = json['targetScrollIndex'] as int
  ..today = json['today'] as int
  ..minutesPerDay = (json['minutesPerDay'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(int.parse(k), e as int),
  )
  ..lastTimerMinute = json['lastTimerMinute'] as int
  ..loaded = json['loaded'] as bool
  ..suggestedMin = (json['suggestedMin'] as num).toDouble();

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'dailyEnabled': instance.dailyEnabled,
      'suggestionEnabled': instance.suggestionEnabled,
      'targetMinPerPoint': instance.targetMinPerPoint,
      'workBreakRatio': instance.workBreakRatio,
      'targetScrollIndex': instance.targetScrollIndex,
      'today': instance.today,
      'minutesPerDay':
          instance.minutesPerDay.map((k, e) => MapEntry(k.toString(), e)),
      'lastTimerMinute': instance.lastTimerMinute,
      'loaded': instance.loaded,
      'suggestedMin': instance.suggestedMin,
    };
