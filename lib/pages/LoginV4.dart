import 'package:flutter/material.dart';
import 'package:eni/components/cardLog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int topSelectedIndex = 0;
  var _left = 0.0;
  var _right = 140.0;

  void topTapped(int index) {
    setState(() {
      topSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
  void pageChanged(int index) {
    setState(() {
      if(index == 0) {
        _right = 140.0;
        _left = 0;
      } else {
        _right = 0;
        _left = 120.0;
      }
      topSelectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget _tab() {
      return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(37, 116, 169, .5),
          borderRadius: BorderRadius.circular(50.0)
        ),
        margin: EdgeInsets.only(left: 50.0, right: 50.0),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 300,),
              left: _left,
              right: _right,
              height: 48.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(50.0)
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    topTapped(0);
                  },
                  child: Text('Entrar', style: TextStyle(color: Colors.white),),
                ),
                FlatButton(
                  onPressed: () {
                    topTapped(1);
                  },
                  child: Text('Cadastrar', style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ],
        )
      );
    }
    return Scaffold(
      backgroundColor: Color(0xFF102733),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _tab(),
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 300.0,
                    child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: pageController,
                        onPageChanged: (index) {
                          pageChanged(index);
                        },
                        pageSnapping : true ,
                        physics : BouncingScrollPhysics(),  
                        children: <Widget>[
                          CardLogin(),
                          CardLogin()
                        ],
                      )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
