import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'info_user.dart';
import 'info_order.dart';

class OrderDetail extends StatefulWidget{
  bool isSellOrder;
  OrderDetail(this.isSellOrder);
  @override
  State<StatefulWidget> createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetail>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: new Text(
          'Đơn hàng #151231231',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: colorBackground,
        height: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            InfoUser(widget.isSellOrder),
            InforOrder(),
          ],
        ),
      ),
    );
  }
}