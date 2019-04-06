import 'package:flutter/material.dart';
import 'package:flutter_food_app/page/search/hotkey.dart';
import 'list_post.dart';

class ProductContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
              child: Text(
                "TỪ KHÓA HOT",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            HotkeyContent(1),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                "GỢI Ý",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 16.0),
              child: ListPost(),
            )
          ],
        ));
  }
}
