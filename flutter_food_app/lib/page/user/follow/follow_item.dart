import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

class FollowItem extends StatefulWidget{
  final int index;
  FollowItem(this.index);
  @override
  State<StatefulWidget> createState() => FollowItemState();
}

class FollowItemState extends State<FollowItem>{
  bool isFollow = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              onTap: (){
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      widget.index % 2 == 0
                          ? 'assets/images/cat.jpg'
                          : 'assets/images/dog.jpg',
                      fit: BoxFit.cover,
                      width: 40.0,
                      height: 40.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.index % 2 == 0
                              ? "meow_meow"
                              : "lu_lu",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Ralway"
                          ),
                        ),
                        Text(
                          widget.index % 2 ==0
                              ? "Trần Văn Mèo"
                              : "Lọ Thị Chó",
                          style: TextStyle(
                              fontSize: 14,
                              color: colorText
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
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