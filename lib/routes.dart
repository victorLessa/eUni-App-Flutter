import 'package:eni/pages/CreateEvent.dart';
import 'package:eni/pages/Login.dart';
import 'package:eni/pages/Home.dart';
import 'package:eni/pages/Register.dart';
import 'package:flutter/cupertino.dart';

Object routes(BuildContext context) {
  return {
    '/': (context) => Login(),
    '/register': (context) => Register(),
    '/second': (context) => HomePage(),
    '/createEvent': (context) => CreateEvent()
  };
}
