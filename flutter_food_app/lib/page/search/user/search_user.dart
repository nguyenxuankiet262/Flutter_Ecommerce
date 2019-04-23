import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'list_search_user.dart';

class SearchUser extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SearchUserState();
}

class SearchUserState extends State<SearchUser>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              padding:
              EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Text(
                "Tìm thấy 20 kết quả",
                style: TextStyle(
                  color: colorInactive,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListSearchUser(),
          ],
        ));
  }
}