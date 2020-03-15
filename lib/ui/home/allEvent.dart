import 'package:flutter/material.dart';

Widget _getEventWidget(icon, text) {
  return Container(
      margin: EdgeInsets.all(5.0),
      width: 100.0,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(text,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800))
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(37, 116, 169, .5),
        borderRadius: BorderRadius.circular(10),
      ));
}

Widget allEvents() {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text('All events', style: TextStyle(color: Colors.white)),
        ],
      ),
      Container(
        height: 100.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _getEventWidget(Icons.mic, 'Music'),
            _getEventWidget(Icons.assignment_ind, 'Work'),
            _getEventWidget(Icons.school, 'Education'),
            _getEventWidget(Icons.tv, 'Cinema'),
          ],
        ),
      )
    ],
  );
}
