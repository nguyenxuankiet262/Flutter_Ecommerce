import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

class HeaderFeedback extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderFeedbackState();
}

class HeaderFeedbackState extends State<HeaderFeedback> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _index = 0;
                  });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: _index != 0 ? Colors.white : colorActive,
                      border: Border.all(
                          color: _index != 0 ? colorInactive : colorActive,
                          width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: Center(
                    child: Text(
                      "Lỗi phần mềm",
                      style: TextStyle(
                        color: _index != 0 ? colorInactive : Colors.white,
                          fontFamily: "Ralway",
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
              flex: 1,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    _index = 1;
                  });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: _index != 1 ? Colors.white : colorActive,
                      border: Border.all(
                          color: _index != 1 ? colorInactive : colorActive,
                          width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: Center(
                    child: Text(
                      "Đề xuất",
                      style: TextStyle(
                        color: _index != 1 ? colorInactive : Colors.white,
                        fontFamily: "Ralway",
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
              flex: 1,
            ),
          ],
        ));
  }
}
