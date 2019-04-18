import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/state/bottom_bar_state.dart';
import 'package:flutter_food_app/common/state/search_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/filter/filter.dart';
import 'package:flutter_food_app/page/home/home.dart';
import 'package:flutter_food_app/page/cart/cart.dart';
import 'package:flutter_food_app/page/location/location.dart';
import 'package:flutter_food_app/page/notification/notification.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:flutter_food_app/page/user/info.dart';
import 'package:flutter_food_app/page/user/settings/settings_main_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> with SingleTickerProviderStateMixin{
  int _index = 0;
  bool _isVisible = true;
  PageController _pageController;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
    BlocProvider.of<FunctionBloc>(context).openDrawer(_openDrawer);
    BlocProvider.of<FunctionBloc>(context).navigateToPost(navigateToPost);
    BlocProvider.of<FunctionBloc>(context).navigateToFilter(navigateToFilter);
    BlocProvider.of<FunctionBloc>(context).navigateToUser(navigateToUser);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _controller.dispose();
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

  void navigateToUser(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoPage(true)),
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

  void _openDrawer(){
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (context, SearchState state) {
        return Scaffold(
          key: _scaffoldKey,
          extendBody: true,
          endDrawer: SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: new Drawer(
                child: SettingsMain()
            ),
          ),
          backgroundColor: colorBackground,
          body: new PageView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              MaterialApp(
                home: MyHomePage(this.navigateToPost, this.navigateToFilter,
                    this.navigateToLocation),
                theme: ThemeData(
                  fontFamily: 'Montserrat',
                ),
                debugShowCheckedModeBanner: false,
              ),
              MaterialApp(
                home: Cart(),
                theme: ThemeData(
                  fontFamily: 'Montserrat',
                ),
                debugShowCheckedModeBanner: false,
              ),
              MaterialApp(
                home: NotificationPage(),
                theme: ThemeData(
                  fontFamily: 'Montserrat',
                ),
                debugShowCheckedModeBanner: false,
              ),
              MaterialApp(
                home: InfoPage(false),
                theme: ThemeData(
                  fontFamily: 'Montserrat',
                ),
                debugShowCheckedModeBanner: false,
              ),
            ],
            onPageChanged: onPageChanged,
            controller: _pageController,
          ),
          resizeToAvoidBottomPadding: false,
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: BlocBuilder(
            bloc: BlocProvider.of<BottomBarBloc>(context),
            builder: (context, BottomBarState bottombarstate) {
              bottombarstate.isVisible ? _controller.forward() : _controller.reverse();
              return Visibility(
                  visible: !state.isSearch,
                  child: SlideTransition(
                      position: _offsetFloat,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(
                          FontAwesomeIcons.cameraRetro,
                          color: colorActive,
                        ),
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
                      )));
            },
          ),
          bottomNavigationBar: BlocBuilder(
            bloc: BlocProvider.of<BottomBarBloc>(context),
            builder: (context, BottomBarState bottombarstate) {
              bottombarstate.isVisible ? _controller.forward() : _controller.reverse();
              return SlideTransition(
                  position: _offsetFloat,
                  child: Visibility(
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
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            child: Container(
                              color: Colors.white,
                              height: 56,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.home,
                                    color:
                                    _index == 0 ? colorActive : Colors.grey,
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
                                        color: _index == 1
                                            ? colorActive
                                            : Colors.grey,
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
                                      color: _index == 2
                                          ? colorActive
                                          : Colors.grey,
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
                                      color: _index == 3
                                          ? colorActive
                                          : Colors.grey),
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
          ),
        );
      },
    );
  }
}
