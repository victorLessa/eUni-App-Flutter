import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eni/services/authenticate.dart' as Auth;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, 
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.account_circle,
                      color: Colors.blue,
                      size: 80.0,
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'E-mail',
                          ),
                          validator: (value) {
                            if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)) {
                              return 'E-mail inserido não é valído';
                            }
                            if(value.trim().isEmpty) {
                              return 'Insira um email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if(value.trim().isEmpty) {
                              return 'Insira uma senha';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: 
                            FlatButton(
                              color: Colors.blue,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  var result = await Auth.Authenticate().signIn(emailController.text, passwordController.text);
                                  var body  = json.decode(result.body);
                                  if (result.statusCode == 200) {
                                    var prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('token', body['token']);
                                    Navigator.pushNamed(context, '/second');
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                        title: Text(body['message']),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Fechar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                        );
                                      }
                                    );
                                  }
                                }
                              },
                              child: Text('Login'),
                            ),
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}