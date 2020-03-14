import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eni/components/heroPost.dart';
import 'package:eni/controller/user.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  var details;
  Future<Response> startStore() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return await User().details(token);
  }

  @override
  void initState() {
    super.initState();
    startStore().then((result) {
      setState(() {
        details = json.decode(result.body);
      });
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

    final profile = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              details != null ? details['username'] : '',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'FullStack Developer at BrasilCap',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
              textAlign: TextAlign.left,
            )
          ],
        ),
        CircleAvatar(
          backgroundColor: Color(0xFFFAE072),
          radius: 32,
          backgroundImage: AssetImage('images/avatar.jpg'),
        )
        // Icon(Icons.account_circle, size: 40.0, color: Colors.white,)
      ],
    );

    Widget dataPicker() {
      return DatePickerTimeline(
        DateTime.now(),
        height: 70.0,
        monthTextStyle: TextStyle(color: Colors.white, fontSize: 10.0),
        dateTextStyle: TextStyle(color: Colors.white),
        dayTextStyle: TextStyle(color: Colors.white, fontSize: 10.0),
        selectionColor: Color.fromRGBO(37, 116, 169, .5),
        onDateChange: (date) {
          // New date selected
          print(date);
        },
      );
    }

    Widget _getEventWidget(icon, text) {
      return Container(
          margin: EdgeInsets.all(5.0),
          width: 100.0,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(text,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800))
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          decoration: BoxDecoration(
            color: Color.fromRGBO(37, 116, 169, .5),
            borderRadius: BorderRadius.circular(10),
          ));
    }

    Widget _allEvents() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('All events', style: TextStyle(color: Colors.white)),
            ],
          ),
          Container(
            height: 100.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _getEventWidget(Icons.mic, 'Music'),
                _getEventWidget(Icons.assignment_ind, 'Work'),
                _getEventWidget(Icons.school, 'Education'),
                _getEventWidget(Icons.tv, 'Cinema'),
              ],
            ),
          )
        ],
      );
    }

    Widget _cardEvent(item) {
      return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailScreen();
              })),
          child: Hero(
              tag: item['id'],
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item['title'],
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.schedule,
                                size: 15.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(item['date'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10.0)),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.place,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(item['locale'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10.0))
                                ],
                              ))
                        ],
                      ),
                    ),
                    Image(
                      image: AssetImage('images/eletronic.jpg'),
                      width: 160.0,
                    )
                  ],
                ),
                color: Color.fromRGBO(37, 116, 169, .5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
              )));
    }

    Widget _popularEvents() {
      return Column(children: <Widget>[
        Row(children: <Widget>[
          Text(
            'Popular events',
            style: TextStyle(color: Colors.white),
          )
        ]),
        Container(
            width: double.infinity,
            height: 300.0,
            child: ListView.builder(
                itemCount: details['events'].length,
                itemBuilder: (context, index) {
                  return _cardEvent(details['events'][index]);
                }))
      ]);
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
            padding(profile),
            padding(dataPicker()),
            padding(_allEvents()),
            padding(_popularEvents()),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
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
