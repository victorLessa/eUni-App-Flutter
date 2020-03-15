import 'package:flutter/material.dart';

Widget profile(details) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            details != null ? details['username'] : '',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'FullStack Developer at BrasilCap',
            style: TextStyle(color: Colors.white, fontSize: 12.0),
            textAlign: TextAlign.left,
          )
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
