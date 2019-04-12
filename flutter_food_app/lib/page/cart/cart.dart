import "package:flutter/material.dart";
import 'package:toast/toast.dart';
import 'list_post.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartState();
}

class _CartState extends State<Cart> with AutomaticKeepAliveClientMixin {
  int itemCount = 1;

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cảnh Báo!"),
          content: new Text("Bạn có chắc muốn xóa tất cả không?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Không"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Có",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Toast.show('Đã xóa tất cả', context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogPost() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/gifs/relax.gif',
                        fit: BoxFit.fill,
                      ),
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    height: 150,
                  ),
                  Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        "Thông báo",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0, right: 20, left: 20),
                    child: Text(
                      'Hãy kiểm tra kĩ càng trước khi đặt hàng!.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: "Ralway"),
                    ),
                  ),
                  Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                                width: 70,
                                decoration: BoxDecoration(
                                  color: colorInactive,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    "HỦY",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          InkWell(
                            child: Container(
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    "ĐỒNG Ý",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            onTap: () {
                              _onSuccess();
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  Future _onSuccess() {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Đang gửi...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.none,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: new CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context); //pop dialog
      Toast.show('Cảm ơn bạn đã đặt hàng!', context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        brightness: Brightness.light,
        title: Text(
          'Giỏ hàng',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          new Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: GestureDetector(
                child: Text(
                  'ĐẶT HÀNG',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: itemCount > 0 ? colorActive : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                onTap: () {
                  _showDialogPost();
                },
              ),
            ),
          ),
        ],
        leading: GestureDetector(
          child: Icon(
            FontAwesomeIcons.solidTrashAlt,
            color: Colors.black,
            size: 18,
          ),
          onTap: () {
            if (itemCount > 0) {
              _showDialog();
            }
          },
        ),
      ),
      body: itemCount != 0
          ? Container(
        color: colorBackground,
        child: ListCart(),
      )
          : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/icon_heartbreak.png'),
              GestureDetector(
                onTap: () {
                  setState(() {
                    itemCount = 1;
                  });
                },
                child: Text('Nothing to show!'),
              ),
            ],
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
