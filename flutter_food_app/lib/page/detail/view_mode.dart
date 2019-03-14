import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/const/color_const.dart';

class ViewMode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ViewModeState();
}

class ViewModeState extends State<ViewMode>{
  int indexView = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 150,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: colorGrey.withOpacity(0.5),
                border: Border(
                    top: BorderSide(
                        color: Colors.grey.withOpacity(0.5)),
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5)))),
            child: Text(
              "CHẾ ĐỘ XEM",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: 10.0,
                right: 20.0,
                left: 15.0,
                bottom: 10.0),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.listAlt),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text("Hình và chữ"),
                      ),
                    ],
                  ),
                  indexView == 1
                      ? Icon(Icons.radio_button_checked)
                      : Icon(Icons.radio_button_unchecked)
                ],
              ),
              onTap: () {
                setState(() {
                  indexView = 1;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: 10.0,
                right: 20.0,
                left: 15.0,
                bottom: 10.0),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.gripVertical),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text("Lưới"),
                      ),
                    ],
                  ),
                  indexView == 2
                      ? Icon(Icons.radio_button_checked)
                      : Icon(Icons.radio_button_unchecked)
                ],
              ),
              onTap: () {
                setState(() {
                  indexView = 2;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

}