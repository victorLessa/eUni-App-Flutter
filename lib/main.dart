import 'package:flutter/material.dart';
// import 'package:eni/pages/Login.dart';
// import 'package:eni/pages/loginV2.dart';
// import 'package:eni/pages/LoginV3.dart';
import 'package:eni/pages/Home.dart';
import 'package:eni/pages/LoginV4.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/second': (context) => HomePage(),
    },
  ));
}
