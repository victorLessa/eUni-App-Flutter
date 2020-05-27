import 'package:flutter/material.dart';
import 'package:eni/controller/authenticate.dart' as Auth;
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:convert';
import 'package:eni/redux/app_actions.dart';
import 'package:eni/redux/app_state.dart';
import 'package:eni/firebase_notification_handler.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _pathImg = '';

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var obscureText = true;
  var _loading = false;
  void initState() {
    super.initState();
    new FirebaseNotifications(person).setUpFirebase();
  }

  void person(String person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
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

  Future signIn(email, password) async {
    final result = await Auth.Authenticate().signIn(email, password);
    if (result.statusCode == 200) {
      var body = json.decode(result.body);

      StoreProvider.of<AppState>(context)
          .dispatch({"type": SaveUser(), "data": body});
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      var body = json.decode(result.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(body['message']),
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
                      left: 50.0, right: 50.0, top: 100.0, bottom: 100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Login',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(
                                height: 50.0,
                              )
                            ],
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
                                // validator: (value) {
                                //   if (!RegExp(
                                //           r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                //       .hasMatch(value)) {
                                //     return 'E-mail inserido não é valído';
                                //   }
                                //   if (value.trim().isEmpty) {
                                //     return 'Insira um email';
                                //   }
                                //   return null;
                                // },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                obscureText: obscureText,
                                controller: _passwordController,
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
                                    ),
                                  ),
                                ),
                                // validator: (value) {
                                //   if (value.trim().isEmpty) {
                                //     return 'Insira uma senha';
                                //   }
                                //   return null;
                                // },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: RaisedGradientButton(
                                  child: _loading
                                      ? SizedBox(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.transparent,
                                            strokeWidth: 2.0,
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.white),
                                          ),
                                          height: 20.0,
                                          width: 20.0,
                                        )
                                      : Text(
                                          'Login',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromRGBO(125, 0, 179, 1),
                                      Color.fromRGBO(179, 0, 255, 1)
                                    ],
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _loading = true;
                                    });
                                    if (_formKey.currentState.validate()) {
                                      await signIn(
                                          'victordsgnr@gmail.com', '123');
                                    }
                                    setState(() {
                                      _loading = false;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50.0,
                              ),
                              Text(
                                'Forgot Password?',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w600),
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
                              Text(
                                "Don't have an account?",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.popAndPushNamed(
                                      context, '/register');
                                },
                                splashColor: Colors.transparent,
                                child: Text(
                                  'Create Account',
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
