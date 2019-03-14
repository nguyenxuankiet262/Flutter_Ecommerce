import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoItemState();
}

class InfoItemState extends State<InfoItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colorInactive, width: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.userTie,
                          size: 19,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Thông tin",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Mình bắt chước loài mèo kêu nha\nKêu cùng anh méo meo meo meo\nEm chỉ muốn ôm anh nhõng nhẽo\nAizo meo meo meo meo mèo",
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            )),
        Container(
            height: 50,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colorInactive, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.home,
                      size: 19,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Địa chỉ",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "TP. Hồ Chí Minh",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            )),
        Container(
            height: 50,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colorInactive, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.mobileAlt,
                      size: 19,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Điện thoại",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "+ 84 123 456 789",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ))
      ],
    );
  }
}
