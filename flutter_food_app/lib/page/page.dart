import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/grid_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/state/search_state.dart';
import 'package:flutter_food_app/const/animation_const.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/filter/filter.dart';
import 'package:flutter_food_app/page/home/home.dart';
import 'package:flutter_food_app/page/cart/cart.dart';
import 'package:flutter_food_app/page/location/location.dart';
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

  void navigateToFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterPage(1),
      ),
    );
  }

  void navigateToLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPage(),
      ),
    );
  }

  void navigateToPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (context, SearchState state) {
        return Scaffold(
            extendBody: true,
            backgroundColor: colorBackground,
            body: new PageView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                MaterialApp(
                  home: MyHomePage(this.navigateToPost, this.navigateToFilter, this.navigateToLocation),
                  theme: ThemeData(
                    fontFamily: 'Montserrat',
                  ),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Visibility(
              visible: !state.isSearch,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: const Icon(FontAwesomeIcons.cameraRetro, color: colorActive,),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraPage(),
                      ),
                    );
                  });
                },
              ),
            ),
            bottomNavigationBar: Visibility(
              visible: !state.isSearch,
              child: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 8.0,
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
                                    color: _index == 0
                                        ? colorActive
                                        : Colors.grey),
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
                                  color:
                                      _index == 1 ? colorActive : Colors.grey,
                                  size: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    'Giỏ hàng',
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        color: _index == 1
                                            ? colorActive
                                            : Colors.grey),
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
                                      color: _index == 2
                                          ? colorActive
                                          : Colors.grey),
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
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _index == 3
                                            ? colorActive
                                            : colorInactive,
                                        width: _index == 3 ? 2.0 : 2.0),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100.0))),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/cat.jpg',
                                    fit: BoxFit.cover,
                                    width: 21.0,
                                    height: 21.0,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                color: Colors.white,
                                child: Text(
                                  "Cá nhân",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 3.0,
                          bottom: 9.3,
                          child: Text(
                            'Cá nhân',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: _index == 3 ? colorActive : Colors.grey),
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
            ));
      },
    );
  }
}