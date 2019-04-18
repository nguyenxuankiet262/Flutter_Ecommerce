import 'package:flutter/material.dart';
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
      shrinkWrap: true,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(15.0),
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
                          size: 14,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Thông tin",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Mình bắt chước loài mèo kêu nha\nKêu cùng anh méo meo meo meo\nEm chỉ muốn ôm anh nhõng nhẽo\nAizo meo meo meo meo mèo",
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.home,
                        size: 14,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Địa chỉ",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "TP. Hồ Chí Minh",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Raleway',
                  ),
                ),
                Container(
                  height: 200,
                  color: Colors.white,
                )
              ],
            )),
      ],
    );
  }
}
