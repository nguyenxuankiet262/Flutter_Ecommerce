import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_order_bloc.dart';
import 'package:flutter_food_app/common/state/list_search_order_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/settings/main/order_manage/order_detail/order_detail.dart';
import 'package:intl/intl.dart';

import 'package:shimmer/shimmer.dart';

class SearchOrderItem extends StatefulWidget {
  final int indexItems;
  final int intdexTabs;
  final bool isSellOrder;

  SearchOrderItem(this.indexItems, this.intdexTabs, this.isSellOrder);

  @override
  State<StatefulWidget> createState() => SearchOrderItemState();
}

class SearchOrderItemState extends State<SearchOrderItem> {
  ListSearchOrderBloc listSearchOrderBloc;
  final fDay = new DateFormat('dd-MM-yyyy');
  final fHour = new DateFormat('h:mm a ');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listSearchOrderBloc = BlocProvider.of<ListSearchOrderBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: listSearchOrderBloc,
      builder: (context, ListSearchOrderState state) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OrderDetail(widget.isSellOrder
                              ? state
                              .listOrder[
                          widget.indexItems]
                              .userOrder
                              .id
                              : state.listOrder[widget.indexItems].userSeller.id,widget.intdexTabs, state.listOrder[widget.indexItems].id, widget.isSellOrder)));
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
                                  state.listOrder[widget.indexItems].id,
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
                                                ? state
                                                .listOrder[
                                            widget.indexItems]
                                                .userOrder
                                                .username
                                                : state.listOrder[widget.indexItems].userSeller.username,
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
                                          state
                                              .listOrder[widget.indexItems]
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
                                        state.listOrder[widget.indexItems]
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
                                        baseColor: widget.intdexTabs == 0
                                            ? colorActive
                                            : widget.intdexTabs == 1
                                            ? Colors.orange
                                            : Colors.red,
                                        highlightColor: Colors.yellow,
                                        child: Text(
                                          widget.intdexTabs == 0
                                              ? "Đơn hàng mới"
                                              : widget.intdexTabs == 1
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
                                  state.listOrder[widget.indexItems].day),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Ralway",
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                  fHour.format(state
                                      .listOrder[widget.indexItems].day),
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
