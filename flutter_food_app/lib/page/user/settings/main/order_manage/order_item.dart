import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/model/order.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/settings/main/order_manage/order_detail/order_detail.dart';
import 'package:intl/intl.dart';

import 'package:shimmer/shimmer.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  final int indexTabs;
  final bool isSellOrder;

  OrderItem(this.order, this.indexTabs, this.isSellOrder);

  @override
  State<StatefulWidget> createState() => OrderItemState();
}

class OrderItemState extends State<OrderItem> {
  ApiBloc apiBloc;
  final fDay = new DateFormat('dd-MM-yyyy');
  final fHour = new DateFormat('h:mm a ');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OrderDetail(widget.isSellOrder
                              ? widget.order
                              .userOrder
                              .id
                              : widget.order.userSeller.id,widget.indexTabs, widget.order.id, widget.isSellOrder)));
            },
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "#" +
                                  widget.order.id,
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
                                        child: Text(
                                            widget.isSellOrder
                                                ? widget.order
                                                .userOrder
                                                .username
                                                : widget.order.userSeller.username,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontFamily: "Ralway",
                                                color: Colors.blue,
                                                fontWeight:
                                                FontWeight.w600))),
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
                                        width: MediaQuery.of(context)
                                            .size
                                            .width -
                                            175,
                                        child: Text(
                                          widget.order
                                              .listProduct[0]
                                              .name,
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
                                    Text(
                                        widget.order
                                            .product[0].qty
                                            .toString(),
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
                                        baseColor: widget.indexTabs == 0
                                            ? colorActive
                                            : widget.indexTabs == 1
                                            ? Colors.orange
                                            : Colors.red,
                                        highlightColor: Colors.yellow,
                                        child: Text(
                                          widget.indexTabs == 0
                                              ? "Đơn hàng mới"
                                              : widget.indexTabs == 1
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
                              fDay.format(
                                  widget.order.day),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Ralway",
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                  fHour.format(Helper().plus7hourDateTime(widget.order.day)),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: "Ralway",
                                      color: colorInactive,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
                        ),
                      ],
                    ))));
      },
    );
  }
}
