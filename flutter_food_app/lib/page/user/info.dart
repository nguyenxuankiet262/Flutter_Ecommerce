import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/page/authentication/login/signin.dart';
import 'header.dart';
import 'settings/settings_another_user.dart';
import 'body.dart';
import 'package:badges/badges.dart';
import 'package:flutter_food_app/page/user/settings/settings_main_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/const/color_const.dart';

class InfoPage extends StatefulWidget {
  bool isAnother;

  InfoPage(this.isAnother);

  @override
  State<StatefulWidget> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin {
  bool isLogin = true;
  bool isFollow = false;
  ScrollController _hideButtonController;

  void Logining() {
    setState(() {
      isLogin = true;
    });
  }

  void Signouting() {
    setState(() {
      isLogin = false;
    });
  }

  void _showBottomSheetMainUser(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SettingsMain();
        });
  }

  void _showBottomSheetAnotherUser(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SettingsAnother();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        BlocProvider.of<BottomBarBloc>(context)
            .changeVisible(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        BlocProvider.of<BottomBarBloc>(context)
            .changeVisible(true);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hideButtonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !isLogin && !widget.isAnother
        ? Scaffold(
            appBar: AppBar(
              elevation: 0.5,
              brightness: Brightness.light,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                "Thông tin cá nhân",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            body: SigninContent(),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0.5,
              brightness: Brightness.light,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                widget.isAnother ? 'kiki123' : 'meow_meow',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              actions: !widget.isAnother
                  ? <Widget>[
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<FunctionBloc>(context).currentState.openDrawer();
                        },
                        child: BadgeIconButton(
                          itemCount: 2,
                          // required
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          // required
                          // default: Colors.red
                          badgeTextColor: Colors.white,
                          // default: Colors.white
                          hideZeroCount: true, // default: true
                        ),
                      ),
                    ]
                  : <Widget>[
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            child: Padding(
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                              padding: EdgeInsets.only(right: 10.0),
                            ),
                            onTap: () {
                              _showBottomSheetAnotherUser(context);
                            },
                          ),
                        ),
                      ),
                    ],
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: widget.isAnother
                      ? BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/dog.jpg'),
                          ),
                        )
                      : BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/cat.jpg'),
                          ),
                        ),
                ),
                ListView(
                  controller: !widget.isAnother ? _hideButtonController : null,
                  children: <Widget>[
                    Header(widget.isAnother),
                    Body(),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: widget.isAnother
                ? Container(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isFollow = !isFollow;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: colorActive, width: 1.5)),
                              child: Center(
                                child: Text(
                                  isFollow ? 'BỎ THEO DÕI' : 'THEO DÕI',
                                  style: TextStyle(
                                      color: colorActive,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0),
                                ),
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            color: colorActive,
                            child: Center(
                              child: Text(
                                'GỌI ĐIỆN NGƯỜI BÁN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0),
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  )
                : null);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
