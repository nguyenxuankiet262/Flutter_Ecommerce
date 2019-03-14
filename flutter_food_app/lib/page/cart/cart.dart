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
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cảnh Báo!"),
          content: new Text("Bạn có chắc muốn xóa tất cả không?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Yes",
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          'Giỏ hàng',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          new Center(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                child: Text(
                  'ĐẶT HÀNG',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: itemCount > 0 ? colorActive : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
        leading: GestureDetector(
          child: Icon(
            FontAwesomeIcons.solidTrashAlt,
            color: Colors.grey,
          ),
          onTap: () {
            if (itemCount > 0) {
              _showDialog();
            }
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: itemCount != 0
                ? ListView(
                    children: <Widget>[
                      ListCart(),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            itemCount = 0;
                          });
                        },
                        child: Text(
                          "Chuyển sang empty"
                        ),
                      ),
                    ],
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
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
