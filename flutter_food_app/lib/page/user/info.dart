import 'package:flutter/material.dart';
import 'header.dart';
import 'settings_another_user.dart';
import 'body.dart';
import 'package:badges/badges.dart';
import 'settings_main_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/const/color_const.dart';

class InfoPage extends StatefulWidget {
  bool isAnother;
  Function navigateToPost, navigateToUser;

  InfoPage(this.isAnother);

  @override
  State<StatefulWidget> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin {
  bool isLogin = false;

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
          return SettingsMain(this.Signouting);
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return !isLogin && !widget.isAnother
        ? Scaffold(
            appBar: AppBar(
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
            body: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 30.0),
                    child: Icon(
                      FontAwesomeIcons.userLock,
                      size: 150,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: 200,
                    height: 40,
                    child: RaisedButton(
                      onPressed: () {
                        Logining();
                      },
                      child: Text(
                        "ĐĂNG NHẬP",
                        style: TextStyle(
                            fontFamily: "Ralway",
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      color: colorActive,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
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
                          _showBottomSheetMainUser(context);
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
                  children: <Widget>[
                    Header(widget.isAnother),
                    Body(),
                  ],
                ),
              ],
            ),
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
