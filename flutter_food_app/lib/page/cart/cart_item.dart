import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:toast/toast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_food_app/page/post/post.dart';

class CartItem extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CartItemState();
}

class CartItemState extends State<CartItem>{
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: new BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: colorInactive))
        ),
        padding: new EdgeInsets.all(15.0),
        child: new Slidable(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
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
                          borderRadius: new BorderRadius.all(
                              Radius.circular(5.0)),
                        ),
                        width: 130,
                        height: 100,
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
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 10.0, bottom: 5.0, left: 15.0, top: 5.0),
                                  child: Text(
                                    '123A Đường Lên Đỉnh Olympia, F15, Q.TB, TP.HCM',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: colorText),
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
                              "60.000 VNĐ",
                              style: TextStyle(
                                  color: colorActive,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 40,
                height: 100,
                margin: EdgeInsets.only(right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _count++;
                        });
                      },
                      child: Container(
                        child: Text(
                          "+",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: colorActive
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _count.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if(_count > 1) {
                            _count--;
                          }
                        });
                      },
                      child: Container(
                        child: Text(
                          "-",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: _count == 1 ? colorInactive : colorActive
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          delegate: new SlidableDrawerDelegate(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            ClipRRect(
              child: new IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    setState(() {
                      Toast.show('Delete', context);
                    });
                  }
              ),
              borderRadius: new BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0)),
            ),
          ],
        )
    );
  }

}