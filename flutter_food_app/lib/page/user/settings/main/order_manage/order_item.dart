import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/settings/main/order_manage/order_detail/order_detail.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:toast/toast.dart';
import 'package:shimmer/shimmer.dart';

class OrderItem extends StatefulWidget {
  int index;
  bool isSellOrder;

  OrderItem(this.index, this.isSellOrder);

  @override
  State<StatefulWidget> createState() => OrderItemState();
}

class OrderItemState extends State<OrderItem> {
  int _index = 0;

  _showStatusPicker() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: Container(
                height: 260,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 30,
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Center(
                          child: Text(
                            "Chọn tình trạng",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Container(
                      height: 180,
                      child: CupertinoPicker(
                        backgroundColor: Colors.white,
                        looping: true,
                        itemExtent: 50,
                        //height of each item
                        children:
                            new List.generate(statusOptions.length, (index) {
                          return new Center(
                            child: Text(
                              statusOptions[index],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0),
                            ),
                          );
                        }),
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            _index = index;
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Hủy",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: GestureDetector(
                                    onTap: () {
                                      print(statusOptions[_index]);
                                      Toast.show(
                                          "Đã cập nhật đơn hàng!", context);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Chấp nhận",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 14),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderDetail(widget.isSellOrder)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: new Card(
            child: Container(
                height: 75,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 75,
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "#154123123112",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "8 phút trước",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12.0),
                            ),
                          ),
                          Container(
                            child: Shimmer.fromColors(
                                baseColor: widget.index == 0
                                    ? colorActive
                                    : widget.index == 1
                                        ? colorActive
                                        : widget.index == 2
                                            ? Colors.orange
                                            : Colors.red,
                                highlightColor: Colors.yellow,
                                child: Text(
                                  widget.index == 0
                                      ? "Đơn hàng mới"
                                      : widget.index == 1
                                          ? "Đơn hàng mới"
                                          : widget.index == 2
                                              ? "Đơn hàng thành công"
                                              : "Đơn hàng bị hủy",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                    !widget.isSellOrder
                        ? Container()
                        : Positioned(
                      right: 0.0,
                            child: Container(
                                height: 75,
                                width: 200,
                                child: Center(
                                    child: GestureDetector(
                                  onTap: () {
                                    _showStatusPicker();
                                  },
                                  child: Text(
                                    "Cập nhật tình trạng",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )))),
                  ],
                ))),
      ),
    );
  }
}
