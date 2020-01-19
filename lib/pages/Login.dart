import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final _formKey = GlobalKey<FormState>();


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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'E-mail',
                          ),
                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Insira um email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if(value.isEmpty) {
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
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  print('object');
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