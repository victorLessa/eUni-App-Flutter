import 'package:flutter/material.dart';
// import 'package:eni/pages/Login.dart';
import 'package:eni/pages/loginV2.dart';
// import 'package:eni/pages/LoginV3.dart';
import 'package:eni/pages/Home.dart';

void main () {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => Login(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => HomePage(),
    },
  )
  ); 
}


