import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        height: 115,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Container(
                    width: 50,
                    height: 2,
                    color: colorInactive,
                  ),
                )),
            Container(
                padding: EdgeInsets.all(15.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.2))),
                child: Center(
                  child: Text(
                    'Báo cáo',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.2))),
              child: Center(
                child: Text(
                  'Đánh giá',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
