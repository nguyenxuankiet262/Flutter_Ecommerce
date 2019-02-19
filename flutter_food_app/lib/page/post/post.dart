import 'package:flutter/material.dart';
import 'slider.dart';
import 'body.dart';
import 'rating.dart';
import 'relative_post.dart';
import 'settings/settings.dart';
import 'package:flutter_food_app/const/color_const.dart';

class Post extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostState();
}

class PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          'Bánh tiramisu thơm ngon đây cả nhà ơi',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            tooltip: 'Tùy chỉnh',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPost()));
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          CarouselWithIndicator(),
          PostBody(),
          CommentPost(),
          RelativePost(),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          margin: EdgeInsets.all(5.0),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: colorActive,
              border: Border.all(
                color: colorActive,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              )),
          child: Center(
            child: Text(
              'Nhắn tin người đăng',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        onTap: () {
          print('Tap');
        },
      ),
    );
  }
}
