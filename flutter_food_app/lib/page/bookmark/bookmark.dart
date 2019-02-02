import "package:flutter/material.dart";
import 'post.dart';
import 'package:toast/toast.dart';

class MyBookMark extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBookMarkState();
}

class _MyBookMarkState extends State<MyBookMark> {
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
              child: new Text("Yes",style: TextStyle(color: Colors.red),),
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
            'Yêu thích',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                child: Padding(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  padding: EdgeInsets.only(right: 10.0),
                ),
                onTap: (){
                  _showDialog();
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: itemCount != 0
                ? ListBookMark()
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/icon_heartbreak.png'),
                Text('Nothing to show!'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
