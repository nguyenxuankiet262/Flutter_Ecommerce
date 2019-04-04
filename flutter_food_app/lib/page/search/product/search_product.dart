import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'list_search_post.dart';

class SearchProduct extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SearchProductState();
}

class SearchProductState extends State<SearchProduct>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding:
              EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Text(
                "Tìm thấy 10 kết quả",
                style: TextStyle(
                  color: colorInactive,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16.0),
              child: ListSearchPost(),
            )
          ],
        ));
  }
}