import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'slider.dart';
import 'post.dart';
import 'header.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                HeaderHome(),
                Padding(
                  child: Text(
                    'Anzi mang đến những thức phẩm tốt nhất!',
                    style: TextStyle(
                      color: colorText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                CarouselWithIndicator(),
                ListPost(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
