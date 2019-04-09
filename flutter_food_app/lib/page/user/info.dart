import 'package:flutter/material.dart';
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
  Function navigateToPost, navigateToUser;

  InfoPage(this.isAnother);

  @override
  State<StatefulWidget> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin {
  bool isLogin = true;

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
