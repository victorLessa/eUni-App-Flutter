import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eni/web/auth_service.dart' as Auth;
import 'package:eni/redux/app_actions.dart';
import 'package:eni/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  var obscureText = true;
  var obscureRepeatPassword = true;

  @override
  void initState() {
    super.initState();
  }

  Future<http.Response> register(
      email, username, password, repeatPassword) async {
    if (password != repeatPassword) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Senhas não conferem'),
            actions: <Widget>[
              FlatButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
    await Auth.AuthService.register(email, username, password)
        .then((onValue) async {
      var body = json.decode(onValue.body);
      StoreProvider.of<AppState>(context)
          .dispatch({"type": SaveUser(), "data": body});
      Navigator.pushReplacementNamed(context, '/second');
      return;
    }).catchError((onError) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(onError.message),
            actions: <Widget>[
              FlatButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50.0, top: 150.0, bottom: 100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Create Account',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                ),
                                validator: (value) {
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(value)) {
                                    return 'E-mail inserido não é valído';
                                  }
                                  if (value.trim().isEmpty) {
                                    return 'Insira um email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                ),
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'Insira um usuário';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: obscureText,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 0.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          obscureText = !obscureText;
                                        });
                                      },
                                      splashColor: Colors.transparent,
                                      child: Icon(
                                        obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                    ), // myIcon is a 48px-wide widget.
                                  ),
                                ),
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'Insira uma senha';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _repeatPasswordController,
                                obscureText: obscureRepeatPassword,
                                decoration: InputDecoration(
                                  labelText: 'Repeat Password',
                                  suffixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 0.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          obscureRepeatPassword =
                                              !obscureRepeatPassword;
                                        });
                                      },
                                      splashColor: Colors.transparent,
                                      child: Icon(
                                        obscureRepeatPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                    ), // myIcon is a 48px-wide widget.
                                  ),
                                ),
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'Insira uma senha';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: RaisedGradientButton(
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromRGBO(125, 0, 179, 1),
                                      Color.fromRGBO(179, 0, 255, 1)
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      await register(
                                          _emailController.text,
                                          _usernameController.text,
                                          _passwordController.text,
                                          _repeatPasswordController.text);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 50.0,
                              ),
                              Text(
                                "Already have an account? ",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.popAndPushNamed(context, '/');
                                },
                                splashColor: Colors.transparent,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
