import 'timerstate.dart';
import 'library.dart';
import 'package:flutter/material.dart';

class TimeEntry {
  int minute = 0;
  String type = "";
  int date = 0; // stored in yyyymmdd format

  TimeEntry(this.minute, this.type, DateTime dateTime) {
    date = dateTimeToInt(dateTime);
  }
}