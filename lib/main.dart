import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:eni/redux/app_store.dart';
import 'package:eni/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: appStore,
      child: MaterialApp(
          debugShowCheckedModeBanner: true,
          // Start the app with the "/" named route. In this case, the app starts
          // on the FirstScreen widget.
          theme: ThemeData(fontFamily: 'Montserrat'),
          initialRoute: '/',
          routes: routes(context)),
    );
  }
}
