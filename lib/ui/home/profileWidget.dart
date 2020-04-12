import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:eni/redux/app_state.dart';

Widget profile(BuildContext context, details) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StoreConnector<AppState, dynamic>(
            builder: (context, details) {
              return Text(
                details['username'],
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              );
            },
            converter: (store) => store.state.details,
          ),
          SizedBox(
            height: 5.0,
          ),
          StoreConnector<AppState, dynamic>(
              builder: (context, details) {
                return Text(
                  details['course'] != null ? details['course'] : '',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                  textAlign: TextAlign.left,
                );
              },
              converter: (store) => store.state.details)
        ],
      ),
      CircleAvatar(
        backgroundColor: Color(0xFFFAE072),
        radius: 32,
        backgroundImage: AssetImage('images/avatar.jpg'),
      )
      // Icon(Icons.account_circle, size: 40.0, color: Colors.white,)
    ],
  );
}
