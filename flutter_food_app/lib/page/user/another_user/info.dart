import 'package:flutter/material.dart';
import 'header.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/another_user/body.dart';
import 'settings.dart';

class InfoUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoUserPageState();
}

class InfoUserPageState extends State<InfoUserPage>
    with AutomaticKeepAliveClientMixin {
  void _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Settings();
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          'kiki123',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        actions: <Widget>[
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
                  _showBottomSheet(context);
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
                image: const AssetImage('assets/images/dog.jpg'),
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
