import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InforOrder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 5.0, left: 5.0),
      child: Card(
        color: Colors.white,
        elevation: 1.5,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      width: MediaQuery.of(context).size.width - 40,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                            },
                            child: Container(
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/images/carrot.jpg',
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(5.0)),
                              ),
                              width: 105,
                              height: 90,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 145,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  EdgeInsets.only(right: 10.0, left: 15.0),
                                  child: Text(
                                    'Cà rốt tươi ngon đây! Mại zô!',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 10.0,left: 15.0),
                                  child: Text(
                                    '123A Đường Lên Đỉnh Olympia, F15, Q.TB, TP.HCM',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: colorText, fontSize: 12),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.0, bottom: 5.0, left: 15.0, top: 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            FontAwesomeIcons.carrot,
                                            size: 13,
                                          ),
                                        ),
                                        Text(
                                          "Số lượng: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text(
                                            "5",
                                            style: TextStyle(
                                                color: colorActive,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "kg",
                                          style: TextStyle(
                                              color: colorActive,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 12.0
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.0, bottom: 5.0, left: 15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            FontAwesomeIcons.dollarSign,
                                            size: 13,
                                          ),
                                        ),
                                        Text(
                                          "Giá: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text(
                                            "100.000 VNĐ",
                                            style: TextStyle(
                                                color: colorActive,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 4.0),
                                          child: Text(
                                            "/",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "kg",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 12.0
                                          ),
                                        ),
                                      ],
                                    )
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0,bottom: 5.0),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: colorInactive,width: 0.5)),
                  ),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "TỔNG: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            "500.000 VNĐ",
                            style: TextStyle(
                                color: colorActive,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
          )
        ),
      ),
    );
  }
}