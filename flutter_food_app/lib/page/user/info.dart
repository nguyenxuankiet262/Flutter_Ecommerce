import 'package:flutter/material.dart';
import 'header.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'body.dart';
import 'package:badges/badges.dart';
import 'package:flutter_food_app/page/user/settings.dart';

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin {
  void _showBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Settings();
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          'meow_meow',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              _showBottomSheet(context);
            },
            child: BadgeIconButton(
              itemCount: 2,
              // required
              icon: Icon(Icons.menu, color: Colors.black,),
              // required
              // default: Colors.red
              badgeTextColor: Colors.white,
              // default: Colors.white
              hideZeroCount: true, // default: true
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
              Header(),
              Container(
                height: 1,
                color: colorInactive,
              ),
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