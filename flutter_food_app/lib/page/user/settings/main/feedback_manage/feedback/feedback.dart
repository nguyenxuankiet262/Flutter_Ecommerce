import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:toast/toast.dart';
import 'header.dart';
import 'description.dart';
import 'image.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  Future<bool> _showDialog() {
    // flutter defined function
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Cảnh Báo!"),
              content: new Text("Bạn có chắc dừng việc gửi phản hồi không?"),
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
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.5,
          brightness: Brightness.light,
          title: new Text(
            'Thêm phản hồi',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            new Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: GestureDetector(
                  child: Text(
                    'GỬI',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                        color: colorActive,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Toast.show("Cảm ơn bạn đã đanh giá", context);
                  },
                ),
              ),
            ),
          ],
          leading: new Center(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: GestureDetector(
                child: Text(
                  'HỦY',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                onTap: () {
                  _showDialog();
                },
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: colorBackground,
            child: ListView(
              children: <Widget>[
                HeaderFeedback(),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Miêu tả vấn đề",
                    style: TextStyle(fontFamily: "Ralway"),
                  ),
                ),
                DescriptionFeedback(),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Thêm hình ảnh",
                    style: TextStyle(fontFamily: "Ralway"),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ImageFeedback(),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, right:16.0, top: 16.0),
                        child: Text(
                          "Chỉ thêm được 3 hình với kích thước mỗi hình dưới 2MB.",
                          style: TextStyle(fontFamily: "Ralway",
                            color: Colors.red,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        ));
  }
}
