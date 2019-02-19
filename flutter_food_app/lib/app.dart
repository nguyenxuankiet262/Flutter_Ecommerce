import 'package:flutter/material.dart';
import 'const/color_const.dart';
import 'package:flutter_food_app/page/home/home.dart';
import 'package:flutter_food_app/page/bookmark/bookmark.dart';
import 'package:flutter_food_app/page/notification/notification.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:flutter_food_app/page/user/info.dart';

class MyMainPage extends StatefulWidget {
  var cameras;

  MyMainPage(this.cameras);

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._index = page;
    });
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void navigateToPost(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          MaterialApp(
            home: MyHomePage(this.navigateToPost),
            theme: ThemeData(fontFamily: 'Montserrat'),
            debugShowCheckedModeBanner: false,
          ),
          MyBookMark(),
          NotificationPage(),
          InfoPage(),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorActive,
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CameraPage(widget.cameras)),
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
            IconButton(
              icon: Icon(
                _index == 0 ? Icons.home : CommunityMaterialIcons.home_outline,
                color: colorActive,
              ),
              onPressed: () {
                navigationTapped(0);
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 100.0),
              child: IconButton(
                icon: Icon(
                  _index == 1 ? Icons.star : Icons.star_border,
                  color: colorActive,
                ),
                onPressed: () {
                  navigationTapped(1);
                },
              ),
            ),
            IconButton(
              icon: Icon(
                _index == 2 ? Icons.notifications : Icons.notifications_none,
                color: colorActive,
              ),
              onPressed: () {
                navigationTapped(2);
              },
            ),
            new Stack(children: <Widget>[
              IconButton(
                icon: Icon(
                  _index == 3 ? Icons.person : Icons.person_outline,
                  color: colorActive,
                ),
                onPressed: () {
                  ;
                  navigationTapped(3);
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
