import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
class HotkeyContent extends StatefulWidget{
  int index;
  HotkeyContent(this.index);
  @override
  State<StatefulWidget> createState() => HotkeyContentState();
}

class HotkeyContentState extends State<HotkeyContent>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 5.0, top: 5.0),
      child: new Wrap(
        spacing: 16.0, // gap betwee// n adjacent chipsbetween lines
        children: new List.generate(widget.index == 1 ? hotkeys.length : hotUsers.length, (index) {
          return Chip(
            backgroundColor: colorActive,
            label: Text(
              widget.index == 1 ? hotkeys[index] : hotUsers[index],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                fontFamily: "Ralway"
              ),
            )
          );
        })
      )
    );
  }
}