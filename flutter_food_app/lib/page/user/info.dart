import 'package:flutter/material.dart';
import 'header.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'body.dart';
import 'package:badges/badges.dart';

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          'xuankiet262',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          BadgeIconButton(
            itemCount: 2,
            // required
            icon: Icon(Icons.send, color: Colors.black,),
            // required
            // default: Colors.red
            badgeTextColor: Colors.white,
            // default: Colors.white
            hideZeroCount: true, // default: true
          ),
        ],
        leading: GestureDetector(
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
              onTap: () {},
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Header(),
          Container(
            height: 1,
            color: colorInactive,
          ),
          Body(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}