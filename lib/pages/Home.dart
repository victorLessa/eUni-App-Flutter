import 'package:flutter/material.dart';
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
  var dateSelected;

  @override
  void initState() {
    super.initState();

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
      return SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: <Widget>[
            padding(profile(context)),
            padding(dataPicker(context)),
            padding(allEvents()),
            padding(popularEvents()),
          ],
        ),
      ));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 25.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.crop_free,
              color: Colors.black,
              size: 25.0,
            ),
          )
        ],
      ),
      drawer: drawer(context),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            home(),
            // Container(color: Color(0xFF102733),)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.purple,
            ),
            title: Text('Home', style: TextStyle(color: Colors.purple)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.purple,
            ),
            title: Text(
              'Favorite',
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
