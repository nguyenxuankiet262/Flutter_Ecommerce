import 'package:flutter/material.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';

class InfoUser extends StatefulWidget{
  final User user;
  final bool isSellOrder;
  InfoUser(this.user, this.isSellOrder);
  @override
  State<StatefulWidget> createState() => InfoUserState();
}

class InfoUserState extends State<InfoUser>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(5.0),
        child: Card(
            color: Colors.white,
            elevation: 1.5,
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      widget.isSellOrder ?'THÔNG TIN NGƯỜI MUA' : 'THÔNG TIN NGƯỜI BÁN',
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 5.0),
                        child: GestureDetector(
                          child: Text(
                            widget.user.username,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colorActive
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => InfoAnotherPage(widget.user.id)));
                          },
                        ),
                      ),
                      Text(
                        "(" + widget.user.name + ")",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Ralway"
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: Icon(
                            Icons.home,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.user.address,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: Icon(
                            Icons.phone,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.user.phone,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}