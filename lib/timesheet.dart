import 'package:flutter/material.dart';
import 'package:pomodorot/library.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeSheet extends StatefulWidget {
  const TimeSheet({Key? key}) : super(key: key);

  @override
  _TimeSheetState createState() => _TimeSheetState();
}

class _TimeSheetState extends State<TimeSheet> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Sheet"),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, list) {
            if (setting.dailyEnabled) {
              if (setting.minutesPerDay[dateTimeToInt(date)]!=null) {
                return Text(
                  "${(setting.minutesPerDay[dateTimeToInt(date)]! / setting.getTargetMin(-1)).floor()}",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blueAccent
                  ),);
              }
            }
          }
        ),
      ),
    );
  }
}
