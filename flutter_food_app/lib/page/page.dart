import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/state/bottom_bar_state.dart';
import 'package:flutter_food_app/common/state/search_state.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/authentication/authentication.dart';
import 'package:flutter_food_app/page/camera/info/info.dart';
import 'package:flutter_food_app/page/filter/filter.dart';
import 'package:flutter_food_app/page/home/home.dart';
import 'package:flutter_food_app/page/cart/cart.dart';
import 'package:flutter_food_app/page/location/location.dart';
import 'package:flutter_food_app/page/notification/notification.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:flutter_food_app/page/user/follow/follow.dart';
import 'package:flutter_food_app/page/user/info.dart';
import 'package:flutter_food_app/page/user/settings/settings_main_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage>
    with SingleTickerProviderStateMixin {
  FocusScopeNode focusScope;
  int _index = 0;
  bool _isVisible = true;
  PageController _pageController;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;
  FunctionBloc functionBloc;
  UserBloc userBloc;
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  void initState() {
    super.initState();
    focusScope = FocusScopeNode();
    _pageController = new PageController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 2), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
    userBloc = BlocProvider.of<UserBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    functionBloc.openDrawer(_openDrawer);
    functionBloc.navigateToPost(_navigateToPost);
    functionBloc.navigateToFilter(_navigateToFilter);
    functionBloc.navigateToUser(_navigateToUser);
    functionBloc.navigateToFollow(_navigateToFollow);
    functionBloc.navigateToAuthen(_navigateToAuthen);
    functionBloc.navigateToCamera(_navigateToCamera);
    functionBloc.navigateToInfoPost(_navigateToInfoPost);
  }

  @override
  void dispose() {
    super.dispose();
    focusScope.detach();
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

  void _navigateToFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterPage(1),
      ),
    );
  }

  void _navigateToFollow(int _value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FollowPage(
              value: _value,
            ),
      ),
    );
  }

  void _navigateToUser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoPage(true)),
    );
  }

  void _navigateToLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPage(),
      ),
    );
  }

  void _navigateToAuthen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AuthenticationPage(0)));
  }

  void _navigateToPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
  }

  void _openDrawer() {
    _innerDrawerKey.currentState.open();
  }

  void _navigateToCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPage(),
      ),
    );
  }

  void _navigateToInfoPost() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InfoPost(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).setFirstFocus(focusScope);
    return BlocBuilder(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (context, SearchState state) {
        return BlocBuilder(
          bloc: userBloc,
          builder: (context, UserState userstate) {
            return InnerDrawer(
                key: _innerDrawerKey,
                child: Material(
                  child: SettingsMain(),
                ),
                position: InnerDrawerPosition.end,
                animationType: InnerDrawerAnimation.quadratic,
                swipe: userstate.isLogin ? true : false,
                onTapClose: true,
                offset: 0.6,
                scaffold: Scaffold(
                  extendBody: true,
                  backgroundColor: colorBackground,
                  body: new PageView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      FocusScope(
                        node: focusScope,
                        child: MaterialApp(
                          home: MyHomePage(this._navigateToPost,
                              this._navigateToFilter, this._navigateToLocation),
                          theme: ThemeData(
                            fontFamily: 'Montserrat',
                          ),
                          debugShowCheckedModeBanner: false,
                        ),
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
                      bottombarstate.isVisible
                          ? _controller.forward()
                          : _controller.reverse();
                      return Visibility(
                          visible: !state.isSearch,
                          child: SlideTransition(
                              position: _offsetFloat,
                              child: FloatingActionButton.extended(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  if (userBloc.currentState.isLogin) {
                                    _navigateToInfoPost();
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AuthenticationPage(1)));
                                  }
                                },
                                icon: Icon(
                                  FontAwesomeIcons.plus,
                                  color: colorActive,
                                  size: 15,
                                ),
                                label: Text(
                                  "BÁN",
                                  style: TextStyle(
                                    color: colorActive,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                  ),
                                ),
                              )));
                    },
                  ),
                  bottomNavigationBar: BlocBuilder(
                    bloc: BlocProvider.of<BottomBarBloc>(context),
                    builder: (context, BottomBarState bottombarstate) {
                      bottombarstate.isVisible
                          ? _controller.forward()
                          : _controller.reverse();
                      return SlideTransition(
                          position: _offsetFloat,
                          child: Visibility(
                            visible: !state.isSearch,
                            child: BottomAppBar(
                              shape: CircularNotchedRectangle(),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      navigationTapped(0);
                                      FocusScope.of(context)
                                          .setFirstFocus(focusScope);
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: 56,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.home,
                                            color: _index == 0
                                                ? colorActive
                                                : Colors.grey,
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
                                    padding: EdgeInsets.only(right: 100.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        navigationTapped(1);
                                      },
                                      child: Stack(children: <Widget>[
                                        Container(
                                          color: Colors.white,
                                          height: 56,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.shoppingCart,
                                                color: _index == 1
                                                    ? colorActive
                                                    : Colors.grey,
                                                size: 20,
                                              ),
                                              Container(
                                                margin:
                                                EdgeInsets.only(top: 2.0),
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
                                        height: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        top: 1.0,
                                        right: 21.0,
                                        child: new Icon(Icons.brightness_1,
                                            size: 11.0, color: Colors.red),
                                      )
                                    ]),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      navigationTapped(3);
                                    },
                                    child: userstate.isLogin
                                        ? Stack(children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        height: 56,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: _index == 3
                                                          ? colorActive
                                                          : colorInactive,
                                                      width: _index == 3
                                                          ? 2.0
                                                          : 2.0),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          100.0))),
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
                                                style: TextStyle(
                                                    color: Colors.white),
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
                                        child: new Icon(
                                            Icons.brightness_1,
                                            size: 11.0,
                                            color: Colors.red),
                                      )
                                    ])
                                        : Container(
                                      color: Colors.white,
                                      height: 56,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.userAlt,
                                            color: _index == 3
                                                ? colorActive
                                                : Colors.grey,
                                            size: 20,
                                          ),
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              'Cá nhân',
                                              style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  color: _index == 3
                                                      ? colorActive
                                                      : Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ));
          },
        );
      },
    );
  }
}
