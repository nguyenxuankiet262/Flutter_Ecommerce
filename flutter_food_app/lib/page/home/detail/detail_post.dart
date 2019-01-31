import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';

class DetailPost extends StatefulWidget {
  String title = "";
  DetailPost({Key key, @required this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Text('hahaa'),
    );
  }
}