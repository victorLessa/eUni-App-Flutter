import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    padding(component) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: component,
      );
    }

    final header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('UniVento', style: TextStyle(color: Colors.white, fontSize: 20.0),),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.notifications, color: Colors.white, size: 25.0,),
            ),
            Icon(Icons.crop_free, color: Colors.white, size: 25.0,),
          ],
        )
      ],
    );

    final profile = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Victor Camara', style: TextStyle(color: Colors.white, fontSize: 20.0),),
            Text('FullStack Developer at BrasilCap', style: TextStyle(color: Colors.white, fontSize: 12.0), textAlign: TextAlign.left,)
          ],
        ),
        Icon(Icons.account_circle, size: 40.0, color: Colors.white,)
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
            onTap: () {
              
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: Colors.white,),
                SizedBox(height: 10.0,),
                Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(37, 116, 169, .5),
          borderRadius: BorderRadius.circular(10),
        )
      );
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

    Widget _cardEvent() {
      return Card(
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
                    Text('Eletronics', style: TextStyle(color: Colors.white),),
                    SizedBox(height: 10.0,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.schedule, size: 15.0, color: Colors.white,),
                        SizedBox(width: 5.0,),
                        Text('Jun 12 2020', style: TextStyle(color: Colors.white))
                      ],
                    ),
                  Row(
                      children: <Widget>[
                        Icon(Icons.place, size: 15.0, color: Colors.white,),
                        SizedBox(width: 5.0,),
                        Text('Alcântara', style: TextStyle(color: Colors.white))
                      ],
                    )
                  ],
                ),
            ),
            Image(image: AssetImage('images/eletronic.jpg'), width: 150.0,)
          ],
        ),
        color: Color.fromRGBO(37, 116, 169, .5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
      );
    }

    Widget _popularEvents() {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Popular events', style: TextStyle(color: Colors.white),)
            ]
          ),
          Container(
            width: double.infinity,
            height: 300.0,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                _cardEvent(),
                _cardEvent(),
                _cardEvent(),
                _cardEvent(),
                _cardEvent(),
              ],
            )
          )
        ]
      );
    }
    return Scaffold(
      backgroundColor: Color(0xFF102733),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              padding(header),
              padding(profile),
              padding(dataPicker()),
              padding(_allEvents()),
              padding(_popularEvents()),
            ],
          ),
        )
      )
    );
  }
}