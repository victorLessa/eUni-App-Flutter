import 'package:flutter/material.dart';
import 'package:eni/controller/authenticate.dart' as Auth;
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:convert';
import 'package:eni/redux/app_actions.dart';
import 'package:eni/redux/app_state.dart';

class CardLogin extends StatefulWidget {
  @override
  CardLoginState createState() => CardLoginState();
}

class CardLoginState extends State<CardLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _loading;
  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  Future signIn(email, password) async {
    final result = await Auth.Authenticate().signIn(email, password);
    var body = json.decode(result.body);
    if (result.statusCode == 200) {
      StoreProvider.of<AppState>(context)
          .dispatch({"type": SaveUser(), "data": body});
      Navigator.pushReplacementNamed(context, '/second');
      return;
    }
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
        });
  }

  Widget padding(component) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: component,
    );
  }

  Widget _email() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
          labelText: 'E-mail',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          contentPadding: EdgeInsets.only(left: 30.0)),
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Insira uma senha válida';
        }
        return null;
      },
    );
  }

  Widget _password() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Senha',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          contentPadding: EdgeInsets.only(left: 30.0)),
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Insira um E-mail';
        }
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return SizedBox(
        width: double.infinity,
        child: FlatButton(
          onPressed: () async {
            setState(() {
              _loading = true;
            });
            if (true) {
              // await signIn(_emailController.text, _passwordController.text);
              await signIn('victordsgnr@gmail.com', '123');
            }
            setState(() {
              _loading = false;
            });
          },
          child: _loading
              ? SizedBox(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                  height: 20.0,
                  width: 20.0,
                )
              : Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white),
                ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: Color.fromRGBO(37, 116, 169, .5),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: Card(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                padding(_email()),
                padding(_password()),
                padding(_buttonLogin())
              ],
            ),
          )
        ],
      ),
    )));
  }
}
