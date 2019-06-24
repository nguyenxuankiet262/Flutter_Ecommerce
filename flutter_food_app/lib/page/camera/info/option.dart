import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionDialog extends StatefulWidget{
  OptionDialog({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => OptionStateDialog();
}

class OptionStateDialog extends State<OptionDialog>{
  int _index = 0;
  TextEditingController controller;
  FocusNode myFocusNode;
  String text = optionsUnit[0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TextEditingController();
    myFocusNode = FocusNode();
    controller.addListener(_changeText);
  }

  _changeText(){
    setState(() {
      text = controller.text;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        shrinkWrap: true,
        itemCount: optionsUnit.length + 1,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: index == 0 ? 0 : index == optionsUnit.length ? 6 : 16.0),
            child: index != optionsUnit.length
            ? RadioItem(
              index == _index ? true : false,
              optionsUnit[index],
            )
            : Container(
              color: Colors.white,
              height: 40,
              child: Row(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(right: 16),
                    height: 24.0,
                    width: 24.0,
                    child: new Center(
                      child: _index  == optionsUnit.length
                          ? Icon(
                        FontAwesomeIcons.solidDotCircle,
                        size: 20,
                        color: colorActive,
                      )
                          : Icon(
                        FontAwesomeIcons.solidCircle,
                        size: 20,
                        color: colorInactive.withOpacity(0.3),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: controller,
                      focusNode: myFocusNode,
                      onTap: (){
                        setState(() {
                          _index = optionsUnit.length;
                        });
                      },
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterStyle: TextStyle(fontSize: 0),
                        border: InputBorder.none,
                        hintText: "khác",
                        hintStyle: TextStyle(
                            color: colorInactive,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          fontSize: 14
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Montserrat"),
                    ),
                  )
                ],
              )
            ),
          ),
          onTap: (){
            setState(() {
              _index = index;
            });
            if(index == optionsUnit.length){
              setState(() {
                text = "";
              });
              FocusScope.of(context).requestFocus(myFocusNode);
            }
            else{
              FocusScope.of(context).requestFocus(new FocusNode());
              controller.clear();
              setState(() {
                text = optionsUnit[index];
              });
            }
          },
        )
    );
  }
}

class RadioItem extends StatelessWidget {
  final bool _isSelected;
  final String _text;

  RadioItem(this._isSelected, this._text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(right: 16),
          height: 24.0,
          width: 24.0,
          child: new Center(
            child: _isSelected
                ? Icon(
              FontAwesomeIcons.solidDotCircle,
              size: 20,
              color: colorActive,
            )
                : Icon(
              FontAwesomeIcons.solidCircle,
              size: 20,
              color: colorInactive.withOpacity(0.3),
            ),
          ),
        ),
        Text(
          _text,
          style: TextStyle(
              fontSize: 14,
              color: _isSelected ? Colors.black : colorInactive,
              fontWeight: _isSelected ? FontWeight.w600 : FontWeight.w500
          ),
        )
      ],
    );
  }
}
