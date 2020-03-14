import 'package:flutter/material.dart';
import 'package:eni/controller/authenticate.dart' as Auth;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _form = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  signIn(email, password) async {
    try {
      final result = await Auth.Authenticate().signIn(email, password);
      final body = json.decode(result.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', body['token']);
      Navigator.pushNamed(context, '/second');
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    padding(component) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: component,
      );
    }

    final emailInput = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
          labelText: 'E-mail', border: OutlineInputBorder()),
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Insira um E-mail';
        }
        return null;
      },
    );

    final passwordInput = TextFormField(
      obscureText: true,
      controller: passwordController,
      decoration: const InputDecoration(
          labelText: 'Senha', border: OutlineInputBorder()),
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Insira uma senha';
        }
        return null;
      },
    );

    final loginInput = SizedBox(
        width: double.infinity,
        child: FlatButton(
          child: Text("Entrar"),
          color: Colors.blue,
          textColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () async {
            if (_form.currentState.validate()) {
              signIn(emailController.text, passwordController.text);
            }
          },
        ));

    final card = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(26.0),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    padding(emailInput),
                    padding(passwordInput),
                    Divider(),
                    loginInput
                  ],
                ),
              ),
            )
          ],
        ));

    return Scaffold(
      backgroundColor: Color(0xFF102733),
      body: Center(
          child: Stack(
        children: <Widget>[card],
      )),
    );
  }
}
