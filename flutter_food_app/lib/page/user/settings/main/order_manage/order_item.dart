import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => OrderItemState();
}

class OrderItemState extends State<OrderItem>{
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
        color: Colors.white,
      ),
    );
  }
}