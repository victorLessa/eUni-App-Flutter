import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eni/controller/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eni/controller/events.dart';
import 'package:eni/ui/home/profileWidget.dart';
import 'package:eni/ui/home/dataPickerWidget.dart';
import 'package:eni/ui/home/allEvent.dart';
import 'package:eni/ui/home/popularEvent.dart';
import 'package:eni/ui/drawer/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  var details;
  var selectedDayEvent;
  var dateSelected;
  Future<dynamic> startStore() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return await User().details(token);
  }

  Future<dynamic> getEvents(date) async {
    return await Events.getEventsByDate(date);
  }

  @override
  void initState() {
    super.initState();
    startStore().then((result) {
      setState(() {
        details = json.decode(result.body);
      });
    });
    var date = new DateTime.now();
    getEvents(date.year.toString() +
            '-' +
            date.month.toString() +
            '-' +
            date.day.toString())
        .then((result) {
      setState(() {
        selectedDayEvent = json.decode(result.body);
      });
    }).catchError((onError) {
      return onError;
    });
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    padding(component) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: component,
      );
    }

    Widget home() {
      if (details == null) {
        return SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        );
      }
      return SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: <Widget>[
            padding(profile(details)),
            padding(dataPicker((date) async {
              final dateFormatted = date.year.toString() +
                  '-' +
                  date.month.toString() +
                  '-' +
                  date.day.toString();
              await getEvents(dateFormatted).then((result) {
                setState(() {
                  selectedDayEvent = json.decode(result.body);
                });
              });
            })),
            padding(allEvents()),
            padding(popularEvents(selectedDayEvent)),
          ],
        ),
      ));
    }

    return Scaffold(
      backgroundColor: Color(0xFF102733),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(37, 116, 169, .5),
        title: Text('UVENTO'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 25.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.crop_free,
              color: Colors.white,
              size: 25.0,
            ),
          )
        ],
      ),
      drawer: drawer(),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            home(),
            Hero(
              tag: "DemoTag",
              child: Icon(
                Icons.add,
                size: 150.0,
              ),
            ),
            Container(
              color: Color(0xFF102733),
            ),
            // Container(color: Color(0xFF102733),)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: Color(0xFF102733),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text(
                'Home',
                style: TextStyle(
                    color: _currentIndex == 0 ? Colors.yellow : Colors.white),
                textAlign: TextAlign.center,
              ),
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0 ? Colors.yellow : Colors.white,
              )),
          BottomNavyBarItem(
              title: Text(
                'Search',
                style: TextStyle(
                    color: _currentIndex == 1 ? Colors.yellow : Colors.white),
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.search,
                  color: _currentIndex == 1 ? Colors.yellow : Colors.white)),
          BottomNavyBarItem(
              title: Text(
                'Favorite',
                style: TextStyle(
                    color: _currentIndex == 2 ? Colors.yellow : Colors.white),
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.star,
                  color: _currentIndex == 2 ? Colors.yellow : Colors.white)),
        ],
      ),
    );
  }
}
