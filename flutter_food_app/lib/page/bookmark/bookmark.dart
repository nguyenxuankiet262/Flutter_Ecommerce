import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
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
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            'Nơi chứa những giấc mơ!',
            style: TextStyle(
              color: colorText,
            ),
          ),
          transform: Matrix4.translationValues(0.0, 15.0, 0.0),
        ),
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
        RotationTransition(
          turns: new AlwaysStoppedAnimation(180 / 360),
          child: GestureDetector(
            child: BottomAppBar(
              color: colorActive,
              shape: CircularNotchedRectangle(),
              notchMargin: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: RotationTransition(
                      turns: new AlwaysStoppedAnimation(180 / 360),
                      child: Text(
                        'ALL',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: RotationTransition(
                      turns: new AlwaysStoppedAnimation(180 / 360),
                      child: Text(
                        'CLEAR',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              _showDialog();
            },
          ),
        ),
      ],
    );
  }
}
