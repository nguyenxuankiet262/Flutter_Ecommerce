import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class ListPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  int itemCount = 10;
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) => new Card(
          child: new Container(
            width: 200,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(index % 2 == 0
                                  ? 'assets/images/carrot.jpg'
                                  : 'assets/images/tomato.jpg'),
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0))),
                      ),
                      onTap: () {
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 10.0, top: 10.0, left: 10.0),
                      child: Text(
                        index % 2 == 0
                            ? 'Cà rốt tươi ngon đây! Mại zô!'
                            : 'Vua Cà Chua mang đên những quả cà chua tuyệt vời!',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 10.0, bottom: 6.0, left: 10.0, top: 5.0),
                      child: Text(
                        index % 2 == 0
                            ? '123A Đường Lên Đỉnh Olympia, F15, Q.TB, TP.HCM'
                            : '12/2 Con Đường Tơ Lụa, F15, Q.TB, TP.HCM',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: colorText, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 10.0, left: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            index % 2 == 0 ? '40.000 VNĐ' : '150.000 VNĐ',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: colorActive,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  index % 2 == 0
                                      ? '50.000 VNĐ'
                                      : '300.000 VNĐ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorInactive,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.favorite,
                                      color: colorInactive,
                                      size: 15,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 2.0),
                                      child: Text(
                                        '100',
                                        style: TextStyle(
                                            color: colorInactive,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 0,
                      width: 0,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent.withOpacity(0.95),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), topLeft: Radius.circular(5.0))
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    index % 2 == 0 ? '20%': '50%',
                                    style: TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0
                                    ),
                                  ),
                                  Text(
                                    'GIẢM',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      fontSize: 12
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
      ),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
    );
  }
}