import 'package:flutter/material.dart';
import 'package:eni/pages/CreateEvent.dart';

Widget drawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Drawer Header',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.date_range),
          title: const Text('Criar Evento'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateEvent()));
            // Navigator.pushReplacementNamed(context, '/createEvent');
          },
        ),
      ],
    ),
  );
}
