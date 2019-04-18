import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/settings/main/order_manage/order_detail/order_detail.dart';

import 'package:shimmer/shimmer.dart';

class OrderItem extends StatefulWidget {
  final int index;
  final bool isSellOrder;

  OrderItem(this.index, this.isSellOrder);

  @override
  State<StatefulWidget> createState() => OrderItemState();
}

class OrderItemState extends State<OrderItem> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetail(widget.isSellOrder)));
      },
      child: Card(
          child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "#154123123112",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Ralway"),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      widget.isSellOrder
                                          ? "Người mua: "
                                          : "Người bán: ",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Ralway",
                                          color: colorInactive,
                                          fontWeight: FontWeight.w600)),
                                  Shimmer.fromColors(
                                      baseColor: Colors.blue,
                                      highlightColor: Colors.blue,
                                      child: Text("meowmeow",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: "Ralway",
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600))),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Sản phẩm: ",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Ralway",
                                          color: colorInactive,
                                          fontWeight: FontWeight.w600)),
                                  Container(
                                      width: MediaQuery.of(context).size.width - 175,
                                      child: Text(
                                        "Cà rốt tươi ngon đây! Mại zô!asdadasd Cà rốt tươ",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: "Ralway",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Số lượng: ",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Ralway",
                                          color: colorInactive,
                                          fontWeight: FontWeight.w600)),
                                  Text("1",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Ralway",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600))
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Tình trạng: ",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Ralway",
                                          color: colorInactive,
                                          fontWeight: FontWeight.w600)),
                                  Shimmer.fromColors(
                                      period: Duration(seconds: 3),
                                      baseColor: widget.index == 0
                                          ? colorActive
                                          : widget.index == 1
                                              ? Colors.orange
                                              : Colors.red,
                                      highlightColor: Colors.yellow,
                                      child: Text(
                                        widget.index == 0
                                            ? "Đơn hàng mới"
                                            : widget.index == 1
                                                ? "Đơn hàng thành công"
                                                : "Đơn hàng bị hủy",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Ralway",
                                            fontSize: 12.0),
                                      )),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "03/04/2019",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Ralway",
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text("11:11 AM",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: "Ralway",
                                    color: colorInactive,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
