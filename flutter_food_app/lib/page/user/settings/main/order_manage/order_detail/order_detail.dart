import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:toast/toast.dart';
import 'info_user.dart';
import 'info_order.dart';

class OrderDetail extends StatefulWidget{
  final bool isSellOrder;
  OrderDetail(this.isSellOrder);
  @override
  State<StatefulWidget> createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetail>{
  int _index = 1;
  FixedExtentScrollController scrollController;


  @override
  void initState() {
    super.initState();
    scrollController = new FixedExtentScrollController(initialItem: _index);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

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
                        magnification: 1.2,
                        useMagnifier: true,
                        scrollController: scrollController,
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        brightness: Brightness.light,
        title: new Text(
          '#151231231',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              _showStatusPicker();
            },
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
          )
        ],
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