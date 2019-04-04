import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'favorite_item.dart';
import 'package:toast/toast.dart';

class CartItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin:
            EdgeInsets.only(top: 16.0, bottom: 4.0, right: 16.0, left: 16.0),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0, left: 15.0),
                width: MediaQuery.of(context).size.width - 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Post()),
                        );
                      },
                      child: Container(
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/images/carrot.jpg',
                            fit: BoxFit.fill,
                          ),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(5.0)),
                        ),
                        width: 105,
                        height: 90,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 65,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 10.0,
                                      bottom: 5.0,
                                      left: 15.0,
                                      top: 5.0),
                                  child: Text(
                                    '123A Đường Lên Đỉnh Olympia, F15, Q.TB, TP.HCM',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: colorText, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 4.0,
                              right: 10.0,
                              left: 15.0,
                            ),
                            child: Text(
                              "100.000 VNĐ",
                              style: TextStyle(
                                  color: colorActive,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 25,
                height: 90,
                margin: EdgeInsets.only(right: 15.0, top: 15.0, bottom: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _count++;
                        });
                      },
                      child: Container(
                        width: 30,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            "+",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: colorActive),
                          ),
                        )
                      ),
                    ),
                    Text(
                      _count.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_count > 1) {
                            _count--;
                          }
                        });
                      },
                      child: Container(
                        width: 30,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            "-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: _count == 1 ? colorInactive : colorActive),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colorInactive, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Toast.show("Đã xóa", context);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              right: BorderSide(
                                  color: colorInactive, width: 0.5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
                            child: Icon(
                              FontAwesomeIcons.trashAlt,
                              size: 17,
                            ),
                          ),
                          Text(
                            'XÓA',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(height: 40, child: FavoriteItem()),
                  flex: 1,
                ),
              ],
            ),
          ),
        ]));
  }
}
