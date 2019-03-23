import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/const/color_const.dart';

List<String> options = [
  'Tin mới',
  'Giá thấp trước',
  'Yêu thích nhiều nhất',
  'Giảm giá nhiều nhất'
];

List<Icon> optionsIcon = [
  Icon(
    FontAwesomeIcons.clock,
    color: Colors.black,
  ),
  Icon(
    FontAwesomeIcons.dollarSign,
    color: Colors.blue,
  ),
  Icon(
    FontAwesomeIcons.heart,
    color: Colors.red,
  ),
  Icon(
    FontAwesomeIcons.longArrowAltDown,
    color: Colors.green,
  ),
];

class SortMode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SortModeState();
}

class SortModeState extends State<SortMode>{
  int indexFilter = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 240,
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
              "SẮP XẾP THEO",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 180,
            child: ListView.builder(
              itemCount: options.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
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
                            optionsIcon[index],
                            Container(
                              margin:
                              EdgeInsets.only(left: 15.0),
                              child: Text(options[index]),
                            ),
                          ],
                        ),
                        index == indexFilter
                            ? Icon(Icons.radio_button_checked)
                            : Icon(
                            Icons.radio_button_unchecked),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        indexFilter = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}