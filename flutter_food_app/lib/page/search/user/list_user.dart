import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'user_item.dart';

class ListUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) => UserItem(index),
      ),
    );
  }
}

