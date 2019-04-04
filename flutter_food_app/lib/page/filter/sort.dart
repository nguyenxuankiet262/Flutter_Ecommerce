import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SortContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SortContentState();
}

class SortContentState extends State<SortContent> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "SẮP XẾP THEO",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
                itemCount: listSort.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = index;
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 12.0),
                                    child: listIconSort[index],
                                  ),
                                  Text(
                                    listSort[index],
                                  ),
                                ],
                              ),
                              _index == index
                                  ? Icon(
                                      FontAwesomeIcons.solidDotCircle,
                                      size: 15,
                                      color: colorActive,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidCircle,
                                      size: 15,
                                      color: colorInactive.withOpacity(0.3),
                                    )
                            ],
                          ),
                        )))
          ],
        ));
  }
}
