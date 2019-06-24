import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/helper/my_behavior.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/bottom_bar_state.dart';
import 'package:flutter_food_app/common/state/search_state.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/admin/admin_page.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:flutter_food_app/page/authentication/authentication.dart';
import 'package:flutter_food_app/page/camera/info/info.dart';
import 'package:flutter_food_app/page/filter/common/filter.dart';
import 'package:flutter_food_app/page/filter/location//filter.dart';
import 'package:flutter_food_app/page/home/home.dart';
import 'package:flutter_food_app/page/cart/cart.dart';
import 'package:flutter_food_app/page/location/location.dart';
import 'package:flutter_food_app/page/notification/notification.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:flutter_food_app/page/user/follow/follow.dart';
import 'package:flutter_food_app/page/user/info.dart';
import 'package:flutter_food_app/page/user/settings/main/order_manage/order_detail/order_detail.dart';
import 'package:flutter_food_app/page/user/settings/settings_main_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:toast/toast.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  FocusScopeNode focusScope;
  int _index = 0;
  PageController _pageController;
  AnimationController _controller;
  AnimationController _notiController;
  Animation<Offset> _offsetFloat;
  FunctionBloc functionBloc;
  LoadingBloc loadingBloc;
  UserBloc userBloc;
  ApiBloc apiBloc;
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    userBloc = BlocProvider.of<UserBloc>(context);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        await updateNewestSystemNotice(
            apiBloc, loadingBloc, apiBloc.currentState.mainUser.id);
        if (message['notification']['title'] == "Cập nhật đơn hàng") {
          String body = message['notification']['body'];
          if (body.contains("mới")) {
            User user = apiBloc.currentState.mainUser;
            user.badge.buy++;
            apiBloc.changeMainUser(user);
          }
        } else if (message['notification']['title'] == "Đơn hàng mới") {
          User user = apiBloc.currentState.mainUser;
          user.badge.sell++;
          apiBloc.changeMainUser(user);
        }
        _notiController.forward(from: 0.0);
        Timer.periodic(Duration(seconds: 2), (timer) {
          _timer = timer;
          _notiController.forward(from: 0.0);
        });
      },
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {
        await updateNewestSystemNotice(
            apiBloc, loadingBloc, apiBloc.currentState.mainUser.id);
        if (message['notification']['title'] == "Cập nhật đơn hàng") {
          String body = message['notification']['body'];
          if (body.contains("mới")) {
            User user = apiBloc.currentState.mainUser;
            user.badge.buy++;
            apiBloc.changeMainUser(user);
          }
        } else if (message['notification']['title'] == "Đơn hàng mới") {
          User user = apiBloc.currentState.mainUser;
          user.badge.sell++;
          apiBloc.changeMainUser(user);
        }
        _notiController.forward(from: 0.0);
        Timer.periodic(Duration(seconds: 2), (timer) {
          _timer = timer;
          _notiController.forward(from: 0.0);
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    if (userBloc.currentState.isLogin) {
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        updateToken(apiBloc.currentState.mainUser.id, newToken);
      });
    }
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
    apiBloc = BlocProvider.of<ApiBloc>(context);
    functionBloc.openDrawer(_openDrawer);
    functionBloc.navigateToPost(_navigateToPost);
    functionBloc.navigateToFilter(_navigateToFilter);
    functionBloc.navigateToUser(_navigateToUser);
    functionBloc.navigateToFollow(_navigateToFollow);
    functionBloc.navigateToAuthen(_navigateToAuthen);
    functionBloc.navigateToCamera(_navigateToCamera);
    functionBloc.navigateToInfoPost(_navigateToInfoPost);
    functionBloc.navigateToFilterHome(_navigateToFilterDetail);
    functionBloc.navigateToDetailOrder(_navigateToDetailOrder);
    (() async {
      if (await Helper().check()) {
      } else {
        new Future.delayed(const Duration(seconds: 1), () {
          Toast.show("Vui lòng kiểm tra mạng!", context,
              gravity: Toast.CENTER, backgroundColor: Colors.black87);
        });
      }
    })();
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
        builder: (context) => FilterPage(),
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

  void _navigateToFilterDetail() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FilterDetailManagement()));
  }

  void _navigateToUser(String idUser) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoAnotherPage(idUser)),
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthenticationPage()));
  }

  void _navigateToPost(String idPost) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Post(idPost)));
  }

  void _navigateToDetailOrder(
      String idUser, int index, String idOrder, bool isSeller) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OrderDetail(idUser, index, idOrder, isSeller)));
  }

  void _openDrawer() {
    _innerDrawerKey.currentState.open();
  }

  void _navigateToCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPage(1),
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
    super.build(context);
    return WillPopScope(
        child: BlocBuilder(
          bloc: BlocProvider.of<SearchBloc>(context),
          builder: (context, SearchState state) {
            return BlocBuilder(
              bloc: userBloc,
              builder: (context, UserState userstate) {
                return Stack(
                  children: <Widget>[
                    InnerDrawer(
                        key: _innerDrawerKey,
                        child: Material(
                          child: SettingsMain(),
                        ),
                        position: InnerDrawerPosition.end,
                        animationType: InnerDrawerAnimation.quadratic,
                        swipe: userstate.isLogin
                            ? state.isSearch ? false : true
                            : false,
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
                                  home: MyHomePage(
                                      this._navigateToPost,
                                      this._navigateToFilter,
                                      this._navigateToLocation),
                                  builder: (context, child) {
                                    return ScrollConfiguration(
                                      behavior: MyBehavior(),
                                      child: child,
                                    );
                                  },
                                  theme: ThemeData(
                                    fontFamily: 'Montserrat',
                                  ),
                                  debugShowCheckedModeBanner: false,
                                ),
                              ),
                              MaterialApp(
                                home: CartPage(),
                                builder: (context, child) {
                                  return ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: child,
                                  );
                                },
                                theme: ThemeData(
                                  fontFamily: 'Montserrat',
                                ),
                                debugShowCheckedModeBanner: false,
                              ),
                              MaterialApp(
                                home: NotificationPage(),
                                builder: (context, child) {
                                  return ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: child,
                                  );
                                },
                                theme: ThemeData(
                                  fontFamily: 'Montserrat',
                                ),
                                debugShowCheckedModeBanner: false,
                              ),
                              MaterialApp(
                                home: InfoPage(),
                                builder: (context, child) {
                                  return ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: child,
                                  );
                                },
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
                              return BlocBuilder(
                                bloc: apiBloc,
                                builder: (context, ApiState apiState) {
                                  return Visibility(
                                      visible: !state.isSearch,
                                      child: SlideTransition(
                                          position: _offsetFloat,
                                          child: FloatingActionButton.extended(
                                            backgroundColor: Colors.white,
                                            onPressed: () {
                                              if (userBloc
                                                  .currentState.isLogin) {
                                                if (apiState
                                                    .listMenu.isNotEmpty) {
                                                  _navigateToInfoPost();
                                                } else {
                                                  new Future.delayed(
                                                      const Duration(
                                                          seconds: 1), () {
                                                    Toast.show(
                                                        "Vui lòng kiểm tra mạng!",
                                                        context,
                                                        gravity: Toast.CENTER,
                                                        backgroundColor:
                                                            Colors.black87);
                                                  });
                                                }
                                              } else {
                                                functionBloc.onBeforeLogin(() {
                                                  _navigateToInfoPost();
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AuthenticationPage()));
                                              }
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.camera,
                                              color: colorActive,
                                              size: 15,
                                            ),
                                            label: Text(
                                              "BÁN",
                                              style: TextStyle(
                                                  color: colorActive,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          )));
                                },
                              );
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
                                      notchMargin: 8.0,
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              navigationTapped(0);
                                              FocusScope.of(context)
                                                  .setFirstFocus(focusScope);
                                            },
                                            child: Container(
                                              color: Colors.white,
                                              height: 50,
                                              width: 50,
                                              child: Icon(
                                                _index == 0
                                                    ? const IconData(0xe901,
                                                        fontFamily: 'find')
                                                    : const IconData(0xe900,
                                                        fontFamily: 'find'),
                                                color: _index == 0
                                                    ? colorActive
                                                    : colorIconBottomBar,
                                                size: 24.5,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 120.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                navigationTapped(1);
                                              },
                                              child: Stack(children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  color: Colors.white,
                                                  child: Icon(
                                                    _index == 1
                                                        ? const IconData(0xe900,
                                                            fontFamily: 'cart')
                                                        : const IconData(0xe917,
                                                            fontFamily: 'cart'),
                                                    color: _index == 1
                                                        ? colorActive
                                                        : colorIconBottomBar,
                                                    size: 27,
                                                  ),
                                                ),
                                                BlocBuilder(
                                                  bloc: apiBloc,
                                                  builder: (context,
                                                      ApiState apiState) {
                                                    return !userstate.isLogin ||
                                                            apiState.cart ==
                                                                null
                                                        ? Container(
                                                            height: 0,
                                                            width: 0,
                                                          )
                                                        : apiState.cart.products
                                                                .isEmpty
                                                            ? Container(
                                                                height: 0,
                                                                width: 0,
                                                              )
                                                            : new Positioned(
                                                                // draw a red marble
                                                                top: 5.0,
                                                                right: 5,
                                                                child:
                                                                    Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                1),
                                                                        decoration:
                                                                            new BoxDecoration(
                                                                          color:
                                                                              Colors.red,
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          minWidth:
                                                                              18,
                                                                          minHeight:
                                                                              18,
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              new Text(
                                                                            apiState.cart.products.length > 20
                                                                                ? " 20+ "
                                                                                : apiState.cart.products.length.toString(),
                                                                            style:
                                                                                new TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 9,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        )));
                                                  },
                                                )
                                              ]),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (_timer != null) {
                                                _timer.cancel();
                                              }
                                              navigationTapped(2);
                                            },
                                            child: Stack(children: <Widget>[
                                              Container(
                                                height: 50,
                                                width: 50,
                                                color: Colors.white,
                                                child: Icon(
                                                  _index == 2
                                                      ? const IconData(0xe900,
                                                          fontFamily:
                                                              'notification')
                                                      : const IconData(0xe935,
                                                          fontFamily:
                                                              'notification'),
                                                  color: _index == 2
                                                      ? colorActive
                                                      : colorIconBottomBar,
                                                  size: 23,
                                                ),
                                              ),
                                              BlocBuilder(
                                                bloc: apiBloc,
                                                builder: (context,
                                                    ApiState apiState) {
                                                  return !userstate.isLogin ||
                                                          apiState.mainUser ==
                                                              null
                                                      ? Container(
                                                          height: 0,
                                                          width: 0,
                                                        )
                                                      : apiState.mainUser
                                                                      .amountSystemNotice +
                                                                  apiState
                                                                      .mainUser
                                                                      .amountFollowNotice ==
                                                              0
                                                          ? Container(
                                                              height: 0,
                                                              width: 0,
                                                            )
                                                          : new Positioned(
                                                              // draw a red marble
                                                              top: 5.0,
                                                              right: 5,
                                                              child:
                                                                  PimpedButton(
                                                                particle:
                                                                    DemoParticle(),
                                                                pimpedWidgetBuilder:
                                                                    (context,
                                                                        controller) {
                                                                  _notiController =
                                                                      controller;
                                                                  return Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              1),
                                                                      decoration:
                                                                          new BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                      ),
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        minWidth:
                                                                            18,
                                                                        minHeight:
                                                                            18,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            new Text(
                                                                          (apiState.mainUser.amountSystemNotice + apiState.mainUser.amountFollowNotice) > 20
                                                                              ? " 20+ "
                                                                              : (apiState.mainUser.amountSystemNotice + apiState.mainUser.amountFollowNotice).toString(),
                                                                          style:
                                                                              new TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                9,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ));
                                                                },
                                                              ));
                                                },
                                              )
                                            ]),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              navigationTapped(3);
                                            },
                                            child: userstate.isLogin
                                                ? BlocBuilder(
                                                    bloc: apiBloc,
                                                    builder: (context,
                                                        ApiState apiState) {
                                                      return Stack(
                                                          children: <Widget>[
                                                            Container(
                                                              color:
                                                                  Colors.white,
                                                              height: 50,
                                                              width: 50,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              color: _index == 3
                                                                                  ? colorActive
                                                                                  : colorIconBottomBar,
                                                                              width:
                                                                                  1.5),
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              100.0))),
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.white, width: 1.5),
                                                                            borderRadius: BorderRadius.all(Radius.circular(100.0))),
                                                                        child: apiBloc.currentState.mainUser ==
                                                                                null
                                                                            ? Container(
                                                                                height: 22,
                                                                                width: 22,
                                                                              )
                                                                            : ClipOval(
                                                                                child: Image.network(
                                                                                  apiState.mainUser.avatar,
                                                                                  fit: BoxFit.cover,
                                                                                  width: 22.0,
                                                                                  height: 22.0,
                                                                                ),
                                                                              ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ]);
                                                    },
                                                  )
                                                : Container(
                                                    color: Colors.white,
                                                    height: 50,
                                                    width: 50,
                                                    child: Icon(
                                                      _index == 3
                                                          ? const IconData(
                                                              0xe900,
                                                              fontFamily:
                                                                  'user')
                                                          : const IconData(
                                                              0xe901,
                                                              fontFamily:
                                                                  'user'),
                                                      color: _index == 3
                                                          ? colorActive
                                                          : colorIconBottomBar,
                                                      size: 27,
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        )),
                    Visibility(
                      maintainState: false,
                      child: AdminPage(),
                      visible: userstate.isAdmin ? true : false,
                    )
                  ],
                );
              },
            );
          },
        ),
        onWillPop: () {
          if (!userBloc.currentState.isAdmin) {
            functionBloc.currentState.onBackPressed();
          }
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
