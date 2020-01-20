import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            // Navigate back to first screen when tapped.
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var token = prefs.getString('token');
            print(token);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}