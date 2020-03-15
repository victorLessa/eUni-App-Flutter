import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

Widget dataPicker(callback) {
  return DatePickerTimeline(
    DateTime.now(),
    height: 70.0,
    monthTextStyle: TextStyle(color: Colors.white, fontSize: 10.0),
    dateTextStyle: TextStyle(color: Colors.white),
    dayTextStyle: TextStyle(color: Colors.white, fontSize: 10.0),
    selectionColor: Color.fromRGBO(37, 116, 169, .5),
    onDateChange: (date) async {
      callback(date);
      // New date selected
    },
  );
}
