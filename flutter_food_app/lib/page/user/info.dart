import 'package:flutter/material.dart';
import 'header.dart';
import 'settings_another_user.dart';
import 'body.dart';
import 'package:badges/badges.dart';
import 'settings_main_user.dart';

class InfoPage extends StatefulWidget {
  bool isAnother;

  InfoPage(this.isAnother);

  @override
  State<StatefulWidget> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin {
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
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
            decoration: const BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: const AssetImage('assets/images/cat.jpg'),
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
