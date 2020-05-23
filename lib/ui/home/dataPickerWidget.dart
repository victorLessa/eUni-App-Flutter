import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:eni/redux/app_actions.dart';
import 'package:eni/redux/app_state.dart';
import 'package:eni/controller/events.dart';
import 'package:redux/redux.dart';

dateFormatted(date) {
  final dateFormatted = date.year.toString() +
      '-' +
      date.month.toString() +
      '-' +
      date.day.toString();
  return dateFormatted;
}

Widget dataPicker(BuildContext context) {
  final Store store = StoreProvider.of<AppState>(context);
  Events.getEventsByDate(
          dateFormatted(DateTime.now()), store.state.details['token'])
      .then((result) {
    var data = json.decode(result.body);
    StoreProvider.of<AppState>(context)
        .dispatch({"type": SavePopularEvents(), "data": data});
  });
  return DatePicker(
    DateTime.now(),
    height: 70.0,
    initialSelectedDate: DateTime.now(),
    monthTextStyle: TextStyle(color: Colors.black, fontSize: 10.0),
    dateTextStyle: TextStyle(color: Colors.black),
    dayTextStyle: TextStyle(color: Colors.black, fontSize: 10.0),
    selectionColor: Color.fromRGBO(46, 13, 218, .5),
    selectedTextColor: Colors.white,
    onDateChange: (date) async {
      var result = await Events.getEventsByDate(
          dateFormatted(date), store.state.details['token']);
      var data = json.decode(result.body);
      StoreProvider.of<AppState>(context)
          .dispatch({"type": SavePopularEvents(), "data": data});
      // New date selected
    },
  );
}
