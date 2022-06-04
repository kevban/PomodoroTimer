import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'library.dart';
import 'timerstate.dart';
import 'dart:math';
import 'package:json_annotation/json_annotation.dart';
part 'settings.g.dart';

double roundDouble(double value, int places){
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool targetPickerOpened = false;
  bool suggestionPickerOpened = false;

  @override
  void dispose() {
    saveData();
    super.dispose();
  }

  Widget showSettings(String settingDetail, bool enable) {
    if (enable) {
      if (settingDetail == "target") {
        return ListTile(
          title: const Text('Minutes per point'),
          trailing: SizedBox (
              width: 80,
              child: Row(
                children: [
                  Text("${setting.getTargetMin(-1)} min"),
                  getArrowIcon(targetPickerOpened),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              )),
          onTap: () {setState(() {
            targetPickerOpened = !targetPickerOpened;
          });} ,
        );
      } else if (settingDetail == "suggest") {
        return ListTile(
          title: const Text('Work to break ratio'),
          trailing: SizedBox (
              width: 80,
              child: Row(
                children: [
                  Text("${setting.getWorkBreakRatio(setting.workBreakRatio)}x"),
                  getArrowIcon(suggestionPickerOpened),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              )),
          onTap: () {setState(() {
            suggestionPickerOpened = !suggestionPickerOpened;
          });},
        );
      } else if (settingDetail == "minSelect") {
        List<Widget> textInPicker = [];
        for (int i = 0; i < 60 ; i++) {
          textInPicker.add(Center(child: Text("${setting.getTargetMin(i)} min")));
        }
        return SizedBox(height: 150, child: CupertinoPicker(
            itemExtent: 50,
            onSelectedItemChanged: (index) {
               setting.targetMinPerPoint = index;
              setState(() {});},
            children: textInPicker,
          scrollController: FixedExtentScrollController(initialItem: setting.targetMinPerPoint),),

        );
      } else if (settingDetail == "suggestSelect") {
        List<Widget> textInPicker = [];
        for (int i = 0; i < 13 ; i++) {
          textInPicker.add(Center(child: Text("${setting.getWorkBreakRatio(i)}x"),));
        }
        return SizedBox(height: 150, child: CupertinoPicker(
            itemExtent: 50,
            onSelectedItemChanged: (index) {
              setting.workBreakRatio = index;
              setState(() {});},
            children: textInPicker,
        scrollController: FixedExtentScrollController(initialItem: setting.workBreakRatio),)
        );
      }

    }
    return const SizedBox();
  }



  Icon getArrowIcon (bool tapped) {
    if (tapped) {
      return const Icon(Icons.arrow_drop_down_outlined);
    } else {
      return const Icon(Icons.arrow_right_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: ListView(
        children: [
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.star_border),
                Text("   Daily Targets")
              ],
            ),
            trailing: Switch(
              value: setting.dailyEnabled,
              onChanged: (bool switchVal) {
                setting.dailyEnabled = !setting.dailyEnabled;
                setState(() {});
              },
            ),
          ),
          showSettings("target", setting.dailyEnabled),
          showSettings("minSelect", targetPickerOpened),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.lightbulb_outline),
                Text("   Time Suggestions")
              ],
            ),
            trailing: Switch(
              value: setting.suggestionEnabled,
              onChanged: (bool switchVal) {
                setting.suggestionEnabled = !setting.suggestionEnabled;
                setState(() {});
              },
            ),
          ),
          showSettings("suggest", setting.suggestionEnabled),
          showSettings("suggestSelect", suggestionPickerOpened),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.refresh, color: Colors.red,),
                Text("   Hold to reset",style: TextStyle(color: Colors.red),)
              ],
            ),
            trailing: const Icon(Icons.arrow_right_outlined),
            onLongPress: () {
              timerState = TimerState();
              setting = Setting();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Data reset complete'),
              ),);
              saveData();
            },
          ),
        ],
      ),
    );
  }
}

@JsonSerializable()
class Setting {
  // user settings
  bool dailyEnabled = true;
  bool suggestionEnabled = true;
  int targetMinPerPoint = 0; // index in picker
  int workBreakRatio = 4; // index in picker
  int targetScrollIndex = 0;
  // app statistics
  int today = 0; // the date of today in yyyymmdd
  Map<int, int> minutesPerDay = {};
  int lastTimerMinute = 0; // the minute elapsed in prior timer
  bool loaded = false; //a variable that becomes true when loadData() is finished
  double suggestedMin = 0;

  Setting() {}

  // pass in -1 to get the current
  double getWorkBreakRatio(int index) {
    if (index != -1) {
      if (index < 5) {
        return roundDouble(((index + 1) * 0.2), 1);
      } else {
        return roundDouble(((index - 4) * 0.5 + 1), 1);
      }
    } else {
      if (workBreakRatio < 5) {
        return roundDouble(((workBreakRatio + 1) * 0.2), 1);
      } else {
        return roundDouble(((workBreakRatio - 4) * 0.5 + 1), 1);
      }
    }

  }

  // pass in -1 to get the current
  int getTargetMin(int index) {
    if (index != -1) {
      return (index + 1) * 5;
    } else {
      return (targetMinPerPoint + 1) * 5;
    }

  }

  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}


