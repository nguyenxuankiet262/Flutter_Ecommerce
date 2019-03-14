import 'package:flutter/material.dart';
import 'follow_item.dart';

class ListFollow extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ListFollowState();
}

class ListFollowState extends State<ListFollow>{
  int itemCount = 15;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 15.0, left: 15.0),
      child: ListView.builder(
        itemCount: itemCount,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => FollowItem(index),
      ),
    );
  }
}