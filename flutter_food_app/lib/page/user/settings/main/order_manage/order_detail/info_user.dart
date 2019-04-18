import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/info.dart';

class InfoUser extends StatelessWidget{
  final bool isSellOrder;
  InfoUser(this.isSellOrder);
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
                  isSellOrder ?'THÔNG TIN NGƯỜI MUA' : 'THÔNG TIN NGƯỜI BÁN',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: GestureDetector(
                      child: Text(
                        'kiki123',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colorActive
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(true)));
                      },
                    ),
                  ),
                  Text(
                    "(Lò Thị Chó)",
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
                        '123 Đường lên đỉnh Olympia F.15 Q.1 TP.Hồ Chí Minh.',
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
                        '+84 123 456 789',
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