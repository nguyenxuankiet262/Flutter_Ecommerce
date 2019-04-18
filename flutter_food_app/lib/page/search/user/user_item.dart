import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/info.dart';

class UserItem extends StatefulWidget{
  final int _index;
  UserItem(this._index);
  @override
  State<StatefulWidget> createState() => UserItemState();
}

class UserItemState extends State<UserItem>{
  bool isFollow = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      width: 150,
      color: Colors.white,
      margin: EdgeInsets.only(
          right: widget._index == 10 ? 16.0 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(100.0))),
              child: ClipOval(
                child: Image.asset(
                  widget._index % 2 == 0
                      ? 'assets/images/dog.jpg'
                      : 'assets/images/cat.jpg',
                  fit: BoxFit.cover,
                  width: 80.0,
                  height: 80.0,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(true)));
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              widget._index % 2 == 0 ? 'kiki_123' : 'meowmeow',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget._index % 2 == 0 ? '120K' : '1M',
                    style: TextStyle(
                        fontFamily: "Ralway",
                        color: colorInactive,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' người theo dõi',
                    style: TextStyle(
                        fontFamily: "Ralway",
                        color: colorInactive,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          RaisedButton(
            onPressed: (){
              setState(() {
                isFollow = !isFollow;
              });
            },
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
            color: isFollow ? Colors.white : colorActive,
            textColor: isFollow ? Colors.black : Colors.white,
            child: Text(
                isFollow ? "Đang theo dõi" : "Theo dõi"
            ),
          ),
        ],
      ),
    );
  }

}