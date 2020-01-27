import 'package:flutter/material.dart';
import 'package:eni/services/authenticate.dart' as Auth;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CardLogin extends StatefulWidget {
  @override
  CardLoginState createState() => CardLoginState();
}

class CardLoginState extends State<CardLogin> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _textSubmit = 'Entrar';
  @override
  void initState() {
    super.initState();
  }
  signIn(email, password) async {
    final result = await Auth.Authenticate().signIn(email, password);
    var body = json.decode(result.body);
    if(result.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', body['token']);
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
      }
    );
  }

  Widget padding(component) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: component,
    );;
  }

  Widget _email(){
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'E-mail',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        contentPadding: EdgeInsets.only(left: 30.0)
      ),
      validator: (value) {
        if(value.trim().isEmpty) {
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
        contentPadding: EdgeInsets.only(left: 30.0)
      ),
      validator: (value) {
        if(value.trim().isEmpty) {
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

        onPressed: () {
          setState(() {
            _textSubmit = 'Carregando...';
          });
          if(_formKey.currentState.validate()) {
            signIn(_emailController.text, _passwordController.text); 
          }
          setState(() {
            _textSubmit = 'Entrar';
          });
        },
        child: Text(_textSubmit, style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        color: Color.fromRGBO(37, 116, 169, .5),
      )
    );
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
                    padding( _buttonLogin())
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}