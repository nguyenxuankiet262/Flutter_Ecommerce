import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/order.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'info_user.dart';
import 'info_order.dart';

class OrderDetail extends StatefulWidget {
  final String idUser;
  final String idOrder;
  final bool isSellOrder;
  final int index;

  OrderDetail(this.idUser, this.index, this.idOrder, this.isSellOrder);

  @override
  State<StatefulWidget> createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetail> {
  int _index = 1;
  FixedExtentScrollController scrollController;
  Order order;
  ApiBloc apiBloc;
  int indexTab;

  @override
  void initState() {
    super.initState();
    indexTab = widget.index;
    apiBloc = BlocProvider.of<ApiBloc>(context);
    scrollController = new FixedExtentScrollController(initialItem: _index);
    (() async {
      if(await Helper().check()){
        Order temp = await getOrderById(widget.idOrder);
        setState(() {
          order = temp;
        });
      }else {
        new Future.delayed(
            const Duration(seconds: 1),
                () {
              Toast.show(
                  "Vui lòng kiểm tra mạng!",
                  context,
                  gravity: Toast.CENTER,
                  backgroundColor:
                  Colors.black87);
            });
      }
    })();
  }

  double onCalculateTotal() {
    double total = 0;
    for (int i = 0; i < order.listProduct.length; i++) {
      total += double.parse(order.listProduct[i].currentPrice) *
          order.product[i].qty;
    }
    return total;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
  }

  onSuccess(){
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        Navigator.pop(context);
        Toast.show("Cập nhật thành công", context);
      });
    });
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
                                    onTap: () async {
                                      Navigator.pop(context);
                                      _showLoading();
                                      await updateStatusOrder(order.id, _index.toString());
                                      User user = apiBloc.currentState.mainUser;
                                      try{
                                        if(user.listNewOrder != null) {
                                          if (indexTab == 0) {
                                            for (int i = 0; i <
                                                user.listNewOrder.length; i++) {
                                              if (widget.idOrder ==
                                                  user.listNewOrder[i].id) {
                                                user.listNewOrder.removeAt(i);
                                                break;
                                              }
                                            }
                                          }
                                          else if (indexTab == 1) {
                                            for (int i = 0; i <
                                                user.listSuccessOrder.length;
                                            i++) {
                                              if (widget.idOrder ==
                                                  user.listSuccessOrder[i].id) {
                                                user.listSuccessOrder.removeAt(
                                                    i);
                                                break;
                                              }
                                            }
                                          }
                                          else {
                                            for (int i = 0; i <
                                                user.listCancelOrder.length;
                                            i++) {
                                              if (widget.idOrder ==
                                                  user.listCancelOrder[i].id) {
                                                user.listCancelOrder.removeAt(
                                                    i);
                                                break;
                                              }
                                            }
                                          }
                                          if(indexTab == 0){
                                            if(_index != 2){
                                              User user = apiBloc.currentState.mainUser;
                                              user.badge.sell --;
                                              apiBloc.changeMainUser(user);
                                            }
                                          }
                                          else{
                                            if(_index == 2){
                                              User user = apiBloc.currentState.mainUser;
                                              user.badge.sell ++;
                                              apiBloc.changeMainUser(user);
                                            }
                                          }
                                        }
                                        else{
                                          if(indexTab == 0){
                                            if(_index != 2){
                                              User user = apiBloc.currentState.mainUser;
                                              user.badge.sell --;
                                              apiBloc.changeMainUser(user);
                                            }
                                          }
                                          else{
                                            if(_index == 2){
                                              User user = apiBloc.currentState.mainUser;
                                              user.badge.sell ++;
                                              apiBloc.changeMainUser(user);
                                            }
                                          }
                                        }
                                        if(_index == 0){
                                          if(user.listCancelOrder == null){
                                            user.listCancelOrder = new List<Order>();
                                          }
                                          user.listCancelOrder.insert(0, order);
                                        }
                                        else if(_index == 1){
                                          if(user.listSuccessOrder == null){
                                            user.listSuccessOrder = new List<Order>();
                                          }
                                          user.listSuccessOrder.insert(0, order);
                                        }
                                        else{
                                          if(user.listNewOrder == null){
                                            user.listNewOrder = new List<Order>();
                                          }
                                          user.listNewOrder.insert(0, order);
                                        }
                                      }
                                      finally{
                                        apiBloc.changeMainUser(user);
                                      }
                                      onSuccess();
                                      indexTab = _index;
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
      backgroundColor: colorBackground,
      appBar: AppBar(
        elevation: 0.5,
        brightness: Brightness.light,
        title: new Text(
          order != null ? "#" + order.listProduct[0].id : "",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          order != null
          ? widget.isSellOrder
              ? IconButton(
            onPressed: () {
              _showStatusPicker();
            },
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
          )
              : Container()
              : Container()
        ],
      ),
      body: order != null
          ? ListView(
        shrinkWrap: true,
        children: <Widget>[
          InfoUser(widget.isSellOrder ? order.userOrder : order.userSeller, widget.isSellOrder),
          InforOrder(order),
        ],
      )
          : Container(
      ),
      bottomNavigationBar: order != null
      ? Container(
        height: 40,
        color: colorActive,
        child: Center(
          child: Text(
            "Tổng: " + Helper().onFormatPrice(onCalculateTotal().toString()),
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      )
      : Container(),
    );
  }
}
