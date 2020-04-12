import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:eni/redux/app_actions.dart';
import 'package:eni/redux/app_state.dart';
import 'package:eni/controller/events.dart';

Widget dataPicker(BuildContext context) {
  return StoreConnector<AppState, String>(
      builder: (BuildContext context, token) {
        return DatePickerTimeline(
          DateTime.now(),
          height: 70.0,
          monthTextStyle: TextStyle(color: Colors.white, fontSize: 10.0),
          dateTextStyle: TextStyle(color: Colors.white),
          dayTextStyle: TextStyle(color: Colors.white, fontSize: 10.0),
          selectionColor: Color.fromRGBO(37, 116, 169, .5),
          onDateChange: (date) async {
            final dateFormatted = date.year.toString() +
                '-' +
                date.month.toString() +
                '-' +
                date.day.toString();
            var result = await Events.getEventsByDate(dateFormatted, token);
            var data = json.decode(result.body);
            StoreProvider.of<AppState>(context)
                .dispatch({"type": SavePopularEvents(), "data": data});
            // New date selected
          },
        );
      },
      converter: (store) => store.state.details['token']);
}
