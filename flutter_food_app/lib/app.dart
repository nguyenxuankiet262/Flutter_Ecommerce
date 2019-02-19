import 'package:flutter/material.dart';
import 'const/color_const.dart';
import 'package:flutter_food_app/page/home/home.dart';
import 'package:flutter_food_app/page/bookmark/bookmark.dart';
import 'package:flutter_food_app/page/notification/notification.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'package:flutter_food_app/page/info_user/info.dart';


class MyMainPage extends StatefulWidget {
  var cameras;
  MyMainPage(this.cameras);
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  final _widgetOptions = [
    MyHomePage(),
    MyBookMark(),
    NotificationPage(),
    InfoPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_index),
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorActive,
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPage(widget.cameras)),
            );
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              child: _index == 0
                  ? Icon(
                      Icons.home,
                      color: colorActive,
                    )
                  : Image.asset('assets/images/icon_home.png'),
              onTap: () {
                setState(() {
                  _index = 0;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 100.0),
              child: IconButton(
                icon: Icon(
                  _index == 1 ? Icons.star : Icons.star_border,
                  color: _index == 1 ? colorActive : colorInactive,
                ),
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                },
              ),
            ),
            IconButton(
              icon: Icon(
                _index == 2 ? Icons.notifications : Icons.notifications_none,
                color: _index == 2 ? colorActive : colorInactive,
              ),
              onPressed: () {
                setState(() {
                  _index = 2;
                });
              },
            ),
            new Stack(children: <Widget>[
              IconButton(
                icon: Icon(
                  _index == 3 ? Icons.person : Icons.person_outline,
                  color: _index == 3 ? colorActive : colorInactive,
                ),
                onPressed: () {
                  setState(() {
                    _index = 3;
                  });
                },
              ),
              new Positioned(
                // draw a red marble
                top: 5.0,
                right: 20.0,
                child: new Icon(Icons.brightness_1,
                    size: 8.0, color: Colors.redAccent),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
