import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/filter/filter.dart';
import 'package:flutter_food_app/page/home/home.dart';
import 'package:flutter_food_app/page/cart/cart.dart';
import 'package:flutter_food_app/page/notification/notification.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:flutter_food_app/page/search/search.dart';
import 'package:flutter_food_app/page/user/info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
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

  void navigateToFilter(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterPage(1),),
    );
  }

  void navigateToPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
  }

  void navigateToSearch(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: new PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          MaterialApp(
            home: MyHomePage(this.navigateToPost, this.navigateToFilter, this.navigateToSearch),
            theme: ThemeData(fontFamily: 'Montserrat', pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),),
            debugShowCheckedModeBanner: false,
          ),
          Cart(),
          NotificationPage(),
          InfoPage(false),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorActive,
        child: const Icon(FontAwesomeIcons.cameraRetro),
        onPressed: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CameraPage(),),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                navigationTapped(0);
              },
              child: Container(
                color: Colors.white,
                height: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.home,
                      color: _index == 0 ? colorActive : Colors.grey,
                      size: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.0),
                      child: Text(
                        'Trang chủ',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            color: _index == 0 ? colorActive : Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 80.0),
              child: GestureDetector(
                onTap: () {
                  navigationTapped(1);
                },
                child: Stack(children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 56,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.shoppingCart,
                          color: _index == 1 ? colorActive : Colors.grey,
                          size: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2.0),
                          child: Text(
                            'Giỏ hàng',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: _index == 1 ? colorActive : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Positioned(
                    // draw a red marble
                    top: 4.0,
                    right: 10.0,
                    child: new Icon(Icons.brightness_1,
                        size: 11.0, color: Colors.red),
                  )
                ]),
              ),
            ),
            GestureDetector(
                onTap: () {
                  navigationTapped(2);
                },
                child: Stack(children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 56,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.solidBell,
                          color: _index == 2 ? colorActive : Colors.grey,
                          size: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2.0),
                          child: Text(
                            'Thông báo',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: _index == 2 ? colorActive : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Positioned(
                    // draw a red marble
                    top: 4.0,
                    right: 20.0,
                    child: new Icon(Icons.brightness_1,
                        size: 11.0, color: Colors.red),
                  )
                ]),
            ),
            GestureDetector(
              onTap: () {
                navigationTapped(3);
              },
              child: Stack(children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.userAlt,
                        color: _index == 3 ? colorActive : Colors.grey,
                        size: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2.0),
                        child: Text(
                          'Cá nhân',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              color: _index == 3   ? colorActive : Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                new Positioned(
                  // draw a red marble
                  top: 4.0,
                  right: 13.0,
                  child: new Icon(Icons.brightness_1,
                      size: 11.0, color: Colors.red),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
